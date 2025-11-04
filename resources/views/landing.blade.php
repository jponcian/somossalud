@extends('layouts.landing')

@section('title', 'SomosSalud | Plataforma digital de salud comunitaria')
@section('description', 'Conecta pacientes, aliados y resultados en un solo lugar con la plataforma SomosSalud y la red SaludSonrisa.')

@section('content')
    <nav class="navbar navbar-expand-lg py-3">
        <div class="container d-flex flex-column flex-lg-row align-items-lg-center">
            <div class="d-flex align-items-center justify-content-between w-100 w-lg-auto">
                <a class="navbar-brand fw-bold text-primary d-flex align-items-center gap-2" href="#">
                    <img src="{{ asset('images/logo.png') }}" alt="SomosSalud" style="height:48px">
                </a>
                <div class="d-lg-none">
                    <a href="{{ route('login', ['perfil' => 'pacientes']) }}"
                        class="btn btn-outline-primary me-2">Pacientes</a>
                    <a href="{{ route('login', ['perfil' => 'empleados']) }}" class="btn btn-success">Clinica</a>
                </div>
            </div>
            <div class="d-none d-lg-flex align-items-center ms-auto gap-4">
                <a href="#contacto" class="text-decoration-none text-primary fw-semibold">Contacto</a>
                <a href="{{ route('login', ['perfil' => 'pacientes']) }}" class="btn btn-outline-primary">Pacientes</a>
                <a href="{{ route('login', ['perfil' => 'empleados']) }}" class="btn btn-success">Clinica</a>
            </div>
        </div>
    </nav>

    <section class="hero">
        <div class="container">
            <div class="row align-items-center g-5">
                <div class="col-lg-6 text-center text-lg-start">
                    <span class="badge-soft">SomosSalud + SaludSonrisa</span>
                    <h1 class="display-5 fw-bold mb-3">La plataforma que conecta pacientes con aliados de salud confiables
                    </h1>
                    <p class="lead mb-4">Gestiona citas, resultados y beneficios en una sola experiencia digital diseñada
                        para clínicas comunitarias y familias venezolanas.</p>
                    <ul class="hero-list list-unstyled mx-auto mx-lg-0">
                        <li><i class="fa-solid fa-circle-check"></i> Reservas confirmadas y recordatorios automáticos.</li>
                        <li><i class="fa-solid fa-circle-check"></i> Resultados de laboratorio con acceso seguro y trazable.
                        </li>
                        <li><i class="fa-solid fa-circle-check"></i> Descuentos inmediatos en la red SaludSonrisa.</li>
                    </ul>
                    <div class="mt-4">
                        @auth
                            <a href="{{ route('suscripcion.show') }}" class="btn btn-success btn-lg me-2"><i
                                    class="fa-solid fa-shield-heart me-2"></i>Mi suscripción</a>
                        @else
                            <a href="{{ route('register') }}" class="btn btn-success btn-lg me-2"><i
                                    class="fa-solid fa-user-plus me-2"></i>Quiero afiliarme</a>
                        @endauth
                    </div>
                    <!-- <div class="row mt-4 g-3 text-start">
                                                                <div class="col-6 col-md-4">
                                                                    <div class="metric-card">
                                                                        <div class="value">+500</div>
                                                                        <div class="label">Pacientes acompañados</div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-6 col-md-4">
                                                                    <div class="metric-card">
                                                                        <div class="value">10 min</div>
                                                                        <div class="label">Promedio de respuesta</div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-6 col-md-4">
                                                                    <div class="metric-card">
                                                                        <div class="value">+6</div>
                                                                        <div class="label">Aliados en integración</div>
                                                                    </div>
                                                                </div>
                                                            </div> -->
                </div>
                <div class="col-lg-5 offset-lg-1">
                    <div class="insight-card">
                        <div class="d-flex align-items-center mb-3">
                            <div class="hero-card-icon me-3"><i class="fa-solid fa-heart-pulse"></i></div>
                            <div>
                                <h3 class="h5 mb-1">Suscripción familiar activa</h3>
                                <span class="small text-white-75">SomosSalud · Plan SaludSonrisa</span>
                            </div>
                        </div>
                        <ul class="list-unstyled mb-4">
                            <li class="mb-2"><i class="fa-solid fa-circle-check me-2"></i>Descuento del 10% en consultas y
                                tratamientos dentales.</li>
                            <li class="mb-2"><i class="fa-solid fa-circle-check me-2"></i>Citas priorizadas en
                                especialidades pediátricas y odontológicas.</li>
                            <li class="mb-2"><i class="fa-solid fa-circle-check me-2"></i>Historial clínico digital con
                                auditoría de accesos.</li>
                        </ul>
                        <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
                            <!-- <div>
                                                                                    <span class="d-block text-white-75 small">Próxima renovación</span>
                                                                                    <strong>Octubre 2026</strong>
                                                                                </div> -->
                            <a href="{{ route('login') }}" class="btn btn-outline-light btn-sm">Ingresar al portal</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="py-5" id="contacto">
        <div class="container">
            <div class="cta-section">
                <div class="row align-items-center g-4">
                    <div class="col-lg-7 text-center text-lg-start">
                        <h2 class="mb-3">¿Listo para digitalizar tu clínica?</h2>
                        <p class="mb-4 text-white-75">Agenda una demo personalizada y descubre cómo SomosSalud impulsa la
                            atención comunitaria junto a tu equipo.</p>
                        <div class="d-flex flex-column flex-md-row gap-3 justify-content-center justify-content-lg-start">
                            <a href="mailto:alianzas@somossalud.com" class="btn btn-light btn-lg">Afiliar mi clínica</a>
                            <!-- <a href="mailto:alianzas@somossalud.com" class="btn btn-outline-light btn-lg">Escribir al
                                                                    equipo</a> -->
                        </div>
                    </div>
                    <div class="col-lg-5">
                        <div class="card-benefit">
                            <h3 class="h6 text-uppercase text-primary mb-3">Contacto directo</h3>
                            <ul class="list-unstyled mb-4">
                                <li class="d-flex align-items-center mb-2"><i
                                        class="fa-solid fa-phone text-primary me-3"></i><span>+58 412 0000000</span></li>
                                <li class="d-flex align-items-center mb-2"><i
                                        class="fa-solid fa-envelope text-primary me-3"></i><span>alianzas@somossalud.com</span>
                                </li>
                                <li class="d-flex align-items-center"><i
                                        class="fa-brands fa-whatsapp text-primary me-3"></i><span>@SomosSaludVE</span></li>
                            </ul>
                            <p class="small text-muted mb-0">Horario de atención: lunes a viernes · 8:00 a. m. - 6:00 p. m.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <footer>
        <div class="container text-center py-3">
            <span>© {{ date('Y') }} SomosSalud — Innovación en salud comunitaria.</span>
            <!-- <div class="d-flex gap-3 justify-content-center mt-2">
                <a href="https://www.instagram.com/clinicasaludsonrisave/?hl=es" target="_blank" rel="noopener"><i
                    class="fa-brands fa-instagram me-1"></i>Instagram</a>
                <a href="https://www.facebook.com/p/Clínica-SaludSonrisa-100089365696512/" target="_blank" rel="noopener"><i
                    class="fa-brands fa-facebook me-1"></i>Facebook</a>
                <a href="mailto:hola@somossalud.com"><i class="fa-solid fa-envelope me-1"></i>Contacto</a>
            </div> -->
        </div>
    </footer>
@endsection