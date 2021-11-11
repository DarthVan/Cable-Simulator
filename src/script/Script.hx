package script;

import components.overlay.Overlay;
import components.window.WindowType;
import haxe.Json;
import motion.Actuate;
import openfl.Assets;
import screen.Screen;
import screen.device.Device;
import screen.device.pick.PickedObject;
import screen.selector.Selector;
import script.TaskType;

/**
 * ...
 * @author Sith
 */

class Script {
	
	public static inline var END : String = 'script_end';
	public static inline var RESET : String = 'script_reset';
	
	public static var currentStep : Step;
	
	var _passedSituationsID : Array<Int>;
	
	var _main : Main;
	var _steps : Array<Step>;
	var _currentStepIndex : Int;
	var _currentSituationIndex : Int;
	var _situationsArray : Array<Dynamic>;
	var _json : Dynamic;
	
	public function new(main : Main) {
		_main = main;
		init();
	}
	
	public function next() : Void {
		
		_main.device.mouseEnabled = true;
		_main.device.mouseChildren = true;
		
		_main.selector.mouseEnabled = true;
		_main.selector.mouseChildren = true;
		
		if (_currentStepIndex == _steps.length - 1) {
			Actuate.timer(2).onComplete(newSituation);
			return;
		}
		
		currentStep = _steps[_currentStepIndex];
		//trace('step n ' + _currentStepIndex);
		
		if (currentStep.comment_notification != null && currentStep.comment_notification != '') {
			if (currentStep.task.type == TaskType.ASKFIX)
				_main.updateAndShowWindow(WindowType.FIX_CONTINUE, Script.currentStep.comment_notification);
			else
				_main.updateAndShowWindow(WindowType.CONTINUE, currentStep.comment_notification);
		}
		
		if (currentStep.task.type == TaskType.COMMENT_SUCCESS) {
			_main.updateAndShowWindow(WindowType.NEXT, currentStep.comment_success);
		}
		
		if (currentStep.set != null) {
			for (i in 0...currentStep.set.length) {
				var setup : Setup = currentStep.set[i];
				
				applySetup(setup);
			}
		}
		
		if (currentStep.tools != null)
			_main.device.tools.activateByList(currentStep.tools);
		
		//_main.tester.updateText('action: ' + _currentStepIndex);
		
		if (_currentStepIndex < _steps.length)
			_currentStepIndex++;
		else
			reset();
		
		// new
		if (currentStep.task.type == TaskType.WAIT) {
			var duration : Float = Std.parseFloat(currentStep.task.value);
			if (duration == null || duration <= 0 || Math.isNaN(duration))
				duration = 1.0;
			
			_main.device.mouseEnabled = false;
			_main.device.mouseChildren = false;
			
			_main.selector.mouseEnabled = false;
			_main.selector.mouseChildren = false;
			
			Actuate.timer(duration).onComplete(next);
			
			//_main.tester.updateText('waiting...');
		}
		
	}
	
	// применить сетапы из следующего шага (preview)
	public function previewNextStep() : Void {
		var tmpStep : Step = currentStep;
		currentStep = _steps[_currentStepIndex];
		
		if (currentStep.set != null) {
			for (i in 0...currentStep.set.length) {
				var setup : Setup = currentStep.set[i];
				
				if (setup.ignorePreview)
					continue;
				
				applySetup(setup);
			}
		}
		
		if (currentStep.tools != null)
			_main.device.tools.activateByList(currentStep.tools);
			
		currentStep = tmpStep;
	}
	
	public function repeat() : Void {
		
	}
	
	public function reset() : Void {
		init();
		_currentStepIndex = 0;
		next();
	}
	
	public function newSituation() : Void {
		
		if (_situationsArray.length <= 0) {
			_main.device.mouseEnabled = false;
			_main.device.mouseChildren = false;
			return;
		}
		
		//var randomIndex : Int = Math.round(Math.random() * (_situationsArray.length - 1));
		var randomIndex : Int = 0;
		
		var tmpSituation : Dynamic = _situationsArray[randomIndex];
		// Std.int(Math.random() * (_situationsArray.length - 1))]; //todo: test it!
		
		trace("simulator script: now playing " + tmpSituation.title);
		
		var tmpSteps : Array<Dynamic> = tmpSituation.steps;
		
		//trace('total steps in json = ' + tmpSteps.length);
		_steps = new Array<Step>();
		
		for (i in 0...tmpSteps.length) {
			
			// test skipper
			//if (i < 21) //10 //21 //
			//	continue;
			
			var step : Step = new Step();
			
			var tmpSetup : Array<Dynamic>;
			if (tmpSteps[i].set != null) {
				tmpSetup = tmpSteps[i].set;
				var tmpArray : Array<Setup> = new Array<Setup>();
				for (j in 0...tmpSetup.length) {
					var setup : Setup = new Setup();
					setup.target = tmpSetup[j].target;
					setup.data = tmpSetup[j].data;
					setup.ignorePreview = tmpSetup[j].ignorePreview == 'true' ? true : false;
					tmpArray.push(setup);
				}
				step.set = tmpArray;
				//trace('set length = ' + tmpArray.length);
			}
			
			if (tmpSteps[i].task != null) {
				var task : Task = new Task();
				task.type = tmpSteps[i].task.type;
				task.target = tmpSteps[i].task.target;
				task.value = tmpSteps[i].task.value;
				step.task = task;
			}
			
			step.tools = tmpSteps[i].tools; // инструменты, которые должны быть доступны
			
			step.comment_success = tmpSteps[i].comment_success;
			step.comment_failed = tmpSteps[i].comment_failed;
			step.comment_notification = tmpSteps[i].comment_notification;
			
			_steps.insert(_steps.length, step);
			
			//trace('num steps = ', _steps.length);
		}
		
		_situationsArray.splice(randomIndex, 1);
		
		if (_steps.length == 0)
			return;
		
		_currentStepIndex = 0;
		
		_main.device.mouseEnabled = true;
		_main.device.mouseChildren = true;
		
		next();
	}
	
	function init() : Void {
		_json = Json.parse(Assets.getText('assets/data/situations.json'));
		_situationsArray = _json.situations;
		
		if (_json.getRandomly == 'true') {
			var rndSituations : Array<Dynamic> = new Array<Dynamic>();
			while (_situationsArray.length > 0) { //3
				var index : Int = Std.int(Math.random() * (_situationsArray.length - 0.000001)); //0  1  2
				if (index < 0)
					index = 0;
				rndSituations.push(_situationsArray[index]);
				_situationsArray.splice(index, 1);
			}
			_situationsArray = rndSituations;
		}
		
		if (_json.situationsPerPass != '' && _json.situationsPerPass != null) {
			var sitPerPass : Int = Std.parseInt(_json.situationsPerPass);
			_situationsArray.splice(sitPerPass, _situationsArray.length - sitPerPass);
		}
		
		_passedSituationsID = new Array<Int>();
		
		newSituation();
	}
	
	function applySetup(setup : Setup) : Void {
		
		// apply global
		switch (setup.target) {
			case Overlay.TITLE:
				_main.overlay.updateTitle(Std.string(setup.data));
				return;
			case Overlay.INSTRUCTIONS:
				_main.overlay.instructionSplash.updateText(Std.string(setup.data));
				return;
			case Screen.SCREEN:
				_main.showScreen(Std.string(setup.data));
				return;
			case Selector.COLUMN_STATE:
				_main.selector.updateColumnState(setup.data);
				return;
			case Device.COLUMN:
				_main.device.showColumn(setup.data);
				return;
			case RESET:
				reset();
				return;
			case END:
				// {"target":"script_end"}
				_main.device.mouseEnabled = false;
				_main.device.mouseChildren = false;
				//newSituation();
				return;
		}
		
		// apply controls setup
		var pObject : PickedObject = _main.device.column.getObject(setup.target);
		if (pObject != null)
			pObject.setData(setup.data);
	}
}