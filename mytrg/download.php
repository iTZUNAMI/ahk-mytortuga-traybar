<?php



$current_count = file_get_contents('count.txt');
$f = fopen('count.txt', 'w+');
fwrite($f, $current_count + 1);
fclose($f);

header("Location: Installer_myTRG.exe");


?>
