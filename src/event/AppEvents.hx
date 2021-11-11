package event;

import openfl.events.Event;

/**
 * ...
 * @author Sith
 */

class AppEvents extends Event {
	
	public static inline var WINDOW_CLOSED : String = 'window_closed_event';
	public static inline var WINDOW_OPEN_MANUALLY : String = 'window_open_manually_event';
	public static inline var OBJECT_PICKED : String = 'object_picked_event';
	
	public var data(get, null) : Dynamic;
	
	public function new(type : String, data : Dynamic = null, bubbles : Bool = false, cancelable : Bool = false) {
		super(type, bubbles, cancelable);
		this.data = data;
	}
	
	function get_data() : Dynamic {
		return data;
	}
}