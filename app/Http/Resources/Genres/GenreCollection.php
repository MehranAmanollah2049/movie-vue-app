<?php

namespace App\Http\Resources\Genres;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\ResourceCollection;

class GenreCollection extends ResourceCollection
{
    public static $wrap = null;

    /**
     * Transform the resource collection into an array.
     *
     * @return array<int|string, mixed>
     */
    public function toArray(Request $request)
    {
        return $this->collection->map(function ($genre) {
            return [
                'id' => $genre->id,
                'title' => $genre->title,
                'count' => number_format($genre->movies->count())
            ];
        });
    }
}
