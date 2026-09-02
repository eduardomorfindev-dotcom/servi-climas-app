import FirebaseAuth

/// Maneja el registro, inicio y cierre de sesión usando Firebase Authentication.
/// Las cuentas y contraseñas ya no se guardan localmente: viven en Firebase.
enum SesionManager {

    static func registrar(
        nombre: String,
        correo: String,
        contrasena: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        Auth.auth().createUser(withEmail: correo, password: contrasena) { resultado, error in
            if let error {
                completion(.failure(error))
                return
            }

            let cambioPerfil = resultado?.user.createProfileChangeRequest()
            cambioPerfil?.displayName = nombre
            cambioPerfil?.commitChanges { errorPerfil in
                if let errorPerfil {
                    completion(.failure(errorPerfil))
                } else {
                    completion(.success(()))
                }
            }
        }
    }

    static func iniciarSesion(
        correo: String,
        contrasena: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        Auth.auth().signIn(withEmail: correo, password: contrasena) { _, error in
            if let error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    static func cerrarSesion() {
        try? Auth.auth().signOut()
    }

    static var nombreUsuarioActual: String {
        Auth.auth().currentUser?.displayName ?? "Usuario"
    }

    /// Traduce los errores más comunes de Firebase Auth a mensajes en español.
    static func mensajeError(_ error: Error) -> String {
        guard let codigo = AuthErrorCode(rawValue: (error as NSError).code) else {
            return "Ocurrió un problema. Intenta de nuevo."
        }

        switch codigo {
        case .emailAlreadyInUse:
            return "Ya existe una cuenta registrada con ese correo."
        case .invalidEmail:
            return "El correo electrónico no es válido."
        case .weakPassword:
            return "La contraseña es demasiado débil."
        case .wrongPassword, .invalidCredential:
            return "El correo o la contraseña son incorrectos."
        case .userNotFound:
            return "No existe una cuenta con ese correo."
        case .networkError:
            return "Hubo un problema de conexión a internet. Intenta de nuevo."
        default:
            return "Ocurrió un problema. Intenta de nuevo."
        }
    }
}
