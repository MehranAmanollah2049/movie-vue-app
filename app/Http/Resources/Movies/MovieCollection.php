<?php

namespace App\Http\Resources\Movies;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\ResourceCollection;

class MovieCollection extends ResourceCollection
{

    public static $wrap = null;

    /**
     * Transform the resource collection into an array.
     *
     * @return array<int|string, mixed>
     */
    public function toArray(Request $request)
    {
        return $this->collection->map(function ($movie) {
            return [
                'id' => $movie->id,
                'title' => $movie->title,
                'year' => $movie->year,
                'imdb' => $movie->imdb,
                'type' => $movie->type,
                'image' => $movie->image,
                'image_bg' => $movie->image_bg,
                'genres' => $movie->genres->pluck('title'),
                'populer' => $movie->populer,
                'langs' => $movie->langs()
            ];
        });
    }
}
