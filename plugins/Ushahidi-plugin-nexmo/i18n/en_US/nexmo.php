<?php
$lang = array(
	'account_balance' => 'Account Balance',
	'api_key' => 'Nexmo API Key',
	'api_secret' => 'Nexmo API Secret',
	'authentication_failed' => 'The provided API key (username) and API secret (password) combination is invalid',
	'check_balance' => 'Check Nexmo Account Balance',
	'delivery_receipt_url' => 'Delivery Receipt URL',
	'fetch_balance_error' => 'Could not fetch the Nexmo account balance',
	'inbound_message_url' => 'Inbound Message URL',
	'invalid_url_auth_key' => 'Invalid URL authentication key',
	'no_api_key_secret' => 'The Nexmo API key and secret have not been specified',
	'no_settings' => 'The settings for the Nexmo plugin have not been defined',
	'phone_number' => 'Phone Number',
	
	// Response codes
	'response_codes' => array(
		1 => 'Throttled. You have exceeded, the submission capacity allowed on this account, please back off and retry',
		2 => 'Missing params. Your request is incomplete and missing some mandatory parameters',
		3 => 'Invalid params. The value of one or more parameters is invalid',
		4 => 'Invalid credentials. The username/password you supplied is either invalid or disabled',
		5 => 'Internal error. An error has occurred in the Nexmo platform whilst processing the message',
		6 => 'Invalid message. The Nexmo platform was unable to process this message, for example, an un-recognised number prefix',
		7 => 'Number barred. The number you are trying to submit to is blacklisted and may not receive messages',
		8 => 'Partner account barred. The username you supplied is for an account that has been barred from submitting messages',
		9 => 'Partner quota exceeded. Your pre-pay account does not have sufficient credit to process this message',
		10 => 'Too many existing binds. The number of simultaneous connections to the platform exceeds the capabilities of your account',
		11 => 'Account not enabled for REST. The account is not provisioned for REST submission, you should use SMPP instead',
		12 => 'Message too long. The combined length of the UDF and message body exceeds 140 octets'
	),
	
	'send_request_failed' => 'The message could not be sent.',
	'settings' => 'Nexmo Settings',
	'settings_text_1' => 'Sign up for Nexmos service by <a href="http://dashboard.nexmo.com/register">clicking here</a>',
	'settings_text_2' => 'Enter your Nexmo API key and secret below',
	
	// Toolitps
	'tooltips' => array(
		'access_information' => 'These are provided when you sign up for an account on http://nexmo.com'
	),
	
	'two_way_nexmo' => 'On your Nexmo dashboard, you will be prompted to provide two callback URLs:<br/>'
						. '<ol>'
						. '<li>Callback URL for inbound message - This is the URL which shall receive incoming SMS</li>'
						. '<li>Callback URL for delivery receipt - The URL to receive delivery status notification</li>'
						. '</ol>',
						
	'working_with_nexmo' => 'Working with Nexmo',
);
?>