<?php

namespace App\Http\Resources\Movies;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\ResourceCollection;

class SeasonCollection extends ResourceCollection
{
    /**
     * Transform the resource collection into an array.
     *
     * @return array<int|string, mixed>
     */
    public function toArray(Request $request)
    {
        return $this->collection->map(function ($season) {
            return [
                'id' => $season->id,
                'title' => $season->title,
                'status' => $season->status == 0 ? 'در حال پخش' : 'تکمیل شده',
                'isLast' => $season->isLast,
                'sections' => new SectionCollection($season->sections),
            ];
        });
    }
}
