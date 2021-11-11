package screen.device.controls.handle;

import screen.device.pick.PickedObject;

/**
 * ...
 * @author Sith
 */

class HandleHole extends PickedObject {
	
	override public function destroy() : Void {
		super.destroy();
		
		graphics.clear();
	}
	
	override function init() : Void {
		super.init();
		
		buttonMode = false;
		//mouseEnabled = false;
		
		graphics.beginFill(0xFF0000, 0.0);
		graphics.drawCircle(0, 0, 15);
		graphics.endFill();
	}
}