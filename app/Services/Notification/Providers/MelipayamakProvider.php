<?php

namespace App\Services\Notification\Providers;

use App\Services\Notification\Contracts\SmsContract;
use Exception;
use GuzzleHttp\Client;
use Illuminate\Support\Facades\Log;

class MelipayamakProvider implements SmsContract
{
    public string $url;

    public function __construct()
    {
        $this->url = config('notification.providers.melipayamak.url');
    }

    public function send(string $phoneNumber , mixed $bodyId , array $arguments)
    {
        try 
        {

            $client = new Client();
            $response = $client->request('POST', $this->url , [
                'json' => [
                    'bodyId' => $bodyId,
                    'to' => "$phoneNumber",
                    'args' => [...$arguments]
                ]
            ]);

            $response = json_decode($response->getBody(),true);

            return array_key_exists('recId' , $response) ? 'true' : 'false';

        } catch(Exception $e)
        {
            Log::info($e->getMessage());
            return 'false';
        }
    }
}