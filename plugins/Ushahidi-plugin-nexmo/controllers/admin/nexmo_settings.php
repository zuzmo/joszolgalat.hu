<?php defined('SYSPATH') or die('No direct script acccess');
/**
 * Settings controller for the nexmo plugin
 *
 * @author     Emmanuel Kala <emkala(at)gmail.com>
 * @package    Ushahidi - http://github.com/ushahidi/Ushahidi_Web
 * @subpackage NexmoSMS
 * @category   Plugins
 */
class Nexmo_Settings_Controller extends Admin_Controller {
	
	/**
	 * Loads the landing page for this controller
	 */
	public function index()
	{
		// Set the current page
		$this->template->this_page = "addons";
		
		// Nexmo settings view
		$this->template->content =  new View('admin/addons/plugin_settings');
		$this->template->content->title  = Kohana::lang('nexmo.settings');
		$this->template->content->settings_form = new View('nexmo/admin/nexmo_settings');
		
		// Set up the form fields
		$form = array(
			'nexmo_api_key' => '4ba3890b',
			'nexmo_api_secret' => 'bb293675',
			'nexmo_phone_no' => '36707177179'
		);
		
		// Get the current settings
		$nexmo = (ORM::factory('nexmo', 1)->loaded)? ORM::factory('nexmo', 1) : new Nexmo_Model();
		
		// Has the form been submitted
		if ($_POST)
		{
			// Extract the data to be validated
			$nexmo_data = arr::extract($_POST, 'nexmo_api_key', 'nexmo_api_secret', 'nexmo_phone_no');
			
			Kohana::log('debug', Kohana::debug($nexmo_data));
			
			// Invoke model validation on the data
			if ($nexmo->validate($nexmo_data))
			{
				$nexmo->save();
			}
		}
		
		// Check if authorization keys have been set
		if (empty($nexmo->delivery_receipt_key))
		{
			// Key for authenticating delivery receipt not set, therefore generate
			$nexmo->delivery_receipt_key = strtoupper(text::random('alnum', 10));
			
			// Save
			$nexmo->save();
		}
		
		if (empty($nexmo->inbound_message_key))
		{
			// Key for authenticating incoming messages not set, therefore generate
			$nexmo->inbound_message_key = strtoupper(text::random('alnum', 10));
			
			// Save
			$nexmo->save();
		}
		
		// Set the form data
		$form = array(
			'nexmo_api_key' => $nexmo->nexmo_api_key,
			'nexmo_api_secret' => $nexmo->nexmo_api_secret,
			'nexmo_phone_no' => $nexmo->nexmo_phone_no
		);
		
		// Set the content for the view
		$this->template->content->settings_form->form = $form;
		
		// Set the DLR and incoming message URLs
		$this->template->content->settings_form->delivery_receipt_url = url::site().'nexmo/delivery/?key='.$nexmo->delivery_receipt_key;
		$this->template->content->settings_form->inbound_message_url = url::site().'nexmo/inbound/?key='.$nexmo->inbound_message_key;
		
		// Javascript header
		$this->template->js = new View('nexmo/admin/nexmo_settings_js');
	}
	
	/**
	 * Gets the current account balance for the nexmo account
	 */
	public function get_balance()
	{
		$this->template = '';
		$this->auto_render = FALSE;
		
		// Initialize the nexmo library
		$nexmo_sms = new Nexmo_Sms_Provider();
		
		header("Content-type: application/json; charset=utf-8");
		print $nexmo_sms->get_account_balance();
	}
}
?>