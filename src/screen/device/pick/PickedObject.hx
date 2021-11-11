package screen.device.pick;

import event.AppEvents;
import motion.Actuate;
import openfl.events.MouseEvent;
import screen.device.tools.Tools;
import sith.core.mvc.view.BasicView;

/**
 * ...
 * @author Sith
 */

class PickedObject extends BasicView {
	
	public var id(get, null) : String;
	public var state(get, null) : String;
	public var previousState(get, null) : String;
	
	public function new(id : String) {
		this.id = id;
		super();
	}
	
	override public function destroy() : Void {
		super.destroy();
		
		removeListeners();
	}
	
	public function undo() : Void {
		setState(previousState);
		previousState = state;
	}
	
	public function applyTool(tool : String) : Void {
		
	}
	
	public function setData(data : Dynamic) : Void {
		var newState : String = Std.string(data.state);
		if (newState == null || newState == '')
			return;
			
		setState(newState, true);
	}
	
	override function init() : Void {
		buttonMode = true;
		
		addListeners();
	}
	
	function setState(value : String, withPrevious : Bool = false) : Void {
		/*if (state == value)
			return;*/
		
		// fix: 1st time state = null here, so assign from value
		if (state == null || state == '' || withPrevious)
			previousState = value;
		else
			previousState = state;
		
		state = value;
	}
	
	function get_id() : String {
		return id;
	}
	
	function get_state() : String {
		return state;
	}
	
	function get_previousState() : String {
		return previousState;
	}
	
	function dispatchPick(timeout : Float = 0.25) : Void {
		if (stage == null)
			return;
		
		if (timeout > 0) {
			removeListeners();
			
			Actuate.timer(timeout).onComplete(stage.dispatchEvent, [new AppEvents(AppEvents.OBJECT_PICKED, new PickData(id, this, state, previousState, Tools.PICKED_TOOL))]);
			
			Actuate.timer(timeout + 0.25).onComplete(addListeners);
			return;
		}
		
		stage.dispatchEvent(new AppEvents(AppEvents.OBJECT_PICKED, new PickData(id, this, state, previousState, Tools.PICKED_TOOL)));
	}
	
	function addListeners() : Void {
		addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		addEventListener(MouseEvent.CLICK, onClick);
	}
	
	function removeListeners() : Void {
		removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		removeEventListener(MouseEvent.CLICK, onClick);
	}
	
	function onMouseUp(e : MouseEvent) : Void {
		if (Tools.PICKED_TOOL != '') {
			dispatchPick();
			return;
		}
	}
	
	function onClick(e : MouseEvent) : Void {
		dispatchPick();
		//e.stopPropagation();
	}
}