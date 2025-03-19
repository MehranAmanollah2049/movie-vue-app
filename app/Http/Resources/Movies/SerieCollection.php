<?php

namespace App\Http\Resources\Movies;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\ResourceCollection;

class SerieCollection extends ResourceCollection
{
    public static $wrap = null;

    /**
     * Transform the resource collection into an array.
     *
     * @return array<int|string, mixed>
     */
    public function toArray(Request $request)
    {
        return $this->collection->map(function ($serie) {
            return [
                'id' => $serie->id,
                'title' => $serie->title,
                'image' => $serie->image_bg,
                'last_season' => $serie->seasons->last()->title,
                'last_episode' => $serie->seasons->last()->sections->last()->episodes->last()->title,
                'langs' => $serie->langs()
            ];
        });
    }
}
