<?php

$scores = "";

if (file_exists("scores.txt")) {
	$scores .= file_get_contents("scores.txt");
}

$score = $_POST["score"];
$player = $_POST["player_id"];
$nick = $_POST["player_nick"];
$mode = $_POST["mode"];
$date = $_POST["date"];

$scores .= "\n$date - $player - $nick - $mode - $score";

file_put_contents("scores.txt", $scores);
