package screen.device.controls;

import openfl.text.TextField;
import openfl.text.TextFormat;
import screen.device.pick.PickedObject;
import utils.TFGenerator;

/**
 * ...
 * @author Sith
 */

class Labeled extends PickedObject {
	
	var _textField : TextField;
	var _labelWidth : Int;
	
	override public function new(id : String, labelWidth : Int = 45) {
		_labelWidth = labelWidth;
		super(id);
	}
	
	override public function destroy() : Void {
		super.destroy();
		
		_textField = null;
	}
	
	override public function setData(data : Dynamic) : Void {
		super.setData(data);
		
		updateText(Std.string(data.text), Std.parseInt(data.size));
	}
	
	override function init() : Void {
		super.init();
		
		_textField = TFGenerator.addSimple('Arial', 12, 0x202020, false, 'center');
		_textField.x = -1;
		_textField.y = 0;
		_textField.width = _labelWidth;
		//_textField.scaleX = 0.94;
		_textField.height = 14;// 15;
		
		addChild(_textField);
	}
	
	function updateText(text : String, size : Int = 0) : Void {
		_textField.text = text;
		
		var tf : TextFormat = _textField.getTextFormat();
		
		if (size > 0) {
			tf.size = size;
			_textField.defaultTextFormat = tf;
			
			if (_textField.textWidth > _labelWidth - 1)
				_textField.scaleX = (_labelWidth - 1) / _textField.textWidth;
				
			return;
		}
		
		tf.size = 12;
		_textField.defaultTextFormat = tf;
		
		while (_textField.textWidth > _labelWidth) {
			tf.size -= 1;
			_textField.defaultTextFormat = tf;
		}
		
		if (tf.size < 8)
			_textField.scaleY = 1.2;
			
		if (tf.size < 6)
			_textField.scaleY = 1.8;
		
		_textField.y = -_textField.textHeight / 2 + 5;
	}
}