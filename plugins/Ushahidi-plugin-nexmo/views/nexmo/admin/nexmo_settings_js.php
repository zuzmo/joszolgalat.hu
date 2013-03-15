<?php
/**
 * PHP-Javascript for the nexmo_settings controller
 */
?>
	/**
	 * Initiates a request for fetching the Nexmo account balance	
	 */
	function getAccountBalance()
	{
		// Show the progress bar
		$('#balance_loading').html('<img src="<?php echo url::base() . "media/img/loading_g.gif"; ?>">');
		
		// Send request to the nexmo_settings controller
		$.get('<?php echo url::site().'admin/nexmo_settings/get_balance'?>', 
			function(response){
				// Hide the progress bar
				$('#balance_loading').html('');
				
				if (response.success)
				{
					// Show the balance
					alert('<?php echo Kohana::lang('nexmo.account_balance')?>: ' + response.message);
				}
				else
				{
					// Show the error message
					alert(response.message);
				}
			}
		);
	}