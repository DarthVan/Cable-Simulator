package components.tester;

import openfl.events.Event;

/**
 * ...
 * @author Sith
 */

class TesterEvent extends Event {

	public static inline var RELOAD : String = 'reload_event';
	public static inline var NEXT : String = 'next_event';
	
	public function new(type : String, bubbles : Bool = false, cancelable : Bool = false) {
		super(type, bubbles, cancelable);
	}
	
}