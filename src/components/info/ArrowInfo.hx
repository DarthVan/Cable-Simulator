package components.info;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.text.TextField;
import utils.TFGenerator;

/**
 * ...
 * @author Sith
 */

class ArrowInfo extends Sprite {
	
	static var ARROW_OFFSET : Int = 5;
	
	public function new(arrow : String = '←', text : String = 'info', x : Int = 0, y : Int = 0) {
		super();
		
		var textField : TextField = TFGenerator.addSimple('Arial', 12, 0xf03c3f, true, 'center', true);
		textField.text = text;
		textField.width = 125;
		textField.height = textField.textHeight + 5;
		textField.x -= textField.width / 2;
		textField.y -= textField.height / 2;
		addChild(textField);
		
		var bArrow : Bitmap = new Bitmap(Assets.getBitmapData('assets/bitmap/ui/info_arrow.png'), null, true);
		switch (arrow) {
			case '←' :
				bArrow.x = textField.x - bArrow.width - ARROW_OFFSET;
				bArrow.y = 0;
			case '↑' :
				bArrow.x = 0;
				bArrow.y = textField.y - bArrow.width - ARROW_OFFSET;
				bArrow.rotation = 90;
			case '→' :
				bArrow.x = textField.width / 2 + ARROW_OFFSET + bArrow.width;
				bArrow.y = 0;
				bArrow.rotation = 180;
			case '↓' :
				bArrow.x = 0;
				bArrow.y = textField.height / 2 + bArrow.width + ARROW_OFFSET;
				bArrow.rotation = 270;
		}
		addChild(bArrow);
		
		this.x = x;
		this.y = y;
		
		mouseEnabled = false;
	}
}