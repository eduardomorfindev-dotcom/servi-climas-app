import UIKit

class VerificacionViewController: UIViewController, UITextFieldDelegate {

    let scrollView = UIScrollView()
    let contenidoView = UIView()
    
    let tituloLabel = UILabel()
    let subtituloLabel = UILabel()
    let codigoTextField = UITextField()
    let verificarButton = UIButton(type: .system)
    let reenviarButton = UIButton(type: .system)
    let regresarButton = UIButton(type: .system)

    var correoUsuario: String = ""

    /// Código "enviado" al correo. Como no hay backend de correo real,
    /// se genera aquí mismo y se muestra en una alerta para poder probarlo.
    private var codigoGenerado: String = ""

    private var segundosParaReenviar = 0
    private var temporizadorReenvio: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        configurarPantalla()
        configurarElementos()
        configurarLayout()
        generarYEnviarCodigo(mostrarAlerta: true)
    }

    deinit {
        temporizadorReenvio?.invalidate()
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

        reenviarButton.setTitleColor(.systemBlue, for: .normal)
        reenviarButton.setTitleColor(.tertiaryLabel, for: .disabled)
        reenviarButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        reenviarButton.addTarget(self, action: #selector(reenviarAccion), for: .touchUpInside)

        regresarButton.setTitle("Regresar", for: .normal)
        regresarButton.setTitleColor(.systemBlue, for: .normal)
        regresarButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        regresarButton.addTarget(self, action: #selector(regresarAccion), for: .touchUpInside)

        view.addSubview(scrollView)
        scrollView.addSubview(contenidoView)

        let subviews = [tituloLabel, subtituloLabel, codigoTextField, verificarButton, reenviarButton, regresarButton]
        subviews.forEach { contenidoView.addSubview($0) }
    }

    private func configurarLayout() {
        let elementos = [scrollView, contenidoView, tituloLabel, subtituloLabel, codigoTextField, verificarButton, reenviarButton, regresarButton]
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

            reenviarButton.topAnchor.constraint(equalTo: verificarButton.bottomAnchor, constant: 18),
            reenviarButton.centerXAnchor.constraint(equalTo: contenidoView.centerXAnchor),

            regresarButton.topAnchor.constraint(equalTo: reenviarButton.bottomAnchor, constant: 12),
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

        if codigo != codigoGenerado {
            mostrarAlerta(titulo: "Código incorrecto", mensaje: "El código no coincide. Verifica el que enviamos a tu correo.")
            codigoTextField.becomeFirstResponder()
            return
        }

        let alerta = UIAlertController(title: "¡Cuenta verificada!", message: "¡Bienvenido! Gracias por tu preferencia.", preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .default) { [weak self] _ in
            guard let self else { return }
            self.navigationController?.pushViewController(NuestrosServiciosViewController(), animated: true)
        })
        present(alerta, animated: true)
    }

    @objc private func reenviarAccion() {
        guard segundosParaReenviar == 0 else { return }
        generarYEnviarCodigo(mostrarAlerta: true)
    }

    @objc private func regresarAccion() {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Código simulado

    private func generarYEnviarCodigo(mostrarAlerta: Bool) {
        codigoGenerado = String(format: "%06d", Int.random(in: 0...999999))
        codigoTextField.text = ""
        iniciarCuentaRegresivaReenvio()

        if mostrarAlerta {
            let alerta = UIAlertController(
                title: "Código enviado",
                message: "Como esta es una app de demostración, tu código de verificación es:\n\n\(codigoGenerado)",
                preferredStyle: .alert
            )
            alerta.addAction(UIAlertAction(title: "Aceptar", style: .default))
            present(alerta, animated: true)
        }
    }

    private func iniciarCuentaRegresivaReenvio() {
        temporizadorReenvio?.invalidate()
        segundosParaReenviar = 30
        actualizarTituloReenviar()

        temporizadorReenvio = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] temporizador in
            guard let self else { return }
            self.segundosParaReenviar -= 1
            if self.segundosParaReenviar <= 0 {
                self.segundosParaReenviar = 0
                temporizador.invalidate()
            }
            self.actualizarTituloReenviar()
        }
    }

    private func actualizarTituloReenviar() {
        if segundosParaReenviar > 0 {
            reenviarButton.setTitle("Reenviar código (\(segundosParaReenviar)s)", for: .normal)
            reenviarButton.isEnabled = false
        } else {
            reenviarButton.setTitle("Reenviar código", for: .normal)
            reenviarButton.isEnabled = true
        }
    }

    private func mostrarAlerta(titulo: String, mensaje: String) {
        let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .default))
        present(alerta, animated: true)
    }
}
