package components.tester;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.SimpleButton;
import openfl.events.MouseEvent;
import openfl.geom.ColorTransform;
import openfl.geom.Rectangle;
import openfl.text.TextField;
import script.Script;
import sith.core.mvc.view.BasicView;
import utils.TFGenerator;

/**
 * ...
 * @author Sith
 */

class Tester extends BasicView {
	
	var _script : Script;
	
	var _textField : TextField;
	var _reload : SimpleButton;
	var _next : SimpleButton;
	
	var _rBitmapNormal : Bitmap;
	var _rBitmapDown : Bitmap;
	
	var _nBitmapNormal : Bitmap;
	var _nBitmapDown : Bitmap;
	
	public function setScript(script : Script) : Void {
		_script = script;
	}
	
	public function updateText(text : String) : Void {
		_textField.text = text;
	}
	
	override function init() : Void {
		super.init();
		
		_textField = TFGenerator.addSimple('Arial', 14, 0x101060, false, 'center', true);
		_textField.width = 100;
		_textField.height = 20;
		addChild(_textField);
		
		_rBitmapNormal = new Bitmap(Assets.getBitmapData('assets/bitmap/ui/reload.jpg').clone());
		_rBitmapDown = new Bitmap(Assets.getBitmapData('assets/bitmap/ui/reload.jpg'));
		_rBitmapNormal.bitmapData.colorTransform(new Rectangle(0, 0, 100, 100), new ColorTransform(1.1, 1.1, 1.1));
		
		_reload = new SimpleButton(_rBitmapNormal, _rBitmapNormal, _rBitmapDown, _rBitmapDown);
		_reload.y = 30;
		addChild(_reload);
		
		_reload.addEventListener(MouseEvent.CLICK, onReload);
		
		_nBitmapNormal = new Bitmap(Assets.getBitmapData('assets/bitmap/ui/next.jpg').clone());
		_nBitmapDown = new Bitmap(Assets.getBitmapData('assets/bitmap/ui/next.jpg'));
		_nBitmapNormal.bitmapData.colorTransform(new Rectangle(0, 0, 100, 100), new ColorTransform(1.1, 1.1, 1.1));
		
		_next = new SimpleButton(_nBitmapNormal, _nBitmapNormal, _nBitmapDown, _nBitmapDown);
		_next.y = 140;
		addChild(_next);
		
		_next.addEventListener(MouseEvent.CLICK, onNext);
		
		updateText('Stand by...');
	}
	
	function onReload(e : MouseEvent) : Void {
		_script.reset();
	}
	
	function onNext(e : MouseEvent) : Void {
		_script.newSituation();
		//_script.next();
	}
}