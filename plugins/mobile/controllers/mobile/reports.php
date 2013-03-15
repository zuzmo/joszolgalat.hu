<?php defined('SYSPATH') or die('No direct script access.');
/**
 * Mobile Controller
 * Generates KML with PlaceMarkers and Category Styles
 *
 * PHP version 5
 * LICENSE: This source file is subject to LGPL license 
 * that is available through the world-wide-web at the following URI:
 * http://www.gnu.org/copyleft/lesser.html
 * @author	   Ushahidi Team <team@ushahidi.com> 
 * @package    Ushahidi - http://source.ushahididev.com
 * @module	   Mobile Controller	
 * @copyright  Ushahidi - http://www.ushahidi.com
 * @license    http://www.gnu.org/copyleft/lesser.html GNU Lesser General Public License (LGPL) 
* 
*/

class Reports_Controller extends Mobile_Controller {

    public function __construct()
    {
		parent::__construct();
	}
	
	/**
	 * Displays a list of reports
	 * @param boolean $category_id If category_id is supplied filter by
	 * that category
	 */
	public function index($category_id = false)
	{
		$this->template->content = new View('mobile/reports');
		
		$db = new Database;
		
		$filter = ( $category_id )
			? " AND ( c.id='".$category_id."' OR 
				c.parent_id='".$category_id."' )  "
			: " AND 1 = 1";
			
		// Pagination
		$pagination = new Pagination(array(
				'style' => 'mobile',
				'query_string' => 'page',
				'items_per_page' => (int) Kohana::config('mobile.items_per_page'),
				'total_items' => $db->query("SELECT DISTINCT i.* FROM `".$this->table_prefix."incident` AS i JOIN `".$this->table_prefix."incident_category` AS ic ON (i.`id` = ic.`incident_id`) JOIN `".$this->table_prefix."category` AS c ON (c.`id` = ic.`category_id`) WHERE `incident_active` = '1' $filter")->count()
				));
		$this->template->content->pagination = $pagination;

		$incidents = $db->query("SELECT DISTINCT i.*, l.location_name FROM `".$this->table_prefix."incident` AS i JOIN `".$this->table_prefix."incident_category` AS ic ON (i.`id` = ic.`incident_id`) JOIN `".$this->table_prefix."category` AS c ON (c.`id` = ic.`category_id`) JOIN `".$this->table_prefix."location` AS l ON (i.`location_id` = l.`id`) WHERE `incident_active` = '1' $filter ORDER BY incident_date DESC LIMIT ". (int) Kohana::config('mobile.items_per_page') . " OFFSET ".$pagination->sql_offset);
		
		// If Category Exists
		if ($category_id)
		{
			$category = ORM::factory("category", $category_id);
		}
		else
		{
			$category = FALSE;
		}
			
		$this->template->content->filter = false;
		$this->template->content->incidents = $incidents;
		$this->template->content->category = $category;
		$this->template->content->have_results = true;
		
		$this->template->header->breadcrumbs = "&nbsp;&raquo;&nbsp;<a href=\"".url::site()."mobile/categories/\">Categories</a>";
	}
	
	public function search($town = false)
	{
		$location = null;
		$town = null;
		
		$this->template->content = new View('mobile/reports');
		
		// Force Home breadcrumb
		$this->template->header->breadcrumbs = " ";
		
		$db = new Database;
		
		$town = isset($_GET['town']) ? $_GET['town'] : '';
		$categoryid = isset($_GET['category_id']) ? (int)$_GET['category_id'] : null;
		$distance = isset($_GET['distance']) ? (float)$_GET['distance'] : 0.5;
		$order = isset($_GET['order']) ? $_GET['order'] : '';
		switch ($order) {
		case 'date':
			$order = 'coalesce(incident_datemodify, incident_dateadd) desc';
			break;
		case 'verified':
			$order  = 'incident_verified desc';
			break;
		default:
			$order = 'distance asc';
		}

		if (!empty($town)) {
			$location = $town;
			if ( ! Kohana::config('settings.multi_country') && $country = ORM::factory('country', Kohana::config('settings.default_country'))->country)
			{
				$location .= ', '.$country;
			}
			$location = mobile_geocoder::geocode($location);
		}

		// if we don't get location there will be no results rendered
		if (!$location) {
			$this->template->content->have_results = false;
			$this->template->content->filter = true;
			$this->template->content->town = $town;
			$this->template->content->category = 0;
			$this->template->content->categories = array();
			return;
		}

		$fields = '
			69.09 *
			DEGREES(
				ACOS(
					SIN( RADIANS(latitude) )*SIN( RADIANS(' . $location['lat'] . ') )
				+
					COS( RADIANS(latitude) )*COS( RADIANS(' . $location['lat'] . ') )
				*
					COS( RADIANS(longitude - (' . $location['lon'] . ')) )
				)
			) as distance,
			i.*,coalesce(incident_datemodify, incident_dateadd) as last_updated, l.location_name';

		$where = '
			WHERE `incident_active` = 1
			';

		$having = "
			HAVING distance < $distance
			";

		$incidents_sql = "SELECT $fields
			FROM `".$this->table_prefix."incident` AS i
				JOIN `" . $this->table_prefix . "location` AS l ON (i.`location_id` = l.`id`)";

		if (!empty($categoryid)) {
			$incidents_sql .= "
				JOIN `" . $this->table_prefix . "incident_category` AS ic ON (i.`id` = ic.`incident_id`)
				";
			$where .= "AND  ic.category_id = $categoryid ";
		}
		$incidents_sql .= $where . $having;

		$pagination = new Pagination(array(
				'style' => 'mobile',
				'query_string' => 'page',
				'items_per_page' => (int) Kohana::config('mobile.items_per_page'),
				'total_items' => $db->query($incidents_sql)->count()
		));

		$this->template->content->pagination = $pagination;

		$incidents = $db->query(
			$incidents_sql .
				"ORDER BY $order
				 LIMIT ". (int) Kohana::config('mobile.items_per_page') . "
				 OFFSET {$pagination->sql_offset}"
		);

		$this->template->content->filter = true;
		$this->template->content->have_results = true;
		$this->template->content->town = $town;
		$this->template->content->incidents = $incidents;
		$this->template->content->category = null;
		
		$categories = ORM::factory('category')
		    ->where('category_visible', '1')
		    ->where('parent_id', '0')
		    ->where('category_trusted != 1')
		    ->orderby('category_title', 'ASC')
		    ->find_all();
		
		$this->template->content->categories = $categories;
	}	
	
	/**
	 * Displays a report.
	 * @param boolean $id If id is supplied, a report with that id will be
	 * retrieved.
	 */
	public function view($id = false)
	{	
		$this->template->header->show_map = TRUE;
		$this->template->header->js = new View('mobile/reports_view_js');
		$this->template->content = new View('mobile/reports_view');
		
		$this->template->header->breadcrumbs = " ";
		
		if ( ! $id )
		{
			url::redirect('mobile');
		}
		else
		{
			$incident = ORM::factory('incident', $id);
			if ( ! $incident->loaded)
			{
				url::redirect('mobile');
			}
			
			$this->template->content->incident = $incident;
			
			$page_no = (isset($_GET['p'])) ? $_GET['p'] : "";
			$category_id = (isset($_GET['c'])) ? $_GET['c'] : "";
			if ($category_id)
			{
				$category = ORM::factory('category')
					->find($category_id);
				if ($category->loaded)
				{
					$this->template->header->breadcrumbs = "&nbsp;&raquo;&nbsp;<a href=\"".url::site()."mobile/categories/\">Categories</a>&nbsp;&raquo;&nbsp;<a href=\"".url::site()."mobile/reports/index/".$category_id."?page=".$page_no."\">".$category->category_title."</a>";
				}
			}
		}
	}
	
	public function submit($saved = false)
	{
		// Cacheable Controller
		$this->is_cachable = FALSE;
		
		$this->template->header->show_map = TRUE;
		$this->template->content  = new View('mobile/reports_submit');
		
		// First, are we allowed to submit new reports?
		if ( ! Kohana::config('settings.allow_reports'))
		{
			url::redirect(url::site().'main');
		}

		// setup and initialize form field names
		$form = array
		(
			'incident_title' => '',
			'incident_description' => '',
            /*
			'incident_month' => '',
			'incident_day' => '',
			'incident_year' => '',
			'incident_hour' => '',
			'incident_minute' => '',
			'incident_ampm' => '',
			'latitude' => '',
			'longitude' => '',
            */
			'location_name' => '',
			//'country_id' => '',
			'incident_category' => array(),
		);
		//	copy the form as errors, so the errors will be stored with keys corresponding to the form field names
		$errors = $form;
		$form_error = FALSE;

		if ($saved == 'saved')
		{
			$form_saved = TRUE;
		}
		else
		{
			$form_saved = FALSE;
		}


		// Initialize Default Values
        /*
		$form['incident_month'] = date('m');
		$form['incident_day'] = date('d');
		$form['incident_year'] = date('Y');
		$form['incident_hour'] = "12";
		$form['incident_minute'] = "00";
		$form['incident_ampm'] = "pm";
         */
		// initialize custom field array
		// $form['custom_field'] = $this->_get_custom_form_fields($id,'',true);
		//GET custom forms
		//$forms = array();
		//foreach (ORM::factory('form')->find_all() as $custom_forms)
		//{
		//	$forms[$custom_forms->id] = $custom_forms->form_title;
		//}
		//$this->template->content->forms = $forms;
		
		
		// check, has the form been submitted, if so, setup validation
		if ($_POST)
		{
			// Instantiate Validation, use $post, so we don't overwrite $_POST fields with our own things
			$post = Validation::factory(array_merge($_POST,$_FILES));

			 //  Add some filters
			$post->pre_filter('trim', TRUE);

			// Add some rules, the input field, followed by a list of checks, carried out in order
			$post->add_rules('incident_title', 'required', 'length[3,200]');
			$post->add_rules('incident_description', 'required');
            /*
			$post->add_rules('incident_month', 'required', 'numeric', 'between[1,12]');
			$post->add_rules('incident_day', 'required', 'numeric', 'between[1,31]');
			$post->add_rules('incident_year', 'required', 'numeric', 'length[4,4]');
			
			if ( ! checkdate($_POST['incident_month'], $_POST['incident_day'], $_POST['incident_year']) )
			{
				$post->add_error('incident_date','date_mmddyyyy');
			}
			
			$post->add_rules('incident_hour', 'required', 'between[1,12]');
			$post->add_rules('incident_minute', 'required', 'between[0,59]');

			if ($_POST['incident_ampm'] != "am" && $_POST['incident_ampm'] != "pm")
			{
				$post->add_error('incident_ampm','values');
			}

			// Validate for maximum and minimum latitude values
			$post->add_rules('latitude', 'between[-90,90]');
			$post->add_rules('longitude', 'between[-180,180]');
             */
			$post->add_rules('location_name', 'required', 'length[3,200]');

            /*
			//XXX: Hack to validate for no checkboxes checked
			if (!isset($_POST['incident_category'])) {
				$post->incident_category = "";
				$post->add_error('incident_category', 'required');
			}
			else
			{
				$post->add_rules('incident_category.*', 'required', 'numeric');
			}
             */
			
			// Geocode Location
			if ( empty($_POST['latitude']) AND empty($_POST['longitude']) 
				AND ! empty($_POST['location_name']) )
			{
				$default_country = Kohana::config('settings.default_country');
				$country_name = "";
				if ($default_country)
				{
					$country = ORM::factory('country', $default_country);
					if ($country->loaded)
					{
						$country_name = $country->country;
					}
				}
				
				$geocode = mobile_geocoder::geocode($_POST['location_name'].", ".$country_name);
				if ($geocode)
				{
					$post->latitude = $geocode['lat'];
					$post->longitude = $geocode['lon'];
				}
				else
				{
					$post->add_error('location_name', 'geocode');
				}
			}

			// Test to see if things passed the rule checks
			if ($post->validate())
			{
				if ($post->latitude AND $post->longitude)
				{
					// STEP 1: SAVE LOCATION
					$location = new Location_Model();
					$location->location_name = $post->location_name;
					$location->latitude = $post->latitude;
					$location->longitude = $post->longitude;
					$location->location_date = date("Y-m-d H:i:s",time());
					$location->save();
				}
				
				// STEP 2: SAVE INCIDENT
				$incident = new Incident_Model();
				if (isset($location) AND $location->loaded)
				{
					$incident->location_id = $location->id;
				}
				$incident->user_id = 0;
				$incident->incident_title = $post->incident_title;
				$incident->incident_description = $post->incident_description;

                /*
				$incident_date = $post->incident_year."-".$post->incident_month."-".$post->incident_day;
				$incident_time = $post->incident_hour
					.":".$post->incident_minute
					.":00 ".$post->incident_ampm;
				$incident->incident_date = date( "Y-m-d H:i:s", strtotime($incident_date . " " . $incident_time) );				
                 */
				$incident->incident_dateadd = $incident->incident_date =  date("Y-m-d H:i:s",time());
				$incident->save();

				// STEP 3: SAVE CATEGORIES
				foreach($post->incident_category as $item)
				{
					$incident_category = new Incident_Category_Model();
					$incident_category->incident_id = $incident->id;
					$incident_category->category_id = $item;
					$incident_category->save();
				}
				
				url::redirect('mobile/reports/thanks');
				
			}
			// No! We have validation errors, we need to show the form again, with the errors
			else
			{
				// repopulate the form fields
				$form = arr::overwrite($form, $post->as_array());

				// populate the error fields, if any
				$errors = arr::overwrite($errors, $post->errors('mobile_report'));
				$form_error = TRUE;
			}
			
		}
		
		
		
		
		$this->template->content->form = $form;
		$this->template->content->errors = $errors;
		$this->template->content->form_error = $form_error;
		$this->template->content->categories = $this->_get_categories($form['incident_category']);
        $mobilecat = 0;
        if ($mobilecat = $this->template->content->categories->current()) {
            $mobilecat = $mobilecat->id;
        }
		$this->template->content->mobilecategory = $mobilecat;
		$this->template->content->cities = $this->_get_cities();
		
		$this->template->header->js = new View('mobile/reports_submit_js');
        /*
		if (!$form['latitude'] || !$form['latitude'])
		{
			$this->template->header->js->latitude = Kohana::config('settings.default_lat');
			$this->template->header->js->longitude = Kohana::config('settings.default_lon');
		}else{
			$this->template->header->js->latitude = $form['latitude'];
			$this->template->header->js->longitude = $form['longitude'];
		}
         */
	}
	
	// http://ushahidi.dev/mobile
	public function thanks()
		{
			$this->template->content = new View('mobile/reports_thanks');
			$this->template->header->breadcrumbs = "&nbsp;&raquo;&nbsp;<a href=\"".url::site()."mobile/reports/submit/\">Submit A Report</a>";
		}
	
	/*
	 * Retrieves Categories
	 */
	private function _get_categories($selected_categories)
	{
		$categories = ORM::factory('category')
			->where('category_visible', '1')
			->where('category_trusted != 1')
			->where("category_title = 'Mobile'")
			->orderby('category_title', 'ASC')
			->find_all();

		return $categories;
	}
	
	
	/*
	 * Retrieves Cities
	 */
	private function _get_cities()
	{
		$cities = ORM::factory('city')->orderby('city', 'asc')->find_all();
		$city_select = array('' => 'Select A Location from the Drop-Down');

		foreach ($cities as $city)
		{
			$city_select[$city->city_lon.",".$city->city_lat] = $city->city;
		}

		return $city_select;
	}
}
