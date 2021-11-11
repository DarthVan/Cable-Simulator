package screen.device.controls.buttons;

import openfl.Assets;
import openfl.display.Bitmap;

/**
 * ...
 * @author Sith
 */

class ResetPush extends SimpleButton {
	
	override public function destroy() : Void {
		super.destroy();
		
		graphics.clear();
	}
	
	override function init() : Void {
		super.init();
		
		_normal = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/push_button.png'), null, true);
		_normal.x = 0;
		_normal.y = 1;
		addChild(_normal);
		
		_down = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/push_button_down.png'), null, true);
		_down.x = 24;
		_down.y = -3;
		_down.visible = false;
		addChild(_down);
		
		graphics.beginFill(0xFF0000, 0.0);
		graphics.drawRect(0, 0, _normal.width, _normal.height);
		graphics.endFill();
	}
	
}