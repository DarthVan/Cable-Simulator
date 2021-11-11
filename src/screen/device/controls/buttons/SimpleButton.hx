package screen.device.controls.buttons;

import openfl.display.Bitmap;
import openfl.events.MouseEvent;
import screen.device.pick.PickedObject;

/**
 * ...
 * @author Sith
 */

class SimpleButton extends PickedObject {
	
	var _normal : Bitmap;
	var _down : Bitmap;
	
	override public function destroy() : Void {
		super.destroy();
		
		removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		removeEventListener(MouseEvent.RELEASE_OUTSIDE, onReleaseOutside);
		
		_normal.bitmapData.dispose();
		_normal = null;
		
		_down.bitmapData.dispose();
		_down = null;
	}
	
	override function init() : Void {
		super.init();
		
		addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		addEventListener(MouseEvent.RELEASE_OUTSIDE, onReleaseOutside);
		
		setState('', true);
	}
	
	override function onMouseUp(e : MouseEvent) : Void {
		_normal.visible = true;
		_down.visible = false;
		
		super.onMouseUp(e);
	}
	
	function onMouseDown(e : MouseEvent) : Void {
		_normal.visible = false;
		_down.visible = true;
	}
	
	function onReleaseOutside(e : MouseEvent) : Void {
		_normal.visible = true;
		_down.visible = false;
	}
}