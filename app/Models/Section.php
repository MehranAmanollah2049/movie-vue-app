<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Section extends Model
{
    use HasFactory;

    protected $fillable = [
        'season_id',
        'quality',
        'disk',
        'type',
        'subtitle',
    ];

    public function episodes()
    {
        return $this->hasMany(SeriesLink::class);
    }
}
