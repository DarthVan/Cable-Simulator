package screen.device.controls.buttons;

import openfl.display.Bitmap;
import openfl.events.MouseEvent;
import screen.device.controls.Labeled;

/**
 * ...
 * @author Sith
 */

class ColorButton extends Labeled {
	
	var _normal : Bitmap;
	var _down : Bitmap;
	
	override public function destroy() : Void {
		super.destroy();
		
		_normal.bitmapData.dispose();
		_normal = null;
		
		_down.bitmapData.dispose();
		_down = null;
	}
	
	override function setState(value : String, withPrevious : Bool = false) : Void {
		super.setState(value, withPrevious);
		
		switch (state) {
			case ButtonState.NORMAL:
				_normal.visible = true;
				_down.visible = false;
			case ButtonState.DOWN:
				_normal.visible = false;
				_down.visible = true;
		}
	}
	
	override function onClick(e : MouseEvent) : Void {
		switch (state) {
			case ButtonState.NORMAL:
				setState(ButtonState.DOWN);
			case ButtonState.DOWN:
				setState(ButtonState.NORMAL);
		}
		super.onClick(e);
	}
}