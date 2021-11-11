package components.window;

import components.window.ActionButton;
import components.window.WindowType;
import event.AppEvents;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Shape;
import openfl.display.SimpleButton;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import utils.TFGenerator;

/**
 * ...
 * @author Sith
 */

class Window extends Sprite {
	
	var _whitePlane : Shape;
	
	var _container : Sprite;
	var _background : Bitmap;
	var _iconSuccess : Bitmap;
	var _iconFailed : Bitmap;
	var _closeButton : SimpleButton;
	var _actionButton : ActionButton;
	var _fixButton : ActionButton;
	var _textField : TextField;
	
	var _type : Int;

	public function new() {
		super();
		init();
	}
	
	public function update(type : Int, message : String) : Void {
		visible = true;
		_background.width = 511;
		_background.height = 219;
		_actionButton.x = 190;
		_actionButton.y = 140;
		
		_fixButton.visible = false;
		
		_textField.htmlText = message;
		_textField.height = _textField.textHeight + 25;
		
		_type = type;
		switch (type) {
			case WindowType.CONTINUE:
				_actionButton.x = 190;
				_actionButton.label.text = 'ПОНЯТНО';
				_textField.x = 50;
				_textField.y = 40;
				_textField.width = 400;
				
				if (_textField.textHeight > 90) {
					_background.height = 139 + _textField.textHeight;
					_actionButton.y = _background.height - 79;
				}
				
				_iconSuccess.visible = false;
				_iconFailed.visible = false;
			case WindowType.NEXT:
				_actionButton.x = 180;
				_actionButton.label.text = 'ДАЛЕЕ';
				_textField.x = 180;
				_textField.y = 25;
				_textField.width = 270;
				_iconSuccess.visible = true;
				_iconFailed.visible = false;
			case WindowType.RETRY:
				_actionButton.x = 180;
				_actionButton.label.text = 'ИСПРАВИТЬ';
				_textField.x = 180;
				_textField.y = 25;
				_textField.width = 270;
				_iconSuccess.visible = false;
				_iconFailed.visible = true;
			case WindowType.FIX_CONTINUE:
				_actionButton.x = 260;
				_actionButton.label.text = 'ПРОДОЛЖИТЬ';
				
				_fixButton.visible = true;
				_fixButton.label.text = 'ИСПРАВИТЬ';
				
				_textField.x = 50;
				_textField.y = 40;
				_textField.width = 400;
				
				if (_textField.textHeight > 90) {
					_background.height = 139 + _textField.textHeight;
					_actionButton.y = _background.height - 79;
					_fixButton.y = _background.height - 79;
				}
				
				_iconSuccess.visible = false;
				_iconFailed.visible = false;
			case WindowType.FINISH:
				_actionButton.x = 190;
				_actionButton.label.text = 'ЗАВЕРШИТЬ';
				_textField.x = 50;
				_textField.y = 40;
				_textField.width = 400;
				_iconSuccess.visible = false;
				_iconFailed.visible = false;
		}
	}
	
	public function show() : Void {
		visible = true;
	}
	
	public function hide() : Void {
		visible = false;
	}
	
	function init() : Void {
		visible = false;
		
		
		_whitePlane = new Shape();
		_whitePlane.graphics.beginFill(0xFFFFFF, Constants.WINDOW_OVERLAY_ALPHA);
		_whitePlane.graphics.drawRect(0, 0, Constants.APP_WIDTH, Constants.APP_HEIGHT);
		_whitePlane.graphics.endFill();
		addChild(_whitePlane);
		
		
		_container = new Sprite();
		
		
		_background = new Bitmap(Assets.getBitmapData('assets/bitmap/ui/window_background.png'), null, true);
		_container.addChild(_background);
		
		
		_iconSuccess = new Bitmap(Assets.getBitmapData('assets/bitmap/ui/window_success.png'), null, true);
		_iconSuccess.x = 10;
		_iconSuccess.y = 6;
		_iconSuccess.visible = false;
		_container.addChild(_iconSuccess);
		
		
		_iconFailed = new Bitmap(Assets.getBitmapData('assets/bitmap/ui/window_failed.png'), null, true);
		_iconFailed.x = 10;
		_iconFailed.y = 6;
		_iconFailed.visible = false;
		_container.addChild(_iconFailed);
		
		
		var closeButtonBitmapDefault : Bitmap = new Bitmap(Assets.getBitmapData('assets/bitmap/ui/window_close_default.png'), null, true);
		var closeButtonBitmapOver : Bitmap = new Bitmap(Assets.getBitmapData('assets/bitmap/ui/window_close_over.png'), null, true);
		_closeButton = new SimpleButton(closeButtonBitmapDefault, closeButtonBitmapOver, closeButtonBitmapDefault, closeButtonBitmapDefault);
		_closeButton.x = 470;
		_closeButton.y = 20;
		_closeButton.addEventListener(MouseEvent.CLICK, onWindowClose);
		_container.addChild(_closeButton);
		
		
		_actionButton = new ActionButton();
		_actionButton.x = 190;
		_actionButton.y = 140;
		_actionButton.addEventListener(MouseEvent.CLICK, onWindowClose);
		_container.addChild(_actionButton);
		
		_fixButton = new ActionButton();
		_fixButton.x = 100;
		_fixButton.y = 140;
		_fixButton.addEventListener(MouseEvent.CLICK, onFixClick);
		_container.addChild(_fixButton);
		
		_textField = TFGenerator.addSimple('Arial', 14, 0x444444, true);
		_container.addChild(_textField);
		
		
		_container.x = (Constants.APP_WIDTH - _container.width) / 2;
		_container.y = (Constants.APP_HEIGHT - _container.height) / 2 - 50;
		addChild(_container);
	}
	
	function onWindowClose(e : MouseEvent) : Void {
		visible = false;
		if (_type == WindowType.FIX_CONTINUE)
			_type = WindowType.NEXT;
		stage.dispatchEvent(new AppEvents(AppEvents.WINDOW_CLOSED, _type));
	}
	
	function onFixClick(e : MouseEvent) : Void {
		visible = false;
		stage.dispatchEvent(new AppEvents(AppEvents.WINDOW_CLOSED, _type));
	}
}