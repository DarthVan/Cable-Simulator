package screen.device.columns;

import openfl.Assets;
import screen.device.controls.arrow.Arrow;
import screen.device.controls.mgrip.MGrip;
import screen.device.pick.PickedObjectID;
import openfl.display.Bitmap;

/**
 * ...
 * @author Sith
 */

class Column_A_Meters extends BasicColumn {
	
	var _bigTripleON : Bitmap;
	
	override function init() : Void {
		super.init();
		
		_bg.bitmapData = Assets.getBitmapData('assets/bitmap/device/column_a_meters.png');
		_bg.x = 240;
		
		addPickedObject(new Arrow(PickedObjectID.A_M_V_ARROW1), 361, 430);
		addPickedObject(new Arrow(PickedObjectID.A_M_V_ARROW2), 531, 430);
		addPickedObject(new Arrow(PickedObjectID.A_M_V_ARROW3), 699, 430);
		addPickedObject(new Arrow(PickedObjectID.A_M_V_ARROW4), 869, 430);
		
		addPickedObject(new MGrip(PickedObjectID.A_M_GRIP), 977, 407);
		
		_bigTripleON = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/voltage.png'));
		_bigTripleON.x = 630;
		_bigTripleON.y = 80;
		addChild(_bigTripleON);
	}
	
	override public function destroy() : Void {
		
		if (_bigTripleON != null && _bigTripleON.bitmapData != null)
			_bigTripleON.bitmapData.dispose();
		_bigTripleON = null;
		
		super.destroy();
	}
}