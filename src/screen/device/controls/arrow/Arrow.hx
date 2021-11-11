package screen.device.controls.arrow;

import motion.Actuate;
import motion.easing.Elastic;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import screen.device.pick.PickedObject;

/**
 * ...
 * @author Sith
 */

class Arrow extends PickedObject {
	
	var _arrow : Bitmap;
	var _container : Sprite;
	
	override public function destroy() : Void {
		super.destroy();
		
		_arrow.bitmapData.dispose();
		_arrow = null;
		
		_container = null;
	}
	
	override public function setData(data : Dynamic) : Void {
		super.setData(data);
		
		var angle : Float = Std.parseFloat(data.angle);
		if (angle < 0)
			angle = 0;
		if (angle > 90)
			angle = 90;
		
		Actuate.tween(_container, 1.25, {rotation: angle, easy : Elastic.easeOut});
	}
	
	override function init() : Void {
		super.init();
		
		_container = new Sprite();
		addChild(_container);
		
		_arrow = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/arrow.png'), null, true);
		_arrow.x = -63;
		_arrow.y = -13;
		_container.addChild(_arrow);
		
		setData({'angle':25});
	}
}