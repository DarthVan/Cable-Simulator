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

class Column_B1_Pullout extends BasicColumn {

	override function init() : Void {
		super.init();
		
		_bg.bitmapData = Assets.getBitmapData('assets/bitmap/device/column_a1_pullout.png');
		_bg.x = 240;
		
		// picked objects ...
		
		addPickedObject(new Switcher(PickedObjectID.B1_SWITCHER), 496, 379);
		
		addPickedObject(new ClampIndicator(PickedObjectID.B1_CLAMP_INDICATOR), 381, 414);
		addPickedObject(new Clamp(PickedObjectID.B1_CLAMP), 360, 319);
		
		addPickedObject(new RedLamp_M2(PickedObjectID.B1_LAMP_RED), 679, 323);
		addPickedObject(new GreenLamp_M2(PickedObjectID.B1_LAMP_GREEN), 732, 323);
		addPickedObject(new YellowLamp_M2(PickedObjectID.B1_LAMP_YELLOW), 784, 323);
		
		addPickedObject(new TestButton_M2(PickedObjectID.B1_TEST_BUTTON), 691, 393);
		
		addPickedObject(new Grip_M2(PickedObjectID.B1_GRIP), 754, 393);
		
		addPickedObject(new RelLampGreen(PickedObjectID.B1_REL_LAMP_GREEN), 635, 325);
		addPickedObject(new RelLampRed(PickedObjectID.B1_REL_LAMP_RED), 638, 334);
		addPickedObject(new RelTest(PickedObjectID.B1_REL_TEST_BUTTON), 564, 400);
		addPickedObject(new RelReset(PickedObjectID.B1_REL_RESET_BUTTON), 590, 400);
		
		addPickedObject(new ResetPush(PickedObjectID.B1_RESET_PUSH_BUTTON), 806, 376);
		
		addPickedObject(new PushHandles(PickedObjectID.B1_PUSH_HANDLES), 302, 318);
	}
}