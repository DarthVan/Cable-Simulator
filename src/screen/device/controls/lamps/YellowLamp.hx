package screen.device.controls.lamps;

import openfl.Assets;
import openfl.display.Bitmap;

/**
 * ...
 * @author Sith
 */

class YellowLamp extends Lamp {

	override function init() : Void {
		super.init();
		
		_on = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/yellow_light.png'), null, true);
		_on.x = -7;
		_on.y = 17;
		addChild(_on);
		
		setState(LampState.OFF);
	}
	
}