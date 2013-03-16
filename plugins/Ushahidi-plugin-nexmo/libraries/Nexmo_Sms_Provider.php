<?php

/* 
 * Class NexmoMessage handles the methods and properties of sending an SMS message.
 *
 * Listing of class properties and methods here -later
 *
 **/

define('NX_SERVER', 'http://rest.nexmo.com/sms/json');

class Nexmo_Sms_Provider implements Sms_Provider_Core {

	/**
	 * Property stores most recent unparsed Nexmo response.
	 * @var string
	 */
	private $unparsed_response = '';
	
	
	/**
	 * Property stores most recent parsed Nexmo response.
	 * @var string
	 */
	private $nexmo_response = '';
	
	
	/**
	 * Whether this class should parse the response from the server. Default: true.
	 * @var bool
	 */
	private $parse_response = TRUE;
	
	/**
	 * API key for the Nexmo account
	 * @var string
	 */
	private $api_key;
	
	/**
	 * API secret associated with the API key
	 * @var string 
	 */
	private $api_secret;
	
	/**
	 * Constructor
	 */
	public function __construct()
	{
		// Load the settings from the DB
		$nexmo_settings = ORM::factory('nexmo', 1);
		
		// Settings loaded?
		if ($nexmo_settings->loaded)
		{
			$this->api_key = $nexmo_settings->nexmo_api_key;
			$this->api_secret = $nexmo_settings->nexmo_api_secret;
		}
		else
		{
			// No settings yet, log error
			Kohana::log('error', Kohana::lang('nexmo.no_settings'));
		}
	}

	
	/**
	 * Prepare new text message.
	 *
	 * @param string $to Recipient of the SMS
	 * @param string $from Sender of the SMS
	 * @param string $message Message to be sent to the recipient
	 */
	public function send($to = NULL, $from  = NULL, $message = NULL)
	{
		if ( !is_numeric($from) ) 
			$from = utf8_encode( $from ); //Must be UTF-8 Encoded if not a continuous number
			
		$message = utf8_encode( $message ); //Must be UTF-8 Encoded
		
		$from = urlencode( $from ); // URL Encode
		$message = urlencode( $message ); // URL Encode
		
		// Check if the API key and secret have been specified
		if ( ! empty($this->api_key) AND ! empty($this->api_secret))
		{
			$post = 'username=' . $this->api_key . '&password=' . $this->api_secret . '&from=' . $from . '&to=' . $to . '&text=' . $message;
						
			if ($this->send_request ($post))
				return TRUE;
		}
		else
		{
			Kohana::log('error', Kohana::lang('nexmo.no_api_key_secret'));
			
			return FALSE;
		}
		
	}
	
	
	/**
	 * Prepare new WAP message.
	 */
	function binary_message ( $to, $from, $body, $udh )
	{
	
		//Binary messages must be hex encoded
		$body = bin2hex ( $body ); //Must be hex encoded binary
		$udh = bin2hex ( $udh ); //Must be hex encoded binary
		
		// URI segment to send to the Nexmo server
		$post = 'username=' . $this->api_key . '&password=' .$this->api_secret . '&from=' . $from . '&to=' . $to 
				. '&type=binary&body=' . $body . '&udh=' . $udh;
		
		$this->send_request ( $post );
		
	}
	
	
	/**
	 * Prepare new binary message.
	 */
	function wappush_message ($to, $from, $title, $url, $validity = 172800000 )
	{
		
		//WAP Push title and URL must be UTF-8 Encoded
		$title = utf8_encode ( $body ); //Must be UTF-8 Encoded
		$url = utf8_encode ( $udh ); //Must be UTF-8 Encoded
		
		$post = 'username='.$this->api_key.'&password='.$this->api_secret.'&from=' . $from . '&to=' . $to 
				. '&type=wappush&url=' . $url . '&title=' . $title . '&validity=' . $validity;
		
		$this->send_request ( $post );
		
	}
	
	
	/**
	 * Prepare and send new text message.
	 */
	private function send_request ($post)
	{
		// Initialize cURL
		$to_nexmo = curl_init( NX_SERVER );
		
		// Set cURL options
		curl_setopt( $to_nexmo, CURLOPT_POST, true );
		curl_setopt( $to_nexmo, CURLOPT_RETURNTRANSFER, true );
		curl_setopt( $to_nexmo, CURLOPT_POSTFIELDS, $post);
		
		$from_nexmo = curl_exec( $to_nexmo );
		
		// Get the HTTP return code
		$http_code = curl_getinfo($to_nexmo, CURLINFO_HTTP_CODE);
		
		// Close cURL session
		curl_close ( $to_nexmo );
		
		// Only proceed to parsing if the request returned HTTP 200
		if ($http_code == 200)
		{
			$from_nexmo = str_replace('-', '', $from_nexmo);
			
			$this->unparsed_response = $from_nexmo;
		
			if ( $this->parse_response )
			{
				$this->nexmo_parse($from_nexmo);
			}
			
			return TRUE;
		}
		else
		{
			// Log the error
			Kohana::log('error', sprintf(Kohana::lang('nexmo.send_request_failed').' HTTP Status %d', $http_code));
			
			return FALSE;
		}
	 
	 }
	
	
	/**
	 * Parse and display server response.
	 */
	private function nexmo_parse ($from_nexmo)
	{
		
		if (NX_SERVER == 'http://rest.nexmo.com/sms/json')
		{
			$response_obj = json_decode( $from_nexmo );
			
			// Run custom event for the plugin on the response data
			Event::run('nexmo_action.update_message_log', $response_obj);
			
			// How many messages were sent?
			if ( $response_obj->messagecount > 1 )
			{
				$start = '<p>Your message was sent in ' . $response_obj->messagecount . ' parts ';
			}
			else
			{
				$start = '<p>Your message was sent ';
			}
			
			// Check each message for errors
			$error = '';
			$messages_array = $response_obj->messages;
			
			foreach ($messages_array as $message)
			{
				if ( $message->status != 0)
				{
					$error .= $message->errortext . ' ';
				}
			}
			
			// Complete parsed response
			if ( $error == '' )
			{
				$complete = 'and delivered successfully.</p>';
			}
			else
			{
				$complete = 'but there was an error: ' . $error . '</p>';
			}
			
			// Set parsed response
			$this->nexmo_response = $start . $complete;
			
		}
		elseif ( NX_SERVER == 'http://rest.nexmo.com/sms/xml' )
		{
			
			// Server is set to XML, so parse with SimpleXML
			$error = '';
			
			//check if SimpleXML is loaded
			if ( !extension_loaded( 'SimpleXML' ) ) return $this->nexmo_response = 'Sorry, you need SimpleXML installed. Please install or try JSON instead.';
			
			$xml = simplexml_load_string( $from_nexmo );
			
			$number_of_parts = 0;
			foreach( $xml->messages[0]->attributes() as $val )
			{
				$number_of_parts += $val;
			}
			
			if( $number_of_parts > 1 )
			{ 
				$start = '<p>Your message was sent in ' . $number_of_parts . ' parts ';
			}
			else
			{ 
				$start = '<p>Your message was sent ';
			}
			
			for ($i = 0; $i < $number_of_parts; $i++)
			{
				if ( $xml->messages[0]->message[$i]->status != 0 )
					$error .= $xml->messages[0]->message[$i]->errorText;
			}
			
			// Check for errors
			if ( $error == '' )
			{
				$complete = 'and delivered successfully.</p>';
			}
			else
			{
				$complete = 'but there was an error: ' . $error . '</p>';
			}
			
			$this->nexmo_response = $start . $complete;
  
		}
		else
		{
			//SERVER not properly set
			$this->nexmo_response = 'Sorry, server response was unreadable. Make sure you have defined constant SERVER to '
									. 'a valid Nexmo server (e.g., http://rest.nexmo.com/sms/json)';
		
		}
		
	}
	
	/**
	 * Gets the account balance for the user via CURL
	 *
	 * @return string
	 */
	public function get_account_balance()
	{
		// Build the request URI
		$request_url = sprintf('http://rest.nexmo.com/account/get-balance/%s/%s', $this->api_key, $this->api_secret);
		
		// cURL options array
		$curl_options = array(
			CURLOPT_URL => $request_url,
			CURLOPT_RETURNTRANSFER => TRUE,
			CURLOPT_HEADER => FALSE,
			CURLOPT_HTTPHEADER => array("Accept: application/json"),
		);
		
		// Initiate cURL
		$ch = curl_init();
		
		// Set the cURL options
		curl_setopt_array($ch, $curl_options);
		
		// Perform cURL session
		$response = curl_exec($ch);
		
		// Get the HTTP response code
		$http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
		
		// Close cURL session
		curl_close($ch);
		
		// Check if the request succeeded
		if ($http_code == 200)
		{
			// Success
			
			// Convert the response to JSON
			$response = json_decode($response);
			
			// Return
			return json_encode(array(
				'success' => TRUE,
				'message' => $response->value
			));
		}
		else
		{
			// Log the error
			Kohana::log('error', Kohana::lang('nexmo.fetch_balance_error'));
			
			// Return
			return json_encode(array(
				'success' => FALSE,
				'message' =>Kohana::lang('nexmo.fetch_balance_error')
			));
		}
	}

}
?>