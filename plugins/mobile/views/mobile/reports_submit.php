<div class="report_submit">
	<h2 class="main_title">Submit A Report</h2>
	<?php print form::open(NULL, array('enctype' => 'multipart/form-data', 'id' => 'reportForm', 'name' => 'reportForm')); ?>
<?php /*
	<input type="hidden" name="latitude" id="latitude" value="<?php echo $form['latitude']; ?>">
	<input type="hidden" name="longitude" id="longitude" value="<?php echo $form['longitude']; ?>">
 */
?>
	<div class="report_form">
		
		<?php
			if ($form_error) {
		?>
		<!-- red-box -->
		<div class="red-box">
			<h3>Error!</h3>
			<ul>
				<?php
					foreach ($errors as $error_item => $error_description)
					{
						// print "<li>" . $error_description . "</li>";
						print ( ! $error_description) ? '' : "<li>" . $error_description . "</li>";
					}
				?>
			</ul>
		</div>
		<?php
			}
		?>	
	
		<div class="report_row">
			<h4><?php echo Kohana::lang('ui_main.reports_title'); ?></h4>
			<?php print form::input('incident_title', $form['incident_title'], ' class="text long"'); ?>
		</div>
		
		<div class="report_row">
			<h4><?php echo Kohana::lang('ui_main.reports_description'); ?></h4>
			<?php print form::textarea('incident_description', $form['incident_description'], ' rows="10" class="textarea long" ') ?>
		</div>
<?php /*
		<div class="report_row">
			<h4><?php echo Kohana::lang('ui_main.reports_date'); ?></h4>
			<?php
			// Month Array
			for ($i=1; $i <= 12 ; $i++) { 
				$month_array[sprintf("%02d", $i)] = date("F", mktime(0, 0, 0, $i, 10));	 // Add Leading Zero
			}
			// Day Array
			for ($i=1; $i <= 31 ; $i++) { 
				$day_array[sprintf("%02d", $i)] = sprintf("%02d", $i);	 // Add Leading Zero
			}
			// Year Array
			$year_now = date('Y');
			for ($i=-2; $i <= 0 ; $i++) {
				$this_year = $year_now + $i;
				$year_array[$this_year] = $this_year;
			}
			
			print form::dropdown('incident_month',$month_array,$form['incident_month']);
			print '<span class="dots">/</span>';
			print form::dropdown('incident_day',$day_array,$form['incident_day']);
			print '<span class="dots">/</span>';
			print form::dropdown('incident_year',$year_array,$form['incident_year']);
			?>
		</div>
		
		<div class="report_row">
			<h4><?php echo Kohana::lang('ui_main.reports_time'); ?></h4>
			<?php
				for ($i=1; $i <= 12 ; $i++) { 
					$hour_array[sprintf("%02d", $i)] = sprintf("%02d", $i);	 // Add Leading Zero
				}
				for ($j=0; $j <= 59 ; $j++) { 
					$minute_array[sprintf("%02d", $j)] = sprintf("%02d", $j);	// Add Leading Zero
				}
				$ampm_array = array('pm'=>'pm','am'=>'am');
				print form::dropdown('incident_hour',$hour_array,$form['incident_hour']);
				print '<span class="dots">:</span>';
				print form::dropdown('incident_minute',$minute_array,$form['incident_minute']);
				print '<span class="dots">:</span>';
				print form::dropdown('incident_ampm',$ampm_array,$form['incident_ampm']);
			?>
		</div>
		<div class="report_row">
			<h4><?php echo Kohana::lang('ui_main.reports_categories'); ?> (Select All That Apply)</h4>
			<div class="report_category" id="categories">
				<?php
				$selected_categories = array();
     if (!empty($form['incident_category']) && is_array($form['incident_category'])) {
					$selected_categories = $form['incident_category'];
				}
				$columns = 1;
				echo category::tree($categories, $selected_categories, 'incident_category', $columns);
				?>
			</div>
		</div>
			<h4>Location</h4>
			<span class="location">Select A Location from the Drop-Down</span>
			<?php print form::dropdown('select_city',$cities,'', ' class="select" '); ?>
			<span class="location">OR Enter A Location</span>
*/ ?>
		<div class="report_row">
			<span class="location">Enter A Location</span>
			<?php print form::input('location_name', $form['location_name'], ' class="text long"'); ?>
		</div>
		
		<div class="report_row">
			<input name="submit" type="submit" value="<?php echo Kohana::lang('ui_main.reports_btn_submit'); ?>" class="btn_submit" /> 
		</div>
        <input type="hidden" name="incident_category[]" value="<?php echo $mobilecategory ?>" />
	</div>
	</form>
</div>
