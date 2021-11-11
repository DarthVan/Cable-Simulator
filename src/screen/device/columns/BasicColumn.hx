package screen.device.columns;

import motion.Actuate;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.geom.Matrix;
import openfl.geom.Rectangle;
import screen.device.pick.PickedObject;
import sith.core.mvc.view.BasicView;

/**
 * ...
 * @author Sith
 */

class BasicColumn extends BasicView {
	
	var _array : Array<PickedObject>;
	var _bg : Bitmap;
	
	override public function destroy() : Void {
		Actuate.reset();
		
		if (_bg != null && _bg.bitmapData != null)
			_bg.bitmapData.dispose();
		_bg = null;
		
		if (_array != null)
			for (o in _array)
				if (o != null)
					o.destroy();
		_array = null;
		
		super.destroy();
	}
	
	public function getObject(id : String) : PickedObject {
		for (o in _array)
			if (o.id == id)
				return o;
		return null;
	}
	
	public function drawBitmapData(x : Int = 250, y : Int = 80, width : Int = 770, height : Int = 700) : BitmapData {
		var bd : BitmapData = new BitmapData(width, height);
		bd.draw(this, new Matrix(1, 0, 0, 1, -x, -y), null, null, new Rectangle(0, 0, width, height));
		return bd;
	}
	
	override function init() : Void {
		super.init();
		
		_array = new Array<PickedObject>();
		
		_bg = new Bitmap();
		addChild(_bg);
	}
	
	function addPickedObject(po : PickedObject, x : Int = 0, y : Int = 0, visible : Bool = true, state : String = '') : Void {
		po.x = x;
		po.y = y;
		po.visible = visible;
		addChild(po);
		_array.push(po);
		if (state != '')
			po.setData({'state':state});
	}
}