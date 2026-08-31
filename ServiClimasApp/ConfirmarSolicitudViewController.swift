import UIKit

class ConfirmarSolicitudViewController: UIViewController {

    // MARK: - DATOS RECIBIDOS

    private let servicio: String
    private let equipo: String
    private let fecha: String
    private let hora: String
    private let comentario: String

    // MARK: - ELEMENTOS

    let scrollView = UIScrollView()
    let contenidoView = UIView()

    let tituloLabel = UILabel()
    let descripcionLabel = UILabel()

    let servicioTituloLabel = UILabel()
    let servicioLabel = UILabel()

    let equipoTituloLabel = UILabel()
    let equipoLabel = UILabel()

    let fechaTituloLabel = UILabel()
    let fechaLabel = UILabel()

    let horaTituloLabel = UILabel()
    let horaLabel = UILabel()

    let comentarioTituloLabel = UILabel()
    let comentarioLabel = UILabel()

    let confirmarButton = UIButton(type: .system)
    let regresarButton = UIButton(type: .system)

    // MARK: - CONSTRUCTOR

    init(
        servicio: String,
        equipo: String,
        fecha: String,
        hora: String,
        comentario: String
    ) {
        self.servicio = servicio
        self.equipo = equipo
        self.fecha = fecha
        self.hora = hora
        self.comentario = comentario

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) no está implementado")
    }

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
        navigationItem.title = "Confirmar solicitud"

        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true

        contenidoView.backgroundColor = .clear
    }

    // MARK: - ELEMENTOS

    private func configurarElementos() {

        // MARK: TÍTULO

        tituloLabel.text = "Confirma tu solicitud"
        tituloLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        tituloLabel.textColor = .label
        tituloLabel.numberOfLines = 0

        // MARK: DESCRIPCIÓN

        descripcionLabel.text = "Revisa los datos de tu servicio antes de confirmar."
        descripcionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        descripcionLabel.textColor = .secondaryLabel
        descripcionLabel.numberOfLines = 0

        // MARK: SERVICIO

        servicioTituloLabel.text = "Servicio"
        configurarTitulo(servicioTituloLabel)

        servicioLabel.text = servicio
        configurarDato(servicioLabel)

        // MARK: EQUIPO

        equipoTituloLabel.text = "Tipo de equipo"
        configurarTitulo(equipoTituloLabel)

        equipoLabel.text = equipo
        configurarDato(equipoLabel)

        // MARK: FECHA

        fechaTituloLabel.text = "Fecha del servicio"
        configurarTitulo(fechaTituloLabel)

        fechaLabel.text = fecha
        configurarDato(fechaLabel)

        // MARK: HORA

        horaTituloLabel.text = "Horario"
        configurarTitulo(horaTituloLabel)

        horaLabel.text = hora
        configurarDato(horaLabel)

        // MARK: COMENTARIO

        comentarioTituloLabel.text = "Comentario adicional"
        configurarTitulo(comentarioTituloLabel)

        comentarioLabel.text = comentario
        configurarDato(comentarioLabel)
        comentarioLabel.numberOfLines = 0

        // MARK: CONFIRMAR

        var configuracion = UIButton.Configuration.filled()
        configuracion.title = "Confirmar solicitud"
        configuracion.image = UIImage(systemName: "checkmark.circle.fill")
        configuracion.imagePlacement = .leading
        configuracion.imagePadding = 10
        configuracion.baseBackgroundColor = .systemBlue
        configuracion.baseForegroundColor = .white
        configuracion.cornerStyle = .large
        configuracion.contentInsets = NSDirectionalEdgeInsets(
            top: 16,
            leading: 20,
            bottom: 16,
            trailing: 20
        )

        confirmarButton.configuration = configuracion
        confirmarButton.layer.cornerRadius = 18
        confirmarButton.layer.shadowColor = UIColor.black.cgColor
        confirmarButton.layer.shadowOpacity = 0.15
        confirmarButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        confirmarButton.layer.shadowRadius = 8

        confirmarButton.addTarget(
            self,
            action: #selector(confirmarSolicitud),
            for: .touchUpInside
        )

        // MARK: REGRESAR

        regresarButton.setTitle("Regresar", for: .normal)
        regresarButton.setTitleColor(.systemBlue, for: .normal)
        regresarButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)

        regresarButton.addTarget(
            self,
            action: #selector(regresar),
            for: .touchUpInside
        )

        // MARK: AGREGAR VISTAS

        view.addSubview(scrollView)
        scrollView.addSubview(contenidoView)

        let elementos = [
            tituloLabel,
            descripcionLabel,
            servicioTituloLabel,
            servicioLabel,
            equipoTituloLabel,
            equipoLabel,
            fechaTituloLabel,
            fechaLabel,
            horaTituloLabel,
            horaLabel,
            comentarioTituloLabel,
            comentarioLabel,
            confirmarButton,
            regresarButton
        ]

        elementos.forEach {
            contenidoView.addSubview($0)
        }
    }

    // MARK: - ESTILO TITULO

    private func configurarTitulo(_ label: UILabel) {
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
    }

    // MARK: - ESTILO DATO

    private func configurarDato(_ label: UILabel) {
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
    }

    // MARK: - LAYOUT

    private func configurarLayout() {

        let elementos = [
            scrollView,
            contenidoView,
            tituloLabel,
            descripcionLabel,
            servicioTituloLabel,
            servicioLabel,
            equipoTituloLabel,
            equipoLabel,
            fechaTituloLabel,
            fechaLabel,
            horaTituloLabel,
            horaLabel,
            comentarioTituloLabel,
            comentarioLabel,
            confirmarButton,
            regresarButton
        ]

        elementos.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([

            // MARK: SCROLL

            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            // MARK: CONTENIDO

            contenidoView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contenidoView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contenidoView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contenidoView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contenidoView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            // MARK: TÍTULO

            tituloLabel.topAnchor.constraint(equalTo: contenidoView.topAnchor, constant: 30),
            tituloLabel.leadingAnchor.constraint(equalTo: contenidoView.leadingAnchor, constant: 24),
            tituloLabel.trailingAnchor.constraint(equalTo: contenidoView.trailingAnchor, constant: -24),

            // MARK: DESCRIPCIÓN

            descripcionLabel.topAnchor.constraint(equalTo: tituloLabel.bottomAnchor, constant: 8),
            descripcionLabel.leadingAnchor.constraint(equalTo: tituloLabel.leadingAnchor),
            descripcionLabel.trailingAnchor.constraint(equalTo: tituloLabel.trailingAnchor),

            // MARK: SERVICIO

            servicioTituloLabel.topAnchor.constraint(equalTo: descripcionLabel.bottomAnchor, constant: 30),
            servicioTituloLabel.leadingAnchor.constraint(equalTo: tituloLabel.leadingAnchor),

            servicioLabel.topAnchor.constraint(equalTo: servicioTituloLabel.bottomAnchor, constant: 8),
            servicioLabel.leadingAnchor.constraint(equalTo: tituloLabel.leadingAnchor),
            servicioLabel.trailingAnchor.constraint(equalTo: tituloLabel.trailingAnchor),

            // MARK: EQUIPO

            equipoTituloLabel.topAnchor.constraint(equalTo: servicioLabel.bottomAnchor, constant: 24),
            equipoTituloLabel.leadingAnchor.constraint(equalTo: tituloLabel.leadingAnchor),

            equipoLabel.topAnchor.constraint(equalTo: equipoTituloLabel.bottomAnchor, constant: 8),
            equipoLabel.leadingAnchor.constraint(equalTo: tituloLabel.leadingAnchor),
            equipoLabel.trailingAnchor.constraint(equalTo: tituloLabel.trailingAnchor),

            // MARK: FECHA

            fechaTituloLabel.topAnchor.constraint(equalTo: equipoLabel.bottomAnchor, constant: 24),
            fechaTituloLabel.leadingAnchor.constraint(equalTo: tituloLabel.leadingAnchor),

            fechaLabel.topAnchor.constraint(equalTo: fechaTituloLabel.bottomAnchor, constant: 8),
            fechaLabel.leadingAnchor.constraint(equalTo: tituloLabel.leadingAnchor),
            fechaLabel.trailingAnchor.constraint(equalTo: tituloLabel.trailingAnchor),

            // MARK: HORA

            horaTituloLabel.topAnchor.constraint(equalTo: fechaLabel.bottomAnchor, constant: 24),
            horaTituloLabel.leadingAnchor.constraint(equalTo: tituloLabel.leadingAnchor),

            horaLabel.topAnchor.constraint(equalTo: horaTituloLabel.bottomAnchor, constant: 8),
            horaLabel.leadingAnchor.constraint(equalTo: tituloLabel.leadingAnchor),
            horaLabel.trailingAnchor.constraint(equalTo: tituloLabel.trailingAnchor),

            // MARK: COMENTARIO

            comentarioTituloLabel.topAnchor.constraint(equalTo: horaLabel.bottomAnchor, constant: 24),
            comentarioTituloLabel.leadingAnchor.constraint(equalTo: tituloLabel.leadingAnchor),

            comentarioLabel.topAnchor.constraint(equalTo: comentarioTituloLabel.bottomAnchor, constant: 8),
            comentarioLabel.leadingAnchor.constraint(equalTo: tituloLabel.leadingAnchor),
            comentarioLabel.trailingAnchor.constraint(equalTo: tituloLabel.trailingAnchor),

            // MARK: CONFIRMAR

            confirmarButton.topAnchor.constraint(equalTo: comentarioLabel.bottomAnchor, constant: 32),
            confirmarButton.leadingAnchor.constraint(equalTo: tituloLabel.leadingAnchor),
            confirmarButton.trailingAnchor.constraint(equalTo: tituloLabel.trailingAnchor),
            confirmarButton.heightAnchor.constraint(equalToConstant: 58),

            // MARK: REGRESAR

            regresarButton.topAnchor.constraint(equalTo: confirmarButton.bottomAnchor, constant: 14),
            regresarButton.centerXAnchor.constraint(equalTo: contenidoView.centerXAnchor),
            regresarButton.bottomAnchor.constraint(equalTo: contenidoView.bottomAnchor, constant: -32)
        ])
    }

    // MARK: - CONFIRMAR SOLICITUD

    @objc private func confirmarSolicitud() {
        // Instancia directamente la clase por código sin usar el Storyboard
        let destinoVC = ConfirmacionEnviadaViewController()
        
        // Pasamos los datos hacia la pantalla de éxito
        destinoVC.servicio = self.servicio
        destinoVC.equipo = self.equipo
        destinoVC.fecha = self.fecha
        destinoVC.hora = self.hora
        destinoVC.comentario = self.comentario
        
        destinoVC.modalPresentationStyle = .fullScreen
        self.present(destinoVC, animated: true, completion: nil)
    }

    // MARK: - REGRESAR

    @objc private func regresar() {
        dismiss(animated: true)
    }
}
