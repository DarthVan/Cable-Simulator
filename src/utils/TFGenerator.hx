package utils;

import openfl.text.TextField;
import openfl.text.TextFormat;

/**
 * ...
 * @author Sith
 */

class TFGenerator {

	public function new() {
	}
	
	public static function addSimple(font : String, size : Int, color : Int, multiline : Bool = true, align : String = 'left', bold : Bool = false) : TextField {
		var textFormat : TextFormat = new TextFormat(font, size, color, bold);
		textFormat.align = align;
		
		var textField : TextField = new TextField();
		textField.defaultTextFormat = textFormat;
		textField.selectable = false;
		textField.mouseWheelEnabled = false;
		textField.mouseEnabled = false;
		textField.multiline = multiline;
		textField.wordWrap = multiline;
		
		return textField;
	}
	
}