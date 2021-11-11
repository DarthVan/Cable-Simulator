package screen.device.controls.handle;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.events.MouseEvent;
import screen.device.controls.handle.ConfirmButtonState;
import screen.device.pick.PickedObject;

/**
 * ...
 * @author Sith
 */

class ConfirmButton extends PickedObject {
	
	var _normal : Bitmap;
	var _down : Bitmap;
	
	override public function destroy() : Void {
		super.destroy();
		
		_normal.bitmapData.dispose();
		_normal = null;
		
		_down.bitmapData.dispose();
		_down = null;
	}
	
	override function init() : Void {
		super.init();
		
		_normal = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/button_confirmation.png'), null, true);
		_normal.x = -3;
		addChild(_normal);
		
		_down = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/button_confirmation_down.png'), null, true);
		addChild(_down);
		
		setState(ConfirmButtonState.NORMAL);
	}
	
	override function setState(value : String, withPrevious : Bool = false) : Void {
		super.setState(value, withPrevious);
		
		switch (state) {
			case ConfirmButtonState.NORMAL:
				_normal.visible = true;
				_down.visible = false;
			case ConfirmButtonState.DOWN:
				_normal.visible = false;
				_down.visible = true;
		}
	}
	
	override function onClick(e : MouseEvent) : Void {
		switch (state) {
			case ConfirmButtonState.NORMAL:
				setState(ConfirmButtonState.DOWN);
			case ConfirmButtonState.DOWN:
				setState(ConfirmButtonState.NORMAL);
		}
		super.onClick(e);
	}
}