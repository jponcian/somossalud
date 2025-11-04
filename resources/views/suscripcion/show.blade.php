@extends('layouts.app')

@section('content')
    <div class="container py-4">
        <h1>Mi suscripción</h1>

        @if(session('error'))
            <div class="alert alert-danger">{{ session('error') }}</div>
        @endif
        @if(session('success'))
            <div class="alert alert-success">{{ session('success') }}</div>
        @endif

        @if($suscripcion)
            <div class="card mb-3">
                <div class="card-body">
                    <p><strong>Plan:</strong> {{ $suscripcion->plan }}</p>
                    <p><strong>Estado:</strong> {{ $suscripcion->estado }}</p>
                    <p><strong>Vence:</strong> {{ $suscripcion->periodo_vencimiento }}</p>
                    <p><strong>Método:</strong> {{ $suscripcion->metodo_pago }}</p>
                </div>
            </div>
        @else
            <div class="alert alert-info">No tienes una suscripción activa.</div>
        @endif

        <div class="card">
            <div class="card-body">
                <h5>Pagar suscripción anual (sandbox)</h5>
                <p>Precio: <strong>$10</strong> (sandbox).</p>
                @if($user->clinica && $user->clinica->descuento)
                    <p>Afiliado a: <strong>{{ $user->clinica->nombre }}</strong> — Descuento:
                        <strong>{{ $user->clinica->descuento }}%</strong></p>
                @endif

                <form method="POST" action="{{ route('suscripcion.pagar') }}">
                    @csrf
                    <button class="btn btn-primary" type="submit">Pagar (sandbox)</button>
                </form>
            </div>
        </div>
    </div>
@endsection