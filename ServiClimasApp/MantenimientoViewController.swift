import UIKit

class MantenimientoViewController: UIViewController {

    // MARK: - SCROLL

    let scrollView = UIScrollView()
    let contenidoView = UIView()

    // MARK: - TITULOS

    let tituloLabel = UILabel()
    let descripcionLabel = UILabel()

    // MARK: - EQUIPO

    let tipoEquipoLabel = UILabel()

    let convencionalButton = UIButton(type: .system)
    let inverterButton = UIButton(type: .system)
    let otroEquipoButton = UIButton(type: .system)

    // MARK: - MANTENIMIENTO

    let mantenimientoLabel = UILabel()

    let preventivoButton = UIButton(type: .system)
    let correctivoButton = UIButton(type: .system)

    // MARK: - FECHA Y HORA

    let fechaLabel = UILabel()
    let fechaPicker = UIDatePicker()

    let horarioLabel = UILabel()
    let horarioPicker = UIDatePicker()

    // MARK: - COMENTARIO

    let comentarioLabel = UILabel()
    let comentarioTextView = UITextView()

    // MARK: - CONTINUAR

    let continuarButton = UIButton(type: .system)

    // MARK: - SELECCIONES

    var equipoSeleccionado = "No seleccionado"
    var mantenimientoSeleccionado = "No seleccionado"

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

        navigationItem.title = "Mantenimiento"

        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true

        contenidoView.backgroundColor = .clear
    }

    // MARK: - ELEMENTOS

    private func configurarElementos() {

        // TÍTULO

        tituloLabel.text = "Solicitar mantenimiento"

        tituloLabel.font = UIFont.systemFont(
            ofSize: 30,
            weight: .bold
        )

        tituloLabel.textColor = .label
        tituloLabel.numberOfLines = 0


        // DESCRIPCIÓN

        descripcionLabel.text =
            "Cuéntanos un poco sobre tu equipo para ofrecerte el servicio adecuado."

        descripcionLabel.font = UIFont.systemFont(
            ofSize: 16,
            weight: .regular
        )

        descripcionLabel.textColor = .secondaryLabel
        descripcionLabel.numberOfLines = 0


        // MARK: TIPO DE EQUIPO

        tipoEquipoLabel.text = "¿Qué tipo de equipo tienes?"

        configurarLabel(tipoEquipoLabel)


        configurarBoton(
            convencionalButton,
            titulo: "Aire acondicionado convencional",
            icono: "snowflake"
        )

        configurarBoton(
            inverterButton,
            titulo: "Aire acondicionado inverter",
            icono: "snowflake"
        )

        configurarBoton(
            otroEquipoButton,
            titulo: "Otro equipo",
            icono: "questionmark.circle.fill"
        )


        convencionalButton.addTarget(
            self,
            action: #selector(seleccionarEquipo),
            for: .touchUpInside
        )

        inverterButton.addTarget(
            self,
            action: #selector(seleccionarEquipo),
            for: .touchUpInside
        )

        otroEquipoButton.addTarget(
            self,
            action: #selector(seleccionarEquipo),
            for: .touchUpInside
        )


        // MARK: MANTENIMIENTO

        mantenimientoLabel.text =
            "¿Qué mantenimiento necesitas?"

        configurarLabel(mantenimientoLabel)


        configurarBoton(
            preventivoButton,
            titulo: "Mantenimiento preventivo",
            icono: "checkmark.shield.fill"
        )


        configurarBoton(
            correctivoButton,
            titulo: "Mantenimiento correctivo",
            icono: "wrench.and.screwdriver.fill"
        )


        // Subtítulo del correctivo

        var configuracionCorrectivo =
            correctivoButton.configuration ?? UIButton.Configuration.filled()

        configuracionCorrectivo.title =
            "Mantenimiento correctivo"

        configuracionCorrectivo.subtitle =
            "Se sugiere cuando el aire tiene 2 años de funcionamiento"

        configuracionCorrectivo.image =
            UIImage(systemName: "wrench.and.screwdriver.fill")

        configuracionCorrectivo.imagePlacement = .leading

        configuracionCorrectivo.imagePadding = 12

        configuracionCorrectivo.baseForegroundColor = .label

        configuracionCorrectivo.baseBackgroundColor =
            .secondarySystemGroupedBackground

        configuracionCorrectivo.cornerStyle = .large

        correctivoButton.configuration =
            configuracionCorrectivo


        preventivoButton.addTarget(
            self,
            action: #selector(seleccionarMantenimiento),
            for: .touchUpInside
        )

        correctivoButton.addTarget(
            self,
            action: #selector(seleccionarMantenimiento),
            for: .touchUpInside
        )


        // MARK: FECHA

        fechaLabel.text =
            "¿Qué día agendamos su servicio?"

        configurarLabel(fechaLabel)


        fechaPicker.datePickerMode = .date

        fechaPicker.preferredDatePickerStyle = .compact

        fechaPicker.minimumDate = Date()


        // MARK: HORARIO

        horarioLabel.text =
            "¿Qué horario prefiere?"

        configurarLabel(horarioLabel)


        horarioPicker.datePickerMode = .time

        horarioPicker.preferredDatePickerStyle = .compact


        // MARK: COMENTARIO

        comentarioLabel.text =
            "¿Algún comentario que quieras agregar?"

        configurarLabel(comentarioLabel)


        comentarioTextView.font =
            UIFont.systemFont(ofSize: 16)

        comentarioTextView.backgroundColor =
            .secondarySystemGroupedBackground

        comentarioTextView.layer.cornerRadius = 16

        comentarioTextView.layer.borderWidth = 1

        comentarioTextView.layer.borderColor =
            UIColor.separator.cgColor

        comentarioTextView.text =
            "Escribe aquí algún comentario sobre tu equipo o el servicio que necesitas..."

        comentarioTextView.textColor =
            .secondaryLabel

        comentarioTextView.textContainerInset =
            UIEdgeInsets(
                top: 15,
                left: 12,
                bottom: 15,
                right: 12
            )


        // MARK: CONTINUAR

        var configuracionContinuar =
            UIButton.Configuration.filled()

        configuracionContinuar.title =
            "Continuar"

        configuracionContinuar.image =
            UIImage(systemName: "arrow.right")

        configuracionContinuar.imagePlacement = .trailing

        configuracionContinuar.imagePadding = 10

        configuracionContinuar.baseBackgroundColor =
            .systemBlue

        configuracionContinuar.baseForegroundColor =
            .white

        configuracionContinuar.cornerStyle =
            .large

        configuracionContinuar.contentInsets =
            NSDirectionalEdgeInsets(
                top: 16,
                leading: 20,
                bottom: 16,
                trailing: 20
            )

        continuarButton.configuration =
            configuracionContinuar

        continuarButton.layer.cornerRadius = 18

        continuarButton.layer.shadowColor =
            UIColor.black.cgColor

        continuarButton.layer.shadowOpacity = 0.18

        continuarButton.layer.shadowOffset =
            CGSize(width: 0, height: 5)

        continuarButton.layer.shadowRadius = 8

        continuarButton.addTarget(
            self,
            action: #selector(continuarAccion),
            for: .touchUpInside
        )


        // MARK: AGREGAR VISTAS

        view.addSubview(scrollView)

        scrollView.addSubview(contenidoView)


        let elementos = [

            tituloLabel,
            descripcionLabel,

            tipoEquipoLabel,

            convencionalButton,
            inverterButton,
            otroEquipoButton,

            mantenimientoLabel,

            preventivoButton,
            correctivoButton,

            fechaLabel,
            fechaPicker,

            horarioLabel,
            horarioPicker,

            comentarioLabel,
            comentarioTextView,

            continuarButton
        ]


        elementos.forEach {
            contenidoView.addSubview($0)
        }
    }

    // MARK: - LABEL

    private func configurarLabel(_ label: UILabel) {

        label.font =
            UIFont.systemFont(
                ofSize: 19,
                weight: .bold
            )

        label.textColor = .label

        label.numberOfLines = 0
    }

    // MARK: - BOTONES

    private func configurarBoton(
        _ boton: UIButton,
        titulo: String,
        icono: String
    ) {

        var configuracion =
            UIButton.Configuration.filled()

        configuracion.title = titulo

        configuracion.image =
            UIImage(systemName: icono)

        configuracion.imagePlacement = .leading

        configuracion.imagePadding = 12

        configuracion.baseForegroundColor =
            .label

        configuracion.baseBackgroundColor =
            .secondarySystemGroupedBackground

        configuracion.cornerStyle =
            .large

        configuracion.contentInsets =
            NSDirectionalEdgeInsets(
                top: 15,
                leading: 18,
                bottom: 15,
                trailing: 18
            )

        boton.configuration =
            configuracion

        boton.layer.cornerRadius = 16

        boton.layer.borderWidth = 1

        boton.layer.borderColor =
            UIColor.separator.cgColor

        boton.layer.shadowColor =
            UIColor.black.cgColor

        boton.layer.shadowOpacity = 0.06

        boton.layer.shadowOffset =
            CGSize(width: 0, height: 3)

        boton.layer.shadowRadius = 5

        boton.clipsToBounds = false
    }

    // MARK: - LAYOUT

    private func configurarLayout() {

        let elementos = [

            scrollView,
            contenidoView,

            tituloLabel,
            descripcionLabel,

            tipoEquipoLabel,

            convencionalButton,
            inverterButton,
            otroEquipoButton,

            mantenimientoLabel,

            preventivoButton,
            correctivoButton,

            fechaLabel,
            fechaPicker,

            horarioLabel,
            horarioPicker,

            comentarioLabel,
            comentarioTextView,

            continuarButton
        ]


        elementos.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }


        NSLayoutConstraint.activate([

            // SCROLL

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


            // CONTENIDO

            contenidoView.topAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.topAnchor
            ),

            contenidoView.leadingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.leadingAnchor
            ),

            contenidoView.trailingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.trailingAnchor
            ),

            contenidoView.bottomAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.bottomAnchor
            ),

            contenidoView.widthAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.widthAnchor
            ),


            // TÍTULO

            tituloLabel.topAnchor.constraint(
                equalTo: contenidoView.topAnchor,
                constant: 30
            ),

            tituloLabel.leadingAnchor.constraint(
                equalTo: contenidoView.leadingAnchor,
                constant: 24
            ),

            tituloLabel.trailingAnchor.constraint(
                equalTo: contenidoView.trailingAnchor,
                constant: -24
            ),


            // DESCRIPCIÓN

            descripcionLabel.topAnchor.constraint(
                equalTo: tituloLabel.bottomAnchor,
                constant: 8
            ),

            descripcionLabel.leadingAnchor.constraint(
                equalTo: tituloLabel.leadingAnchor
            ),

            descripcionLabel.trailingAnchor.constraint(
                equalTo: tituloLabel.trailingAnchor
            ),


            // TIPO EQUIPO

            tipoEquipoLabel.topAnchor.constraint(
                equalTo: descripcionLabel.bottomAnchor,
                constant: 30
            ),

            tipoEquipoLabel.leadingAnchor.constraint(
                equalTo: tituloLabel.leadingAnchor
            ),

            tipoEquipoLabel.trailingAnchor.constraint(
                equalTo: tituloLabel.trailingAnchor
            ),


            // CONVENCIONAL

            convencionalButton.topAnchor.constraint(
                equalTo: tipoEquipoLabel.bottomAnchor,
                constant: 14
            ),

            convencionalButton.leadingAnchor.constraint(
                equalTo: tituloLabel.leadingAnchor
            ),

            convencionalButton.trailingAnchor.constraint(
                equalTo: tituloLabel.trailingAnchor
            ),

            convencionalButton.heightAnchor.constraint(
                equalToConstant: 60
            ),


            // INVERTER

            inverterButton.topAnchor.constraint(
                equalTo: convencionalButton.bottomAnchor,
                constant: 10
            ),

            inverterButton.leadingAnchor.constraint(
                equalTo: convencionalButton.leadingAnchor
            ),

            inverterButton.trailingAnchor.constraint(
                equalTo: convencionalButton.trailingAnchor
            ),

            inverterButton.heightAnchor.constraint(
                equalToConstant: 60
            ),


            // OTRO

            otroEquipoButton.topAnchor.constraint(
                equalTo: inverterButton.bottomAnchor,
                constant: 10
            ),

            otroEquipoButton.leadingAnchor.constraint(
                equalTo: convencionalButton.leadingAnchor
            ),

            otroEquipoButton.trailingAnchor.constraint(
                equalTo: convencionalButton.trailingAnchor
            ),

            otroEquipoButton.heightAnchor.constraint(
                equalToConstant: 60
            ),


            // MANTENIMIENTO

            mantenimientoLabel.topAnchor.constraint(
                equalTo: otroEquipoButton.bottomAnchor,
                constant: 30
            ),

            mantenimientoLabel.leadingAnchor.constraint(
                equalTo: tituloLabel.leadingAnchor
            ),

            mantenimientoLabel.trailingAnchor.constraint(
                equalTo: tituloLabel.trailingAnchor
            ),


            // PREVENTIVO

            preventivoButton.topAnchor.constraint(
                equalTo: mantenimientoLabel.bottomAnchor,
                constant: 14
            ),

            preventivoButton.leadingAnchor.constraint(
                equalTo: tituloLabel.leadingAnchor
            ),

            preventivoButton.trailingAnchor.constraint(
                equalTo: tituloLabel.trailingAnchor
            ),

            preventivoButton.heightAnchor.constraint(
                equalToConstant: 62
            ),


            // CORRECTIVO

            correctivoButton.topAnchor.constraint(
                equalTo: preventivoButton.bottomAnchor,
                constant: 10
            ),

            correctivoButton.leadingAnchor.constraint(
                equalTo: preventivoButton.leadingAnchor
            ),

            correctivoButton.trailingAnchor.constraint(
                equalTo: preventivoButton.trailingAnchor
            ),

            correctivoButton.heightAnchor.constraint(
                equalToConstant: 82
            ),


            // FECHA

            fechaLabel.topAnchor.constraint(
                equalTo: correctivoButton.bottomAnchor,
                constant: 30
            ),

            fechaLabel.leadingAnchor.constraint(
                equalTo: tituloLabel.leadingAnchor
            ),

            fechaLabel.trailingAnchor.constraint(
                equalTo: tituloLabel.trailingAnchor
            ),


            fechaPicker.topAnchor.constraint(
                equalTo: fechaLabel.bottomAnchor,
                constant: 10
            ),

            fechaPicker.leadingAnchor.constraint(
                equalTo: tituloLabel.leadingAnchor
            ),


            // HORARIO

            horarioLabel.topAnchor.constraint(
                equalTo: fechaPicker.bottomAnchor,
                constant: 25
            ),

            horarioLabel.leadingAnchor.constraint(
                equalTo: tituloLabel.leadingAnchor
            ),

            horarioLabel.trailingAnchor.constraint(
                equalTo: tituloLabel.trailingAnchor
            ),


            horarioPicker.topAnchor.constraint(
                equalTo: horarioLabel.bottomAnchor,
                constant: 10
            ),

            horarioPicker.leadingAnchor.constraint(
                equalTo: tituloLabel.leadingAnchor
            ),


            // COMENTARIO

            comentarioLabel.topAnchor.constraint(
                equalTo: horarioPicker.bottomAnchor,
                constant: 30
            ),

            comentarioLabel.leadingAnchor.constraint(
                equalTo: tituloLabel.leadingAnchor
            ),

            comentarioLabel.trailingAnchor.constraint(
                equalTo: tituloLabel.trailingAnchor
            ),


            comentarioTextView.topAnchor.constraint(
                equalTo: comentarioLabel.bottomAnchor,
                constant: 10
            ),

            comentarioTextView.leadingAnchor.constraint(
                equalTo: tituloLabel.leadingAnchor
            ),

            comentarioTextView.trailingAnchor.constraint(
                equalTo: tituloLabel.trailingAnchor
            ),

            comentarioTextView.heightAnchor.constraint(
                equalToConstant: 120
            ),


            // CONTINUAR

            continuarButton.topAnchor.constraint(
                equalTo: comentarioTextView.bottomAnchor,
                constant: 25
            ),

            continuarButton.leadingAnchor.constraint(
                equalTo: tituloLabel.leadingAnchor
            ),

            continuarButton.trailingAnchor.constraint(
                equalTo: tituloLabel.trailingAnchor
            ),

            continuarButton.heightAnchor.constraint(
                equalToConstant: 60
            ),

            continuarButton.bottomAnchor.constraint(
                equalTo: contenidoView.bottomAnchor,
                constant: -30
            )
        ])
    }

    // MARK: - SELECCIONAR EQUIPO

    @objc private func seleccionarEquipo(
        _ sender: UIButton
    ) {

        let botones = [
            convencionalButton,
            inverterButton,
            otroEquipoButton
        ]

        botones.forEach {

            $0.layer.borderWidth = 1

            $0.layer.borderColor =
                UIColor.separator.cgColor

            $0.configuration?.baseBackgroundColor =
                .secondarySystemGroupedBackground

            $0.configuration?.baseForegroundColor =
                .label
        }


        sender.layer.borderWidth = 2

        sender.layer.borderColor =
            UIColor.systemBlue.cgColor

        sender.configuration?.baseBackgroundColor =
            .systemBlue

        sender.configuration?.baseForegroundColor =
            .white


        // Guardar selección

        if sender == convencionalButton {

            equipoSeleccionado =
                "Aire acondicionado convencional"

        } else if sender == inverterButton {

            equipoSeleccionado =
                "Aire acondicionado inverter"

        } else if sender == otroEquipoButton {

            equipoSeleccionado =
                "Otro equipo"
        }
    }

    // MARK: - SELECCIONAR MANTENIMIENTO

    @objc private func seleccionarMantenimiento(
        _ sender: UIButton
    ) {

        let botones = [
            preventivoButton,
            correctivoButton
        ]

        botones.forEach {

            $0.layer.borderWidth = 1

            $0.layer.borderColor =
                UIColor.separator.cgColor

            $0.configuration?.baseBackgroundColor =
                .secondarySystemGroupedBackground

            $0.configuration?.baseForegroundColor =
                .label
        }


        sender.layer.borderWidth = 2

        sender.layer.borderColor =
            UIColor.systemBlue.cgColor

        sender.configuration?.baseBackgroundColor =
            .systemBlue

        sender.configuration?.baseForegroundColor =
            .white


        // Guardar selección

        if sender == preventivoButton {

            mantenimientoSeleccionado =
                "Mantenimiento preventivo"

        } else if sender == correctivoButton {

            mantenimientoSeleccionado =
                "Mantenimiento correctivo"
        }
    }

    // MARK: - CONTINUAR

    @objc private func continuarAccion() {

        // Verificar equipo

        if equipoSeleccionado == "No seleccionado" {

            mostrarAlerta(
                titulo: "Falta seleccionar",
                mensaje: "Selecciona el tipo de equipo que tienes."
            )

            return
        }


        // Verificar mantenimiento

        if mantenimientoSeleccionado == "No seleccionado" {

            mostrarAlerta(
                titulo: "Falta seleccionar",
                mensaje: "Selecciona el tipo de mantenimiento que necesitas."
            )

            return
        }


        // Obtener fecha

        let formatoFecha =
            DateFormatter()

        formatoFecha.locale =
            Locale(identifier: "es_MX")

        formatoFecha.dateStyle = .long

        let fecha =
            formatoFecha.string(
                from: fechaPicker.date
            )


        // Obtener hora

        let formatoHora =
            DateFormatter()

        formatoHora.locale =
            Locale(identifier: "es_MX")

        formatoHora.timeStyle = .short

        let hora =
            formatoHora.string(
                from: horarioPicker.date
            )


        // Obtener comentario

        var comentario =
            comentarioTextView.text ?? ""

        if comentario ==
            "Escribe aquí algún comentario sobre tu equipo o el servicio que necesitas..."
        {
            comentario =
                "Sin comentarios adicionales."
        }


        // CREAR PANTALLA DE CONFIRMACIÓN

        let pantalla =
            ConfirmarSolicitudViewController(

                servicio:
                    mantenimientoSeleccionado,

                equipo:
                    equipoSeleccionado,

                fecha:
                    fecha,

                hora:
                    hora,

                comentario:
                    comentario
            )


        pantalla.modalPresentationStyle =
            .fullScreen


        present(
            pantalla,
            animated: true
        )
    }

    // MARK: - ALERTA

    private func mostrarAlerta(
        titulo: String,
        mensaje: String
    ) {

        let alerta =
            UIAlertController(
                title: titulo,
                message: mensaje,
                preferredStyle: .alert
            )

        alerta.addAction(
            UIAlertAction(
                title: "Aceptar",
                style: .default
            )
        )

        present(
            alerta,
            animated: true
        )
    }
}
