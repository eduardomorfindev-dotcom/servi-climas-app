import FirebaseFirestore
import FirebaseAuth

/// Guarda en Firestore cada solicitud de servicio que un cliente confirma.
enum BaseDatosManager {

    /// Guarda el perfil del cliente (nombre, correo, teléfono ya verificado)
    /// en la colección "usuarios", usando el uid de Firebase Auth como id del documento.
    static func guardarUsuario(nombre: String, correo: String, telefono: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        let datos: [String: Any] = [
            "nombre": nombre,
            "correo": correo,
            "telefono": telefono,
            "fechaRegistro": Timestamp(date: Date())
        ]

        Firestore.firestore().collection("usuarios").document(uid).setData(datos)
    }

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
