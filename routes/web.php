<?php

use App\Http\Controllers\UserController;
use App\Http\Controllers\EventController;
use Illuminate\Support\Facades\Route;

Route::group(['middleware' => 'auth'], function () {
    Route::get('/', [UserController::class, 'welcome']);
    Route::get('/welcome', [UserController::class, 'welcome'])->name('welcome');
    Route::get('/logout', [UserController::class, 'logout'])->name('logout');
    Route::get('/calendar', [EventController::class, 'showCalendar'])->name('calendar');

    Route::group(['middleware' => 'admin'], function () {});
});

Route::group(['middleware' => 'guest'], function () {
    Route::get('/login', [UserController::class, 'showLoginForm'])->name('showLoginForm');
    Route::post('/login', [UserController::class, 'login'])->name('login');
    Route::get('/register', [UserController::class, 'showRegistrationForm'])->name('showRegistrationForm');
    Route::post('/register', [UserController::class, 'register'])->name('register');
});
