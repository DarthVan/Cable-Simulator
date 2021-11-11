package screen.device.controls.handle;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.Point;
import openfl.ui.Mouse;
import openfl.ui.MouseCursor;
import screen.device.controls.handle.HandleState;
import screen.device.pick.PickedObject;
import screen.device.tools.Tools;

/**
 * ...
 * @author Sith
 */

class Handle extends PickedObject {
	
	var _staticPart : Bitmap;
	var _movePart : Bitmap;
	var _drawPart : Shape;
	var _wheel : Sprite;
	var _wheelMark : Sprite;
	
	var _pickPoint : Point;
	var _rotation : Float;
	
	var _prevAngle : Float;
	var _ob : Int;
	
	override public function destroy() : Void {
		super.destroy();
		
		removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		
		_staticPart.bitmapData.dispose();
		_staticPart = null;
		
		_movePart.bitmapData.dispose();
		_movePart = null;
		
		_drawPart.graphics.clear();
		_drawPart = null;
		
		_wheel.graphics.clear();
		_wheel = null;
		
		_wheelMark.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		_wheelMark.graphics.clear();
		_wheelMark = null;
		
		_pickPoint = null;
	}
	
	override public function undo() : Void {
		if (previousState == HandleState.NONE)
			previousState = HandleState.UP;
		super.undo();
	}
	
	override public function setData(data : Dynamic) : Void {
		super.setData(data);
		
		if (data.angle == null || data.angle == '')
			return;
		
		var angle : Float = Std.parseFloat(data.angle);
		_wheel.rotation = _rotation = angle;
		updateParts();
	}
	
	override function init() : Void {
		super.init();
		
		buttonMode = false;
		mouseEnabled = false;
		
		/*_noneBG.x = 182;
		_noneBG.y = -45;*/
		
		_staticPart = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/handle_part.png'), null, true);
		_staticPart.x = -12;
		_staticPart.y = -45;
		addChild(_staticPart);
		
		_drawPart = new Shape();
		//_drawPart.x = 10;
		addChild(_drawPart);
		
		_movePart = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/handle_part.png'), null, true);
		addChild(_movePart);
		
		_wheel = new Sprite();
		/*_wheel.graphics.beginFill(0x0000FF, 0.2);
		_wheel.graphics.drawCircle(0, 0, 40);
		_wheel.graphics.endFill();*/
		addChild(_wheel);
		
		_wheelMark = new Sprite();
		_wheelMark.graphics.beginFill(0xFF0000, 0.0);
		_wheelMark.graphics.drawCircle(0, 0, 25);
		_wheelMark.graphics.endFill();
		_wheelMark.y = -40;
		_wheelMark.mouseEnabled = true;
		_wheelMark.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		_wheel.addChild(_wheelMark);
		
		_wheelMark.buttonMode = true;
		_wheelMark.useHandCursor = true;
		
		_pickPoint = new Point(0, 0);
		
		_rotation = _prevAngle = _ob = 0;
		
		updateParts();
		
		setState(HandleState.UP);
	}
	
	override function setState(value : String, withPrevious : Bool = false) : Void {
		super.setState(value, withPrevious);
		
		switch (state) {
			case HandleState.LEFT:
				_wheel.rotation = _rotation = -90;
				_ob = -2;
				visible = true;
			case HandleState.UP:
				_wheel.rotation = _rotation = 0;
				_ob = 0;
				visible = true;
			case HandleState.RIGHT:
				_wheel.rotation = _rotation = 90;
				_ob = 2;
				visible = true;
			case HandleState.NONE:
				visible = false;
		}
		
		updateParts();
	}
	
	function updateParts() : Void {
		var point : Point = new Point(x, y - 40);
		var tX : Float = -_wheelMark.globalToLocal(point).x;
		var tY : Float = _wheelMark.globalToLocal(point).y - 40;
		
		_movePart.x = tX - 51;
		_movePart.y = tY - 12;
		
		_drawPart.graphics.clear();
		_drawPart.graphics.lineStyle(10, 0x202020);
		_drawPart.graphics.moveTo(0, 0);
		_drawPart.graphics.lineTo(tX, tY);
	}
	
	function onMouseDown(e : MouseEvent) : Void {
		_pickPoint.x = mouseX;
		_pickPoint.y = mouseY;
		_rotation = _wheel.rotation;
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
		
		_rotation = _wheel.rotation;
		
		switch (_rotation) {
			case -90:
				if (_ob == -2)
					setState(HandleState.LEFT);
			case 0:
				if (_ob == 0)
					setState(HandleState.UP);
			case 90:
				if (_ob == 2)
					setState(HandleState.RIGHT);
		}
		
		dispatchPick();
	}
	
	function onEnterFrame(e : Event) : Void {
		
		var cosF : Float = (_pickPoint.x * mouseX + _pickPoint.y * mouseY) / (Math.sqrt(Math.pow(_pickPoint.x, 2) + Math.pow(_pickPoint.y, 2)) * Math.sqrt(Math.pow(mouseX, 2) + Math.pow(mouseY, 2)));
		
		var mark : Int = (_pickPoint.x * mouseY - _pickPoint.y * mouseX) >= 0 ? 1 : -1;
		
		var angle : Float = Math.acos(cosF) * 57.29 * mark;
		if (Math.isNaN(angle))
			return;
		
		_wheel.rotation = _rotation + angle;
		
		if (Math.abs(angle) > 90) {
			if (_prevAngle >= 0 && angle < 0)
				_ob++;
			if (_prevAngle <= 0 && angle > 0)
				_ob--;
		}
		
		_prevAngle = angle;
		
		if (_wheel.rotation < -90 && _ob == -2) {
			_wheel.rotation = -90;
			updateParts();
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			return;
		}
		
		if (_wheel.rotation > -15 && _wheel.rotation < 15) {
			_wheel.rotation = 0;
			updateParts();
			return;
		}
		
		if (_wheel.rotation > 90 && _ob == 2) {
			_wheel.rotation = 90;
			updateParts();
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			return;
		}
		
		updateParts();
	}
}