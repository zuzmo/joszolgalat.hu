<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<?php
$xml = simplexml_load_file('HungarySOS.kml');
$childs = $xml->Document->children();
foreach ($childs as $child)
{
    $name = $child->name;
    $point = $child->Point->coordinates;
   // var_dump($point);
    echo $name.' '.$point[0];
    echo '<br><br>';
    

}

?>