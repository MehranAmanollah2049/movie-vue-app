<?php

namespace App\Providers;

use App\Services\Notification\Contracts\SmsContract;
use App\Services\Notification\Providers\MelipayamakProvider;
use Illuminate\Support\Facades\App;
use Illuminate\Support\ServiceProvider;

class NotificationProvider extends ServiceProvider
{
    /**
     * Register services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap services.
     */
    public function boot(): void
    {
        $default = config('notification.default');
        $provider = config("notification.providers.{$default}.service");
        $provider = is_subclass_of($provider , SmsContract::class) ? $provider : MelipayamakProvider::class;

        App::bind(SmsContract::class , $provider);
    }
}
