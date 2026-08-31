import UIKit

class VerificacionViewController: UIViewController, UITextFieldDelegate {

    let scrollView = UIScrollView()
    let contenidoView = UIView()
    
    let tituloLabel = UILabel()
    let subtituloLabel = UILabel()
    let codigoTextField = UITextField()
    let verificarButton = UIButton(type: .system)
    let regresarButton = UIButton(type: .system)
    
    var correoUsuario: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        configurarPantalla()
        configurarElementos()
        configurarLayout()
    }

    private func configurarPantalla() {
        view.backgroundColor = .systemBackground
        let gesto = UITapGestureRecognizer(target: self, action: #selector(cerrarTeclado))
        gesto.cancelsTouchesInView = false
        view.addGestureRecognizer(gesto)
    }

    private func configurarElementos() {
        tituloLabel.text = "Verificar código"
        tituloLabel.font = UIFont(name: "AvenirNext-Bold", size: 28) ?? .boldSystemFont(ofSize: 28)
        tituloLabel.textColor = .label

        let correoTexto = correoUsuario.isEmpty ? "tu correo" : correoUsuario
        subtituloLabel.text = "Ingresa el código de 6 dígitos enviado a:\n\(correoTexto)"
        subtituloLabel.font = .systemFont(ofSize: 15, weight: .regular)
        subtituloLabel.textColor = .secondaryLabel
        subtituloLabel.numberOfLines = 0

        codigoTextField.placeholder = "000000"
        codigoTextField.borderStyle = .none
        codigoTextField.backgroundColor = .secondarySystemBackground
        codigoTextField.layer.cornerRadius = 14
        codigoTextField.layer.borderWidth = 1
        codigoTextField.layer.borderColor = UIColor.tertiarySystemFill.cgColor
        codigoTextField.font = .systemFont(ofSize: 24, weight: .bold)
        codigoTextField.textAlignment = .center
        codigoTextField.keyboardType = .numberPad
        codigoTextField.delegate = self

        verificarButton.setTitle("Verificar código", for: .normal)
        verificarButton.setTitleColor(.white, for: .normal)
        verificarButton.backgroundColor = .systemBlue
        verificarButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        verificarButton.layer.cornerRadius = 15
        verificarButton.addTarget(self, action: #selector(verificarAccion), for: .touchUpInside)

        regresarButton.setTitle("Regresar", for: .normal)
        regresarButton.setTitleColor(.systemBlue, for: .normal)
        regresarButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        regresarButton.addTarget(self, action: #selector(regresarAccion), for: .touchUpInside)

        view.addSubview(scrollView)
        scrollView.addSubview(contenidoView)

        let subviews = [tituloLabel, subtituloLabel, codigoTextField, verificarButton, regresarButton]
        subviews.forEach { contenidoView.addSubview($0) }
    }

    private func configurarLayout() {
        let elementos = [scrollView, contenidoView, tituloLabel, subtituloLabel, codigoTextField, verificarButton, regresarButton]
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

            tituloLabel.topAnchor.constraint(equalTo: contenidoView.topAnchor, constant: 30),
            tituloLabel.leadingAnchor.constraint(equalTo: contenidoView.leadingAnchor, constant: 25),
            tituloLabel.trailingAnchor.constraint(equalTo: contenidoView.trailingAnchor, constant: -25),

            subtituloLabel.topAnchor.constraint(equalTo: tituloLabel.bottomAnchor, constant: 8),
            subtituloLabel.leadingAnchor.constraint(equalTo: contenidoView.leadingAnchor, constant: 25),
            subtituloLabel.trailingAnchor.constraint(equalTo: contenidoView.trailingAnchor, constant: -25),

            codigoTextField.topAnchor.constraint(equalTo: subtituloLabel.bottomAnchor, constant: 25),
            codigoTextField.leadingAnchor.constraint(equalTo: contenidoView.leadingAnchor, constant: 25),
            codigoTextField.trailingAnchor.constraint(equalTo: contenidoView.trailingAnchor, constant: -25),
            codigoTextField.heightAnchor.constraint(equalToConstant: 60),

            verificarButton.topAnchor.constraint(equalTo: codigoTextField.bottomAnchor, constant: 22),
            verificarButton.leadingAnchor.constraint(equalTo: codigoTextField.leadingAnchor),
            verificarButton.trailingAnchor.constraint(equalTo: codigoTextField.trailingAnchor),
            verificarButton.heightAnchor.constraint(equalToConstant: 52),

            regresarButton.topAnchor.constraint(equalTo: verificarButton.bottomAnchor, constant: 15),
            regresarButton.centerXAnchor.constraint(equalTo: contenidoView.centerXAnchor),
            regresarButton.bottomAnchor.constraint(equalTo: contenidoView.bottomAnchor, constant: -30)
        ])
    }

    @objc private func cerrarTeclado() {
        view.endEditing(true)
    }

    @objc private func verificarAccion() {
        let codigo = codigoTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        if codigo.isEmpty || codigo.count < 6 {
            mostrarAlerta(titulo: "Código incompleto", mensaje: "Ingresa el código de 6 dígitos enviado a tu correo.")
            codigoTextField.becomeFirstResponder()
            return
        }

        let alerta = UIAlertController(title: "¡Cuenta verificada!", message: "¡Bienvenido! Gracias por tu preferencia.", preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .default) { [weak self] _ in
            let serviciosVC = NuestrosServiciosViewController()
            serviciosVC.modalPresentationStyle = .fullScreen
            self?.present(serviciosVC, animated: true, completion: nil)
        })
        present(alerta, animated: true)
    }

    @objc private func regresarAccion() {
        dismiss(animated: true, completion: nil)
    }

    private func mostrarAlerta(titulo: String, mensaje: String) {
        let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .default))
        present(alerta, animated: true)
    }
}
