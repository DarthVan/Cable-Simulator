package screen.device.controls.handle;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Shape;
import screen.device.controls.handle.HiddenHandleState;
import screen.device.pick.PickedObject;

/**
 * ...
 * @author Sith
 */

class HiddenHandle extends PickedObject {
	
	var _hitArea : Shape;
	var _hidden : Bitmap;
	
	override public function destroy() : Void {
		super.destroy();
		
		_hitArea.graphics.clear();
		_hitArea = null;
		
		_hidden.bitmapData.dispose();
		_hidden = null;
	}
	
	override function init() : Void {
		super.init();
		
		_hitArea = new Shape();
		_hitArea.graphics.beginFill(0xFF0000, 0.0);
		_hitArea.graphics.drawCircle(0, 0, 25);
		_hitArea.graphics.endFill();
		addChild(_hitArea);
		
		_hidden = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/hidden_handle.png'), null, true);
		addChild(_hidden);
		
		_hitArea.x = _hidden.width / 2 + 2;
		_hitArea.y = _hidden.height / 2 - 2;
		
		setState(HiddenHandleState.HIDDEN);
	}
	
	override function setState(value : String, withPrevious : Bool = false) : Void {
		super.setState(value, withPrevious);
		
		switch (state) {
			case HiddenHandleState.HIDDEN:
				_hidden.visible = true;
				_hitArea.visible = false;
			case HiddenHandleState.DEPLOYED:
				_hidden.visible = false;
				_hitArea.visible = true;
		}
	}
}