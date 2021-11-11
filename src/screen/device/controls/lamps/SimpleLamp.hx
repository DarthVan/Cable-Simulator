package screen.device.controls.lamps;

import openfl.display.Bitmap;
import screen.device.pick.PickedObject;

/**
 * ...
 * @author Sith
 */

class SimpleLamp extends PickedObject {

	var _on : Bitmap;
	
	override public function destroy() : Void {
		super.destroy();
		
		_on.bitmapData.dispose();
		_on = null;
	}
	
	override function setState(value : String, withPrevious : Bool = false) : Void {
		super.setState(value, withPrevious);
		
		switch (state) {
			case LampState.OFF:
				_on.visible = false;
			case LampState.ON:
				_on.visible = true;
		}
	}
}