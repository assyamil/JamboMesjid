<?php

namespace App\Providers;

use Illuminate\Support\Facades\Blade;
use Illuminate\Support\Facades\URL; // tambahkan ini
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    public function register(): void
    {
        //
    }

    public function boot(): void
    {
        // Paksa HTTPS di production
        if (config('app.env') === 'production') {
            URL::forceScheme('https');
        }

        Blade::component('form.input', \App\View\Components\Form\Input::class);
    }
}
