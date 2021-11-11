package screen.device.controls.indicator;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.events.MouseEvent;
import screen.device.pick.PickedObject;

/**
 * ...
 * @author Sith
 */

class Indicator extends PickedObject {
	
	var _on : Bitmap;
	var _off : Bitmap;
	var _chargedOk : Bitmap;
	var _chargedNotOk : Bitmap;
	var _discharged : Bitmap;
	
	static inline var W : Int = 60;
	static inline var H : Int = 30;
	
	override public function destroy() : Void {
		super.destroy();
		
		_on.bitmapData.dispose();
		_on = null;
		
		_off.bitmapData.dispose();
		_off = null;
		
		_chargedOk.bitmapData.dispose();
		_chargedOk = null;
		
		_chargedNotOk.bitmapData.dispose();
		_chargedNotOk = null;
		
		_discharged.bitmapData.dispose();
		_discharged = null;
	}
	
	override function init() : Void {
		super.init();
		
		_on = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/indicator_on.png'), null, true);
		_on.width = W;
		_on.height = H;
		addChild(_on);
		
		_off = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/indicator_off.png'), null, true);
		_off.width = W;
		_off.height = H;
		addChild(_off);
		
		_chargedOk = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/indicator_charged_ok.png'), null, true);
		_chargedOk.width = W;
		_chargedOk.height = H;
		addChild(_chargedOk);
		
		_chargedNotOk = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/indicator_charged_not_ok.png'), null, true);
		_chargedNotOk.width = W;
		_chargedNotOk.height = H;
		addChild(_chargedNotOk);
		
		_discharged = new Bitmap(Assets.getBitmapData('assets/bitmap/device/controls/indicator_discharged.png'), null, true);
		_discharged.width = W;
		_discharged.height = H;
		addChild(_discharged);
		
		setState(IndicatorState.DISCHARGED);
	}
	
	override function setState(value : String, withPrevious : Bool = false) : Void {
		super.setState(value, withPrevious);
		
		_on.visible = false;
		_off.visible = false;
		_chargedOk.visible = false;
		_chargedNotOk.visible = false;
		_discharged.visible = false;
		
		switch (state) {
			case IndicatorState.ON:
				_on.visible = true;
			case IndicatorState.OFF:
				_off.visible = true;
			case IndicatorState.CHARGED_OK:
				_chargedOk.visible = true;
			case IndicatorState.CHARGED_NOT_OK:
				_chargedNotOk.visible = true;
			case IndicatorState.DISCHARGED:
				_discharged.visible = true;
		}
	}
	
	/*override function onClick(e : MouseEvent) : Void {
		switch (state) {
			case IndicatorState.ON:
				setState(IndicatorState.OFF);
			case IndicatorState.OFF:
				setState(IndicatorState.CHARGED_OK);
			case IndicatorState.CHARGED_OK:
				setState(IndicatorState.CHARGED_NOT_OK);
			case IndicatorState.CHARGED_NOT_OK:
				setState(IndicatorState.DISCHARGED);
			case IndicatorState.DISCHARGED:
				setState(IndicatorState.ON);
		}
		super.onClick(e);
	}*/
}