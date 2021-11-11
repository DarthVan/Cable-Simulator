package screen.device.controls.cells;

/**
 * ...
 * @author Sith
 */

enum abstract CellsState(String) to String {

	var EMPTY = 'empty';
	var NORMAL = 'normal';
	var LOCKED = 'locked';
	var HIDDEN = 'hidden';
	
}