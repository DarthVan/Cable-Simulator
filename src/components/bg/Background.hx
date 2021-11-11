package components.bg;

import openfl.display.Shape;

/**
 * ...
 * @author Sith
 */

class Background extends Shape {

	public function new() {
		super();
		init();
	}
	
	function init() : Void {
		graphics.beginFill(0xFFFFFF);
		graphics.drawRect(0, 0, 1440, 790);
		graphics.endFill();
	}
}