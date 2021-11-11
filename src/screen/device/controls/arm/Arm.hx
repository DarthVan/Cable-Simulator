package screen.device.controls.arm;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.events.MouseEvent;
import screen.device.pick.PickedObject;

/**
 * ...
 * @author Sith
 */

class Arm extends PickedObject {
	
	var _inside : Bitmap;
	var _outside : Bitmap;
	
	override public function destroy() : Void {
		super.destroy();
		
		_inside.bitmapData.dispose();
		_inside = null;
		
		_outside.bitmapData.dispose();
		_outside = null;
	}
	
	override function init() : Void {
		super.init();
		
		_inside = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/arm_inside.png'), null, true);
		_inside.x = 812;
		_inside.y = 179;
		addChild(_inside);
		
		_outside = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/arm_outside.png'), null, true);
		_outside.x = 731;
		_outside.y = 424;
		addChild(_outside);
		
		setState(ArmState.INSIDE);
	}
	
	override function setState(value : String, withPrevious : Bool = false) : Void {
		super.setState(value, withPrevious);
		
		switch (state) {
			case ArmState.INSIDE:
				_inside.visible = true;
				_outside.visible = false;
			case ArmState.OUTSIDE:
				_inside.visible = false;
				_outside.visible = true;
		}
	}
	
	override function onClick(e : MouseEvent) : Void {
		switch (state) {
			case ArmState.INSIDE:
				setState(ArmState.OUTSIDE);
			case ArmState.OUTSIDE:
				setState(ArmState.INSIDE);
		}
		super.onClick(e);
	}
}