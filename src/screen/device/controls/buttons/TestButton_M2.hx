package screen.device.controls.buttons;
import openfl.Assets;
import openfl.display.Bitmap;

/**
 * ...
 * @author Sith
 */

class TestButton_M2 extends ColorButton {

	public function new(id : String) {
		super(id, 41);
	}
	
	override function init() : Void {
		super.init();
		
		_normal = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/test.png'), null, true);
		_normal.x = -5;
		_normal.y = 20;
		addChild(_normal);
		
		_down = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/test_down.png'), null, true);
		_down.x = -2;
		_down.y = 20;
		addChild(_down);
		
		setState(ButtonState.NORMAL);
	}
	
}