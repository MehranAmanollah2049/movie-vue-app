<?php

use App\Services\Notification\Providers\MelipayamakProvider;

return [
    'default' => env('SMS_DEFAULT_SERVICE' , 'melipayamak'),

    'providers' => [
        'melipayamak' => [
            'service' => MelipayamakProvider::class,
            'auth' => [
                'username' => env('MELIPAYAMAK_USERNAME'),
                'password' => env('MELIPAYAMAK_PASSWORD'),
            ],
            'url' => env('MELIPAYAMAK_URL' , 'https://console.melipayamak.com/api/send/shared/' . env('MELIPAYAMAK_TOKEN')),
            'patterns' => [
                'active-code' => 228363
            ]
        ]
    ]
];