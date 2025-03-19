<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Answer extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'answerable_id',
        'answerable_type',
        'comment_id',
        'text'
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function answerable()
    {
        return $this->morphTo();
    }
}
