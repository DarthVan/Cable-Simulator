package screen.device.controls.switcher;

/**
 * ...
 * @author Sith
 */

enum abstract SwitcherState(String) to String {

	var ON = 'on';
	var MIDDLE = 'middle';
	var OFF = 'off';
	
	var ON_TABLED = 'on_tabled';
	var MIDDLE_TABLED = 'middle_tabled';
	var OFF_TABLED = 'off_tabled';
	
}