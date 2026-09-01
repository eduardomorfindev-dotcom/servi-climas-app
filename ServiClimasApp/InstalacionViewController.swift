import UIKit

class InstalacionViewController: UIViewController {

    let scrollView = UIScrollView()
    let contenidoView = UIView()

    let regresarButton = UIButton(type: .system)
    let tituloLabel = UILabel()
    let descripcionLabel = UILabel()

    let minisplitButton = UIButton(type: .system)
    let paqueteButton = UIButton(type: .system)
    
    let fechaLabel = UILabel()
    let datePicker = UIDatePicker()
    
    let confirmarButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        configurarPantalla()
        configurarElementos()
        configurarLayout()
    }

    private func configurarPantalla() {
        view.backgroundColor = .systemGroupedBackground
        scrollView.showsVerticalScrollIndicator = false
        navigationItem.title = ""
    }

    private func configurarElementos() {
        regresarButton.setTitle("Regresar", for: .normal)
        regresarButton.setTitleColor(.systemBlue, for: .normal)
        regresarButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        regresarButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        regresarButton.tintColor = .systemBlue
        regresarButton.addTarget(self, action: #selector(regresarAccion), for: .touchUpInside)

        tituloLabel.text = "Instalación de Equipos"
        tituloLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        tituloLabel.textColor = .label

        descripcionLabel.text = "Selecciona el tipo de equipo:"
        descripcionLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        descripcionLabel.textColor = .secondaryLabel

        configurarOpcionBoton(boton: minisplitButton, titulo: "Minisplit", descripcion: "Instalación residencial", icono: "snowflake")
        minisplitButton.addTarget(self, action: #selector(seleccionarMinisplit), for: .touchUpInside)

        configurarOpcionBoton(boton: paqueteButton, titulo: "Aire de Paquete / Central", descripcion: "Equipos comerciales", icono: "building.2.fill")
        paqueteButton.addTarget(self, action: #selector(seleccionarPaquete), for: .touchUpInside)

        fechaLabel.text = "Selecciona fecha y hora para la cita:"
        fechaLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        fechaLabel.textColor = .label

        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .compact
        datePicker.locale = Locale(identifier: "es_MX")

        confirmarButton.setTitle("Continuar con la Solicitud", for: .normal)
        confirmarButton.setTitleColor(.white, for: .normal)
        confirmarButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        confirmarButton.backgroundColor = .systemBlue
        confirmarButton.layer.cornerRadius = 16
        confirmarButton.addTarget(self, action: #selector(confirmarAccion), for: .touchUpInside)

        view.addSubview(scrollView)
        scrollView.addSubview(contenidoView)

        let subviews = [regresarButton, tituloLabel, descripcionLabel, minisplitButton, paqueteButton, fechaLabel, datePicker, confirmarButton]
        subviews.forEach {
            contenidoView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contenidoView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func configurarOpcionBoton(boton: UIButton, titulo: String, descripcion: String, icono: String) {
        var configuracion = UIButton.Configuration.filled()
        configuracion.title = titulo
        configuracion.subtitle = descripcion
        configuracion.image = UIImage(systemName: icono)
        configuracion.imagePlacement = .leading
        configuracion.imagePadding = 16
        configuracion.baseForegroundColor = .label
        configuracion.baseBackgroundColor = .secondarySystemGroupedBackground
        configuracion.cornerStyle = .large
        boton.configuration = configuracion
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

            regresarButton.topAnchor.constraint(equalTo: contenidoView.topAnchor, constant: 16),
            regresarButton.leadingAnchor.constraint(equalTo: contenidoView.leadingAnchor, constant: 24),

            tituloLabel.topAnchor.constraint(equalTo: regresarButton.bottomAnchor, constant: 16),
            tituloLabel.leadingAnchor.constraint(equalTo: contenidoView.leadingAnchor, constant: 24),
            tituloLabel.trailingAnchor.constraint(equalTo: contenidoView.trailingAnchor, constant: -24),

            descripcionLabel.topAnchor.constraint(equalTo: tituloLabel.bottomAnchor, constant: 8),
            descripcionLabel.leadingAnchor.constraint(equalTo: contenidoView.leadingAnchor, constant: 24),
            descripcionLabel.trailingAnchor.constraint(equalTo: contenidoView.trailingAnchor, constant: -24),

            minisplitButton.topAnchor.constraint(equalTo: descripcionLabel.bottomAnchor, constant: 16),
            minisplitButton.leadingAnchor.constraint(equalTo: contenidoView.leadingAnchor, constant: 20),
            minisplitButton.trailingAnchor.constraint(equalTo: contenidoView.trailingAnchor, constant: -20),
            minisplitButton.heightAnchor.constraint(equalToConstant: 76),

            paqueteButton.topAnchor.constraint(equalTo: minisplitButton.bottomAnchor, constant: 12),
            paqueteButton.leadingAnchor.constraint(equalTo: minisplitButton.leadingAnchor),
            paqueteButton.trailingAnchor.constraint(equalTo: minisplitButton.trailingAnchor),
            paqueteButton.heightAnchor.constraint(equalToConstant: 76),

            fechaLabel.topAnchor.constraint(equalTo: paqueteButton.bottomAnchor, constant: 24),
            fechaLabel.leadingAnchor.constraint(equalTo: contenidoView.leadingAnchor, constant: 24),
            fechaLabel.trailingAnchor.constraint(equalTo: contenidoView.trailingAnchor, constant: -24),

            datePicker.topAnchor.constraint(equalTo: fechaLabel.bottomAnchor, constant: 12),
            datePicker.leadingAnchor.constraint(equalTo: contenidoView.leadingAnchor, constant: 24),

            confirmarButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 32),
            confirmarButton.leadingAnchor.constraint(equalTo: contenidoView.leadingAnchor, constant: 20),
            confirmarButton.trailingAnchor.constraint(equalTo: contenidoView.trailingAnchor, constant: -20),
            confirmarButton.heightAnchor.constraint(equalToConstant: 54),
            confirmarButton.bottomAnchor.constraint(equalTo: contenidoView.bottomAnchor, constant: -32)
        ])
    }

    @objc private func regresarAccion() {
        dismiss(animated: true)
    }

    @objc private func seleccionarMinisplit() {
        minisplitButton.layer.borderWidth = 2
        minisplitButton.layer.borderColor = UIColor.systemBlue.cgColor
        paqueteButton.layer.borderWidth = 0
    }

    @objc private func seleccionarPaquete() {
        paqueteButton.layer.borderWidth = 2
        paqueteButton.layer.borderColor = UIColor.systemBlue.cgColor
        minisplitButton.layer.borderWidth = 0
    }

    @objc private func confirmarAccion() {
        let pantallaConfirmacion = ConfirmacionInstalacionViewController()
        pantallaConfirmacion.modalPresentationStyle = .fullScreen
        present(pantallaConfirmacion, animated: true, completion: nil)
    }
}
