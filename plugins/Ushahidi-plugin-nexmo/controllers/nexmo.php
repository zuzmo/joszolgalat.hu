<?php defined('SYSPATH') or die('No direct script access');
/**
 * Nexmo controller that provides the callback URLs for delivery
 * receipt messages and MO (inbonud) messages
 *
 * @author     Emmanuel Kala <emkala(at)gmail.com>
 * @package    Ushahidi - http://github.com/ushahidi/Ushahidi_Web
 * @subpackage NexmoSMS
 * @category   Plugins
 */
class Nexmo_Controller extends Template_Controller {
	
	/**
	 * Template view for this controller
	 * @var string
	 */
	public $template = '';
	
	/**
	 * Disable automatic rendering of the view content
	 * @var bool
	 */
	public $auto_render = FALSE;
	
	/**
	 * Processes delivery receipt
	 */
	public function delivery()
	{
		// Get the received data
		$data = array_merge($_GET, $_POST);
		
		// Verify that the key exists
		if ( ! empty($data['key']) AND Nexmo_Model::is_valid_api_key($data['key'], 'delivery_receipt_key'))
		{
			// Log this
			Kohana::log('info', sprintf('Delivery status notification for message %s', $data['messageId']));
			
			// Get message log entry using the message id
			$log_entry = ORM::factory('nexmo_message_log')->where('message_id', $data['messageId'])->find();
			
			// @todo If no log entry is found, create a new one
			
			// Does the log entry exist?
			if ($log_entry->loaded)
			{
				// Get the delivery status of the message
				$status = $data['status'];
				
				// Set the recipient - Number message was delivered to
				$log_entry->message_recipient = $data['msisdn'];
				
				switch ($status)
				{
					case 'DELIVERED':
						$log_entry->delivery_status = 1;
					break;
					
					default:
						// Status = FAILED, BUFFERED or EXPIRED
						$log_entry->delivery_status = 0;
				}
				
				// Save the log entry
				$log_entry->save();
			}
		}
		else
		{
			// Send out fail headers
			Kohana::log('error', Kohana::lang('nexmo.invalid_url_auth_key'));
		}
	}
	
	/**
	 * Processes incoming messages
	 */
	public function inbound()
	{
		// Get the received data
		$data = array_merge($_GET, $_POST);
		
		// Verify the API key and incoming messageId parameters
		if ( ! empty($data['key']) AND ! empty($data['messageId']) 
			AND Nexmo_Model::is_valid_api_key($data['key'], 'inbound_message_key'))
		{
			// Extract fields from the submitted data
			$log_data = array(
				'message_id' => $data['messageId'],
				'message_type' => 1,
				'message_sender' => $data['msisdn'],
			);
		
			// Initialize model for updating the internal nexmo message log
			$log_entry = new Nexmo_Message_Log_Model();
		
			if ($log_entry->validate($log_data))
			{
				// Success, save
				$log_entry->save();
			}
		
			//  Add entry to the main messages list
			sms::add($data['msisdn'], $data['text']);
		}
		else
		{
			Kohana::log('error', Kohana::lang('nexmo.invalid_url_auth_key'));
		}
	}	
}
?>