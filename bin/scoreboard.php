<?php

$scores = "";

if (file_exists("scores.txt")) {
	$scores .= file_get_contents("scores.txt");
}

$date = $_POST["date"];

if (!empty($date)) {
	$score = $_POST["score"];
	$player = $_POST["player_id"];
	$nick = $_POST["player_nick"];
	$mode = $_POST["mode"];

	$scores .= "\n$date - $player - $nick - $mode - $score";
}

$modes = array();

if (empty($date)) {
	$scores = explode("\n", $scores);

	$scoresNew = array();
	foreach ($scores as $key => $score) {
		$scoreValues = explode(" - ", $score);

		if (count($scoreValues) <= 1)
			continue;

		$scoreDate = $scoreValues[0];
		$scorePlayer = $scoreValues[1];
		$scoreNick = $scoreValues[2];
		$scoreMode = $scoreValues[3];
		$scoreScore = $scoreValues[4];

		if (!in_array($scoreMode, $modes)) {
			$modes[] = $scoreMode;
		}

		if (!array_key_exists($scorePlayer, $scoresNew)) {
			$scoresNew[$scorePlayer] = array();
		}

		$scoresNew[$scorePlayer]["_nick"] = $scoreNick;
		$scoresNew[$scorePlayer]["_date"] = $scoreDate;
		$scoresNew[$scorePlayer][$scoreMode] = max($scoreScore, $scoresNew[$scorePlayer][$scoreMode]);
	}

?><!doctype html>
<html>
	<head>
		<title>Arrow Mania III - High Scores</title>

		<style>

			body {
				font-family: sans-serif;
				font-size: 12px;
			}

			article {
				width: 200px;
				height: 16em;
				display: block;
				float: left;
				overflow: hidden;
			}

			header {
				line-height: 2em;

				font-weight: bold;
				font-size: 2em;
			}

			ol {
				padding: 0;
				margin: 0 0 0 30px;
			}

			li {
				line-height: 1.2em;
				padding: 0;
				margin: 0;
			}

			li > span { display: inline-block; }
			li > .nick { width: 100px; }
			li > .score { width: 50px; }

		</style>
	</head>

	<body>
		<?php foreach ($modes as $mode): ?>
			<article>
				<header><?php echo $mode; ?></header>
				<ol>
					<?php $table = array(); ?>
					<?php foreach ($scoresNew as $score): ?>
						<?php if (array_key_exists($mode, $score)): ?>
							<?php $table[$score['_nick']] = $score[$mode]; ?>
						<?php endif; ?>
					<?php endforeach; ?>

					<?php arsort($table); ?>
					<?php foreach ($table as $nick => $score): ?>
						<li>
							<span class="nick"><?php echo $nick; ?></span>
							<span class="score"><?php echo $score; ?></span>
						</li>
					<?php endforeach; ?>
				</ol>
			</article>
		<?php endforeach; ?>

		<!--
			<pre><?php print_r($scoresNew); ?></pre>
		-->
	</body>
</html><?php

} else {
	file_put_contents("scores.txt", $scores);
}
