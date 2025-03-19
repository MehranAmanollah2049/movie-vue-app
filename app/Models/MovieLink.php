<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MovieLink extends Model
{
    use HasFactory;

    protected $fillable = [
        'movie_id',
        'url',
        'resolution',
        'disk',
        'quality',
        'Encoder',
        'subtitle',
        'type',
        'alert',
    ];
}
