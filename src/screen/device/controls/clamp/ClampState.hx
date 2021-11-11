package screen.device.controls.clamp;

/**
 * ...
 * @author Sith
 */

enum abstract ClampState(String) to String {

	var INSIDE = 'inside';
	var OUTSIDE = 'outside';
	var OUTSIDE_LOCKED = 'outside_locked';
	
}