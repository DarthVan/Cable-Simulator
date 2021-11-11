package screen.device.controls.latch;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Shape;
import openfl.events.MouseEvent;
import screen.device.pick.PickedObject;

/**
 * ...
 * @author Sith
 */

class Latch extends PickedObject {
	
	var _inside : Shape;
	var _outside : Bitmap;
	var _tableDontWork : Bitmap;
	var _tableGrounded : Bitmap;
	
	var _tableType : String;
	
	override public function destroy() : Void {
		super.destroy();
		
		_inside.graphics.clear();
		_inside = null;
		
		_outside.bitmapData.dispose();
		_outside = null;
		
		_tableDontWork.bitmapData.dispose();
		_tableDontWork = null;
		
		_tableGrounded.bitmapData.dispose();
		_tableGrounded = null;
	}
	
	override public function setData(data : Dynamic) : Void {
		super.setData(data);
		
		if (data.table == null || data.table == '')
			return;
		
		_tableType = Std.string(data.table);
	}
	
	override function init() : Void {
		super.init();
		
		_inside = new Shape();
		_inside.graphics.beginFill(0xFF0000, 0.0);
		_inside.graphics.drawRect(0, 0, 35, 45);
		_inside.graphics.endFill();
		addChild(_inside);
		
		_outside = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/latch.png'), null, true);
		addChild(_outside);
		
		_tableDontWork = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/table_piple_working.png'), null, true);
		_tableDontWork.x = -80;
		_tableDontWork.y = 35;
		addChild(_tableDontWork);
		
		_tableGrounded = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/table_grounded.png'), null, true);
		_tableGrounded.x = -80;
		_tableGrounded.y = 35;
		addChild(_tableGrounded);
		
		setState(LatchState.OUTSIDE_LABELED);
	}
	
	override function setState(value : String, withPrevious : Bool = false) : Void {
		super.setState(value, withPrevious);
		
		_outside.visible = false;
		_tableDontWork.visible = false;
		_tableGrounded.visible = false;
		
		switch (state) {
			case LatchState.INSIDE:
				return;
			case LatchState.OUTSIDE:
				_outside.visible = true;
			case LatchState.OUTSIDE_LABELED:
				_outside.visible = true;
				if (_tableType == 'dont_work')
					_tableDontWork.visible = true;
				else
					_tableGrounded.visible = true;
		}
	}
	
	override function onClick(e : MouseEvent) : Void {
		switch (state) {
			case LatchState.INSIDE:
				//setState(LatchState.OUTSIDE);
			case LatchState.OUTSIDE:
				setState(LatchState.INSIDE);
			case LatchState.OUTSIDE_LABELED:
				setState(LatchState.OUTSIDE);
		}
		super.onClick(e);
	}
}