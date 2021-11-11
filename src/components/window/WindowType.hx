package components.window;

/**
 * @author Sith
 */

enum abstract WindowType(Int) to Int {
	
	var CONTINUE = 0;
	var NEXT = 1;
	var RETRY = 2;
	var FIX_CONTINUE = 3;
	var FINISH = 4;
	
}