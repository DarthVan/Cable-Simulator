package screen.device.controls.handle;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import screen.device.controls.handle.SmallArrowState;
import screen.device.pick.PickedObject;

/**
 * ...
 * @author Sith
 */

class SmallArrow extends PickedObject {
	
	var _container : Sprite;
	var _arrow : Bitmap;
	
	override public function destroy() : Void {
		super.destroy();
		
		_arrow.bitmapData.dispose();
		_arrow = null;
		
		_container = null;
	}
	
	override function init() : Void {
		super.init();
		
		_container = new Sprite();
		addChild(_container);
		
		_arrow = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/small_arrow.png'), null, true);
		_arrow.x = -7;
		_arrow.y = -11;
		_container.addChild(_arrow);
		
		setState(SmallArrowState.UP);
	}
	
	override function setState(value : String, withPrevious : Bool = false) : Void {
		super.setState(value, withPrevious);
		
		switch (state) {
			case SmallArrowState.UP:
				_container.rotation = 0;
			case SmallArrowState.MIDDLE:
				_container.rotation = 45;
			case SmallArrowState.DOWN:
				_container.rotation = 90;
		}
	}
}