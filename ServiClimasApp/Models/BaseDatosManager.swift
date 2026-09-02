import FirebaseFirestore
import FirebaseAuth

/// Guarda en Firestore cada solicitud de servicio que un cliente confirma.
enum BaseDatosManager {

    static func guardarSolicitud(servicio: String, resumen: [(titulo: String, valor: String)]) {
        var datos: [String: Any] = [
            "servicio": servicio,
            "fecha": Timestamp(date: Date()),
            "correoUsuario": Auth.auth().currentUser?.email ?? "",
            "nombreUsuario": Auth.auth().currentUser?.displayName ?? ""
        ]

        for dato in resumen {
            datos[dato.titulo] = dato.valor
        }

        Firestore.firestore().collection("solicitudes").addDocument(data: datos)
    }
}
