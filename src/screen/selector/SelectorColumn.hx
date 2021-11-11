package screen.selector;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.SimpleButton;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Sith
 */

class SelectorColumn extends SimpleButton {
	
	public var id(get, null) : String;
	
	var _onSomeOver : (String)->Void;
	var _onSomePick : (String)->Void;
	var _onSomeOut : ()->Void;
	
	var _bitmapData : BitmapData;
	
	public function new(id : String, bitmapData : BitmapData, onSomeOver : (String)->Void, onSomePick : (String)->Void, onSomeOut : ()->Void) {
		this.id = id;
		
		_bitmapData = bitmapData;
		
		_onSomeOver = onSomeOver;
		_onSomePick = onSomePick;
		_onSomeOut = onSomeOut;
		
		init();
		
		super(upState, overState, overState, overState);
	}
	
	public function update(bitmapData : BitmapData) : Void {
		upState = new Bitmap(bitmapData, null, true);
		upState.alpha = 0.75;
		
		overState = new Bitmap(bitmapData, null, true);
		downState = overState;
	}
	
	override function __this_onMouseOver(event : MouseEvent) : Void {
		super.__this_onMouseOver(event);
		_onSomeOver(id);
	}
	
	override function __this_onMouseDown(event : MouseEvent) : Void {
		super.__this_onMouseDown(event);
		_onSomePick(id);
	}
	
	override function __this_onMouseOut(event : MouseEvent) : Void {
		super.__this_onMouseOut(event);
		_onSomeOut();
	}
	
	function init() : Void {
		update(_bitmapData);
	}
	
	function get_id() : String {
		return id;
	}
}