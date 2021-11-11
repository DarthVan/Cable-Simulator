package screen.device.controls.clamp;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.events.MouseEvent;
import screen.device.pick.PickedObject;

/**
 * ...
 * @author Sith
 */

class ClampIndicator extends PickedObject {

	var _r : Bitmap;
	var _g : Bitmap;
	var _y : Bitmap;
	
	override public function destroy() : Void {
		super.destroy();
		
		_r.bitmapData.dispose();
		_r = null;
		
		_g.bitmapData.dispose();
		_g = null;
		
		_y.bitmapData.dispose();
		_y = null;
		
	}
	
	override function init() : Void {
		super.init();
		
		_r = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/clamp_r.png'), null, true);
		addChild(_r);
		
		_g = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/clamp_g.png'), null, true);
		addChild(_g);
		
		_y = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/clamp_y.png'), null, true);
		addChild(_y);
		
		setState(ClampIndicatorState.RED);
	}
	
	override function setState(value : String, withPrevious : Bool = false) : Void {
		super.setState(value, withPrevious);
		
		_r.visible = false;
		_g.visible = false;
		_y.visible = false;
		
		switch (state) {
			case ClampIndicatorState.RED:
				_r.visible = true;
			case ClampIndicatorState.GREEN:
				_g.visible = true;
			case ClampIndicatorState.YELLOW:
				_y.visible = true;
		}
	}
	
	override function onClick(e : MouseEvent) : Void {
		/*switch (state) {
			case ClampIndicatorState.RED:
				setState(ClampIndicatorState.GREEN);
			case ClampIndicatorState.GREEN:
				setState(ClampIndicatorState.YELLOW);
			case ClampIndicatorState.YELLOW:
				setState(ClampIndicatorState.RED);
		}*/
		super.onClick(e);
	}
	
}