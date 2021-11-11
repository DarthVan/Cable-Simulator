package screen.device.controls.lamps;

import openfl.Assets;
import openfl.display.Bitmap;

/**
 * ...
 * @author Sith
 */

class RedLamp extends Lamp {

	override function init() : Void {
		super.init();
		
		_on = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/red_light.png'), null, true);
		_on.x = -8;
		_on.y = 17;
		addChild(_on);
		
		setState(LampState.OFF);
	}
	
}