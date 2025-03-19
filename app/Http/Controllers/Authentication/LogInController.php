<?php

namespace App\Http\Controllers\Authentication;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Services\Notification\Notification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rules\Password;

class LogInController extends Controller
{
    public function login(Request $request)
    {
        // validation
        $validateData = $request->validate([
            'data' => ['required', 'string'],
            'password' => ['required', 'string'],
        ]);
        
        // find username or phone
        $user = User::whereAny(['username','phone'], $validateData['data'])->first();
        
        if (!$user || !Hash::check($validateData['password'], $user['password'])) {
            return response([
                'message' => 'validation exception',
                'error' => 'کاربری با این اطلاعات یافت نشد'
            ], 422);
        }

        // create token
        $token = $user->createToken('TOKEN', ['*'], now()->addDays(2))->plainTextToken;

        // response
        return response([
            'user' => $user,
            'token' => $token,
        ]);
    }

    public function forgetPassword(Request $request, Notification $notification)
    {
        // validation
        $validateData = $request->validate([
            'phone' => ['required', 'string', 'exists:users'],
        ]);

        // send active code
        $code = mt_rand(100000, 999999);

        $reponse = $notification->sendSms($validateData['phone'], getPattern('active-code'), ["$code"]);

        if ($reponse == 'false') {
            return response([
                'message' => 'validation exception',
                'error' => 'خطایی در ارتباط با سیستم رخ داد'
            ],422);
        }

        // save data
        Cache::set("code-$validateData[phone]", $code,now()->addMinutes(3));

        // response
        return response([
            'message' => 'success',
        ]);
    }

    public function changePassword(Request $request)
    {
        // validation
        $validateData = $request->validate([
            'phone' => ['required', 'string', 'exists:users'],
            'password' => ['required','string',Password::min(8)],
        ]);

        // find user
        $user = User::where('phone' , $validateData['phone'])->first();

        if(!$user)
        {
            return response([
                'message' => 'validation exception',
                'error' => 'کاربری با این شماره موبایل یافت نشد'
            ],422);
        }

        // change password
        $user->update([
            'password' => $validateData['password'],
        ]);

        // response
        return response([
            'message' => 'success'
        ]);

    }
}
