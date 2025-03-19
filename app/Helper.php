<?php

function timeago($date)
{
    $timeago = $date->diffForHumans();
    $set_fa = str_replace('years', 'سال', $timeago);
    $set_fa = str_replace('months', 'ماه', $set_fa);
    $set_fa = str_replace('weeks', 'هفته', $set_fa);
    $set_fa = str_replace('days', 'روز', $set_fa);
    $set_fa = str_replace('hours', 'ساعت', $set_fa);
    $set_fa = str_replace('minutes', 'دقیقه', $set_fa);
    $set_fa = str_replace('seconds', 'ثانیه', $set_fa);
    $set_fa = str_replace('year', 'سال', $set_fa);
    $set_fa = str_replace('month', 'ماه', $set_fa);
    $set_fa = str_replace('day', 'روز', $set_fa);
    $set_fa = str_replace('week', 'هفته', $set_fa);
    $set_fa = str_replace('hour', 'ساعت', $set_fa);
    $set_fa = str_replace('minute', 'دقیقه', $set_fa);
    $set_fa = str_replace('second', 'ثانیه', $set_fa);
    $set_fa = str_replace('ago', 'پیش', $set_fa);
    $set_fa = str_replace('after', 'بعد', $set_fa);
    $set_fa = str_replace('before', 'قبل', $set_fa);
    $set_fa = str_replace('from now', 'بعد', $set_fa);

    return $set_fa == '0 ثانیه پیش' ? 'همین الان' : $set_fa;
}