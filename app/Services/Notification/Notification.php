<?php

namespace App\Services\Notification;

use App\Services\Notification\Contracts\SmsContract;

class Notification 
{
    public function __construct(public SmsContract $smscontract)
    {
        
    }

    public function sendSms()
    {
        $args = func_get_args();
        return $this->smscontract->send(...$args);
    }
}