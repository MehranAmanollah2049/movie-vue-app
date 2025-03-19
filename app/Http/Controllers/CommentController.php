<?php

namespace App\Http\Controllers;

use App\Http\Resources\Comments\CommentCollection;
use App\Models\Answer;
use App\Models\Comment;
use App\Models\Movie;
use Illuminate\Http\Request;

class CommentController extends Controller
{
    public function add(Request $request,Movie $movie)
    {
        $validation = $request->validate([
            'text' => ['required','string'],
            'isExpoile' => ['required']
        ]);

        $movie->comments()->create([
            'user_id' => $request->user()->id,
            'text' => nl2br($validation['text']),
            'isExpoile' => filter_var($validation['isExpoile'], FILTER_VALIDATE_BOOLEAN),
        ]); 

        return new CommentCollection($movie->comments()->orderBy('id','desc')->paginate(10));
    }

    public function add_answer(Request $request,Movie $movie)
    {
        $validation = $request->validate([
            'text' => ['required','string'],
            'isExpoile' => ['required']
        ]);

        Answer::create([
            'user_id' => $request->user()->id,
            'answerable_id' => $request->answerable_id,
            'answerable_type' => 'App\Models\\' . $request->answerable_type,
            'comment_id' => $request->commentId,
            'text' => nl2br($validation['text']),
            'isExpoile' => filter_var($validation['isExpoile'], FILTER_VALIDATE_BOOLEAN),
        ]); 

        return new CommentCollection($movie->comments()->orderBy('id','desc')->paginate(10));
    }

    public function comments(Movie $movie)
    {
        return response([
            'data' => new CommentCollection($movie->comments()->orderBy('id','desc')->paginate(10)),
            'total' => $movie->commentsNum()
        ]);
    }
}
