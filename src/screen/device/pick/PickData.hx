package screen.device.pick;

/**
 * ...
 * @author Sith
 */

class PickData {
	
	public var id(get, null) : String;
	public var object(get, null) : PickedObject;
	public var state(get, null) : String;
	public var prevState(get, null) : String;
	public var tool(get, null) : String;
	
	public function new(id : String, object : PickedObject, state : String, prevState : String, tool : String = '') {
		this.id = id;
		this.object = object;
		this.state = state;
		this.prevState = prevState;
		this.tool = tool;
	}
	
	function get_id() : String {
		return id;
	}
	
	function get_object() : PickedObject {
		return object;
	}
	
	function get_state() : String {
		return state;
	}
	
	function get_prevState() : String {
		return prevState;
	}
	
	function get_tool() : String {
		return tool;
	}
}