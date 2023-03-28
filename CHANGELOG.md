# simplicateca/burton Change Log

## v0.3 - 2023.03.28

### Updated

 - Updated Craft to 4.4.5 along with all other plugin updates.
 - Changed default cpTrigger from `/admin` to `/cms/`
 - Additional clean-up on the root project directory structure
 - Docker compose configuration completely rewritten & commented.
 - No more users permission errors within directories created by Docker containers
 - Buddy deployment scripts refactored & commented
 - Consolidated `.pcss` files and reduced thin component folders
 - Completed the switch from webpack to vite
 - Improved documentation for `Gearbox module`
 - Rebuilt emergency message / alert bar component
 - Improved default footer template & added separate navigation menus
 - Spent too much time making the post-composer-install prep.php pretty


### Added

 - A Docker container for local development documentation (Wikmd). Available at http://localhost:5000
 - Introduced the root etc/ folder for holding additional project files and misc configurations
 - Universal Email Template for Craft system emails
 - Working example of full page transition animation in `components/transitions`
 - Carousel component now has both a full-width and 3-wide versions.
 - Dropdowns in the default primary nav use a11y friendly click-to-toggle AlpineJS menus
 - Social Links widget now has a embedded SVGs available for a number of popular/common services


### Removed
 
 - Code snippets and default settings related to specific vendors/tools used internally, but not universally have been moved to a private repo that can be included locally after running `composer create project`
 - Cleaned up some of the default block type examples & tests and moved them to a playground release.
 - Disabled updating & plugin installation from within the control panel - even on development
 - Disabled powered by Craft CMS header
