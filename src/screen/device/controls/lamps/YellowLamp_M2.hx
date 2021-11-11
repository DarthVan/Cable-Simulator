package screen.device.controls.lamps;

import openfl.Assets;
import openfl.display.Bitmap;

/**
 * ...
 * @author Sith
 */
class YellowLamp_M2 extends Lamp {

	public function new(id : String) {
		super(id, 41);
	}
	
	override function init() : Void {
		super.init();
		
		_on = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/yellow_light_m.png'), null, true);
		_on.x = -8;
		_on.y = 15;
		addChild(_on);
		
		setState(LampState.OFF);
	}
	
}