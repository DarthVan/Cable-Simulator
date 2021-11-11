package components.window;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.SimpleButton;
import openfl.display.Sprite;
import openfl.text.TextField;
import utils.TFGenerator;

/**
 * ...
 * @author Sith
 */

class ActionButton extends SimpleButton {
	
	public var label(get, null) : TextField;
	
	public function new() {
		init();
		super(upState, overState, downState, hitTestState);
	}
	
	function init() : Void {
		var stateDefault : Sprite = new Sprite();
		
		var bitmap : Bitmap = new Bitmap(Assets.getBitmapData('assets/bitmap/ui/window_button_default.png'), null, true);
		stateDefault.addChild(bitmap);
		
		label = TFGenerator.addSimple('Arial Narrow Bold', 16, 0xFFFFFF, false, 'center');
		label.width = stateDefault.width;
		label.y = 8;
		label.text = 'BUTTON';
		stateDefault.addChild(label);
		
		/*var bitmapOver : Bitmap = new Bitmap(Assets.getBitmapData('assets/window_button_default.png'), null, true);
		stateDefault.addChild(bitmapOver);*/
		
		upState = stateDefault;
		overState = stateDefault;
		downState = stateDefault;
		hitTestState = stateDefault;
	}
	
	function get_label() : TextField {
		return label;
	}
}