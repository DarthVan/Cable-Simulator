package screen.device.columns;

import openfl.utils.Assets;
import screen.device.controls.arm.Arm;
import screen.device.controls.buttons.BPFEButton;
import screen.device.controls.buttons.GreenButton;
import screen.device.controls.buttons.PushOFF;
import screen.device.controls.buttons.PushON;
import screen.device.controls.buttons.RedButton;
import screen.device.controls.caps.Caps;
import screen.device.controls.cells.Cells;
import screen.device.controls.grip.Grip;
import screen.device.controls.handle.ConfirmButton;
import screen.device.controls.handle.Handle;
import screen.device.controls.handle.HandleHole;
import screen.device.controls.handle.HiddenHandle;
import screen.device.controls.handle.SmallArrow;
import screen.device.controls.indicator.Indicator;
import screen.device.controls.key.Key;
import screen.device.controls.lamps.GreenLamp;
import screen.device.controls.lamps.PhaseGreenLamp;
import screen.device.controls.lamps.PhaseRedLamp;
import screen.device.controls.lamps.PhaseYellowLamp;
import screen.device.controls.lamps.RedLamp;
import screen.device.controls.lamps.ResetLamp;
import screen.device.controls.lamps.YellowLamp;
import screen.device.controls.latch.Latch;
import screen.device.pick.PickedObjectID;

/**
 * ...
 * @author Sith
 */

class Column_A extends BasicColumn {
	
	override function init() : Void {
		super.init();
		
		_bg.bitmapData = Assets.getBitmapData('assets/bitmap/device/column_a.png');
		_bg.x = 240;
		
		// picked objects ...
		
		addPickedObject(new PushOFF(PickedObjectID.A_PUSH_OFF), 695, 246);
		addPickedObject(new PushON(PickedObjectID.A_PUSH_ON), 758, 246);
		
		addPickedObject(new Indicator(PickedObjectID.A_INDICATOR_L), 683, 326);
		addPickedObject(new Indicator(PickedObjectID.A_INDICATOR_R), 747, 326);
		
		addPickedObject(new Arm(PickedObjectID.A_BIG_ARM));
		
		addPickedObject(new Caps(PickedObjectID.A_CAPS), 686, 233);
		
		addPickedObject(new ResetLamp(PickedObjectID.A_LAMP_RESET), 563, 189);
		
		//addPickedObject(new Arrow(PickedObjectID.A_V_ARROW), 433, 258);
		
		addPickedObject(new BPFEButton(PickedObjectID.A_BUTTON_BPFE), 735, 188);
		
		addPickedObject(new Key(PickedObjectID.A_KEY_UP1), 637, 195);
		addPickedObject(new Key(PickedObjectID.A_KEY_UP2), 637, 250);
		addPickedObject(new Key(PickedObjectID.A_KEY_LEFT1), 560, 567);
		addPickedObject(new Key(PickedObjectID.A_KEY_LEFT2), 612, 567);
		
		addPickedObject(new HandleHole(PickedObjectID.A_HANDLE_HOLE), 749, 580);
		
		addPickedObject(new Latch(PickedObjectID.A_LATCH_UP), 683, 178);
		addPickedObject(new Latch(PickedObjectID.A_LATCH_LEFT), 653, 561);
		addPickedObject(new Latch(PickedObjectID.A_LATCH_RIGHT), 842, 561);
		
		addPickedObject(new ConfirmButton(PickedObjectID.A_BUTTON_CONFIRM), 712, 572);
		addPickedObject(new SmallArrow(PickedObjectID.A_S_ARROW), 795, 580);
		addPickedObject(new Handle(PickedObjectID.A_HANDLE), 710, 613);
		addPickedObject(new HiddenHandle(PickedObjectID.A_HIDDEN_HANDLE), 891, 568);
		
		addPickedObject(new PhaseGreenLamp(PickedObjectID.A_PHASE_GREEN), 379, 242);
		addPickedObject(new PhaseRedLamp(PickedObjectID.A_PHASE_RED), 365, 263);
		addPickedObject(new PhaseYellowLamp(PickedObjectID.A_PHASE_YELLOW), 391, 263);
		
		addPickedObject(new Grip(PickedObjectID.A_GRIP_LEFT), 315, 510);
		addPickedObject(new Grip(PickedObjectID.A_GRIP_RIGHT), 402, 510);
		addPickedObject(new Grip(PickedObjectID.A_GRIP_DOWN), 359, 588);
		
		addPickedObject(new GreenButton(PickedObjectID.A_BUTTON_GREEN), 314, 422);
		addPickedObject(new RedButton(PickedObjectID.A_BUTTON_RED), 397, 422);
		
		addPickedObject(new YellowLamp(PickedObjectID.A_LAMP_YELLOW), 429, 337);
		addPickedObject(new RedLamp(PickedObjectID.A_LAMP_RED), 355, 337);
		addPickedObject(new GreenLamp(PickedObjectID.A_LAMP_GREEN), 282, 337);
		
		addPickedObject(new Cells(PickedObjectID.A_CELLS), 546, 120);
	}
}