import UIKit

class AgendarCitaViewController: UIViewController, UITextFieldDelegate {

    let scrollView = UIScrollView()
    let contenidoView = UIView()
    let tituloLabel = UILabel()

    let nombreTextField = UITextField()
    let fechaTextField = UITextField()
    let servicioTextField = UITextField()

    let guardarCitaButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Agendar Cita"

        configurarUI()
    }

    func configurarUI() {

        // ScrollView
        view.addSubview(scrollView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(contenidoView)

        contenidoView.translatesAutoresizingMaskIntoConstraints = false

        // Título
        tituloLabel.text = "Nueva Cita de Servicio"
        tituloLabel.font = UIFont.boldSystemFont(ofSize: 22)
        tituloLabel.translatesAutoresizingMaskIntoConstraints = false

        contenidoView.addSubview(tituloLabel)

        // Campos de texto
        configurarTextField(
            nombreTextField,
            placeholder: "Nombre del cliente"
        )

        configurarTextField(
            fechaTextField,
            placeholder: "Fecha (Ej: 31/08/2026)"
        )

        configurarTextField(
            servicioTextField,
            placeholder: "Tipo de servicio (Ej: Clima/Refrigeración)"
        )

        // Botón
        guardarCitaButton.setTitle("Guardar Cita", for: .normal)
        guardarCitaButton.backgroundColor = .systemBlue
        guardarCitaButton.setTitleColor(.white, for: .normal)
        guardarCitaButton.layer.cornerRadius = 8
        guardarCitaButton.translatesAutoresizingMaskIntoConstraints = false

        guardarCitaButton.addTarget(
            self,
            action: #selector(funcGuardarTapped),
            for: .touchUpInside
        )

        contenidoView.addSubview(guardarCitaButton)

        // Constraints
        NSLayoutConstraint.activate([

            scrollView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),

            scrollView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),

            scrollView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),

            scrollView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),

            contenidoView.topAnchor.constraint(
                equalTo: scrollView.topAnchor
            ),

            contenidoView.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor
            ),

            contenidoView.trailingAnchor.constraint(
                equalTo: scrollView.trailingAnchor
            ),

            contenidoView.bottomAnchor.constraint(
                equalTo: scrollView.bottomAnchor
            ),

            contenidoView.widthAnchor.constraint(
                equalTo: scrollView.widthAnchor
            ),

            tituloLabel.topAnchor.constraint(
                equalTo: contenidoView.topAnchor,
                constant: 30
            ),

            tituloLabel.centerXAnchor.constraint(
                equalTo: contenidoView.centerXAnchor
            ),

            nombreTextField.topAnchor.constraint(
                equalTo: tituloLabel.bottomAnchor,
                constant: 30
            ),

            nombreTextField.leadingAnchor.constraint(
                equalTo: contenidoView.leadingAnchor,
                constant: 24
            ),

            nombreTextField.trailingAnchor.constraint(
                equalTo: contenidoView.trailingAnchor,
                constant: -24
            ),

            nombreTextField.heightAnchor.constraint(
                equalToConstant: 45
            ),

            fechaTextField.topAnchor.constraint(
                equalTo: nombreTextField.bottomAnchor,
                constant: 16
            ),

            fechaTextField.leadingAnchor.constraint(
                equalTo: contenidoView.leadingAnchor,
                constant: 24
            ),

            fechaTextField.trailingAnchor.constraint(
                equalTo: contenidoView.trailingAnchor,
                constant: -24
            ),

            fechaTextField.heightAnchor.constraint(
                equalToConstant: 45
            ),

            servicioTextField.topAnchor.constraint(
                equalTo: fechaTextField.bottomAnchor,
                constant: 16
            ),

            servicioTextField.leadingAnchor.constraint(
                equalTo: contenidoView.leadingAnchor,
                constant: 24
            ),

            servicioTextField.trailingAnchor.constraint(
                equalTo: contenidoView.trailingAnchor,
                constant: -24
            ),

            servicioTextField.heightAnchor.constraint(
                equalToConstant: 45
            ),

            guardarCitaButton.topAnchor.constraint(
                equalTo: servicioTextField.bottomAnchor,
                constant: 40
            ),

            guardarCitaButton.leadingAnchor.constraint(
                equalTo: contenidoView.leadingAnchor,
                constant: 24
            ),

            guardarCitaButton.trailingAnchor.constraint(
                equalTo: contenidoView.trailingAnchor,
                constant: -24
            ),

            guardarCitaButton.heightAnchor.constraint(
                equalToConstant: 50
            ),

            guardarCitaButton.bottomAnchor.constraint(
                equalTo: contenidoView.bottomAnchor,
                constant: -40
            )
        ])
    }

    func configurarTextField(
        _ textField: UITextField,
        placeholder: String
    ) {

        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false

        contenidoView.addSubview(textField)
    }

    @objc func funcGuardarTapped() {

        // Aquí agregaremos después la lógica para guardar la cita.

    }
}
