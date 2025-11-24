<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resultados Listos</title>
</head>
<body style="margin: 0; padding: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f4f4;">
    <table width="100%" cellpadding="0" cellspacing="0" style="background-color: #f4f4f4; padding: 20px 0;">
        <tr>
            <td align="center">
                <table width="600" cellpadding="0" cellspacing="0" style="background-color: #ffffff; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.1);">
                    <!-- Header -->
                    <tr>
                        <td style="background: linear-gradient(135deg, #0ea5e9 0%, #10b981 100%); padding: 40px 30px; text-align: center;">
                            <div style="font-size: 48px; margin-bottom: 10px;">🔬</div>
                            <h1 style="color: #ffffff; margin: 0; font-size: 26px; font-weight: 600;">
                                ¡Tus Resultados Están Listos!
                            </h1>
                            <p style="color: rgba(255,255,255,0.9); margin: 10px 0 0 0; font-size: 15px;">
                                Ya puedes consultar tus resultados de laboratorio
                            </p>
                        </td>
                    </tr>

                    <!-- Content -->
                    <tr>
                        <td style="padding: 40px 30px;">
                            <p style="color: #333333; font-size: 16px; line-height: 1.6; margin: 0 0 20px 0;">
                                Hola <strong>{{ $paciente->name }}</strong>,
                            </p>

                            <p style="color: #666666; font-size: 15px; line-height: 1.6; margin: 0 0 30px 0;">
                                Nos complace informarte que tus resultados de laboratorio ya están disponibles en nuestro portal.
                            </p>

                            <!-- Result Info Box -->
                            <table width="100%" cellpadding="0" cellspacing="0" style="background: linear-gradient(135deg, #f0f9ff 0%, #f0fdf4 100%); border-left: 4px solid #0ea5e9; border-radius: 8px; margin: 0 0 30px 0;">
                                <tr>
                                    <td style="padding: 25px;">
                                        <h2 style="color: #0ea5e9; font-size: 18px; margin: 0 0 15px 0; font-weight: 600;">
                                            📋 Detalles del Examen
                                        </h2>
                                        
                                        <table width="100%" cellpadding="8" cellspacing="0">
                                            <tr>
                                                <td style="color: #666666; font-size: 14px; font-weight: 600; width: 140px;">Tipo:</td>
                                                <td style="color: #333333; font-size: 15px;">
                                                    <span style="background-color: #0ea5e9; color: white; padding: 4px 12px; border-radius: 12px; font-size: 13px; font-weight: 600;">
                                                        {{ $resultado->tipo_examen }}
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="color: #666666; font-size: 14px; font-weight: 600;">Examen:</td>
                                                <td style="color: #333333; font-size: 15px; font-weight: 600;">
                                                    {{ $resultado->nombre_examen }}
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="color: #666666; font-size: 14px; font-weight: 600;">Fecha:</td>
                                                <td style="color: #333333; font-size: 15px;">
                                                    {{ $resultado->fecha_resultado->format('d/m/Y') }}
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="color: #666666; font-size: 14px; font-weight: 600;">Clínica:</td>
                                                <td style="color: #333333; font-size: 15px;">
                                                    {{ $resultado->clinica->nombre }}
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>

                            @if(!$tieneEmailTemporal)
                                <!-- CTA Button - Usuario con cuenta -->
                                <table width="100%" cellpadding="0" cellspacing="0" style="margin: 0 0 30px 0;">
                                    <tr>
                                        <td align="center">
                                            <a href="{{ route('paciente.resultados') }}" style="display: inline-block; background: linear-gradient(135deg, #0ea5e9 0%, #10b981 100%); color: #ffffff; text-decoration: none; padding: 16px 40px; border-radius: 8px; font-size: 16px; font-weight: 600; box-shadow: 0 4px 12px rgba(14, 165, 233, 0.3);">
                                                📊 Ver Mis Resultados
                                            </a>
                                        </td>
                                    </tr>
                                </table>

                                <!-- Verification Code -->
                                <table width="100%" cellpadding="0" cellspacing="0" style="background-color: #f8f9fa; border-radius: 8px; margin: 0 0 30px 0;">
                                    <tr>
                                        <td style="padding: 20px; text-align: center;">
                                            <p style="color: #666666; font-size: 13px; margin: 0 0 10px 0;">
                                                También puedes verificar la autenticidad de tu resultado con este código:
                                            </p>
                                            <p style="color: #0ea5e9; font-size: 20px; font-weight: 700; font-family: 'Courier New', monospace; margin: 0; letter-spacing: 2px;">
                                                {{ $resultado->codigo_verificacion }}
                                            </p>
                                            <p style="color: #999999; font-size: 12px; margin: 10px 0 0 0;">
                                                Ingresa este código en <a href="{{ route('laboratorio.verificar', $resultado->codigo_verificacion) }}" style="color: #0ea5e9;">{{ url('/verificar-resultado') }}</a>
                                            </p>
                                        </td>
                                    </tr>
                                </table>
                            @else
                                <!-- CTA Button - Usuario sin cuenta -->
                                <table width="100%" cellpadding="0" cellspacing="0" style="background-color: #fff3cd; border-left: 4px solid #ffc107; border-radius: 8px; margin: 0 0 25px 0;">
                                    <tr>
                                        <td style="padding: 20px;">
                                            <h3 style="color: #856404; font-size: 16px; margin: 0 0 10px 0; font-weight: 600;">
                                                🔐 Crea tu cuenta para ver tus resultados
                                            </h3>
                                            <p style="color: #856404; font-size: 14px; line-height: 1.6; margin: 0 0 15px 0;">
                                                Para acceder a tus resultados en línea, crea tu cuenta usando tu cédula:
                                            </p>
                                            <p style="color: #333333; font-size: 16px; font-weight: 700; font-family: 'Courier New', monospace; margin: 0 0 15px 0;">
                                                {{ $paciente->cedula }}
                                            </p>
                                        </td>
                                    </tr>
                                </table>

                                <table width="100%" cellpadding="0" cellspacing="0" style="margin: 0 0 30px 0;">
                                    <tr>
                                        <td align="center">
                                            <a href="{{ route('register') }}" style="display: inline-block; background: linear-gradient(135deg, #0ea5e9 0%, #10b981 100%); color: #ffffff; text-decoration: none; padding: 16px 40px; border-radius: 8px; font-size: 16px; font-weight: 600; box-shadow: 0 4px 12px rgba(14, 165, 233, 0.3);">
                                                ✨ Crear Mi Cuenta Ahora
                                            </a>
                                        </td>
                                    </tr>
                                </table>

                                <!-- Verification Code for users without account -->
                                <table width="100%" cellpadding="0" cellspacing="0" style="background-color: #f8f9fa; border-radius: 8px; margin: 0 0 20px 0;">
                                    <tr>
                                        <td style="padding: 20px; text-align: center;">
                                            <p style="color: #666666; font-size: 13px; margin: 0 0 10px 0;">
                                                O verifica tu resultado directamente con este código:
                                            </p>
                                            <p style="color: #0ea5e9; font-size: 20px; font-weight: 700; font-family: 'Courier New', monospace; margin: 0; letter-spacing: 2px;">
                                                {{ $resultado->codigo_verificacion }}
                                            </p>
                                            <p style="color: #999999; font-size: 12px; margin: 10px 0 0 0;">
                                                <a href="{{ route('laboratorio.verificar', $resultado->codigo_verificacion) }}" style="color: #0ea5e9; text-decoration: none; font-weight: 600;">
                                                    Click aquí para ver tu resultado →
                                                </a>
                                            </p>
                                        </td>
                                    </tr>
                                </table>
                            @endif

                            <p style="color: #666666; font-size: 14px; line-height: 1.6; margin: 0;">
                                Si tienes alguna pregunta sobre tus resultados, no dudes en contactarnos o consultar con tu médico.
                            </p>
                        </td>
                    </tr>

                    <!-- Footer -->
                    <tr>
                        <td style="background-color: #f8f9fa; padding: 30px; text-align: center; border-top: 1px solid #e9ecef;">
                            <p style="color: #666666; font-size: 14px; margin: 0 0 10px 0;">
                                <strong>Clínica SaludSonrisa</strong>
                            </p>
                            <p style="color: #999999; font-size: 12px; margin: 0;">
                                Este es un correo automático, por favor no respondas a este mensaje.
                            </p>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
