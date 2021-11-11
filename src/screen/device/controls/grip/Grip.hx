package screen.device.controls.grip;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.Point;
import openfl.ui.Mouse;
import openfl.ui.MouseCursor;
import screen.device.tools.Tools;

/**
 * ...
 * @author Sith
 */

class Grip extends Labeled {
	
	var _container : Sprite;
	var _pickPoint : Point;
	var _rotation : Float;
	var _snapped : Bool;
	
	var _grip : Bitmap;
	var _offset : Point;
	var _url : String;
	
	override public function new(id : String, labelWidth : Int = 45, offset : Point = null, url : String = null) {
		if (offset == null)
			offset = new Point(20, 45);
		_offset = offset;
		
		if (url == null || url == '')
			url = 'assets/bitmap/device/controls/grip.png';
		_url = url;
		
		super(id, labelWidth);
	}
	
	override public function destroy() : Void {
		super.destroy();
		
		if (_grip != null && _grip.bitmapData != null)
			_grip.bitmapData.dispose();
		_grip = null;
		
		removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		
		_container.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		_container = null;
		
		_pickPoint = null;
	}
	
	override function init() : Void {
		super.init();
		
		_container = new Sprite();
		_container.x = _offset.x;
		_container.y = _offset.y;
		_container.useHandCursor = true;
		_container.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		addChild(_container);
		
		_grip = new Bitmap(Assets.getBitmapData(_url), null, true);
		_grip.x -= Std.int(_grip.width / 2);
		_grip.y -= Std.int(_grip.height / 2);
		_container.addChild(_grip);
		
		_pickPoint = new Point(0, 0);
		
		_snapped = true;
		
		_rotation = 0;
		
		setState(GripState.UP);
	}
	
	override function setState(value : String, withPrevious : Bool = false) : Void {
		super.setState(value, withPrevious);
		
		switch (state) {
			case GripState.LEFT:
				_container.rotation = -45;
			case GripState.UP:
				_container.rotation = 0;
			case GripState.RIGHT:
				_container.rotation = 45;
		}
	}
	
	function onEnterFrame(e : Event) : Void {
		var mx : Float = mouseX - _offset.x;
		var my : Float = mouseY - _offset.y;
		
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
		_pickPoint.x = mouseX - _offset.x;
		_pickPoint.y = mouseY - _offset.y;
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
			case -45:
				setState(GripState.LEFT);
			case 0:
				setState(GripState.UP);
			case 45:
				setState(GripState.RIGHT);
		}
		
		dispatchPick();
	}
}