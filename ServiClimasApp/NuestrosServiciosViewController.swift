import UIKit

class NuestrosServiciosViewController: UIViewController {

    let scrollView = UIScrollView()
    let contenidoView = UIView()

    let tituloLabel = UILabel()
    let servicioRequeridoLabel = UILabel()

    let mantenimientoButton = UIButton(type: .system)
    let instalacionButton = UIButton(type: .system)
    let reparacionButton = UIButton(type: .system)
    let compraButton = UIButton(type: .system)
    let cerrarSesionButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        configurarPantalla()
        configurarElementos()
        configurarLayout()
    }

    // MARK: - PANTALLA

    private func configurarPantalla() {

        view.backgroundColor = .systemGroupedBackground

        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false

        contenidoView.backgroundColor = .clear

        navigationItem.title = ""
    }

    // MARK: - ELEMENTOS

    private func configurarElementos() {

        // TÍTULO

        tituloLabel.text = "Nuestros Servicios"

        tituloLabel.font = UIFont.systemFont(
            ofSize: 30,
            weight: .bold
        )

        tituloLabel.textColor = .label
        tituloLabel.textAlignment = .left


        // PREGUNTA

        servicioRequeridoLabel.text = "¿Qué servicio necesitas?"

        servicioRequeridoLabel.font = UIFont.systemFont(
            ofSize: 17,
            weight: .medium
        )

        servicioRequeridoLabel.textColor = .secondaryLabel
        servicioRequeridoLabel.textAlignment = .left


        // MARK: - MANTENIMIENTO

        configurarBoton(
            boton: mantenimientoButton,
            titulo: "Mantenimiento",
            descripcion: "Limpieza y revisión preventiva",
            icono: "wrench.and.screwdriver.fill",
            color: .systemBlue
        )

        mantenimientoButton.addTarget(
            self,
            action: #selector(mantenimientoAccion),
            for: .touchUpInside
        )


        // MARK: - INSTALACIÓN

        configurarBoton(
            boton: instalacionButton,
            titulo: "Instalación",
            descripcion: "Instalación profesional de equipos",
            icono: "snowflake",
            color: .systemBlue
        )

        instalacionButton.addTarget(
            self,
            action: #selector(instalacionAccion),
            for: .touchUpInside
        )


        // MARK: - REPARACIÓN

        configurarBoton(
            boton: reparacionButton,
            titulo: "Reparación",
            descripcion: "Diagnóstico y solución de fallas",
            icono: "wrench.adjustable.fill",
            color: .systemBlue
        )

        reparacionButton.addTarget(
            self,
            action: #selector(reparacionAccion),
            for: .touchUpInside
        )


        // MARK: - COMPRA

        configurarBoton(
            boton: compraButton,
            titulo: "Comprar aire acondicionado",
            descripcion: "Encuentra el equipo ideal para tu espacio",
            icono: "cart.fill",
            color: .systemIndigo
        )

        compraButton.addTarget(
            self,
            action: #selector(compraAccion),
            for: .touchUpInside
        )


        // MARK: - CERRAR SESIÓN

        cerrarSesionButton.setTitle(
            "Cerrar sesión",
            for: .normal
        )

        cerrarSesionButton.setTitleColor(
            .systemRed,
            for: .normal
        )

        cerrarSesionButton.titleLabel?.font =
            UIFont.systemFont(
                ofSize: 16,
                weight: .semibold
            )

        cerrarSesionButton.backgroundColor =
            .systemRed.withAlphaComponent(0.08)

        cerrarSesionButton.layer.cornerRadius = 14

        cerrarSesionButton.contentEdgeInsets = UIEdgeInsets(
            top: 12,
            left: 24,
            bottom: 12,
            right: 24
        )

        cerrarSesionButton.addTarget(
            self,
            action: #selector(cerrarSesionAccion),
            for: .touchUpInside
        )


        // MARK: - SCROLL

        view.addSubview(scrollView)

        scrollView.addSubview(contenidoView)

        let subviews = [
            tituloLabel,
            servicioRequeridoLabel,
            mantenimientoButton,
            instalacionButton,
            reparacionButton,
            compraButton,
            cerrarSesionButton
        ]

        subviews.forEach {
            contenidoView.addSubview($0)
        }
    }


    // MARK: - CONFIGURAR BOTONES

    private func configurarBoton(
        boton: UIButton,
        titulo: String,
        descripcion: String,
        icono: String,
        color: UIColor
    ) {

        var configuracion = UIButton.Configuration.filled()

        configuracion.title = titulo
        configuracion.subtitle = descripcion

        configuracion.image = UIImage(
            systemName: icono
        )

        configuracion.imagePlacement = .leading
        configuracion.imagePadding = 16

        configuracion.baseForegroundColor = .white
        configuracion.baseBackgroundColor = color

        configuracion.cornerStyle = .large

        configuracion.contentInsets =
            NSDirectionalEdgeInsets(
                top: 12,
                leading: 20,
                bottom: 12,
                trailing: 20
            )


        configuracion.titleTextAttributesTransformer =
            UIConfigurationTextAttributesTransformer { atributos in

                var nuevos = atributos

                nuevos.font = UIFont.systemFont(
                    ofSize: 17,
                    weight: .bold
                )

                return nuevos
            }


        configuracion.subtitleTextAttributesTransformer =
            UIConfigurationTextAttributesTransformer { atributos in

                var nuevos = atributos

                nuevos.font = UIFont.systemFont(
                    ofSize: 13,
                    weight: .regular
                )

                nuevos.foregroundColor =
                    UIColor.white.withAlphaComponent(0.85)

                return nuevos
            }


        boton.configuration = configuracion

        boton.layer.cornerRadius = 18

        boton.layer.shadowColor =
            UIColor.black.cgColor

        boton.layer.shadowOpacity = 0.12

        boton.layer.shadowOffset =
            CGSize(width: 0, height: 4)

        boton.layer.shadowRadius = 8

        boton.clipsToBounds = false

        boton.accessibilityTraits = .button

        boton.accessibilityLabel = titulo

        boton.accessibilityHint = descripcion
    }


    // MARK: - LAYOUT

    private func configurarLayout() {

        let elementos = [
            scrollView,
            contenidoView,
            tituloLabel,
            servicioRequeridoLabel,
            mantenimientoButton,
            instalacionButton,
            reparacionButton,
            compraButton,
            cerrarSesionButton
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
                constant: 32
            ),

            tituloLabel.leadingAnchor.constraint(
                equalTo: contenidoView.leadingAnchor,
                constant: 24
            ),

            tituloLabel.trailingAnchor.constraint(
                equalTo: contenidoView.trailingAnchor,
                constant: -24
            ),


            // PREGUNTA

            servicioRequeridoLabel.topAnchor.constraint(
                equalTo: tituloLabel.bottomAnchor,
                constant: 8
            ),

            servicioRequeridoLabel.leadingAnchor.constraint(
                equalTo: contenidoView.leadingAnchor,
                constant: 24
            ),

            servicioRequeridoLabel.trailingAnchor.constraint(
                equalTo: contenidoView.trailingAnchor,
                constant: -24
            ),


            // MANTENIMIENTO

            mantenimientoButton.topAnchor.constraint(
                equalTo: servicioRequeridoLabel.bottomAnchor,
                constant: 24
            ),

            mantenimientoButton.leadingAnchor.constraint(
                equalTo: contenidoView.leadingAnchor,
                constant: 20
            ),

            mantenimientoButton.trailingAnchor.constraint(
                equalTo: contenidoView.trailingAnchor,
                constant: -20
            ),

            mantenimientoButton.heightAnchor.constraint(
                equalToConstant: 76
            ),


            // INSTALACIÓN

            instalacionButton.topAnchor.constraint(
                equalTo: mantenimientoButton.bottomAnchor,
                constant: 14
            ),

            instalacionButton.leadingAnchor.constraint(
                equalTo: mantenimientoButton.leadingAnchor
            ),

            instalacionButton.trailingAnchor.constraint(
                equalTo: mantenimientoButton.trailingAnchor
            ),

            instalacionButton.heightAnchor.constraint(
                equalToConstant: 76
            ),


            // REPARACIÓN

            reparacionButton.topAnchor.constraint(
                equalTo: instalacionButton.bottomAnchor,
                constant: 14
            ),

            reparacionButton.leadingAnchor.constraint(
                equalTo: mantenimientoButton.leadingAnchor
            ),

            reparacionButton.trailingAnchor.constraint(
                equalTo: mantenimientoButton.trailingAnchor
            ),

            reparacionButton.heightAnchor.constraint(
                equalToConstant: 76
            ),


            // COMPRA

            compraButton.topAnchor.constraint(
                equalTo: reparacionButton.bottomAnchor,
                constant: 14
            ),

            compraButton.leadingAnchor.constraint(
                equalTo: mantenimientoButton.leadingAnchor
            ),

            compraButton.trailingAnchor.constraint(
                equalTo: mantenimientoButton.trailingAnchor
            ),

            compraButton.heightAnchor.constraint(
                equalToConstant: 76
            ),


            // CERRAR SESIÓN

            cerrarSesionButton.topAnchor.constraint(
                equalTo: compraButton.bottomAnchor,
                constant: 32
            ),

            cerrarSesionButton.centerXAnchor.constraint(
                equalTo: contenidoView.centerXAnchor
            ),

            cerrarSesionButton.bottomAnchor.constraint(
                equalTo: contenidoView.bottomAnchor,
                constant: -32
            )
        ])
    }


    // MARK: - ACCIONES

    @objc private func mantenimientoAccion() {

        let pantalla = MantenimientoViewController()

        pantalla.modalPresentationStyle = .fullScreen

        present(
            pantalla,
            animated: true
        )
    }


    @objc private func instalacionAccion() {

        mostrarAlertaServicio(
            nombre: "Instalación"
        )
    }


    @objc private func reparacionAccion() {

        mostrarAlertaServicio(
            nombre: "Reparación"
        )
    }


    @objc private func compraAccion() {

        mostrarAlertaServicio(
            nombre: "Compra de aire acondicionado nuevo"
        )
    }


    // MARK: - ALERTA TEMPORAL

    private func mostrarAlertaServicio(
        nombre: String
    ) {

        let alerta = UIAlertController(
            title: "Servicio seleccionado",
            message: "Has seleccionado: \(nombre)",
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


    // MARK: - CERRAR SESIÓN

    @objc private func cerrarSesionAccion() {

        self.view.window?.rootViewController =
            RegistroViewController()

        self.view.window?.makeKeyAndVisible()
    }
}
