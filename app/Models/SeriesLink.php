<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SeriesLink extends Model
{
    use HasFactory;

    protected $fillable = [
        'section_id',
        'title',
        'url'
    ];
}
