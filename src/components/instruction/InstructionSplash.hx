package components.instruction;

import components.scroller.Scroller;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.geom.Rectangle;
import openfl.text.TextField;
import sith.core.mvc.view.ComplexView;
import sith.ui.S9Bitmap;
import utils.TFGenerator;

/**
 * ...
 * @author Sith
 */

class InstructionSplash extends ComplexView {
	
	var _s9Bitmap : S9Bitmap;
	var _textField : TextField;
	var _scroller : Scroller;
	var _closeShape : Sprite;
	
	/*public function new() {
		super();
	}*/
	
	override public function destroy() : Void {
		super.destroy();
		
		_s9Bitmap = null;
		_scroller = null;
		_closeShape = null;
	}
	
	public function updateText(text : String) : Void {
		_textField.htmlText = text;
		_textField.height = _textField.textHeight + 10;
		height = _textField.height + 50;
		if (height < 100)
			height = 100;
		if (height > 500)
			height = 500;
		_scroller.update();
	}
	
	public function show() : Void {
		visible = true;
		listenerPool.activate('onClick');
		listenerPool.activate('onWheel');
	}
	
	public function hide() : Void {
		visible = false;
		listenerPool.deactivate('onClick');
		listenerPool.deactivate('onWheel');
	}
	
	override function init() : Void {
		super.init();
		
		_s9Bitmap = new S9Bitmap(Assets.getBitmapData('assets/bitmap/ui/instruction_splash.png'), new Rectangle(38, 10, 488, 140));
		addChild(_s9Bitmap);
		destroyablePool.add(_s9Bitmap);
		
		_scroller = new Scroller();
		addChild(_scroller);
		destroyablePool.add(_scroller);
		_scroller.x = 60;
		_scroller.y = 14;
		
		_textField = TFGenerator.addSimple('Arial', 14, 0x101010, true);
		_scroller.container.addChild(_textField);
		
		_closeShape = new Sprite();
		_closeShape.graphics.beginFill(0xFF0000, 0.0);
		_closeShape.graphics.drawRect(0, 0, 10, 10);
		_closeShape.graphics.endFill();
		addChild(_closeShape);
		
		width = 505;
		height = 500;
		
		listenerPool.create('onClick', _closeShape, MouseEvent.CLICK, onClick);
		listenerPool.create('onWheel', this, MouseEvent.MOUSE_WHEEL, onMouseWheel).activate();
		
		visible = false;
		
		updateText('qwe');
	}
	
	function onMouseWheel(e : MouseEvent) : Void {
		//trace('onMouseWheel = ', e.delta);
		_scroller.currentY += e.delta * 20;
	}
	
	override function set_width(value : Float) : Float {
		super.set_width(value);
		
		snapRect.width = _s9Bitmap.width = _width;
		_scroller.width = _width - 75;
		
		_closeShape.width = _width - 30;
		
		_textField.width = _width - 80;
		
		return _width;
	}
	
	override function set_height(value : Float) : Float {
		super.set_height(value);
		
		snapRect.height = _s9Bitmap.height = _height;
		_scroller.height = _height - 36;
		
		_closeShape.height = _height;
		
		return _height;
	}
	
	function onClick(e : MouseEvent) : Void {
		hide();
	}
}