package screen.device.controls.buttons;

import openfl.Assets;
import openfl.display.Bitmap;

/**
 * ...
 * @author Sith
 */

class PushOFF extends SimpleButton {
	
	override function init() : Void {
		super.init();
		
		_normal = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/push_off.png'), null, true);
		addChild(_normal);
		
		_down = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/push_off_down.png'), null, true);
		_down.visible = false;
		addChild(_down);
	}
}