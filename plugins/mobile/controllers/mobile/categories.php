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

class Categories_Controller extends Mobile_Controller {

    public function __construct()
    {
		parent::__construct();
	}
	
	/**
	 * Displays a list of reports
	 * @param boolean $category_id If category_id is supplied filter by
	 * that category
	 */
	public function index()
	{
		$this->template->content = new View('mobile/categories');
		
		// Get all active top level categories
        $parent_categories = array();
        foreach (ORM::factory('category')
				->where('category_visible', '1')
				->where('parent_id', '0')
				->orderby('category_title')
				->find_all() as $category)
        {
            // Get The Children
			$children = array();
			foreach ($category->children as $child)
			{
				$children[$child->id] = array(
					$child->category_title,
					$child->category_color,
					$child->category_image,
					$this->_category_count($child->id)
				);
			}

			// Put it all together
            $parent_categories[$category->id] = array(
				$category->category_title,
				$category->category_color,
				$category->category_image,
				$this->_category_count($category->id),
				$children
			);
			
			if ($category->category_trusted)
			{ // Get Trusted Category Count
				$trusted = ORM::factory("incident")
					->join("incident_category","incident.id","incident_category.incident_id")
					->where("category_id",$category->id);
				if ( ! $trusted->count_all())
				{
					unset($parent_categories[$category->id]);
				}
			}
        }
        $this->template->content->categories = $parent_categories;
		
		// Force Home breadcrumb
		$this->template->header->breadcrumbs = " ";

		// Get pages
		$this->template->content->pages = ORM::factory('page')->where('page_active', '1')->find_all();
	}
	
	private function _category_count($category_id = false)
	{
		if ($category_id)
		{
			return ORM::factory('incident_category')
				->join('incident', 'incident_category.incident_id', 'incident.id')
				->where('category_id', $category_id)
				->where('incident_active', '1')
				->count_all();
		}
		else
		{
			return 0;
		}
	}
}
