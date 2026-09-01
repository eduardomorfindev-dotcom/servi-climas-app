import UIKit

class ConfirmacionInstalacionViewController: UIViewController {

    let scrollView = UIScrollView()
    let contenidoView = UIView()

    let iconoImageView = UIImageView()
    let tituloLabel = UILabel()
    let mensajeLabel = UILabel()
    let finalizarButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        configurarPantalla()
        configurarElementos()
        configurarLayout()
    }

    private func configurarPantalla() {
        view.backgroundColor = .systemGroupedBackground
        scrollView.showsVerticalScrollIndicator = false
        navigationItem.hidesBackButton = true
    }

    private func configurarElementos() {
        // Icono de palomita verde de éxito
        let configuracionSimbolo = UIImage.SymbolConfiguration(pointSize: 70, weight: .bold)
        iconoImageView.image = UIImage(systemName: "checkmark.circle.fill", withConfiguration: configuracionSimbolo)
        iconoImageView.tintColor = .systemGreen
        iconoImageView.contentMode = .scaleAspectFit

        tituloLabel.text = "¡Solicitud Exitosa!"
        tituloLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        tituloLabel.textColor = .label
        tituloLabel.textAlignment = .center

        mensajeLabel.text = "Hemos registrado tu solicitud de instalación correctamente. Nos pondremos en contacto contigo muy pronto para coordinar los detalles."
        mensajeLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        mensajeLabel.textColor = .secondaryLabel
        mensajeLabel.textAlignment = .center
        mensajeLabel.numberOfLines = 0

        finalizarButton.setTitle("Volver al Menú Principal", for: .normal)
        finalizarButton.setTitleColor(.white, for: .normal)
        finalizarButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        finalizarButton.backgroundColor = .systemBlue
        finalizarButton.layer.cornerRadius = 16
        finalizarButton.addTarget(self, action: #selector(finalizarAccion), for: .touchUpInside)

        view.addSubview(scrollView)
        scrollView.addSubview(contenidoView)

        let subviews = [
            iconoImageView,
            tituloLabel,
            mensajeLabel,
            finalizarButton
        ]

        subviews.forEach {
            contenidoView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contenidoView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func configurarLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contenidoView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contenidoView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contenidoView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contenidoView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contenidoView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            iconoImageView.topAnchor.constraint(equalTo: contenidoView.topAnchor, constant: 60),
            iconoImageView.centerXAnchor.constraint(equalTo: contenidoView.centerXAnchor),
            iconoImageView.heightAnchor.constraint(equalToConstant: 90),
            iconoImageView.widthAnchor.constraint(equalToConstant: 90),

            tituloLabel.topAnchor.constraint(equalTo: iconoImageView.bottomAnchor, constant: 24),
            tituloLabel.leadingAnchor.constraint(equalTo: contenidoView.leadingAnchor, constant: 24),
            tituloLabel.trailingAnchor.constraint(equalTo: contenidoView.trailingAnchor, constant: -24),

            mensajeLabel.topAnchor.constraint(equalTo: tituloLabel.bottomAnchor, constant: 12),
            mensajeLabel.leadingAnchor.constraint(equalTo: contenidoView.leadingAnchor, constant: 32),
            mensajeLabel.trailingAnchor.constraint(equalTo: contenidoView.trailingAnchor, constant: -32),

            finalizarButton.topAnchor.constraint(equalTo: mensajeLabel.bottomAnchor, constant: 48),
            finalizarButton.leadingAnchor.constraint(equalTo: contenidoView.leadingAnchor, constant: 24),
            finalizarButton.trailingAnchor.constraint(equalTo: contenidoView.trailingAnchor, constant: -24),
            finalizarButton.heightAnchor.constraint(equalToConstant: 54),
            finalizarButton.bottomAnchor.constraint(equalTo: contenidoView.bottomAnchor, constant: -40)
        ])
    }

    @objc private func finalizarAccion() {
        // Cierra todas las pantallas modales acumuladas y regresa hasta Nuestros Servicios
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
