<?php

namespace App\Http\Controllers\Authentication;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Services\Notification\Notification;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;

class VerifyController extends Controller
{
    public function verify(Request $request)
    {
        // validation
        $validateData = $request->validate([
            'code' => ['required', 'string'],
            'phone' => ['required', 'string'],
            'data' => ['required'],
            'data_type' => ['required'],
        ]);

        // check cache
        if (!Cache::has("code-$validateData[phone]")) {
            return response([
                'message' => 'validation exception',
                'error' => 'کد وارد شده معتبر نمی باشد لذا نسبت به دریافت مجدد ان اقدام کنید',
            ], 422);
        }

        // check code
        $code = Cache::get("code-$validateData[phone]");

        if ($code != $validateData['code']) {
            return response([
                'message' => 'validation exception',
                'error' => 'کد وارد شده معتبر نمی باشد',
            ], 422);
        }

        // register
        if ($validateData['data_type'] == 1) {
            return $this->register($validateData['data']);
        }

        Cache::forget("code-$validateData[phone]");

        return response([
            'message' => 'success',
        ]);
    }

    public function resend(Request $request, Notification $notification)
    {
        // send active code
        $code = mt_rand(100000, 999999);

        $reponse = $notification->sendSms($request->phone, getPattern('active-code'), ["$code"]);

        if ($reponse == 'false') {
            return response([
                'message' => 'validation exception',
                'error' => 'خطایی در ارتباط با سیستم رخ داد'
            ], 422);
        }

        // save data
        Cache::set("code-$request->phone", $code, now()->addMinutes(3));

        return response([
            'message' => 'success'
        ]);
    }

    protected function register($data)
    {

        // check that is username & phone number is unique
        $isPhoneUnique = User::where('phone' , $data['phone'])->first();

        // response if it was not unique
        if($isPhoneUnique) 
        {
            return response([
                'message' => 'validation exception',
                'error' => 'شماره موبایل  شما از قبل ثبت شده است'
            ],422);
        }

        // check that is username & phone number is unique
        $isUsernameUnique = User::where('username' , $data['username'])->first();

        // response if it was not unique
        if($isUsernameUnique) 
        {
            return response([
                'message' => 'validation exception',
                'error' => 'یا نام کاربری شما از قبل ثبت شده است'
            ],422);
        }

        $user = User::create([...$data]);

        // create token
        $token = $user->createToken('TOKEN', ['*'], now()->addDays(2))->plainTextToken;

        // response
        return response([
            'user' => $user->refresh(),
            'token' => $token,
        ]);
    }
}
