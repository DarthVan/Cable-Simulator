package screen.device.controls.caps;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.events.MouseEvent;
import screen.device.pick.PickedObject;

/**
 * ...
 * @author Sith
 */

class Caps extends PickedObject {
	
	var _opened : Bitmap;
	var _closed : Bitmap;
	var _padlock : Bitmap;
	var _table : Bitmap;
	
	override public function destroy() : Void {
		super.destroy();
		
		_opened.bitmapData.dispose();
		_opened = null;
		
		_closed.bitmapData.dispose();
		_closed = null;
		
		_padlock.bitmapData.dispose();
		_padlock = null;
		
		_table.bitmapData.dispose();
		_table = null;
	}
	
	override function init() : Void {
		super.init();
		
		_opened = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/caps_opened.png'), null, true);
		_opened.x = -19;
		_opened.y = 65;
		addChild(_opened);
		
		_closed = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/caps_closed.png'), null, true);
		addChild(_closed);
		
		_padlock = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/padlock.png'), null, true);
		_padlock.x = 43;
		_padlock.y = 41;
		addChild(_padlock);
		
		_table = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/caps_table.png'), null, true);
		_table.x = -36;
		_table.y = 44;
		addChild(_table);
		
		setState(CapsState.CLOSED_LABELED);
	}
	
	override function setState(value : String, withPrevious : Bool = false) : Void {
		super.setState(value, withPrevious);
		
		_opened.visible = false;
		_closed.visible = false;
		_padlock.visible = false;
		_table.visible = false;
		
		switch (state) {
			case CapsState.OPENED:
				_opened.visible = true;
			case CapsState.CLOSED:
				_closed.visible = true;
				_padlock.visible = true;
			case CapsState.CLOSED_LABELED:
				_closed.visible = true;
				_padlock.visible = true;
				_table.visible = true;
		}
	}
	
	override function onClick(e : MouseEvent) : Void {
		switch (state) {
			case CapsState.OPENED:
				setState(CapsState.CLOSED);
			case CapsState.CLOSED:
				setState(CapsState.OPENED);
			case CapsState.CLOSED_LABELED:
				setState(CapsState.CLOSED);
		}
		super.onClick(e);
	}
}