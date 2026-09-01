import UIKit

class CompraAireViewController: UIViewController {

    let scrollView = UIScrollView()
    let contenidoView = UIView()

    let regresarButton = UIButton(type: .system)
    let tituloLabel = UILabel()
    let descripcionLabel = UILabel()

    let tamanoSegmento = UISegmentedControl(items: ["Chico", "Mediano", "Grande"])

    let equipo1Button = UIButton(type: .system)
    let equipo2Button = UIButton(type: .system)
    let equipo3Button = UIButton(type: .system)

    let solicitarButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        configurarPantalla()
        configurarElementos()
        configurarLayout()
    }

    private func configurarPantalla() {
        view.backgroundColor = .systemGroupedBackground
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        contenidoView.backgroundColor = .clear
        navigationItem.title = ""
    }

    private func configurarElementos() {
        regresarButton.setTitle("Regresar", for: .normal)
        regresarButton.setTitleColor(.systemBlue, for: .normal)
        regresarButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        regresarButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        regresarButton.tintColor = .systemBlue
        regresarButton.addTarget(self, action: #selector(regresarAccion), for: .touchUpInside)

        tituloLabel.text = "Comprar aire acondicionado"
        tituloLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        tituloLabel.textColor = .label
        tituloLabel.numberOfLines = 0

        descripcionLabel.text = "Encuentra el equipo ideal para tu espacio"
        descripcionLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        descripcionLabel.textColor = .secondaryLabel
        descripcionLabel.numberOfLines = 0

        tamanoSegmento.selectedSegmentIndex = 0

        configurarEquipoBoton(
            boton: equipo1Button,
            titulo: "Equipo 12,000 BTU",
            subtitulo: "$8,999 · Ideal para espacios chicos",
            icono: "snowflake"
        )
        equipo1Button.addTarget(self, action: #selector(equipo1Accion), for: .touchUpInside)

        configurarEquipoBoton(
            boton: equipo2Button,
            titulo: "Equipo 18,000 BTU",
            subtitulo: "$12,499 · Ideal para espacios medianos",
            icono: "snowflake"
        )
        equipo2Button.addTarget(self, action: #selector(equipo2Accion), for: .touchUpInside)

        configurarEquipoBoton(
            boton: equipo3Button,
            titulo: "Equipo 24,000 BTU",
            subtitulo: "$15,999 · Ideal para espacios grandes",
            icono: "snowflake"
        )
        equipo3Button.addTarget(self, action: #selector(equipo3Accion), for: .touchUpInside)

        var configuracionSolicitar = UIButton.Configuration.filled()
        configuracionSolicitar.title = "Solicitar cotización"
        configuracionSolicitar.image = UIImage(systemName: "cart.fill")
        configuracionSolicitar.imagePlacement = .leading
        configuracionSolicitar.imagePadding = 12
        configuracionSolicitar.baseForegroundColor = .white
        configuracionSolicitar.baseBackgroundColor = .systemIndigo
        configuracionSolicitar.cornerStyle = .large
        configuracionSolicitar.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 20, bottom: 14, trailing: 20)
        solicitarButton.configuration = configuracionSolicitar
        solicitarButton.addTarget(self, action: #selector(solicitarAccion), for: .touchUpInside)

        [regresarButton, tituloLabel, descripcionLabel, tamanoSegmento,
         equipo1Button, equipo2Button, equipo3Button, solicitarButton].forEach {
            contenidoView.addSubview($0)
        }
        view.addSubview(scrollView)
        scrollView.addSubview(contenidoView)
    }

    private func configurarEquipoBoton(boton: UIButton, titulo: String, subtitulo: String, icono: String) {
        var configuracion = UIButton.Configuration.filled()
        configuracion.title = titulo
        configuracion.subtitle = subtitulo
        configuracion.image = UIImage(systemName: icono)
        configuracion.imagePlacement = .leading
        configuracion.imagePadding = 16
        configuracion.baseForegroundColor = .white
        configuracion.baseBackgroundColor = .systemBlue
        configuracion.cornerStyle = .large
        configuracion.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20)

        configuracion.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { atributos in
            var nuevos = atributos
            nuevos.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            return nuevos
        }

        configuracion.subtitleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { atributos in
            var nuevos = atributos
            nuevos.font = UIFont.systemFont(ofSize: 13, weight: .regular)
            nuevos.foregroundColor = UIColor.white.withAlphaComponent(0.85)
            return nuevos
        }

        boton.configuration = configuracion
        boton.layer.cornerRadius = 18
        boton.layer.shadowColor = UIColor.black.cgColor
        boton.layer.shadowOpacity = 0.12
        boton.layer.shadowOffset = CGSize(width: 0, height: 4)
        boton.layer.shadowRadius = 8
        boton.clipsToBounds = false
    }

    private func configurarLayout() {
        let elementos = [scrollView, contenidoView, regresarButton, tituloLabel, descripcionLabel,
                          tamanoSegmento, equipo1Button, equipo2Button, equipo3Button, solicitarButton]
        elementos.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

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

            regresarButton.topAnchor.constraint(equalTo: contenidoView.topAnchor, constant: 16),
            regresarButton.leadingAnchor.constraint(equalTo: contenidoView.leadingAnchor, constant: 24),

            tituloLabel.topAnchor.constraint(equalTo: regresarButton.bottomAnchor, constant: 16),
            tituloLabel.leadingAnchor.constraint(equalTo: contenidoView.leadingAnchor, constant: 24),
            tituloLabel.trailingAnchor.constraint(equalTo: contenidoView.trailingAnchor, constant: -24),

            descripcionLabel.topAnchor.constraint(equalTo: tituloLabel.bottomAnchor, constant: 8),
            descripcionLabel.leadingAnchor.constraint(equalTo: contenidoView.leadingAnchor, constant: 24),
            descripcionLabel.trailingAnchor.constraint(equalTo: contenidoView.trailingAnchor, constant: -24),

            tamanoSegmento.topAnchor.constraint(equalTo: descripcionLabel.bottomAnchor, constant: 20),
            tamanoSegmento.leadingAnchor.constraint(equalTo: contenidoView.leadingAnchor, constant: 24),
            tamanoSegmento.trailingAnchor.constraint(equalTo: contenidoView.trailingAnchor, constant: -24),

            equipo1Button.topAnchor.constraint(equalTo: tamanoSegmento.bottomAnchor, constant: 24),
            equipo1Button.leadingAnchor.constraint(equalTo: contenidoView.leadingAnchor, constant: 20),
            equipo1Button.trailingAnchor.constraint(equalTo: contenidoView.trailingAnchor, constant: -20),
            equipo1Button.heightAnchor.constraint(equalToConstant: 76),

            equipo2Button.topAnchor.constraint(equalTo: equipo1Button.bottomAnchor, constant: 14),
            equipo2Button.leadingAnchor.constraint(equalTo: equipo1Button.leadingAnchor),
            equipo2Button.trailingAnchor.constraint(equalTo: equipo1Button.trailingAnchor),
            equipo2Button.heightAnchor.constraint(equalToConstant: 76),

            equipo3Button.topAnchor.constraint(equalTo: equipo2Button.bottomAnchor, constant: 14),
            equipo3Button.leadingAnchor.constraint(equalTo: equipo1Button.leadingAnchor),
            equipo3Button.trailingAnchor.constraint(equalTo: equipo1Button.trailingAnchor),
            equipo3Button.heightAnchor.constraint(equalToConstant: 76),

            solicitarButton.topAnchor.constraint(equalTo: equipo3Button.bottomAnchor, constant: 32),
            solicitarButton.leadingAnchor.constraint(equalTo: equipo1Button.leadingAnchor),
            solicitarButton.trailingAnchor.constraint(equalTo: equipo1Button.trailingAnchor),
            solicitarButton.heightAnchor.constraint(equalToConstant: 56),
            solicitarButton.bottomAnchor.constraint(equalTo: contenidoView.bottomAnchor, constant: -32)
        ])
    }

    @objc private func regresarAccion() {
        dismiss(animated: true)
    }

    @objc private func equipo1Accion() {
        mostrarDetalle(nombre: "Equipo 12,000 BTU", precio: "$8,999")
    }

    @objc private func equipo2Accion() {
        mostrarDetalle(nombre: "Equipo 18,000 BTU", precio: "$12,499")
    }

    @objc private func equipo3Accion() {
        mostrarDetalle(nombre: "Equipo 24,000 BTU", precio: "$15,999")
    }

    private func mostrarDetalle(nombre: String, precio: String) {
        let alerta = UIAlertController(
            title: nombre,
            message: "Precio: \(precio)",
            preferredStyle: .alert
        )
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .default))
        present(alerta, animated: true)
    }

    @objc private func solicitarAccion() {
        let alerta = UIAlertController(
            title: "Solicitud enviada",
            message: "Un asesor te contactará pronto para cerrar tu compra.",
            preferredStyle: .alert
        )
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .default))
        present(alerta, animated: true)
    }
}
