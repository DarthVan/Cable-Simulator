package screen.device.controls.pck;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.events.MouseEvent;
import screen.device.controls.pck.PCKSwitcherState;
import screen.device.pick.PickedObject;

/**
 * ...
 * @author Sith
 */

class PCKSwitcher extends PickedObject {

	var _on : Bitmap;
	var _off : Bitmap;
	
	override public function destroy() : Void {
		super.destroy();
		
		_on.bitmapData.dispose();
		_on = null;
		
		_off.bitmapData.dispose();
		_off = null;
	}
	
	override function init() : Void {
		super.init();
		
		_on = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/pck_up.png'), null, true);
		addChild(_on);
		
		_off = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/pck_down.png'), null, true);
		_off.y = 6;
		addChild(_off);
		
		setState(PCKSwitcherState.ON);
	}
	
	override function setState(value : String, withPrevious : Bool = false) : Void {
		super.setState(value, withPrevious);
		
		_on.visible = false;
		_off.visible = false;
		
		switch (state) {
			case PCKSwitcherState.ON:
				_on.visible = true;
			case PCKSwitcherState.OFF:
				_off.visible = true;
		}
	}
	
	override function onClick(e : MouseEvent) : Void {
		switch (state) {
			case PCKSwitcherState.ON:
				setState(PCKSwitcherState.OFF);
			case PCKSwitcherState.OFF:
				setState(PCKSwitcherState.ON);
		}
		super.onClick(e);
	}
}