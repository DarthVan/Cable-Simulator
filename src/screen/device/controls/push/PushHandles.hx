package screen.device.controls.push;

import screen.device.pick.PickedObject;

/**
 * ...
 * @author Sith
 */

class PushHandles extends PickedObject {

	override public function destroy() : Void {
		super.destroy();
		
		graphics.clear();
	}
	
	override function init() : Void {
		super.init();
		
		graphics.beginFill(0xFF0000, 0.0);
		graphics.drawRect(0, 0, 54, 114);
		graphics.drawRect(642, 0, 54, 114);
		graphics.endFill();
		
		setState('', true);
	}
	
}