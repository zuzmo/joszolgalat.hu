<?php defined('SYSPATH') or die('No direct script access.');
/**
 * Model for the nexmo settings table
 *
 * @author     Emmanuel Kala <emkala(at)gmail.com>
 * @package    Ushahidi - http://github.com/ushahidi/Ushahidi_Web
 * @subpackage NexmoSMS
 * @category   Plugins
 */
class Nexmo_Model extends ORM {
	
	/**
	 * Database table name
	 * @var string
	 */	
	protected $table_name = 'nexmo';
	
	/**
	 * Validates and optionally saves a nexmo settings record from an array
	 *
	 * @param array $array Values to check
	 * @param bool $save Saves record when set to TRUE
	 * @return bool
	 */
	public function validate(array & $array, $save =  FALSE)
	{
		// Set up validation
		$array = Validation::factory($array)
					->pre_filter('trim')
					->add_rules('nexmo_api_secret', 'required')
					->add_rules('nexmo_api_key', 'required');
		
		if ( ! empty($array->nexmo_phone_no))
		{
			$array->add_rules('nexmo_phone_no', 'length[3, 25]');
		}
		// Pass validation to parent and return
		return parent::validate($array, $save);
	}
	
	/**
	 * Checks if an API key matches the value in the specified column
	 *
	 * @param string $value API key
	 * @param string $column_name Name of the column to look up the API key
	 * @return bool
	 */
	public static function is_valid_api_key($value, $column_name)
	{
		return (bool) ORM::factory('nexmo', 1)->where($column_name, $value)->count_all();
	}
	
	/**
	 * Checks if the provided authentication token pair is valid - whether it has
	 * been registered in the nexmo settings table
	 *
	 * @param string $api_key Nexmo API key provided when a user signs up on http://nexmo.com
	 * @param string $api_secret Nexmo API secret - provided after a user signs up on http://nexmo.com
	 * @return bool
	 */
	public static function is_valid_auth_token_pair($api_key, $api_secret)
	{
		return (bool) !ORM::factory('nexmo', 1)
						->where(array('nexmo_api_key' => $api_key, 'nexmo_api_secret' => $api_secret))
						->count();
	}
	
}
?>