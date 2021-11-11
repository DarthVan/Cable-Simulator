package screen.device.controls.indicator;

/**
 * ...
 * @author Sith
 */

enum abstract IndicatorState(String) to String {
	
	var ON = 'on';
	var OFF = 'off';
	var CHARGED_OK = 'charged_ok';
	var CHARGED_NOT_OK = 'charged_not_ok';
	var DISCHARGED = 'discharged';
	
}