package screen.device.controls.switcher;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.Point;
import openfl.ui.Mouse;
import openfl.ui.MouseCursor;
import screen.device.controls.switcher.SwitcherState;
import screen.device.pick.PickedObject;
import screen.device.tools.Tools;

/**
 * ...
 * @author Sith
 */

class Switcher extends PickedObject {

	var _container : Sprite;
	var _pickPoint : Point;
	var _rotation : Float;
	var _snapped : Bool;
	
	var _switcher : Bitmap;
	var _table : Bitmap;
	
	override public function destroy() : Void {
		super.destroy();
		
		_switcher.bitmapData.dispose();
		_switcher = null;
		
		_table.bitmapData.dispose();
		_table = null;
		
		removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		
		_container.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		_container = null;
		
		_pickPoint = null;
	}
	
	override function init() : Void {
		super.init();
		
		_table = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/table_piple_working.png'), null, true);
		_table.x = -95;
		_table.y = -9;
		addChild(_table);
		
		_container = new Sprite();
		_container.useHandCursor = true;
		_container.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		addChild(_container);
		
		_switcher = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/switcher.png'), null, true);
		_switcher.x -= 38;
		_switcher.y -= 28;
		_container.addChild(_switcher);
		
		_pickPoint = new Point(0, 0);
		
		_snapped = true;
		
		_rotation = 0;
		
		setState(SwitcherState.ON);
	}
	
	override function setState(value : String, withPrevious : Bool = false) : Void {
		super.setState(value, withPrevious);
		
		_table.visible = false;
		
		switch (state) {
			case SwitcherState.ON:
				_container.rotation = 45;
			case SwitcherState.MIDDLE:
				_container.rotation = 0;
			case SwitcherState.OFF:
				_container.rotation = -45;
			case SwitcherState.ON_TABLED:
				_container.rotation = 45;
				_table.visible = true;
			case SwitcherState.MIDDLE_TABLED:
				_container.rotation = 0;
				_table.visible = true;
			case SwitcherState.OFF_TABLED:
				_container.rotation = -45;
				_table.visible = true;
		}
	}
	
	function onEnterFrame(e : Event) : Void {
		var mx : Float = mouseX;
		var my : Float = mouseY;
		
		var cosF : Float = (_pickPoint.x * mx + _pickPoint.y * my) / (Math.sqrt(Math.pow(_pickPoint.x, 2) + Math.pow(_pickPoint.y, 2)) * Math.sqrt(Math.pow(mx, 2) + Math.pow(my, 2)));
		
		var mark : Int = (_pickPoint.x * my - _pickPoint.y * mx) >= 0 ? 1 : -1;
		
		var angle : Float = Math.acos(cosF) * 57.29 * mark;
		if (Math.isNaN(angle))
			return;
		
		_container.rotation = angle + _rotation;
		
		if (_container.rotation < -30) {
			_container.rotation = -45;
			_snapped = true;
			return;
		}
		
		if (_container.rotation > -15 && _container.rotation < 15) {
			_container.rotation = 0;
			_snapped = true;
			return;
		}
		
		if (_container.rotation > 30) {
			_container.rotation = 45;
			_snapped = true;
			return;
		}
		
		_snapped = false;
	}
	
	function onMouseDown(e : MouseEvent) : Void {
		if (state == SwitcherState.ON_TABLED || state == SwitcherState.MIDDLE_TABLED || state == SwitcherState.OFF_TABLED)
			return;
		_pickPoint.x = mouseX;
		_pickPoint.y = mouseY;
		_rotation = _container.rotation;
		stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
		Mouse.cursor = MouseCursor.HAND;
	}
	
	override function onMouseUp(e : MouseEvent) : Void {
		removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		
		Mouse.cursor = MouseCursor.AUTO;
		
		if (Tools.PICKED_TOOL != '') {
			dispatchPick();
			return;
		}
		
		if (_snapped)
			_rotation = _container.rotation;
		
		switch (_rotation) {
			case 45:
				setState(SwitcherState.ON);
			case 0:
				setState(SwitcherState.MIDDLE);
			case -45:
				setState(SwitcherState.OFF);
		}
		
		dispatchPick();
	}
	
	override function onClick(e : MouseEvent) : Void {
		
		switch (state) {
			case SwitcherState.ON_TABLED:
				setState(SwitcherState.ON);
			case SwitcherState.MIDDLE_TABLED:
				setState(SwitcherState.MIDDLE);
			case SwitcherState.OFF_TABLED:
				setState(SwitcherState.OFF);
		}
		
		super.onClick(e);
	}
}