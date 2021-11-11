package screen.device.controls.buttons;

import openfl.Assets;
import openfl.display.Bitmap;

/**
 * ...
 * @author Sith
 */

class RelTest extends SimpleButton {

	override function init() : Void {
		super.init();
		
		_normal = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/rel_test.png'), null, true);
		addChild(_normal);
		
		_down = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/rel_test_down.png'), null, true);
		_down.visible = false;
		addChild(_down);
	}
	
}