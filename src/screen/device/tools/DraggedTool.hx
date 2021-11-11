package screen.device.tools;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.display.Sprite;

/**
 * ...
 * @author Sith
 */

class DraggedTool extends Sprite {
	
	var _arrow : Shape;
	var _bitmap : Bitmap;
	
	public function new() {
		super();
		init();
	}
	
	public function update(bitmapData : BitmapData) : Void {
		_bitmap = new Bitmap(bitmapData, null, true);
		
		/*_bitmap.x -= 25;
		_bitmap.y -= 15;*/
		/*_bitmap.x -= 68;
		_bitmap.y -= 125;*/
		_bitmap.x -= _bitmap.width / 2;
		_bitmap.y -= _bitmap.height / 2 - 10;
		
		_bitmap.alpha = 0.7;
		addChild(_bitmap);
		
		//addArrow();
	}
	
	public function clear() : Void {
		//_arrow.graphics.clear();
		if (_bitmap != null && _bitmap.parent != null)
			removeChild(_bitmap);
		_bitmap = null;
	}
	
	function init() : Void {
		
		mouseEnabled = false;
		
	}
	
	function addArrow() : Void {
		_arrow = new Shape();
		_arrow.graphics.beginFill(0xFF0000);
		_arrow.graphics.lineStyle(1, 0xFFFFFF);
		_arrow.graphics.moveTo(0, 0);
		_arrow.graphics.lineTo( -6, -20);
		
		_arrow.graphics.lineTo( -3, -20);
		_arrow.graphics.lineTo( -3, -24);
		_arrow.graphics.lineTo( 3, -24);
		_arrow.graphics.lineTo( 3, -20);
		
		_arrow.graphics.lineTo( 6, -20);
		_arrow.graphics.lineTo(0, 0);
		_arrow.graphics.endFill();
		addChild(_arrow);
	}
}