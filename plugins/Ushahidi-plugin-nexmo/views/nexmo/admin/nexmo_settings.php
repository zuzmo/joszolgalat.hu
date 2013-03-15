<table style="width: 630px;" class="my_table">
	<tr>
		<td style="width:60px;">
			<span class="big_blue_span"><?php echo Kohana::lang('ui_main.step');?> 1:</span>
		</td>
		<td>
			<h4 class="fix"><?php echo Kohana::lang('nexmo.settings_text_1');?>.</h4>
		</td>
	</tr>
	<tr>
		<td>
			<span class="big_blue_span"><?php echo Kohana::lang('ui_main.step');?> 2:</span>
		</td>
		<td>
			<h4 class="fix"><?php echo Kohana::lang('nexmo.settings_text_2');?>.</h4>
			<div class="row">
				<h4><?php echo Kohana::lang('nexmo.api_key');?>:</h4>
				<?php print form::input('nexmo_api_key', $form['nexmo_api_key'], ' class="text title_2"'); ?>
			</div>
			<div class="row">
				<h4><?php echo Kohana::lang('nexmo.api_secret');?>:</h4>
				<?php print form::password('nexmo_api_secret', $form['nexmo_api_secret'], ' class="text title_2"'); ?>
			</div>
			
			<div class="row">
				<h4><?php echo Kohana::lang('nexmo.phone_number');?>:</h4>
				<?php print form::input('nexmo_phone_no', $form['nexmo_phone_no'], ' class="text title_2"'); ?>
			 </div>
			 
		</td>
	</tr>
	<tr>
		<td>
			<span class="big_blue_span">Step 3:</span>
		</td>
		<td>
			<h4 class="fix">
				<a href="#" onclick="getAccountBalance();"><?php echo Kohana::lang('nexmo.check_balance') ;?></a>
				<span id="balance_loading"></span>
			</h4>
		</td>
	</tr>
	<tr>
		<td>
			<span class="big_blue_span"><?php echo Kohana::lang('ui_main.step');?> 4:</span>
		</td>
		<td>
			<h4 class="fix"><?php echo Kohana::lang('nexmo.working_with_nexmo')?> </h4>
			<p><?php echo Kohana::lang('nexmo.two_way_nexmo'); ?></p>
			<p><?php echo Kohana::lang('nexmo.delivery_receipt_url'); ?></p>
			<p class="sync_key">
				<span><?php echo $delivery_receipt_url; ?> </span>
			</p>
			<p><?php echo Kohana::lang('nexmo.inbound_message_url'); ?></p>
			<p class="sync_key">
				<span><?php echo $inbound_message_url; ?></span>
			</p>
		</td>
	</tr>								
</table>