<?php

namespace App\Http\Controllers\Authentication;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Services\Notification\Notification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Validation\Rules\Password;

class RegisterController extends Controller
{
    public function register(Request $request,Notification $notification)
    {
        // validation
        $validateData = $request->validate([
            'username' => ['required','string'],
            'phone' => ['required','string'],
            'password' => ['required','string',Password::min(8)],
        ]);


        // check that is username & phone number is unique
        $isDataUnique = User::where('username' , $validateData['username'])->orwhere('phone' , $validateData['phone'])->first();

        // response if it was not unique
        if($isDataUnique) 
        {
            return response([
                'message' => 'validation exception',
                'error' => 'شماره موبایل یا نام کاربری شما از قبل ثبت شده است'
            ],422);
        }

        // send active code
        $code = mt_rand(100000,999999);

        $reponse = $notification->sendSms($validateData['phone'],getPattern('active-code'),["$code"]);

        if($reponse == 'false') {
            return response([
                'message' => 'validation exception',
                'error' => 'خطایی در ارتباط با سیستم رخ داد'
            ]);
        }

        // save data
        Cache::set("code-$validateData[phone]" , $code,now()->addMinutes(3));

        // response
        return response([
            'message' => 'success',
        ]);
    }
}
