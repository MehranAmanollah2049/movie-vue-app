<?php

namespace App\Services\Notification\Contracts;

interface SmsContract
{
    public function send(string $phoneNumber , mixed $bodyId , array $arguments);
} 