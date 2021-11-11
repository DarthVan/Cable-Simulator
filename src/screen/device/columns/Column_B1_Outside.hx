package screen.device.columns;

import openfl.Assets;
import screen.device.controls.buttons.CubeButton;
import screen.device.controls.buttons.GVButton;
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
import screen.device.controls.pck.PCKSwitcher;
import screen.device.controls.push.PushHandles;
import screen.device.controls.switcher.Switcher;
import screen.device.pick.PickedObjectID;

/**
 * ...
 * @author Sith
 */

class Column_B1_Outside extends BasicColumn {

	override function init() : Void {
		super.init();
		
		_bg.bitmapData = Assets.getBitmapData('assets/bitmap/device/column_a1_outside.png');
		_bg.x = 240;
		
		// picked objects ...
		
		addPickedObject(new CubeButton(PickedObjectID.B1_CUBE_BUTTON), 933, 348);
		addPickedObject(new GVButton(PickedObjectID.B1_GV_BUTTON), 475, 350);
		addPickedObject(new PCKSwitcher(PickedObjectID.B1_PCK_SWITCHER), 425, 337);
		
		addPickedObject(new Switcher(PickedObjectID.B1_SWITCHER), 434, 468);
		
		addPickedObject(new ClampIndicator(PickedObjectID.B1_CLAMP_INDICATOR), 320, 503);
		addPickedObject(new Clamp(PickedObjectID.B1_CLAMP), 298, 408);
		
		addPickedObject(new RedLamp_M2(PickedObjectID.B1_LAMP_RED), 617, 412);
		addPickedObject(new GreenLamp_M2(PickedObjectID.B1_LAMP_GREEN), 670, 412);
		addPickedObject(new YellowLamp_M2(PickedObjectID.B1_LAMP_YELLOW), 722, 412);
		
		addPickedObject(new TestButton_M2(PickedObjectID.B1_TEST_BUTTON), 629, 482);
		
		addPickedObject(new Grip_M2(PickedObjectID.B1_GRIP), 692, 482);
		
		addPickedObject(new RelLampGreen(PickedObjectID.B1_REL_LAMP_GREEN), 573, 414);
		addPickedObject(new RelLampRed(PickedObjectID.B1_REL_LAMP_RED), 576, 423);
		addPickedObject(new RelTest(PickedObjectID.B1_REL_TEST_BUTTON), 502, 489);
		addPickedObject(new RelReset(PickedObjectID.B1_REL_RESET_BUTTON), 528, 489);
		
		addPickedObject(new ResetPush(PickedObjectID.B1_RESET_PUSH_BUTTON), 744, 465);
		
		addPickedObject(new PushHandles(PickedObjectID.B1_PUSH_HANDLES), 240, 407);
	}
}