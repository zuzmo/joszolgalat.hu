<div class="report_list">
	<div class="block">
		<?php
		if ($category AND $category->loaded)
		{
			$category_id = $category->id;
			$color_css = 'class="swatch" style="background-color:#'.$category->category_color.'"';
			echo '<h2 class="other"><a href="#"><div '.$color_css.'></div>'.$category->category_title.'</a></h2>';
		}
		else
		{
			$category_id = "";
		}
		?>
		<div class="other filter">
<?php if (!empty($filter)) { ?>
			<form action=<?php echo url::site() . '/mobile/reports/search' ?> method="get" accept-charset="utf-8">
				<div><label for="town">Your Area</label>
				<input type="text" name="town" value="<?php echo $town ?>"></div>
				
				<div><label for="distance">Distance</label>
				<select name="distance" id="distance">
					<?php
					$distance_options = array('0.5', '1', '2', '3', '7', '10', '20');
					$selected_distance = isset($_GET['distance']) ? $_GET['distance'] : '0.5';
					foreach($distance_options as $option){
						echo '<option value="' . $option . '"';
						echo $option == $selected_distance ? 'selected' : '';
						echo '>' . $option . ' km</option>';
					}
					?>
				</select></div>
				<div><label for="category">Category</label>
				<select class="catlist" name="category_id" id="category_id">
					<?php 
						$selected_category = isset($_GET['category_id']) ? $_GET['category_id'] : '0';
						
						echo '<option value="0"';
						echo 0 == $selected_category ? 'selected' : '';
						echo '>All categories</option>';
						
						foreach ($categories as $category) {
							
						echo '<option value="' . $category->id . '"';
						echo $category->id == $selected_category ? 'selected' : '';
						echo '>' . $category->category_title . '</option>';
						
						if ($category->children->count() > 0) {
							foreach ($category->children as $child) {
								echo '<option value="' . $child->id . '"';
								echo $child->id == $selected_category ? 'selected' : '';
								echo '>--' . $child->category_title . '</option>';
							}
						}
					} 
				?>
				</select></div>
				<div><label for="order">Order By</label>
				<select name="order" id="order">
					<?php
					$order_options = array('distance', 'date', 'verified');
					$selected_distance = isset($_GET['order']) ? $_GET['order'] : 'distance';
					foreach($order_options as $option){
						echo '<option value="' . $option . '"';
						echo $option == $selected_distance ? 'selected' : '';
						echo '>' . $option . '</option>';
					}
					?>
				</select>
				<input class="searchbtn" type="submit" value="Search &rarr;">
				</div>
			</form>
<?php } ?>
		</div>
		<div class="list">
			<ul>
				<?php
				if ($have_results && $incidents->count())
				{
					$page_no = (isset($_GET['page'])) ? $_GET['page'] : "";
					foreach ($incidents as $incident)
					{
						$incident_date = $incident->incident_date;
						$incident_date = date('H:i M d', strtotime($incident->incident_date));
						if(property_exists($incident, 'last_updated')){
							$lastupdated = $incident->last_updated;
							$lastupdated = date('H:i M d', strtotime($incident->last_updated));
						}
						$location_name = $incident->location_name;
						echo '<li><span class="verified ';
						if ($incident->incident_verified == 1)
						{
							echo 'verified_yes">Verified</span>';
						} else {
							echo '">Unverified</span>';
						}
						echo "<strong><a href=\"".url::site()."mobile/reports/view/".$incident->id."?c=".$category_id."&p=".$page_no."\">".$incident->incident_title."</a></strong>";
						echo "&nbsp;&nbsp;<i>$incident_date";
						if(isset($lastupdated)) {
							echo "(Updated ".$lastupdated.")";
						}
						echo "</i>";
						echo "<BR /><span class=\"location_name\">".$location_name."</span></li>";
					}
				}
				else
				{
					echo "<li>No Reports Found</li>";
				}
				?>
			</ul>
		</div>
		<?php if ($have_results) { echo $pagination; } ?>
	</div>
</div>
