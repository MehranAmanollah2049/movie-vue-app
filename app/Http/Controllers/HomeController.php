<?php

namespace App\Http\Controllers;

use App\Http\Resources\Genres\GenreCollection;
use App\Http\Resources\Movies\MovieCollection;
use App\Http\Resources\Movies\MovieResource;
use App\Http\Resources\Movies\SerieCollection;
use App\Http\Resources\Tags\TagCollection;
use App\Models\Genre;
use App\Models\Movie;
use App\Models\Tag;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class HomeController extends Controller
{

    public function menuData()
    {
        return response([
            'movies' => Movie::where('type', '0')->get()->count(),
            'series' => Movie::where('type', '1')->get()->count(),
            'tags' => [
                'movies' => new TagCollection(Tag::where('type', '0')->get()),
                'series' => new TagCollection(Tag::where('type', '1')->get()),
            ],
            'genres' => new GenreCollection(Genre::all())
        ]);
    }

    public function newMovies()
    {
        return new MovieCollection(Movie::orderBy('id', 'desc')->get()->take(6));
    }

    public function series()
    {
        $series = Movie::where('type', '1')->get();

        $series = $series->filter(function ($movie) {
            Log::info($movie->isGoingOn() ? true : false);
            return $movie->isGoingOn();
        })->values();


        return new SerieCollection($series->take(8));
    }

    public function newMovies2()
    {
        $movies = Movie::orderBy('id', 'desc')->where('type', '0')->get();

        return new MovieCollection($movies->take(14));
    }

    public function search(Request $request)
    {
        $movies = Movie::where('title', 'LIKE', "%$request->title%")->get();

        return response([
            'isMore' => $movies->count() > 4,
            'movies' => new MovieCollection($movies->take(4))
        ]);
    }

    public function genres()
    {
        return new GenreCollection(Genre::all());
    }

    public function filter(Request $request)
    {
        $Movies = Movie::query();

        if ($request->has('category') && $request->category != -1) {
            $Movies->where('type', (string)$request->category);
        }

        if ($request->has('genres') && $request->genres != []) {
            $Movies->whereHas('genres', function ($query) use ($request) {
                $query->whereIn('genre_id', $request->genres);
            });
        }

        if ($request->has('tag') && $request->tag != -1) {
            $Movies->whereHas('tags', function ($query) use ($request) {
                $query->where('tag_id', $request->tag);
            });
        }

        if ($request->has('search') && $request->search != '') {
            $Movies->where('title', 'LIKE', "%$request->search%");
        }

        if ($request->has('orderBy') && $request->orderBy != -1) {
            if ($request->orderBy == 'جدید ترین') {
                $Movies->orderBy('id', 'desc');
            } else if ($request->orderBy == 'سال انتشار') {
                $Movies->orderBy('year', 'desc');
            } else if ($request->orderBy == 'نمره IMDB') {
                $Movies->orderBy('imdb', 'desc');
            } else if ($request->orderBy == 'امتیاز کاربران') {
                $Movies->orderBy('populer', 'desc');
            }
        }

        return new MovieCollection($Movies->paginate(20));
    }

    public function movie(Movie $movie)
    {
        return new MovieResource($movie);
    }

    public function like(Movie $movie, Request $request)
    {
        $status = 'unliked';
        $hasLiked = $request->user()->likes()->where('movie_id', $movie->id)->first();

        if ($hasLiked) {
            if ($hasLiked->isliked == true && $request->type == true) {
                $hasLiked->delete();
                 $status = null;
            }
            else if ($hasLiked->isliked == true && $request->type == false) {
                $hasLiked->update([
                    'isliked' => false
                ]);
                $status = 'unliked';
            }
            else if ($hasLiked->isliked == false && $request->type == false) {
                $hasLiked->delete();
                 $status = null;
            }
            else if ($hasLiked->isliked == false && $request->type == true) {
                $hasLiked->update([
                    'isliked' => true
                ]);
                $status = 'liked';
            }
            
        } else {
            $request->user()->likes()->create([
                'movie_id' => $movie->id,
                'isliked' => $request->type,
            ]);
            $status = $request->type ? 'liked' : 'unliked';
        }

        $populer = $movie->calculatePopulerity();
        $votes = $movie->likes->count();

        return response([
            'isLiked' => $status,
            'populer' => $populer,
            'votes' => $votes
        ]);
    }
}
