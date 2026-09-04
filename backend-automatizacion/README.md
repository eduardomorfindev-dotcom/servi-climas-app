# Automatización WhatsApp + Facebook — Servi Climas Manzanillo

Este backend (Firebase Cloud Functions) hace 3 cosas:

1. **`whatsappWebhook`** — responde automáticamente a clientes que escriban por WhatsApp, y puede **agendar la cita de verdad** cuando el cliente confirma servicio y fecha.
2. **`facebookWebhook`** — lo mismo, pero para mensajes de tu página de Facebook.
3. **`publicarEnFacebook`** — publica un post promocional en tu página de Facebook cada 28 horas, rotando entre 4 mensajes sobre tus servicios.

Las respuestas las genera Claude (Anthropic), usando información de tu negocio (servicios, cómo agendar, etc.) — sin inventar precios ni promociones que no le hayamos dado. Cuando un cliente confirma una cita, Claude usa una herramienta (`agendar_cita`) que guarda los datos en Firestore, en la colección **`citas_bot`** (nombre, servicio, fecha/hora, canal y comentario). Puedes revisarlas en Firebase Console → Firestore Database.

## Lo que tú necesitas hacer (cuentas y llaves)

Esto no lo puedo hacer yo por ti — requiere tus propias cuentas y verificación de identidad/negocio:

1. **Cuenta de Anthropic** (console.anthropic.com) → crear una API key → obtienes `ANTHROPIC_API_KEY`.
2. **Meta Business Suite** → verificar tu negocio → habilitar **WhatsApp Business API** → obtienes:
   - `WHATSAPP_TOKEN` (token de acceso)
   - `WHATSAPP_PHONE_NUMBER_ID` (ID del número de WhatsApp del negocio)
   - `WHATSAPP_VERIFY_TOKEN` (lo inventas tú, cualquier texto secreto)
3. **Facebook Developers** (developers.facebook.com) → crear una app → conectar tu página → obtienes:
   - `FB_PAGE_TOKEN` (token de acceso de la página)
   - `FB_VERIFY_TOKEN` (lo inventas tú, cualquier texto secreto)

## Cómo desplegarlo (cuando ya tengas las llaves)

```bash
cd backend-automatizacion
firebase login
cd functions && npm install && cd ..
firebase functions:secrets:set ANTHROPIC_API_KEY
firebase functions:secrets:set WHATSAPP_TOKEN
firebase functions:secrets:set WHATSAPP_PHONE_NUMBER_ID
firebase functions:secrets:set WHATSAPP_VERIFY_TOKEN
firebase functions:secrets:set FB_PAGE_TOKEN
firebase functions:secrets:set FB_VERIFY_TOKEN
firebase deploy --only functions
```

Cada `secrets:set` te va a pedir que pegues el valor correspondiente — Firebase los guarda cifrados, no quedan en el código.

Al terminar el `deploy`, la terminal te da 3 URLs (una por función). Las de `whatsappWebhook` y `facebookWebhook` son las que registras como "webhook" en Meta Business Suite / Facebook Developers al configurar WhatsApp/Messenger.

## Costo

Revisa la sección de "Preguntas y respuestas" que ya platicamos: se cobra por uso (Claude + WhatsApp Business API), no es una suscripción fija. Firebase Functions tiene capa gratuita generosa para empezar.
