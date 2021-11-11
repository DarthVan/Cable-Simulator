package screen.device.columns;

import openfl.Assets;
import openfl.display.Bitmap;
import screen.device.controls.arm.Arm;
import screen.device.controls.buttons.BPFEButton;
import screen.device.controls.buttons.GreenButton;
import screen.device.controls.buttons.RedButton;
import screen.device.controls.caps.Caps;
import screen.device.controls.handle.ConfirmButton;
import screen.device.controls.handle.Handle;
import screen.device.controls.handle.HandleHole;
import screen.device.controls.handle.HiddenHandle;
import screen.device.controls.handle.SmallArrow;
import screen.device.controls.indicator.Indicator;
import screen.device.controls.cells.Cells;
import screen.device.controls.key.Key;
import screen.device.controls.lamps.GreenLamp;
import screen.device.controls.lamps.RedLamp;
import screen.device.controls.lamps.YellowLamp;
import screen.device.controls.latch.Latch;
import screen.device.controls.buttons.PushOFF;
import screen.device.controls.buttons.PushON;
import screen.device.controls.lamps.ResetLamp;
import screen.device.pick.PickedObjectID;

/**
 * ...
 * @author Sith
 */

class Column_AB extends BasicColumn {

	override function init() : Void {
		super.init();
		
		_bg = new Bitmap(Assets.getBitmapData('assets/bitmap/device/column_ab.png'));
		_bg.x = 240;
		addChild(_bg);
		
		// picked objects ...
		
		addPickedObject(new PushOFF(PickedObjectID.AB_PUSH_OFF), 695, 246);
		addPickedObject(new PushON(PickedObjectID.AB_PUSH_ON), 758, 246);
		
		addPickedObject(new Indicator(PickedObjectID.AB_INDICATOR_L), 683, 326);
		addPickedObject(new Indicator(PickedObjectID.AB_INDICATOR_R), 747, 326);
		
		addPickedObject(new Arm(PickedObjectID.AB_BIG_ARM));
		
		addPickedObject(new Caps(PickedObjectID.AB_CAPS), 686, 233);
		
		addPickedObject(new ResetLamp(PickedObjectID.AB_LAMP_RESET), 563, 189);
		
		addPickedObject(new BPFEButton(PickedObjectID.AB_BUTTON_BPFE), 735, 188);
		
		addPickedObject(new Key(PickedObjectID.AB_KEY_UP1), 637, 195);
		addPickedObject(new Key(PickedObjectID.AB_KEY_UP2), 637, 250);
		addPickedObject(new Key(PickedObjectID.AB_KEY_LEFT1), 560, 567);
		addPickedObject(new Key(PickedObjectID.AB_KEY_LEFT2), 612, 567);
		
		addPickedObject(new HandleHole(PickedObjectID.AB_HANDLE_HOLE), 749, 580);
		
		addPickedObject(new Latch(PickedObjectID.AB_LATCH_UP), 683, 178);
		addPickedObject(new Latch(PickedObjectID.AB_LATCH_LEFT), 653, 561);
		addPickedObject(new Latch(PickedObjectID.AB_LATCH_RIGHT), 842, 561);
		
		addPickedObject(new ConfirmButton(PickedObjectID.AB_BUTTON_CONFIRM), 712, 572);
		addPickedObject(new SmallArrow(PickedObjectID.AB_S_ARROW), 795, 580);
		addPickedObject(new Handle(PickedObjectID.AB_HANDLE), 710, 613);
		addPickedObject(new HiddenHandle(PickedObjectID.AB_HIDDEN_HANDLE), 891, 568);
		
		addPickedObject(new GreenButton(PickedObjectID.AB_BUTTON_GREEN), 314, 422);
		addPickedObject(new RedButton(PickedObjectID.AB_BUTTON_RED), 397, 422);
		
		addPickedObject(new YellowLamp(PickedObjectID.AB_LAMP_YELLOW), 429, 337);
		addPickedObject(new RedLamp(PickedObjectID.AB_LAMP_RED), 355, 337);
		addPickedObject(new GreenLamp(PickedObjectID.AB_LAMP_GREEN), 282, 337);
		
		addPickedObject(new Cells(PickedObjectID.AB_CELLS), 546, 120);
	}
}