<?php

namespace App\Http\Resources\Movies;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\ResourceCollection;

class MovieLinksCollection extends ResourceCollection
{
    /**
     * Transform the resource collection into an array.
     *
     * @return array<int|string, mixed>
     */
    public function toArray(Request $request)
    {
        return $this->collection->map(function ($link) {
            return [
                "id" => $link->id,
                "url" => $link->url,
                "resolution" => $link->resolution,
                "disk" => $link->disk,
                "quality" => $link->quality,
                "Encoder" => $link->Encoder,
                "subtitle" => $link->subtitle,
                "alert" => $link->alert,
            ];
        });
    }
}
