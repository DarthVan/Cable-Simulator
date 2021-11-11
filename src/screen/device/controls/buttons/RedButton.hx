package screen.device.controls.buttons;

import openfl.Assets;
import openfl.display.Bitmap;

/**
 * ...
 * @author Sith
 */

class RedButton extends ColorButton {

	override function init() : Void {
		super.init();
		
		_normal = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/red.png'), null, true);
		_normal.x = -4;
		_normal.y = 20;
		addChild(_normal);
		
		_down = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/red_down.png'), null, true);
		_down.x = -1;
		_down.y = 20;
		addChild(_down);
		
		setState(ButtonState.NORMAL);
	}
	
}