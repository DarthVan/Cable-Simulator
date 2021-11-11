package screen.device.controls.latch;

/**
 * ...
 * @author Sith
 */

enum abstract LatchState(String) to String {
	
	var INSIDE = 'inside';
	var OUTSIDE = 'outside';
	var OUTSIDE_LABELED = 'outside_labeled';
	
}