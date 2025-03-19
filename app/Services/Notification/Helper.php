<?php


function  getPattern($key,$provider = 'melipayamak') {
    return config("notification.providers.$provider.patterns.$key");
}