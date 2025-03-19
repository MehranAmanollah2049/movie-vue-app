<?php

namespace App\Http\Resources\Comments;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\ResourceCollection;

class CommentCollection extends ResourceCollection
{

    public static $wrap = null;

    /**
     * Transform the resource collection into an array.
     *
     * @return array<int|string, mixed>
     */
    public function toArray(Request $request)
    {
        return $this->collection->map(function ($comment) {

            $timeago = $comment->created_at->diffForHumans();
            return [
                'id' => $comment->id,
                'text' => $comment->text,
                'isExpoile' => $comment->isExpoile,
                'time' => timeago($comment->created_at),
                'user' => [
                    'id' => $comment->user->id,
                    'username' => $comment->user->username,
                    'profile' => $comment->user->profile,
                ],
                'answers' => new AnswerCollection($comment->answers)
            ];
        });
    }

    public function paginationInformation($request, $paginated, $default)
    {
        return [
            'hasMore' => $default['links']['next'],
        ];
    }
}
