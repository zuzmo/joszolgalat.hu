<?php
/**
 * Performs install/uninstall methods for the Sharing Plugin
 *
 * @package    Ushahidi
 * @author     Ushahidi Team
 * @copyright  (c) 2008 Ushahidi Team
 * @license    http://www.ushahidi.com/license.html
 */
class Sharing_Install {

	/**
	 * Constructor to load the shared database library
	 */
	public function __construct()
	{
		$this->db =  new Database();
	}

	/**
	 * Creates the required database tables for the sharing module
	 */
	public function run_install()
	{
		// Create the database tables
		// Include the table_prefix
		$this->db->query("
			CREATE TABLE IF NOT EXISTS `".Kohana::config('database.default.table_prefix')."sharing`
			(
				`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
				`sharing_name` varchar(150) NOT NULL COMMENT 'name that appears on the front end',
				`sharing_url` varchar(255) NOT NULL COMMENT 'url of the deployment to share with',
				`sharing_color` varchar(20) DEFAULT 'CC0000' COMMENT 'color that shows the shared reports',
				`sharing_active` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'sharing active or inactive ',
				`sharing_date` datetime DEFAULT NULL COMMENT 'date the sharing was initiated',
				PRIMARY KEY (id)
			);");

			$this->db->query("
			CREATE TABLE IF NOT EXISTS `".Kohana::config('database.default.table_prefix')."sharing_incident`
			(
				`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
				`sharing_id` INT UNSIGNED NOT NULL,
				`incident_id` INT(10) NOT NULL,
				`incident_title` varchar(255) NOT NULL COMMENT 'title of the report',
				`latitude` double NOT NULL COMMENT 'latitude of the report',
				`longitude` double NOT NULL COMMENT 'longitude of the report',
				`incident_date` datetime DEFAULT NULL,
				PRIMARY KEY (id)
			);");

			$this->db->query("
			CREATE TABLE IF NOT EXISTS `".Kohana::config('database.default.table_prefix')."sharing_log`
			(
			  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
			  `sharing_id` int(11) NOT NULL,
			  `sharing_log_date` int(10) unsigned DEFAULT NULL,
			   PRIMARY KEY (`id`)
			);");

			//Dump the sharing scheduler item from bundled SQL dump file
			$this->db->query("DELETE FROM `".Kohana::config('database.default.table_prefix')."scheduler` where scheduler_name = 'Sharing' ");
			$db_insert = fopen (dirname(dirname(__FILE__)).'/sql/s_sharing.sql', 'r');
			$rows = fread ($db_insert, filesize(dirname(dirname(__FILE__)).'/sql/s_sharing.sql'));
			
			//split by ; to get the sql statement for inserting each row
			$rows = explode(';\n',$rows);

			foreach($rows as $query) 
			{
				$this->db->query($query);
			}

    
	}

	/**
	 * Deletes the database tables for the sharing module
	 */
	public function uninstall()
	{
		$this->db->query("
			DROP TABLE ".Kohana::config('database.default.table_prefix')."sharing;
			");
		$this->db->query("
			DROP TABLE ".Kohana::config('database.default.table_prefix')."sharing_incident;
			");
		$this->db->query("
			DROP TABLE ".Kohana::config('database.default.table_prefix')."sharing_log;
			");

	}
}
