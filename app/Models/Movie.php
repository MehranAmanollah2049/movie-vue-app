<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Movie extends Model
{
    use HasFactory;


    protected $fillable = [
        'title',
        'title_fa',
        'image',
        'image_bg',
        'imdb',
        'populer',
        'year',
        'text',
        'type',
    ];

    public function genres()
    {
        return $this->belongsToMany(Genre::class , 'genre_movie');
    }

    public function tags()
    {
        return $this->belongsToMany(Tag::class , 'movie_tag');
    }

    public function likes()
    {
        return $this->hasMany(Like::class);
    }



    public function movie_links()
    {
        return $this->hasMany(MovieLink::class);
    }

    public function seasons()
    {
        return $this->hasMany(Season::class);
    }

    public function langs()
    {
        $arr = [];

        $hasSubtitle = false;
        $hasFarsi = false;

        if ($this->type == 0) {
            $hasSubtitle = !! $this->movie_links()->where('type', '0')->first();
            $hasFarsi =  !!$this->movie_links()->where('type', '1')->first();
        } else {

            $result = [];

            foreach ($this->seasons as $season) {
                $result = array_merge($season->sections->pluck('type')->toArray(),$result);
            }

            $hasSubtitle = in_array('0',$result);
            $hasFarsi = in_array('1',$result);
        }

        if ($hasSubtitle) {
            $arr[] = '0';
        }

        if ($hasFarsi) {
            $arr[] = '1';
        }

        return $arr;
    }

    public function isGoingOn()
    {
        if($this->type == 1)
        {
            return $this->seasons->last()->status == 0;
        }

        return false;
    }

    public function alert()
    {
        if($this->type == 0)
        {
            if($this->movie_links()->where('type' , '1')->first())
            {
                return ' بروزرسانی: دوبله فارسی اضافه شد ';
            }   
            else if($this->movie_links()->where('type' , '0')->first())       
            {
                return ' بروزرسانی: زیرنویس فارسی اضافه شد ';
            } 
            else if($this->movie_links()->where('type' , '3')->first()) {
                return ' بروزرسانی: نسخه بدون زیرنویس اضافه شد ';
            }
            else {
                return null;
            }
        }
        else {

            $last_season =  $this->seasons->last()->title;
            $episode =  $this->seasons->last()->sections->last()->episodes->last()->title;
            return "بروزرسانی:   $last_season  $episode اضافه شد ";
        }
    }

    public function stars()
    {
        return $this->belongsToMany(Star::class);
    }

    public function calculatePopulerity()
    {
        $result = 0;
        $total = $this->likes->count();

        if($total)
        {
            $trueCount = $this->likes()->where('isLiked' , 1)->get()->count();

            $percent = ($trueCount / $total) * 100;

            $result = $percent;

            $this->update([
                'populer' => $result,
            ]);
        }
        else {
            $this->update([
                'populer' => 0,
            ]);
        }

        return $result;
        
    }

    public function comments()
    {
        return $this->hasMany(Comment::class);
    }

    public function commentsNum()
    {
        $total = 0;

        if($this->comments->count() > 0)
        {
            $total += $this->comments->count();
            
            foreach($this->comments as $comment)
            {
                $total += $comment->answers->count();
            }
        }

        return $total;
    }
}
