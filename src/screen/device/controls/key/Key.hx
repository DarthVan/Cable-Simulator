package screen.device.controls.key;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.Point;
import openfl.ui.Mouse;
import openfl.ui.MouseCursor;
import screen.device.pick.PickedObject;
import screen.device.tools.Tools;

/**
 * ...
 * @author Sith
 */

class Key extends PickedObject {
	
	var _bg : Bitmap;
	
	var _larvaLeft : Bitmap;
	var _larvaCenter : Bitmap;
	
	var _keyLeft : Bitmap;
	var _keyCenter : Bitmap;
	
	var _container : Sprite;
	var _pickPoint : Point;
	var _rotation : Float;
	var _snapped : Bool;
	
	override public function destroy() : Void {
		super.destroy();
		
		removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		removeEventListener(MouseEvent.RELEASE_OUTSIDE, onReleaseOutside);
		
		_bg.bitmapData.dispose();
		_bg = null;
		
		_larvaLeft.bitmapData.dispose();
		_larvaLeft = null;
		
		_larvaCenter.bitmapData.dispose();
		_larvaCenter = null;
		
		_keyLeft.bitmapData.dispose();
		_keyLeft = null;
		
		_keyCenter.bitmapData.dispose();
		_keyCenter = null;
		
		_container.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		_container = null;
		
		_pickPoint = null;
	}
	
	override function init() : Void {
		super.init();
		
		buttonMode = false;
		mouseEnabled = false;
		
		_bg = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/base_key.png'), null, true);
		addChild(_bg);
		
		_larvaLeft = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/larva_left.png'), null, true);
		_larvaLeft.x = 6;
		_larvaLeft.y = 9;
		addChild(_larvaLeft);
		
		_larvaCenter = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/larva_center.png'), null, true);
		_larvaCenter.x = 6;
		_larvaCenter.y = 7;
		addChild(_larvaCenter);
		
		_keyLeft = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/key_left.png'), null, true);
		_keyLeft.x = -18;
		_keyLeft.y = 3;
		addChild(_keyLeft);
		
		_keyCenter = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/key_ceter.png'), null, true);
		_keyCenter.x = -21;
		_keyCenter.y = -2;
		addChild(_keyCenter);
		
		_container = new Sprite();
		_container.graphics.beginFill(0xFF0000, 0.0);
		_container.graphics.drawRect(-10, -18, 30, 44); 
		_container.graphics.endFill();
		_container.x = 1;
		_container.y = 16;
		_container.useHandCursor = true;
		_container.buttonMode = true;
		_container.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		addChild(_container);
		
		_pickPoint = new Point(0, 0);
		
		_snapped = true;
		
		_rotation = 0;
		
		setState(KeyState.CENTER);
	}
	
	override function setState(value : String, withPrevious : Bool = false) : Void {
		super.setState(value, withPrevious);
		
		_larvaLeft.visible = false;
		_keyLeft.visible = false;
		_larvaCenter.visible = false;
		_keyCenter.visible = false;
		
		switch (state) {
			case KeyState.LEFT:
				_container.rotation = -45;
				_larvaLeft.visible = true;
				_keyLeft.visible = true;
			case KeyState.LEFT_NO_KEY:
				_container.rotation = -45;
				_larvaLeft.visible = true;
			case KeyState.CENTER:
				_container.rotation = 0;
				_larvaCenter.visible = true;
				_keyCenter.visible = true;
			case KeyState.CENTER_NO_KEY:
				_container.rotation = 0;
				_larvaCenter.visible = true;
		}
	}
	
	function onEnterFrame(e : Event) : Void {
		var cosF : Float = (_pickPoint.x * mouseX + _pickPoint.y * mouseY) / (Math.sqrt(Math.pow(_pickPoint.x, 2) + Math.pow(_pickPoint.y, 2)) * Math.sqrt(Math.pow(mouseX, 2) + Math.pow(mouseY, 2)));
		
		var mark : Int = (_pickPoint.x * mouseY - _pickPoint.y * mouseX) >= 0 ? 1 : -1;
		
		var angle : Float = Math.acos(cosF) * 57.29 * mark;
		if (Math.isNaN(angle))
			return;
		
		_container.rotation = angle + _rotation;
		
		if (_container.rotation < -30) {
			_container.rotation = -45;
			_snapped = true;
			
			_larvaLeft.visible = true;
			_keyLeft.visible = true;
			_larvaCenter.visible = false;
			_keyCenter.visible = false;
			
			return;
		}
		
		if (_container.rotation > -15 /*&& _container.rotation < 15*/) {
			_container.rotation = 0;
			_snapped = true;
			
			_larvaLeft.visible = false;
			_keyLeft.visible = false;
			_larvaCenter.visible = true;
			_keyCenter.visible = true;
			
			return;
		}
		
		/*if (_container.rotation > 30) {
			_container.rotation = 45;
			_snapped = true;
			return;
		}*/
		
		_snapped = false;
	}
	
	function onMouseDown(e : MouseEvent) : Void {
		if (state == KeyState.LEFT_NO_KEY || state == KeyState.CENTER_NO_KEY)
			return;
		_pickPoint.x = mouseX - 1;
		_pickPoint.y = mouseY - 16;
		_rotation = _container.rotation;
		addEventListener(MouseEvent.RELEASE_OUTSIDE, onReleaseOutside);
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
		Mouse.cursor = MouseCursor.HAND;
	}
	
	function onReleaseOutside(e : MouseEvent) : Void {
		onMouseUp(null);
	}
	
	override function onMouseUp(e : MouseEvent) : Void {
		removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		removeEventListener(MouseEvent.RELEASE_OUTSIDE, onReleaseOutside);
		
		Mouse.cursor = MouseCursor.AUTO;
		
		if (Tools.PICKED_TOOL != '') {
			dispatchPick();
			return;
		}
		
		if (state == KeyState.LEFT_NO_KEY || state == KeyState.CENTER_NO_KEY) {
			dispatchPick();
			return;
		}
		
		if (_pickPoint.x == mouseX - 1 || _pickPoint.y == mouseY - 16) {
			switch (state) {
				case KeyState.LEFT:
					setState(KeyState.LEFT_NO_KEY);
				case KeyState.CENTER:
					setState(KeyState.CENTER_NO_KEY);
			}
			dispatchPick();
			return;
		}
		
		if (_snapped)
			_rotation = _container.rotation;
		
		switch (_rotation) {
			case -45:
				setState(KeyState.LEFT);
			case 0:
				setState(KeyState.CENTER);
			/*case 45:
				state = GripStates.RIGHT;*/
		}
		
		dispatchPick();
	}
	
	override function onClick(e : MouseEvent) : Void {
		/*if (_pickPoint.x != mouseX - 1 || _pickPoint.y != mouseY - 16)
			return;
		
		switch (state) {
			case KeyState.LEFT:
				setState(KeyState.LEFT_NO_KEY);
			case KeyState.CENTER:
				setState(KeyState.CENTER_NO_KEY);
		}*/
		
		super.onClick(e);
	}
}