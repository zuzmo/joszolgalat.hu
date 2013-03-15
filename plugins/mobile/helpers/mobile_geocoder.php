<?php
/**
 * Mobile Geocoder helper
 * 
 * @package    Category
 * @author     Ushahidi Team
 * @copyright  (c) 2008 Ushahidi Team
 * @license    http://www.ushahidi.com/license.html
 */
class mobile_geocoder_Core {
	
	public static function geocode($address = NULL)
	{
		if ($address)
		{
			$map_object = new GoogleMapAPI;
			//$map_object->_minify_js = isset($_REQUEST["min"]) ? FALSE : TRUE;
			$geocodes = $map_object->getGeoCode($address);
			//$geocodes = $MAP_OBJECT->geoGetCoordsFull($address);
			
			return $geocodes;
		}
		else
		{
			return false;
		}
	}
	
}