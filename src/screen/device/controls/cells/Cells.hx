package screen.device.controls.cells;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.events.MouseEvent;
import screen.device.pick.PickedObject;

/**
 * ...
 * @author Sith
 */

class Cells extends PickedObject {

	var _empty : Bitmap;
	var _curtains : Bitmap;
	var _locks : Bitmap;
	
	override public function destroy() : Void {
		super.destroy();
		
		_empty.bitmapData.dispose();
		_empty = null;
		
		_curtains.bitmapData.dispose();
		_curtains = null;
		
		_locks.bitmapData.dispose();
		_locks = null;
	}
	
	override function init() : Void {
		super.init();
		
		//mouseEnabled = false;
		buttonMode = false;
		
		_empty = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/cell_empty.png'));
		addChild(_empty);
		
		_curtains = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/cell_curtains.png'));
		_curtains.x = 83;
		_curtains.y = 0;
		addChild(_curtains);
		
		_locks = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/cell_curtains_locks.png'));
		_locks.x = 116;
		_locks.y = 35;
		addChild(_locks);
		
		setState(CellsState.HIDDEN);
	}
	
	override function setState(value : String, withPrevious : Bool = false) : Void {
		super.setState(value, withPrevious);
		
		_empty.visible = false;
		_curtains.visible = false;
		_locks.visible = false;
		buttonMode = false;
		
		switch (state) {
			case CellsState.HIDDEN:
				return;
			case CellsState.EMPTY:
				_empty.visible = true;
			case CellsState.NORMAL:
				_empty.visible = true;
				_curtains.visible = true;
			case CellsState.LOCKED:
				_empty.visible = true;
				_curtains.visible = true;
				_locks.visible = true;
				buttonMode = true;
		}
	}
	
	override function onClick(e : MouseEvent) : Void {
		
		if (state == CellsState.LOCKED)
			setState(CellsState.NORMAL);
		
		super.onClick(e);
	}
}