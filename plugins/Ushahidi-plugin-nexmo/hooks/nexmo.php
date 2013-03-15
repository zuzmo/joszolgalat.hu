<?php defined('SYSPATH') or die('No direct script access.');
/**
 * Hook for the Nexmo SMS plugin
 *
 * @author Nexmo - http://nexmo.com
 * @copyright Nexmo - http://nexmo.com
 */
class nexmo {
	
	/**
	 * Constructor
	 */
	public function __construct()
	{
		// Register the main event method - add
		Event::add('system.pre_controller', array($this, 'add'));
	}
	
	/**
	 * Adds all other events for the plugin framework to the application
	 */
	public function add()
	{
		// Add the nexmo plugin to the list of SMS providers
		plugin::add_sms_provider('nexmo');
		
		// Add Nexmo CSS
		plugin::add_stylesheet('nexmo/views/css/nexmo');
		
		// Add event callbacks
		Event::add('nexmo_action.update_message_log', array($this, 'update_message_log'));
	}
	
	/**
	 * Callback function for the update_message_log event. This method is
	 * called when a message has been sent via the Nexmo plugin and a response
	 * has been received from the gateway. This function extracts the information
	 * from the response and updates the message log
	 */
	public function update_message_log()
	{
		// Get the event data and decode it to json
		$response = Event::$data;
		
		// Get each message in the response and update the log
		foreach ($response->messages as $message)
		{
			// Only process successful messages
			if ($message->status == 0)
			{
				// Model for the message logs
				$log_entry = new Nexmo_Message_Log_Model();
				
				$log_entry->message_id = $message->messageid;
				$log_entry->message_type = 0;
				$log_entry->delivery_status = 0;
					
				// Save
				$log_entry->save();
			}
			else
			{
				// Log failure
				Kohana::log('error', Kohana::lang('nexmo.response_codes.'.$message->status));
			}
		}
	}
}

// Initialize the hook
new nexmo();

?>