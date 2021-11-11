package screen.device.controls.clamp;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Shape;
import openfl.events.MouseEvent;
import screen.device.pick.PickedObject;

/**
 * ...
 * @author Sith
 */

class Clamp extends PickedObject {

	var _inside : Bitmap;
	var _outside : Shape;
	var _padlock : Bitmap;
	
	override public function destroy() : Void {
		super.destroy();
		
		_inside.bitmapData.dispose();
		_inside = null;
		
		_outside.graphics.clear();
		_outside = null;
		
		_padlock.bitmapData.dispose();
		_padlock = null;
		
	}
	
	override function init() : Void {
		super.init();
		
		_inside = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/clamp_inside.png'), null, true);
		addChild(_inside);
		
		_outside = new Shape();
		_outside.graphics.beginFill(0xFF0000, 0.0);
		_outside.graphics.drawRect(0, 0, _inside.width, _inside.height);
		_outside.graphics.endFill();
		addChild(_outside);
		
		_padlock = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/clamp_lock.png'), null, true);
		_padlock.x = 36;
		_padlock.y = 50;
		addChild(_padlock);
		
		setState(ClampState.OUTSIDE_LOCKED);
	}
	
	override function setState(value : String, withPrevious : Bool = false) : Void {
		super.setState(value, withPrevious);
		
		_inside.visible = false;
		_outside.visible = false;
		_padlock.visible = false;
		
		switch (state) {
			case ClampState.INSIDE:
				_inside.visible = true;
			case ClampState.OUTSIDE:
				_outside.visible = true;
			case ClampState.OUTSIDE_LOCKED:
				_outside.visible = true;
				_padlock.visible = true;
		}
	}
	
	override function onClick(e : MouseEvent) : Void {
		switch (state) {
			case ClampState.INSIDE:
				setState(ClampState.OUTSIDE);
			case ClampState.OUTSIDE:
				setState(ClampState.INSIDE);
			case ClampState.OUTSIDE_LOCKED:
				setState(ClampState.OUTSIDE);
		}
		super.onClick(e);
	}
}