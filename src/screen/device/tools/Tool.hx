package screen.device.tools;

import openfl.display.Bitmap;
import openfl.display.Sprite;

/**
 * ...
 * @author Sith
 */

class Tool extends Sprite {
	
	public var type(get, null) : String;
	var _bitmap : Bitmap;
	
	public function new(type : String, bitmap : Bitmap) {
		this.type = type;
		_bitmap = bitmap;
		super();
		init();
	}
	
	function init() : Void {
		addChild(_bitmap);
		
		buttonMode = true;
	}
	
	function get_type() : String {
		return type;
	}
}