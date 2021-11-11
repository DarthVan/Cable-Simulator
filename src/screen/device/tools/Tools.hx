package screen.device.tools;

import components.info.ArrowInfo;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.events.TimerEvent;
import openfl.media.Sound;
import openfl.utils.Timer;

/**
 * ...
 * @author Sith
 */

class Tools extends Sprite {
	
	public static var PICKED_TOOL : String;
	
	var _tools : Array<Tool>;
	var _info : ArrowInfo;
	
	var _draggedTool : DraggedTool;
	var _timer : Timer;
	
	static var TOOLS_PAD : Int = 0;
	
	public function new() {
		super();
		init();
	}
	
	public function returnTool(type : String) : Void {
		switch (type) {
			case ToolType.HANDLE:
				_tools[0].visible = true;
			case ToolType.PADLOCK:
				_tools[1].visible = true;
			case ToolType.KEY:
				_tools[2].visible = true;
			case ToolType.TABLE:
				_tools[3].visible = true;
		}
		
		stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUP);
		stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		addEventListener(MouseEvent.MOUSE_DOWN, onSomeToolMouseDown);
		
		_draggedTool.clear();
		_timer.reset();
		PICKED_TOOL = '';
	}
	
	public function activateByList(array : Array<String>) : Void {
		for (i in 0...array.length)
			for (j in 0..._tools.length)
				if (array[i] == _tools[j].type)
					_tools[j].visible = true;
	}
	
	function init() : Void {
		
		_info = new ArrowInfo('↓', 'Нажмите на элемент и далее перетащите его на панель');
		_info.x = 60;
		_info.y = 0;
		addChild(_info);
		
		_tools = new Array<Tool>();
		
		useHandCursor = true;
		
		var handle : Tool = new Tool(ToolType.HANDLE, new Bitmap(Assets.getBitmapData('assets/bitmap/device/tools/tool_handle.png'), null, true));
		_tools.insert(0, handle);
		
		var padlock : Tool = new Tool(ToolType.PADLOCK, new Bitmap(Assets.getBitmapData('assets/bitmap/device/tools/tool_padlock.png'), null, true));
		_tools.insert(1, padlock);
		
		var key : Tool = new Tool(ToolType.KEY, new Bitmap(Assets.getBitmapData('assets/bitmap/device/tools/tool_key.png'), null, true));
		_tools.insert(2, key);
		
		var table : Tool = new Tool(ToolType.TABLE, new Bitmap(Assets.getBitmapData('assets/bitmap/device/tools/tool_table.png'), null, true));
		_tools.insert(3, table);
		
		var yStart : Int = 60;
		for (i in 0..._tools.length) {
			_tools[i].x = 0;
			_tools[i].y = yStart;
			yStart += Std.int(_tools[i].height) + TOOLS_PAD;
			addChild(_tools[i]);
		}
		
		_draggedTool = new DraggedTool();
		addChild(_draggedTool);
		
		PICKED_TOOL = '';
		
		_timer = new Timer(25, 1);
		_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
		
		addEventListener(MouseEvent.MOUSE_DOWN, onSomeToolMouseDown);
	}
	
	function onSomeToolMouseDown(e : MouseEvent) : Void {
		removeEventListener(MouseEvent.MOUSE_DOWN, onSomeToolMouseDown);
		
		/*var sound : Sound = Assets.getSound('assets/sound/pick.mp3');
		sound.play();*/
		
		var type : String = cast(e.target, Tool).type;
		PICKED_TOOL = type;
		switch (type) {
			case ToolType.HANDLE:
				_tools[0].visible = false;
				_draggedTool.update(Assets.getBitmapData('assets/bitmap/device/tools/tool_handle.png'));
			case ToolType.PADLOCK:
				_draggedTool.update(Assets.getBitmapData('assets/bitmap/device/tools/tool_padlock.png'));
			case ToolType.KEY:
				//_tools[2].visible = false;
				_draggedTool.update(Assets.getBitmapData('assets/bitmap/device/tools/tool_key.png'));
			case ToolType.TABLE:
				_draggedTool.update(Assets.getBitmapData('assets/bitmap/device/tools/tool_table.png'));
		}
		
		_draggedTool.x = mouseX;
		_draggedTool.y = mouseY;
		
		stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		_timer.start();
	}
	
	function onTimerComplete(e : TimerEvent) : Void {
		stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUP);
	}
	
	function onMouseMove(e : MouseEvent) : Void {
		_draggedTool.x = mouseX;
		_draggedTool.y = mouseY;
	}
	
	function onStageMouseUP(e : MouseEvent) : Void {
		trace('Release');
		stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUP);
		stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		addEventListener(MouseEvent.MOUSE_DOWN, onSomeToolMouseDown);
		
		_draggedTool.clear();
		_timer.reset();
		
		returnTool(PICKED_TOOL);
		
		PICKED_TOOL = '';
	}
}