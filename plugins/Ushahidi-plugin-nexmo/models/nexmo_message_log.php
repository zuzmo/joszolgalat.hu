<?php defined('SYSPATH') or die('No direct script access.');
/**
 * Model for the Nexmo Message Log table
 *
 * @author     Emmanuel Kala <emkala(at)gmail.com>
 * @package    Ushahidi - http://github.com/ushahidi/Ushahidi_Web
 * @subpackage NexmoSMS
 * @category   Plugins
 */
class Nexmo_Message_Log_Model extends ORM {
	
	/**
	 * Database table name
	 * @var string
	 */
	protected $table_name = 'nexmo_message_log';

	/**
	 * Validates and optionally saves a message log record from an array
	 *
	 * @param array $array Data to be validated and optionally saved
	 * @param bool $save Creates the record in the DB when TRUE
	 * @return bool 
	 */
	public function validate(array & $array, $save = FALSE)
	{
		// Validation rules for a log entry
		$array = Validation::factory($array)
					->pre_filter('trim')
					->add_rules('message_id', 'required')
					->add_rules('message_sender', 'required')
					->add_rules('message_type', 'required', 'in_array[0,1]');
		
		// Pass validation to parent and return
		return parent::validate($array, $save);
	}
}
?>