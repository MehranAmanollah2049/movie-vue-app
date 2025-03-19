<?php

namespace App\Http\Resources\Movies;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\ResourceCollection;

class SectionCollection extends ResourceCollection
{
    /**
     * Transform the resource collection into an array.
     *
     * @return array<int|string, mixed>
     */
    public function toArray(Request $request)
    {
        return $this->collection->map(function ($section) {
            return [
                'id' => $section->id,
                'quality' => $section->quality,
                'disk' => $section->disk,
                'type' => $section->type,
                'subtitle' => $section->subtitle,
                'episodes' => $section->episodes->select(['id','title','url'])
            ];
        });
    }
}
