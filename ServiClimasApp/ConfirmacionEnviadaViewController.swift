import UIKit

class ConfirmacionEnviadaViewController: UIViewController {

    // MARK: - DATOS RECIBIDOS
    var servicio: String?
    var equipo: String?
    var fecha: String?
    var hora: String?
    var comentario: String?

    // MARK: - ELEMENTOS

    let iconoImageView = UIImageView()
    let tituloLabel = UILabel()
    let mensajeLabel = UILabel()
    let finalizarButton = UIButton(type: .system)

    // MARK: - VIEW DID LOAD

    override func viewDidLoad() {
        super.viewDidLoad()

        configurarPantalla()
        configurarElementos()
        configurarLayout()
    }

    // MARK: - PANTALLA

    private func configurarPantalla() {
        view.backgroundColor = .systemGroupedBackground
        isModalInPresentation = true
    }

    // MARK: - ELEMENTOS

    private func configurarElementos() {

        // MARK: ICONO
        let configuracionSimbolo = UIImage.SymbolConfiguration(pointSize: 70, weight: .medium)
        iconoImageView.image = UIImage(systemName: "checkmark.circle.fill", withConfiguration: configuracionSimbolo)
        iconoImageView.tintColor = .systemGreen
        iconoImageView.contentMode = .scaleAspectFit

        // MARK: TÍTULO
        tituloLabel.text = "¡Solicitud Exitosa!"
        tituloLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        tituloLabel.textColor = .label
        tituloLabel.textAlignment = .center
        tituloLabel.numberOfLines = 0

        // MARK: MENSAJE
        mensajeLabel.text = "Tu servicio de mantenimiento e instalación ha sido registrado correctamente. En breve nos pondremos en contacto contigo para confirmar tu cita."
        mensajeLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        mensajeLabel.textColor = .secondaryLabel
        mensajeLabel.textAlignment = .center
        mensajeLabel.numberOfLines = 0

        // MARK: BOTÓN FINALIZAR
        var configuracionBoton = UIButton.Configuration.filled()
        configuracionBoton.title = "Volver al Inicio"
        configuracionBoton.image = UIImage(systemName: "house.fill")
        configuracionBoton.imagePlacement = .leading
        configuracionBoton.imagePadding = 10
        configuracionBoton.baseBackgroundColor = .systemBlue
        configuracionBoton.baseForegroundColor = .white
        configuracionBoton.cornerStyle = .large
        configuracionBoton.contentInsets = NSDirectionalEdgeInsets(
            top: 16,
            leading: 20,
            bottom: 16,
            trailing: 20
        )

        finalizarButton.configuration = configuracionBoton
        finalizarButton.layer.cornerRadius = 18
        finalizarButton.layer.shadowColor = UIColor.black.cgColor
        finalizarButton.layer.shadowOpacity = 0.15
        finalizarButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        finalizarButton.layer.shadowRadius = 8

        finalizarButton.addTarget(
            self,
            action: #selector(volverAlInicioTapped),
            for: .touchUpInside
        )

        // MARK: AGREGAR VISTAS
        view.addSubview(iconoImageView)
        view.addSubview(tituloLabel)
        view.addSubview(mensajeLabel)
        view.addSubview(finalizarButton)
    }

    // MARK: - LAYOUT

    private func configurarLayout() {
        let elementos = [
            iconoImageView,
            tituloLabel,
            mensajeLabel,
            finalizarButton
        ]

        elementos.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            
            // MARK: ICONO
            iconoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            iconoImageView.heightAnchor.constraint(equalToConstant: 90),
            iconoImageView.widthAnchor.constraint(equalToConstant: 90),

            // MARK: TÍTULO
            tituloLabel.topAnchor.constraint(equalTo: iconoImageView.bottomAnchor, constant: 24),
            tituloLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            tituloLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),

            // MARK: MENSAJE
            mensajeLabel.topAnchor.constraint(equalTo: tituloLabel.bottomAnchor, constant: 12),
            mensajeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            mensajeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),

            // MARK: BOTÓN FINALIZAR
            finalizarButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            finalizarButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            finalizarButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            finalizarButton.heightAnchor.constraint(equalToConstant: 58)
        ])
    }

    // MARK: - ACCIÓN

    @objc private func volverAlInicioTapped() {
        // Regresa al menú principal cerrando las pantallas modales
        view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}

