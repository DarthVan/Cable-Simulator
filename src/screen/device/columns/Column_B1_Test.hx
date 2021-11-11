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

class Column_B1_Test extends BasicColumn {

	override function init() : Void {
		super.init();
		
		_bg.bitmapData = Assets.getBitmapData('assets/bitmap/device/column_a1_test.png');
		_bg.x = 240;
		
		// picked objects ...
		
		addPickedObject(new Switcher(PickedObjectID.B1_SWITCHER), 517, 360);
		
		addPickedObject(new ClampIndicator(PickedObjectID.B1_CLAMP_INDICATOR), 403, 395);
		addPickedObject(new Clamp(PickedObjectID.B1_CLAMP), 381, 300);
		
		addPickedObject(new RedLamp_M2(PickedObjectID.B1_LAMP_RED), 700, 304);
		addPickedObject(new GreenLamp_M2(PickedObjectID.B1_LAMP_GREEN), 753, 304);
		addPickedObject(new YellowLamp_M2(PickedObjectID.B1_LAMP_YELLOW), 805, 304);
		
		addPickedObject(new TestButton_M2(PickedObjectID.B1_TEST_BUTTON), 712, 374);
		
		addPickedObject(new Grip_M2(PickedObjectID.B1_GRIP), 775, 374);
		
		addPickedObject(new RelLampGreen(PickedObjectID.B1_REL_LAMP_GREEN), 656, 306);
		addPickedObject(new RelLampRed(PickedObjectID.B1_REL_LAMP_RED), 659, 315);
		addPickedObject(new RelTest(PickedObjectID.B1_REL_TEST_BUTTON), 585, 381);
		addPickedObject(new RelReset(PickedObjectID.B1_REL_RESET_BUTTON), 611, 381);
		
		addPickedObject(new ResetPush(PickedObjectID.B1_RESET_PUSH_BUTTON), 827, 357);
		
		addPickedObject(new PushHandles(PickedObjectID.B1_PUSH_HANDLES), 323, 299);
	}
}