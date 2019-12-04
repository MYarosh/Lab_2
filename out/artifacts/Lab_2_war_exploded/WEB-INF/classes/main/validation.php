<?php

$y = $_GET['Y'];

if (!(is_numeric($y))){
	echo "notnumber";
}else {if (!(($y >= -5) && ($y<=3))){
	echo "notinarea";
}
}
?>