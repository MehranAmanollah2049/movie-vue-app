<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Season extends Model
{
    use HasFactory;

    protected $fillable = [
        'title',
        'movie_id',
        'status',
        'isLast',
    ];

    public function sections()
    {
        return $this->hasMany(Section::class);
    }
}
