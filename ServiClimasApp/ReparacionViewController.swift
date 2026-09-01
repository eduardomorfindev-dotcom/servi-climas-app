import UIKit

class ReparacionViewController: UIViewController {

    let scrollView = UIScrollView()
    let contenidoView = UIView()

    let regresarButton = UIButton(type: .system)
    let tituloLabel = UILabel()
    let descripcionLabel = UILabel()

    let problemaTextView = UITextView()
    let problemaPlaceholder = "Describe brevemente la falla (ej. no enfría, hace ruido, fuga de agua...)"

    let agendarButton = UIButton(type: .system)

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

        tituloLabel.text = "Reparación"
        tituloLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        tituloLabel.textColor = .label

        descripcionLabel.text = "Diagnóstico y solución de fallas"
        descripcionLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        descripcionLabel.textColor = .secondaryLabel
        descripcionLabel.numberOfLines = 0

        problemaTextView.font = UIFont.systemFont(ofSize: 16)
        problemaTextView.text = problemaPlaceholder
        problemaTextView.textColor = .placeholderText
        problemaTextView.backgroundColor = .secondarySystemGroupedBackground
        problemaTextView.layer.cornerRadius = 14
        problemaTextView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        problemaTextView.delegate = self

        var configuracion = UIButton.Configuration.filled()
        configuracion.title = "Agendar reparación"
        configuracion.image = UIImage(systemName: "wrench.adjustable.fill")
        configuracion.imagePlacement = .leading
        configuracion.imagePadding = 12
        configuracion.baseForegroundColor = .white
        configuracion.baseBackgroundColor = .systemBlue
        configuracion.cornerStyle = .large
        configuracion.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 20, bottom: 14, trailing: 20)
        agendarButton.configuration = configuracion
        agendarButton.addTarget(self, action: #selector(agendarAccion), for: .touchUpInside)

        [regresarButton, tituloLabel, descripcionLabel, problemaTextView, agendarButton].forEach {
            contenidoView.addSubview($0)
        }
        view.addSubview(scrollView)
        scrollView.addSubview(contenidoView)
    }

    private func configurarLayout() {
        let elementos = [scrollView, contenidoView, regresarButton, tituloLabel,
                          descripcionLabel, problemaTextView, agendarButton]
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

            problemaTextView.topAnchor.constraint(equalTo: descripcionLabel.bottomAnchor, constant: 24),
            problemaTextView.leadingAnchor.constraint(equalTo: contenidoView.leadingAnchor, constant: 20),
            problemaTextView.trailingAnchor.constraint(equalTo: contenidoView.trailingAnchor, constant: -20),
            problemaTextView.heightAnchor.constraint(equalToConstant: 140),

            agendarButton.topAnchor.constraint(equalTo: problemaTextView.bottomAnchor, constant: 24),
            agendarButton.leadingAnchor.constraint(equalTo: contenidoView.leadingAnchor, constant: 20),
            agendarButton.trailingAnchor.constraint(equalTo: contenidoView.trailingAnchor, constant: -20),
            agendarButton.heightAnchor.constraint(equalToConstant: 56),
            agendarButton.bottomAnchor.constraint(equalTo: contenidoView.bottomAnchor, constant: -32)
        ])
    }

    @objc private func regresarAccion() {
        dismiss(animated: true)
    }

    @objc private func agendarAccion() {
        let alerta = UIAlertController(
            title: "Solicitud enviada",
            message: "Un técnico revisará tu problema y te contactará pronto.",
            preferredStyle: .alert
        )
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .default))
        present(alerta, animated: true)
    }
}

extension ReparacionViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == problemaPlaceholder {
            textView.text = ""
            textView.textColor = .label
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = problemaPlaceholder
            textView.textColor = .placeholderText
        }
    }
}
