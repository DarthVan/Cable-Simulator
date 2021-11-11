package screen.selector;

import components.info.ArrowInfo;
import event.AppEvents;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.errors.Error;
import screen.device.pick.PickData;
import screen.selector.SelectorColumn;
import sith.core.mvc.view.BasicView;

/**
 * ...
 * @author Sith
 */

class Selector extends BasicView {
	
	var _columns : Array<SelectorColumn>;
	var _info : ArrowInfo;
	
	public static inline var COLUMN_STATE : String = 'column_state';
	static inline var PATH : String = 'assets/bitmap/selector/';
	
	override public function destroy() : Void {
		super.destroy();
		
		// destroy all
	}
	
	public function updateColumnState(data : Dynamic) : Void {
		var id : String = Std.string(data.id);
		var url : String = Std.string(data.url);
		if (id == null || id == '' || url == null || url == '') {
			throw new Error(this + ': id or url are null or undefined!');
			return;
		}
		
		for (i in 0..._columns.length) {
			if (id == _columns[i].id) {
				var bitmapData : BitmapData = Assets.getBitmapData(PATH + url);
				if (bitmapData == null)
					return;
				_columns[i].update(bitmapData);
				return;
			}
		}
	}
	
	override function init() : Void {
		super.init();
		
		_columns = new Array<SelectorColumn>();
		_columns.insert(0, new SelectorColumn('A1', Assets.getBitmapData('assets/bitmap/selector/situation_1/state_1/colonna_A1.png'), onSomeOver, onSomePick, onSomeOut));
		_columns.insert(1, new SelectorColumn('A', Assets.getBitmapData('assets/bitmap/selector/situation_1/state_1/colonna_A.png'), onSomeOver, onSomePick, onSomeOut));
		_columns.insert(2, new SelectorColumn('AB', Assets.getBitmapData('assets/bitmap/selector/situation_1/state_1/colonna_AB.png'), onSomeOver, onSomePick, onSomeOut));
		_columns.insert(3, new SelectorColumn('B', Assets.getBitmapData('assets/bitmap/selector/situation_1/state_1/colonna_B.png'), onSomeOver, onSomePick, onSomeOut));
		_columns.insert(4, new SelectorColumn('B1', Assets.getBitmapData('assets/bitmap/selector/situation_1/state_1/colonna_B1.png'), onSomeOver, onSomePick, onSomeOut));
		
		var xstart : Int = 200;
		for (i in 0..._columns.length) {
			_columns[i].x = xstart;
			xstart += Std.int(_columns[i].width);
			_columns[i].y = 120;
			//addChild(_columns[i]);
		}
		
		var i : Int = _columns.length - 1;
		while (i >= 0) {
			addChild(_columns[i]);
			i--;
		}
		
		_info = new ArrowInfo('←', 'Выберите колонну для операций', 1250, 50);
		addChild(_info);
	}
	
	function onSomeOver(id : String) : Void {
		
	}
	
	function onSomePick(id : String) : Void {
		stage.dispatchEvent(new AppEvents(AppEvents.OBJECT_PICKED, new PickData(id, null, '', '')));
	}
	
	function onSomeOut() : Void {
		
	}
}