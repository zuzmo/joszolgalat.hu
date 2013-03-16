<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<?php
exit;
$link = mysql_connect('sql.ppt.local', 'ushahidi3', 'JJ3uNdvV');
if (!$link) {
    die('Could not connect: ' . mysql_error());
}
mysql_select_db('ushahidi3');

mysql_query("DELETE FROM incident WHERE id > 5");
mysql_query("DELETE FROM location WHERE id > 556");

mysql_query("SET NAMES 'utf8'");

$xml = simplexml_load_file('HungarySOS.kml');
$childs = $xml->Document->children();
foreach ($childs as $child)
{
    $name = $child->name;
    $description = strip_tags($child->description);
    $point = $child->Point->coordinates;
   // var_dump($point);
    //echo $name.' '.$point[0];
    
    $points = split(',',$point[0]);
    
    //echo $description.' '.$points[0].' '.$points[1].'<br>';
    if ($name !== '') {
	// location insert
	mysql_query("INSERT INTO location (location_name,country_id,latitude,longitude,location_visible,location_date) VALUES (
		'$name',100,'".$points[1]."','".$points[0]."',1,now())");
	$locationId = mysql_insert_id();
    
	// incidens insert
	mysql_query("INSERT INTO incident (location_id,locale,incident_title,incident_description,incident_date,
		incident_mode,incident_active,incident_verified,incident_dateadd,incident_datemodify,incident_alert_status,
		incident_zoom) VALUES ($locationId,'hu_HU','$name','$description',now(),1,1,1,now(),now(),2,8)");
	$incidentId = mysql_insert_id();
	// category relation insert
	mysql_query("INSERT INTO incident_category (incident_id,incident_category) VALUES ($incidentId,5)");
    
	echo $locationId.' '.$incidentId.'<br>';
    }
}


mysql_close($link);
?>