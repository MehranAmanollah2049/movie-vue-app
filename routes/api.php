<?php

use App\Http\Controllers\Authentication\LogInController;
use App\Http\Controllers\Authentication\RegisterController;
use App\Http\Controllers\Authentication\VerifyController;
use App\Http\Controllers\CommentController;
use App\Http\Controllers\DownloadController;
use App\Http\Controllers\HomeController;
use App\Http\Middleware\AuthCheckMiddleware;
use App\Models\Movie;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Storage;

Route::middleware('auth:sanctum')->group(function () {

    Route::get('/user', function (Request $request) {
        return $request->user();
    });

    Route::delete('/logout' , function(Request $request) {
        $request->user()->tokens()->delete();

        return response([
            'message' => 'success'
        ]);
    });

});

Route::prefix('auth')->group(function () {

    // register
    Route::post('/register' , [RegisterController::class , 'register']);

    // login
    Route::post('/login' , [LogInController::class , 'login']);
    Route::post('/forget-password' , [LogInController::class , 'forgetPassword']);
    Route::put('/change-password' , [LogInController::class , 'changePassword']);

    // verify
    Route::post('/verify' , [VerifyController::class , 'verify']);
    Route::post('/resend' , [VerifyController::class , 'resend']);

});

Route::controller(HomeController::class)->group(function () {

    Route::get('/menu','menuData');
    Route::get('/new-movies','newMovies');
    Route::get('/new-movies2','newMovies2');
    Route::get('/going-on-series','series');
    Route::get('/search','search');

});

Route::get('/genres' , [HomeController::class , 'genres']);
Route::post('/filter-movies' , [HomeController::class , 'filter']);
Route::get('/movie/{movie}' , [HomeController::class , 'movie'])->middleware(AuthCheckMiddleware::class);
Route::post('/movie/{movie}/like' , [HomeController::class , 'like'])->middleware('auth:sanctum');


Route::prefix('download')->controller(DownloadController::class)->group(function () {

    Route::prefix('movie')->group(function () {
        Route::post('/{movielink}' , 'make_movie_link');
        Route::get('/{movielink}/dw' , 'download_movie')->name('movie.download')->middleware('signed');
    });

    Route::prefix('series')->group(function () {
        Route::post('/{serieslink}' , 'make_series_link');
        Route::get('/{serieslink}/dw' , 'download_series')->name('series.download')->middleware('signed');
    });

});


Route::prefix('comments')->controller(CommentController::class)->group(function () {

    Route::middleware('auth:sanctum')->group(function () {
        Route::post('/add/{movie}' , 'add');
        Route::post('/add-answer/{movie}' , 'add_answer');
    });

    Route::get('/{movie}' , 'comments');

});