package screen.device.controls.mgrip;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.Point;
import openfl.ui.Mouse;
import openfl.ui.MouseCursor;
import screen.device.controls.mgrip.MGripState;
import screen.device.pick.PickedObject;
import screen.device.tools.Tools;

/**
 * Meters Screen Grip
 * @author Sith
 */

class MGrip extends PickedObject {

	var _container : Sprite;
	var _pickPoint : Point;
	var _rotation : Float;
	var _snapped : Bool;
	
	var _grip : Bitmap;
	
	override public function destroy() : Void {
		super.destroy();
		
		removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		
		_container.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		_container = null;
		
		_grip.bitmapData.dispose();
		_grip = null;
		
		_pickPoint = null;
	}
	
	override function init() : Void {
		super.init();
		
		_container = new Sprite();
		_container.useHandCursor = true;
		_container.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		addChild(_container);
		
		_grip = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/grip.png'), null, true);
		_grip.x -= 7;
		_grip.y -= 25;
		_container.addChild(_grip);
		
		_pickPoint = new Point(0, 0);
		
		_snapped = true;
		
		_rotation = 0;
		
		setState(MGripState.O);
	}
	
	override function setState(value : String, withPrevious : Bool = false) : Void {
		super.setState(value, withPrevious);
		
		switch (state) {
			case MGripState.O:
				_container.rotation = 0;
			case MGripState.L1N:
				_container.rotation = 45;
			case MGripState.L2N:  
				_container.rotation = 90;
			case MGripState.L3N:
				_container.rotation = 135;
			case MGripState.L1L2:
				_container.rotation = -45;
			case MGripState.L2L3:
				_container.rotation = -90;
			case MGripState.L3L1:
				_container.rotation = -135;
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
		
		if (_container.rotation > -15 && _container.rotation < 15) {
			_container.rotation = 0;
			_snapped = true;
			return;
		}
		
		if (_container.rotation > 30 && _container.rotation < 60) {
			_container.rotation = 45;
			_snapped = true;
			return;
		}
		
		if (_container.rotation > 75 && _container.rotation < 105) {
			_container.rotation = 90;
			_snapped = true;
			return;
		}
		
		if (_container.rotation > 120) {
			_container.rotation = 135;
			_snapped = true;
			return;
		}
		
		if (_container.rotation > -60 && _container.rotation < -30) {
			_container.rotation = -45;
			_snapped = true;
			return;
		}
		
		if (_container.rotation > -105 && _container.rotation < -75) {
			_container.rotation = -90;
			_snapped = true;
			return;
		}
		
		if (_container.rotation < -120) {
			_container.rotation = -135;
			_snapped = true;
			return;
		}
		
		_snapped = false;
	}
	
	function onMouseDown(e : MouseEvent) : Void {
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
			case 0:
				setState(MGripState.O);
			case 45:
				setState(MGripState.L1N);
			case 90:
				setState(MGripState.L2N);
			case 135:
				setState(MGripState.L3N);
			case -45:
				setState(MGripState.L1L2);
			case -90:
				setState(MGripState.L2L3);
			case -135:
				setState(MGripState.L3L1);
		}
		
		dispatchPick();
	}
}