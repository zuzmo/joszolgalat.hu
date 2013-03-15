=== About ===
name: Mobile Edition
website: http://www.ushahidi.com
description: Mobile Accessible Version of Ushahidi
version: 1.0.0
requires: 2.0
tested up to: 2.2
author: David Kobia
author website: http://www.dkfactor.com

== Description ==

== Installation ==
1. Copy the entire /mobile/ directory into your /plugins/ directory.
2. Activate the plugin.

== Changelog ==
1.0.0

** Many thanks to Penny Leach and Marga Keuvelaar, and work done on the Christchurch Earthquake map. **

- Moved recent reports and recent news back to homepage instead of category page
- Fixed the result listing page for category drill down instead of searching
- Fixed the name of the category param
- Added categories to the view, enabled select box
- Fixing the last update bug on category result pages
- Fixed the date and added the updated date
- Adding a filter bar
- Sesults screen: added filtering for distance & category, and ordering options
- Switched the mobile geocoding radius to the Haversine forumla
- Don't execute SQL and render results when there is no location
- Fixed pagination query and total result information
- Location sensitive result list
- Simplify mobile report submission
- Added the categories page to the breadcrumb on a report page
- Added the breadcrumb to a reports list to go back to the categories list
- Adding a new page for the result list of the reports search.
- Replaced dynamic google map on mobile result page with static map.
- Moved the categories display to a new page (/mobile/categories)
- Simplified the home page
- Updated dates to be more consistent, using a style like '13:45 Feb 24'. Closes #20.
- Fixed mobile nav
- LOTS of other fixes, and layout tweaks

0.9.4
- More fixes to prevent API call inteference

0.9.2
- Mobile hook interfered with api calls

0.9.1
- Modified to work with the latest version of 2.0
