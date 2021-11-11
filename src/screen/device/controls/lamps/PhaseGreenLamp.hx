package screen.device.controls.lamps;

import openfl.Assets;
import openfl.display.Bitmap;

/**
 * ...
 * @author Sith
 */

class PhaseGreenLamp extends SimpleLamp {

	override function init() : Void {
		super.init();
		
		_on = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/green_light_v.png'), null, true);
		addChild(_on);
		
		setState(LampState.OFF);
	}
	
}