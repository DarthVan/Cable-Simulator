package components.overlay;

import components.fonts.Fonts;
import components.instruction.InstructionSplash;
import components.window.Window;
import event.AppEvents;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Shape;
import openfl.display.SimpleButton;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.filters.BlurFilter;
import openfl.text.TextField;
import sith.core.mvc.view.ComplexView;
import sith.core.pools.snap.LinearSnapGroup;
import sith.core.pools.snap.PivotType;
import utils.TFGenerator;

/**
 * ...
 * @author Sith
 */

class Overlay extends ComplexView {
	
	public static inline var TITLE : String = 'title';
	public static inline var INSTRUCTIONS : String = 'instructions';
	
	public var title(get, null) : TextField;
	public var window(get, null) : Window;
	public var instruction(get, null) : SimpleButton;
	public var instructionSplash(get, null) : InstructionSplash;
	public var notification(get, null) : SimpleButton;
	
	var _instructionContainer : Sprite;
	var _notificationContainer : Sprite;
	var _buttonSize : Int = 80;
	
	/*public function new() {
		super();
	}*/
	
	public function updateTitle(text : String) : Void {
		title.htmlText = text;
	}
	
	public function instructionEnable() : Void {
		instruction.mouseEnabled = true;
		instruction.enabled = true;
		instruction.alpha = 1.0;
		instruction.addEventListener(MouseEvent.CLICK, onInstructionClick);
	}
	
	public function instructionDisable() : Void {
		instruction.mouseEnabled = false;
		instruction.enabled = false;
		instruction.alpha = 0.5;
		instruction.removeEventListener(MouseEvent.CLICK, onInstructionClick);
	}
	
	public function notificationEnable() : Void {
		notification.mouseEnabled = true;
		notification.enabled = true;
		notification.alpha = 1.0;
		notification.addEventListener(MouseEvent.CLICK, onNotificationClick);
	}
	
	public function notificationDisable() : Void {
		notification.mouseEnabled = false;
		notification.enabled = false;
		notification.alpha = 0.5;
		notification.removeEventListener(MouseEvent.CLICK, onNotificationClick);
	}
	
	public function nBlurEnabled() : Void {
		_instructionContainer.filters = [new BlurFilter(Constants.WINDOW_OVERLAY_BLUR, Constants.WINDOW_OVERLAY_BLUR, 2)];
		_notificationContainer.filters = [new BlurFilter(Constants.WINDOW_OVERLAY_BLUR, Constants.WINDOW_OVERLAY_BLUR, 2)];
		instructionSplash.filters = [new BlurFilter(Constants.WINDOW_OVERLAY_BLUR, Constants.WINDOW_OVERLAY_BLUR, 2)];
	}
	
	public function nBlurDisabled() : Void {
		_instructionContainer.filters = [];
		_notificationContainer.filters = [];
		instructionSplash.filters = [];
	}
	
	override function init() : Void {
		super.init();
		
		snapRect.width = 1440;
		snapRect.height = 800;
		
		drawInstructions();
		drawInstructionSplash();
		
		drawNotification();
		
		drawWindow();
		
		drawTitle();
	}
	
	function drawInstructions() : Void {
		_instructionContainer = new Sprite();
		_instructionContainer.x = 50;
		_instructionContainer.y = 560;
		addChild(_instructionContainer);
		
		var instructionStateDefault : Sprite = new Sprite();
		var instructionHit : Shape = new Shape();
		instructionHit.graphics.beginFill(0xFF0000, 0.0);
		instructionHit.graphics.drawRect(0, 0, _buttonSize, _buttonSize);
		instructionHit.graphics.endFill();
		instructionStateDefault.addChild(instructionHit);
		var instructionBitmap : Bitmap = new Bitmap(Assets.getBitmapData('assets/bitmap/ui/instruction_icon_default.png'), null, true);
		instructionBitmap.x = (_buttonSize - instructionBitmap.width) / 2;
		instructionBitmap.y = 10;
		instructionStateDefault.addChild(instructionBitmap);
		var instructionText : TextField = TFGenerator.addSimple('Arial Narrow', 11, 0x444444, false, 'center');
		instructionText.x = 0;
		instructionText.y = 50;
		instructionText.width = _buttonSize;
		instructionText.height = 20;
		instructionText.text = 'ИНСТРУКЦИЯ';
		instructionStateDefault.addChild(instructionText);
		var instructionStateOver : Sprite = new Sprite();
		var instructionBitmap2 : Bitmap = new Bitmap(Assets.getBitmapData('assets/bitmap/ui/instruction_icon_over.png'), null, true);
		instructionBitmap2.x = (_buttonSize - instructionBitmap2.width) / 2;
		instructionBitmap2.y = 10;
		instructionStateOver.addChild(instructionBitmap2);
		var instructionText2 : TextField = TFGenerator.addSimple('Arial Narrow', 11, 0x444444, false, 'center');
		instructionText2.x = 0;
		instructionText2.y = 50;
		instructionText2.width = _buttonSize;
		instructionText2.height = 20;
		instructionText2.text = 'ИНСТРУКЦИЯ';
		instructionStateOver.addChild(instructionText2);
		instruction = new SimpleButton(instructionStateDefault, instructionStateOver, instructionStateDefault, instructionStateDefault);
		instruction.addEventListener(MouseEvent.CLICK, onInstructionClick);
		_instructionContainer.addChild(instruction);
	}
	
	function drawInstructionSplash() : Void {
		instructionSplash = new InstructionSplash();
		addChild(instructionSplash);
		snapPool.add(new LinearSnapGroup('istructionSplash', [instructionSplash], snapRect, PivotType.BOTTOM_LEFT, [140, 160, 0, 0, 0, 0]));
		snapPool.updateX();
		snapPool.updateY();
		startAutoSnap();
	}
	
	function drawNotification() : Void {
		_notificationContainer = new Sprite();
		_notificationContainer.x = 50;
		_notificationContainer.y = 460;
		addChild(_notificationContainer);
		
		var notificationStateDefault : Sprite = new Sprite();
		var notificationHit : Shape = new Shape();
		notificationHit.graphics.beginFill(0xFF0000, 0.0);
		notificationHit.graphics.drawRect(0, 0, _buttonSize, _buttonSize);
		notificationHit.graphics.endFill();
		notificationStateDefault.addChild(notificationHit);
		var notificationBitmap : Bitmap = new Bitmap(Assets.getBitmapData('assets/bitmap/ui/notification_icon_default.png'), null, true);
		notificationBitmap.x = (_buttonSize - notificationBitmap.width) / 2;
		notificationBitmap.y = 10;
		notificationStateDefault.addChild(notificationBitmap);
		var notificationText : TextField = TFGenerator.addSimple('Arial Narrow', 11, 0x444444, false, 'center');
		notificationText.x = 0;
		notificationText.y = 50;
		notificationText.width = _buttonSize;
		notificationText.height = 20;
		notificationText.text = 'УВЕДОМЛЕНИЯ';
		notificationStateDefault.addChild(notificationText);
		var notificationStateOver : Sprite = new Sprite();
		var notificationBitmap2 : Bitmap = new Bitmap(Assets.getBitmapData('assets/bitmap/ui/notification_icon_over.png'), null, true);
		notificationBitmap2.x = (_buttonSize - notificationBitmap2.width) / 2;
		notificationBitmap2.y = 10;
		notificationStateOver.addChild(notificationBitmap2);
		var notificationText2 : TextField = TFGenerator.addSimple('Arial Narrow', 11, 0x444444, false, 'center');
		notificationText2.x = 0;
		notificationText2.y = 50;
		notificationText2.width = _buttonSize;
		notificationText2.height = 20;
		notificationText2.text = 'УВЕДОМЛЕНИЯ';
		notificationStateOver.addChild(notificationText2);
		notification = new SimpleButton(notificationStateDefault, notificationStateOver, notificationStateDefault, notificationStateDefault);
		notification.addEventListener(MouseEvent.CLICK, onNotificationClick);
		_notificationContainer.addChild(notification);
	}
	
	function drawWindow() : Void {
		window = new Window();
		addChild(window);
	}
	
	function drawTitle() : Void {
		title = TFGenerator.addSimple(Fonts.BEBAS, 36, 0x205caf); //PFDinTextCompPro-Medium  BebasNeueBold
		title.x = 78;
		title.y = 15;
		title.width = 900;
		title.height = 50;
		addChild(title);
	}
	
	function get_title() : TextField {
		return title;
	}
	
	function get_window() : Window {
		return window;
	}
	
	function get_instruction() : SimpleButton {
		return instruction;
	}
	
	function get_instructionSplash() : InstructionSplash {
		return instructionSplash;
	}
	
	function onInstructionClick(e : MouseEvent) : Void {
		if (instructionSplash.visible)
			instructionSplash.hide();
		else
			instructionSplash.show();
		//stage.dispatchEvent(new AppEvents(AppEvents.OPEN_INSTRUCTIONS));
	}
	
	function get_notification() : SimpleButton {
		return notification;
	}
	
	function onNotificationClick(e : MouseEvent) : Void {
		stage.dispatchEvent(new AppEvents(AppEvents.WINDOW_OPEN_MANUALLY));
	}
}