package;

import components.bg.Background;
import components.fonts.Fonts;
import components.overlay.Overlay;
import components.tester.Tester;
import components.window.WindowType;
import event.AppEvents;
import motion.Actuate;
import openfl.display.Sprite;
import openfl.filters.BlurFilter;
import screen.ScreenType;
import screen.device.Device;
import screen.device.pick.PickData;
import screen.selector.Selector;
import script.Script;
import script.Step;
import script.Task;
import script.TaskType;

/**
 * ...
 * @author Sith
 */

class Main extends Sprite {
	
	public var selector : Selector;
	public var device : Device;
	public var overlay : Overlay;
	public var tester : Tester;
	
	var _script : Script;
	var _bg : Background;

	public function new() {
		super();
		init();
	}
	
	public function showScreen(type : String) : Void {
		clear();
		
		switch (type) {
			case ScreenType.SELECTOR:
				addChild(selector);
				//overlay.notificationDisable();
			case ScreenType.DEVICE:
				addChild(device);
				//overlay.notificationEnable();
		}
		
		setChildIndex(overlay, numChildren - 1);
		
		//setChildIndex(tester, numChildren - 1);
	}

	public function updateAndShowWindow(type : Int, message : String, dealy : Bool = false) : Void {
		if (dealy) {
			Actuate.timer(0.75).onComplete(updateAndShowWindow, [type, message]);
			return;
		}
		addBlur();
		overlay.window.update(type, message);
	}
	
	// =============================== PRIVATE =================================
	
	function init() : Void {
		
		Fonts.init();
		
		_bg = new Background();
		addChild(_bg);
		
		selector = new Selector();
		device = new Device();
		
		overlay = new Overlay();
		addChild(overlay);
		
		/*tester = new Tester();
		tester.x = 50;
		tester.y = 100;
		addChild(tester);*/
		
		_script = new Script(this);
		
		//tester.setScript(_script);
		
		stage.addEventListener(AppEvents.WINDOW_CLOSED, onWindowClosed);
		stage.addEventListener(AppEvents.WINDOW_OPEN_MANUALLY, onWindowOpenManually);
		stage.addEventListener(AppEvents.OBJECT_PICKED, onObjectPicked);
	}
	
	function checkTarget(pickID : String, taskTarget : String) : Bool {
		var targets : Array<String> = taskTarget.split(',');
		if (targets.length > 1) {
			for (s in targets)
				if (s == pickID)
					return true;
		} else {
			if (pickID == taskTarget)
				return true;
		}
		return false;
	}
	
	function onObjectPicked(e : AppEvents) : Void {
		var pick : PickData = cast(e.data, PickData);
		var task : Task = Script.currentStep.task;
		var step : Step = Script.currentStep;
		
		device.mouseEnabled = false;
		device.mouseChildren = false;
		
		switch (task.type) { // checks on errors
			case TaskType.SELECT:
				
				//if (pick.id != task.target) {
				if (!checkTarget(pick.id, task.target)) {
					if (step.comment_failed != '')
						updateAndShowWindow(WindowType.RETRY, Script.currentStep.comment_failed, true);
						//pick.object.undo();
					return;
				}
				
			case TaskType.PICK:
				
				//if (pick.tool != '' || pick.id != task.target || pick.state != task.value) {
				if (pick.tool != '' || !checkTarget(pick.id, task.target) || pick.state != task.value) {
					if (step.comment_failed != '')
						updateAndShowWindow(WindowType.RETRY, Script.currentStep.comment_failed, true);
					if (pick.tool != '') {
						device.tools.returnTool(pick.tool);
						return;
					}
					pick.object.undo();
					return;
				}
				
			case TaskType.TOOL:
				
				if (pick.tool != task.value || !checkTarget(pick.id, task.target)) {
				//if (pick.tool != task.value || pick.id != task.target) {
					if (step.comment_failed != '')
						updateAndShowWindow(WindowType.RETRY, Script.currentStep.comment_failed, true);
					if (pick.tool != '')
						device.tools.returnTool(pick.tool);
					else
						pick.object.undo();
					return;
				}
		}
		
		if (pick.tool != '') {
			pick.object.applyTool(pick.tool);
			device.tools.returnTool(pick.tool);
		}
		
		if (step.comment_success != '') {
			_script.previewNextStep();
			updateAndShowWindow(WindowType.NEXT, Script.currentStep.comment_success, true);
		} else
			_script.next();
	}
	
	function clear() : Void {
		if (selector.stage != null)
			removeChild(selector);
		if (device.stage != null)
			removeChild(device);
	}
	
	function onWindowClosed(e : AppEvents) : Void {
		removeBlur();
		device.mouseEnabled = true;
		device.mouseChildren = true;
		
		switch (e.data) {
			case WindowType.CONTINUE:
				if (Script.currentStep.task.type == TaskType.COMMENT || Script.currentStep.task.type == TaskType.ASKFIX)
					_script.next();
				//do nothing, just close window
				//if (Script.currentStep.task.type == TaskType.WAIT)
				//	Actuate.timer(1).onComplete(_script.next);
			case WindowType.NEXT:
				//todo: next step
				if (Script.currentStep.task.type == TaskType.ASKFIX) {
					if (Script.currentStep.task.target == 'fix')
						updateAndShowWindow(WindowType.CONTINUE, Script.currentStep.comment_failed);
					else {
						if (Script.currentStep.comment_success == '')
							_script.next();
						else
							updateAndShowWindow(WindowType.CONTINUE, Script.currentStep.comment_success);
					}
					return;
				}
				_script.next();
				//if (Script.currentStep.task.type == TaskType.WAIT)
				//	Actuate.timer(1).onComplete(_script.next);
			case WindowType.RETRY:
				//todo: retry current step
			case WindowType.FINISH:
				//todo: next situation or stop simulator
			case WindowType.FIX_CONTINUE:
				if (Script.currentStep.task.type == TaskType.ASKFIX) {
					if (Script.currentStep.task.target == 'fix') {
						if (Script.currentStep.comment_success == '')
							_script.next();
						else
							updateAndShowWindow(WindowType.CONTINUE, Script.currentStep.comment_success);
					} else
						updateAndShowWindow(WindowType.CONTINUE, Script.currentStep.comment_failed);
					return;
				}
		}
	}
	
	function onWindowOpenManually(e : AppEvents) : Void {
		addBlur();
		var text : String = Script.currentStep.comment_notification;
		if (text != null && text != '') // не обновлять текст, если в текущем действии он пустой
			overlay.window.update(WindowType.CONTINUE, text);
		overlay.window.show();
	}
	
	function addBlur() : Void {
		selector.filters = [new BlurFilter(Constants.WINDOW_OVERLAY_BLUR, Constants.WINDOW_OVERLAY_BLUR, 2)];
		device.filters = [new BlurFilter(Constants.WINDOW_OVERLAY_BLUR, Constants.WINDOW_OVERLAY_BLUR, 2)];
		//overlay.notification.filters = [new BlurFilter(10, 10, 2)]; // SimpleButton.filters bug ←
		overlay.nBlurEnabled();
	}
	
	function removeBlur() : Void {
		selector.filters = [];
		device.filters = [];
		//overlay.notification.filters = []; // SimpleButton.filters bug ←
		overlay.nBlurDisabled();
	}
}