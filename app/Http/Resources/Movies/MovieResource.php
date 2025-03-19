<?php

namespace App\Http\Resources\Movies;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class MovieResource extends JsonResource
{
    public static $wrap = null;

    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'title' => $this->title,
            'title_fa' => $this->title_fa,
            'text' => $this->text,
            'year' => $this->year,
            'imdb' => $this->imdb,
            'type' => $this->type,
            'image' => $this->image,
            'image_bg' => $this->image_bg,
            'genres' => $this->genres->select(['id','title']),
            'populer' => $this->populer,
            'langs' => $this->langs(),
            'alert' => $this->alert(),
            'stars' => [
                'actors' => $this->stars()->where('type','actor')->get()->select('id','name'),
                'directors' => $this->stars()->where('type','director')->get()->select('id','name'),
            ],
            'likes' => $this->likeStatus($request),
            "votes" => $this->likes->count(),
            'links' => $this->when($this->type == 0 , function () {
                return [
                    'type_0' => new MovieLinksCollection($this->movie_links()->where('type' , '0')->get()),
                    'type_1' => new MovieLinksCollection($this->movie_links()->where('type' , '1')->get()),
                    'type_2' => new MovieLinksCollection($this->movie_links()->where('type' , '2')->get()),
                ];
            }),
            'links_series' => $this->when($this->type == 1 , function () {
                return new SeasonCollection($this->seasons);
            }),
            
        ];
    }

    protected function likeStatus(Request $request)
    {
        if(auth()->check())
        {
            $hasLiked = $request->user()->likes()->where('movie_id', $this->id)->first();
            
            if(!$hasLiked)
            {
                return null;
            }

            return $hasLiked->isliked ? 'liked' : 'unliked';
        }
        else {
            return null;
        }
    }
}
