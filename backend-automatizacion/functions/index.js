const { onRequest } = require("firebase-functions/v2/https");
const { onSchedule } = require("firebase-functions/v2/scheduler");
const { defineSecret } = require("firebase-functions/params");
const logger = require("firebase-functions/logger");
const Anthropic = require("@anthropic-ai/sdk");
const admin = require("firebase-admin");

admin.initializeApp();
const db = admin.firestore();

const ANTHROPIC_API_KEY = defineSecret("ANTHROPIC_API_KEY");
const WHATSAPP_TOKEN = defineSecret("WHATSAPP_TOKEN");
const WHATSAPP_PHONE_NUMBER_ID = defineSecret("WHATSAPP_PHONE_NUMBER_ID");
const WHATSAPP_VERIFY_TOKEN = defineSecret("WHATSAPP_VERIFY_TOKEN");
const FB_PAGE_TOKEN = defineSecret("FB_PAGE_TOKEN");
const FB_VERIFY_TOKEN = defineSecret("FB_VERIFY_TOKEN");

const PROMPT_NEGOCIO = `Eres el asistente virtual de "Servi Climas Manzanillo", un negocio de aire acondicionado y refrigeración en Manzanillo, Colima, México.

Servicios que ofrece el negocio:
- Mantenimiento preventivo y correctivo de aires acondicionados.
- Instalación de equipos (minisplit, aire de paquete/central).
- Reparación de fallas (no enfría, hace ruido, gotea agua, no enciende, huele mal).
- Venta de equipos nuevos (varias capacidades, normal o inverter, 110V o 220V).

Instrucciones:
- Responde siempre en español, de forma breve, amable y profesional.
- Si el cliente pregunta por precios exactos, explica que dependen del equipo/servicio y que un técnico le confirmará el costo.
- Si el cliente quiere agendar una cita, pregúntale qué servicio necesita y para qué fecha/hora, y usa la herramienta "agendar_cita" para guardarla en cuanto tengas esos datos.
- Si no sabes algo o es un tema fuera de aire acondicionado/refrigeración, dilo con honestidad y ofrece que un humano del negocio lo atienda.
- No inventes precios, horarios ni promociones que no se te hayan dado.`;

const HERRAMIENTA_AGENDAR_CITA = {
  name: "agendar_cita",
  description: "Guarda una cita de servicio que el cliente confirmó (mantenimiento, instalación, reparación o compra).",
  input_schema: {
    type: "object",
    properties: {
      nombreCliente: { type: "string", description: "Nombre del cliente" },
      servicio: { type: "string", description: "Mantenimiento, Instalación, Reparación o Compra de aire" },
      fechaHora: { type: "string", description: "Fecha y hora acordada, en texto tal como la dijo el cliente" },
      comentario: { type: "string", description: "Detalles adicionales relevantes, si los hay" },
    },
    required: ["nombreCliente", "servicio", "fechaHora"],
  },
};

async function guardarCita(canal, idContacto, datos) {
  await db.collection("citas_bot").add({
    canal,
    idContacto,
    nombreCliente: datos.nombreCliente,
    servicio: datos.servicio,
    fechaHora: datos.fechaHora,
    comentario: datos.comentario || "",
    creadoEn: admin.firestore.FieldValue.serverTimestamp(),
  });
}

async function generarRespuesta(apiKey, canal, idContacto, mensajeCliente) {
  const cliente = new Anthropic({ apiKey });

  const mensajes = [{ role: "user", content: mensajeCliente }];

  let respuesta = await cliente.messages.create({
    model: "claude-sonnet-4-5",
    max_tokens: 400,
    system: PROMPT_NEGOCIO,
    tools: [HERRAMIENTA_AGENDAR_CITA],
    messages: mensajes,
  });

  if (respuesta.stop_reason === "tool_use") {
    const usoHerramienta = respuesta.content.find((bloque) => bloque.type === "tool_use");

    await guardarCita(canal, idContacto, usoHerramienta.input);

    mensajes.push({ role: "assistant", content: respuesta.content });
    mensajes.push({
      role: "user",
      content: [
        {
          type: "tool_result",
          tool_use_id: usoHerramienta.id,
          content: "Cita guardada correctamente.",
        },
      ],
    });

    respuesta = await cliente.messages.create({
      model: "claude-sonnet-4-5",
      max_tokens: 400,
      system: PROMPT_NEGOCIO,
      tools: [HERRAMIENTA_AGENDAR_CITA],
      messages: mensajes,
    });
  }

  return respuesta.content
    .filter((bloque) => bloque.type === "text")
    .map((bloque) => bloque.text)
    .join("\n");
}

// ---------- WhatsApp (Meta Cloud API) ----------

exports.whatsappWebhook = onRequest(
  { secrets: [ANTHROPIC_API_KEY, WHATSAPP_TOKEN, WHATSAPP_PHONE_NUMBER_ID, WHATSAPP_VERIFY_TOKEN] },
  async (req, res) => {
    if (req.method === "GET") {
      const modo = req.query["hub.mode"];
      const token = req.query["hub.verify_token"];
      const reto = req.query["hub.challenge"];

      if (modo === "subscribe" && token === WHATSAPP_VERIFY_TOKEN.value()) {
        res.status(200).send(reto);
      } else {
        res.sendStatus(403);
      }
      return;
    }

    try {
      const entrada = req.body?.entry?.[0]?.changes?.[0]?.value;
      const mensaje = entrada?.messages?.[0];

      if (!mensaje || mensaje.type !== "text") {
        res.sendStatus(200);
        return;
      }

      const numeroCliente = mensaje.from;
      const textoCliente = mensaje.text.body;

      const textoRespuesta = await generarRespuesta(
        ANTHROPIC_API_KEY.value(),
        "whatsapp",
        numeroCliente,
        textoCliente
      );

      await fetch(
        `https://graph.facebook.com/v21.0/${WHATSAPP_PHONE_NUMBER_ID.value()}/messages`,
        {
          method: "POST",
          headers: {
            Authorization: `Bearer ${WHATSAPP_TOKEN.value()}`,
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            messaging_product: "whatsapp",
            to: numeroCliente,
            text: { body: textoRespuesta },
          }),
        }
      );

      res.sendStatus(200);
    } catch (error) {
      logger.error("Error en whatsappWebhook", error);
      res.sendStatus(200);
    }
  }
);

// ---------- Facebook Messenger ----------

exports.facebookWebhook = onRequest(
  { secrets: [ANTHROPIC_API_KEY, FB_PAGE_TOKEN, FB_VERIFY_TOKEN] },
  async (req, res) => {
    if (req.method === "GET") {
      const modo = req.query["hub.mode"];
      const token = req.query["hub.verify_token"];
      const reto = req.query["hub.challenge"];

      if (modo === "subscribe" && token === FB_VERIFY_TOKEN.value()) {
        res.status(200).send(reto);
      } else {
        res.sendStatus(403);
      }
      return;
    }

    try {
      const evento = req.body?.entry?.[0]?.messaging?.[0];
      const textoCliente = evento?.message?.text;
      const idCliente = evento?.sender?.id;

      if (!textoCliente || !idCliente) {
        res.sendStatus(200);
        return;
      }

      const textoRespuesta = await generarRespuesta(
        ANTHROPIC_API_KEY.value(),
        "facebook",
        idCliente,
        textoCliente
      );

      await fetch(
        `https://graph.facebook.com/v21.0/me/messages?access_token=${FB_PAGE_TOKEN.value()}`,
        {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            recipient: { id: idCliente },
            message: { text: textoRespuesta },
          }),
        }
      );

      res.sendStatus(200);
    } catch (error) {
      logger.error("Error en facebookWebhook", error);
      res.sendStatus(200);
    }
  }
);

// ---------- Publicación automática en Facebook ----------

const PUBLICACIONES = [
  "❄️ ¿Tu aire acondicionado no enfría como antes? En Servi Climas Manzanillo hacemos mantenimiento preventivo y correctivo para que rinda al máximo. ¡Contáctanos!",
  "🔧 Instalamos tu aire acondicionado (minisplit o de paquete) de forma profesional y con garantía. Servi Climas Manzanillo, a tus órdenes.",
  "💧 ¿Gotea agua, hace ruido o no enciende? Reparamos tu equipo rápido y con garantía. Escríbenos por WhatsApp o Facebook.",
  "🛒 ¿Buscas comprar un aire acondicionado nuevo? Tenemos equipos normales e inverter, 110V y 220V, al mejor precio en Manzanillo.",
];

// Rota entre los 4 mensajes de arriba, uno distinto cada vez que corre.
exports.publicarEnFacebook = onSchedule(
  { schedule: "every 28 hours", secrets: [FB_PAGE_TOKEN] },
  async () => {
    const indice = Math.floor(Date.now() / (28 * 60 * 60 * 1000)) % PUBLICACIONES.length;
    const mensaje = PUBLICACIONES[indice];

    try {
      await fetch(
        `https://graph.facebook.com/v21.0/me/feed?access_token=${FB_PAGE_TOKEN.value()}`,
        {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ message: mensaje }),
        }
      );
    } catch (error) {
      logger.error("Error en publicarEnFacebook", error);
    }
  }
);
