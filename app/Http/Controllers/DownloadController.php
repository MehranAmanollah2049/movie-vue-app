<?php

namespace App\Http\Controllers;

use App\Models\Movie;
use App\Models\MovieLink;
use App\Models\SeriesLink;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\URL;

class DownloadController extends Controller
{

    public function make_movie_link(MovieLink $movielink)
    {
        return URL::temporarySignedRoute('movie.download' , now()->addMinutes(5) , [
            'movielink' => $movielink->id,
        ]);
    }
    
    public function download_movie(MovieLink $movielink)
    {
        return Storage::disk('movies')->download($movielink->url);
    }

    public function make_series_link(SeriesLink $serieslink)
    {
        return URL::temporarySignedRoute('series.download' , now()->addMinutes(5) , [
            'serieslink' => $serieslink->id,
        ]);
    }
    
    public function download_series(SeriesLink $serieslink)
    {
        return Storage::disk('series')->download($serieslink->url);
    }


}
