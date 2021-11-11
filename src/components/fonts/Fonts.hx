package components.fonts;

import openfl.Assets;
import openfl.text.Font;

/**
 * ...
 * @author Sith
 */

class Fonts {
	
	public static var PFDIN(default, null) : String;
	public static var BEBAS(default, null) : String;
	
	public function new() {
		
	}
	
	public static function init() : Void {
		PFDIN = Assets.getFont("assets/fonts/PFDinTextCompPro-Medium.ttf").fontName;
		BEBAS = Assets.getFont("assets/fonts/BebasNeue-Bold.ttf").fontName;
		
		trace(PFDIN, BEBAS);
	}
}

@:font("assets/fonts/PFDinTextCompPro-Medium.ttf")
private class FontClassName1 extends Font {}

@:font("assets/fonts/BebasNeue-Bold.ttf")
private class FontClassName2 extends Font {}