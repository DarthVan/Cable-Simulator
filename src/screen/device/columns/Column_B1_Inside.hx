package screen.device.columns;

import openfl.Assets;
import screen.device.controls.buttons.RelReset;
import screen.device.controls.buttons.RelTest;
import screen.device.controls.buttons.ResetPush;
import screen.device.controls.buttons.TestButton_M2;
import screen.device.controls.clamp.Clamp;
import screen.device.controls.clamp.ClampIndicator;
import screen.device.controls.grip.Grip_M2;
import screen.device.controls.lamps.GreenLamp_M2;
import screen.device.controls.lamps.RedLamp_M2;
import screen.device.controls.lamps.RelLampGreen;
import screen.device.controls.lamps.RelLampRed;
import screen.device.controls.lamps.YellowLamp_M2;
import screen.device.controls.push.PushHandles;
import screen.device.controls.switcher.Switcher;
import screen.device.pick.PickedObjectID;

/**
 * ...
 * @author Sith
 */

class Column_B1_Inside extends BasicColumn {

	override function init() : Void {
		super.init();
		
		_bg.bitmapData = Assets.getBitmapData('assets/bitmap/device/column_a1_inside.png');
		_bg.x = 240;
		
		// picked objects ...
		
		addPickedObject(new Switcher(PickedObjectID.B1_SWITCHER), 536, 339);
		
		addPickedObject(new ClampIndicator(PickedObjectID.B1_CLAMP_INDICATOR), 423, 374);
		addPickedObject(new Clamp(PickedObjectID.B1_CLAMP), 401, 279);
		
		addPickedObject(new RedLamp_M2(PickedObjectID.B1_LAMP_RED), 720, 283);
		addPickedObject(new GreenLamp_M2(PickedObjectID.B1_LAMP_GREEN), 775, 283);
		addPickedObject(new YellowLamp_M2(PickedObjectID.B1_LAMP_YELLOW), 828, 283);
		
		addPickedObject(new TestButton_M2(PickedObjectID.B1_TEST_BUTTON), 732, 353);
		
		addPickedObject(new Grip_M2(PickedObjectID.B1_GRIP), 794, 353);
		
		addPickedObject(new RelLampGreen(PickedObjectID.B1_REL_LAMP_GREEN), 676, 285);
		addPickedObject(new RelLampRed(PickedObjectID.B1_REL_LAMP_RED), 678, 294);
		addPickedObject(new RelTest(PickedObjectID.B1_REL_TEST_BUTTON), 604, 360);
		addPickedObject(new RelReset(PickedObjectID.B1_REL_RESET_BUTTON), 630, 360);
		
		addPickedObject(new ResetPush(PickedObjectID.B1_RESET_PUSH_BUTTON), 850, 340);
		
		addPickedObject(new PushHandles(PickedObjectID.B1_PUSH_HANDLES), 342, 279);
	}
}