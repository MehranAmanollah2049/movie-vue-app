<?php

namespace App\Http\Resources\Comments;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\ResourceCollection;

class AnswerCollection extends ResourceCollection
{
    public static $wrap = null;

    /**
     * Transform the resource collection into an array.
     *
     * @return array<int|string, mixed>
     */
    public function toArray(Request $request)
    {
        return $this->collection->map(function ($answer) {

            return [
                'id' => $answer->id,
                'comment_id' => $answer->comment_id,
                'text' => $answer->text,
                'isExpoile' => $answer->isExpoile,
                'time' => timeago($answer->created_at),
                'user' => [
                    'id' => $answer->user->id,
                    'username' => $answer->user->username,
                    'profile' => $answer->user->profile,
                ],
                'answered_to' => $answer->answerable->user->username
            ];
        });
    }
}
