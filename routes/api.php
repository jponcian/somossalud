<?php

use Illuminate\Support\Facades\Route;
use App\Models\ExchangeRate;

Route::get('/tasa', function() {
    $rate = ExchangeRate::latestRate()->first();
    if(!$rate){
        return response()->json(['message' => 'Sin tasa disponible'], 404);
    }
    return [
        'date' => $rate->date->format('Y-m-d'),
        'from' => $rate->from,
        'to' => $rate->to,
        'rate' => (float)$rate->rate,
        'source' => $rate->source,
    ];
});
