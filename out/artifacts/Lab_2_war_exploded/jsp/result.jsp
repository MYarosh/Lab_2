<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" http-equiv="refresh">
    <link rel="stylesheet" type="text/css" href="../css/main.css">
    <title>Lab1</title>

</head>
<body id="body">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <th colspan="2" class="container task">
            Ярошевский М.С.<br>
            P3214<br>
            Вариант 214024
        </th>
        <th></th>
    </tr>


</table>
<?php


$currentTime = date("d.m.Y, G:i:s", $start - $OFFSET * 60);
function createResultTable($x, $y, $r, $currentTime, $start) {
	if (!(is_numeric($x) && is_numeric($y) && is_numeric($r)) || !(($x == 2) || ($x == 1.5) || ($x == 1) || ($x == 0.5) || ($x == 0) || ($x == -0.5) || ($x == -1) || ($x == -1.5) || ($x == -2)) || !(($y >= -5) && ($y<=3)) || !(($r == 1) || ($r == 2) || ($r == 3) || ($r == 4) || ($r == 5))){
$result = "Неверный ввод!";
} else { if ((($x >= 0) && ($y >= 0) && ($y <= $r / 2 - $x)) || (($x <= 0) && ($y >= 0) && ($x ^ 2 + $y ^ 2 <= $r ^ 2)) || (($x <= 0) && ($x >= -$r / 2) && ($y <= 0) && ($y >= -$r))){
$result = "Попадание!";
} else{
$result= "Непопадание!";
}
}
$response = "
<table border='1' cellpadding='0' cellspacing='0' width='100%'>
    <tr class='container'>
        <td colspan='6'>Результат</td>
    </tr>
    <tr class='container'>
        <td>X</td>
        <td>Y</td>
        <td>R</td>
        <td>Время начала</td>
        <td>Время скрипта(в миллисекундах)</td>
        <td>Результат</td>
    </tr>
    <tr class='container'>
        <td>$x</td>
        <td>$y</td>
        <td>$r</td>
        <td>$currentTime</td>";

        $scriptTime = (microtime(true) - $start) * 1000;


        $response .=   "    <td>$scriptTime</td>
        <td>$result</td>
    </tr>
    <tr class='container'>
        <td colspan='6'>
            <form action='./index.html'>
                <input type='submit' value='BACK'>
            </form>
        </td>
    </tr>

    ";
    return $response;
    }

    function checkHit($x, $y, $r) {
    if (!(is_numeric($x) && is_numeric($y) && is_numeric($r)) || !(($x = 2) || ($x = 1.5) || ($x = 1) || ($x = 0.5) || ($x = 0) || ($x = -0.5) || ($x = -1) || ($x = -1.5) || ($x = -2)) || !(($y >= -5) && ($y<=3)) || !(($r = 1) || ($r = 2) || ($r = 3) || ($r = 4) || ($r = 5))){
    return "Неверный ввод!";
    } else { if ((($x >= 0) && ($y >= 0) && ($y <= $r / 2 - $x)) || (($x <= 0) && ($y >= 0) && ($x ^ 2 + $y ^ 2 <= $r ^ 2)) || (($x <= 0) && ($x >= -$r / 2) && ($y <= 0) && ($y >= -$r))){
    return "Попадание!";
    } else{
    return "Непопадание!";
    }
    }
    }
    ?>
    <?php echo createResultTable($X, $Y, $R, $currentTime, $start);?>

</table>

</body>
</html>
