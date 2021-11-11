package screen.device;

import motion.Actuate;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import screen.device.ColumnType;
import screen.device.columns.BasicColumn;
import screen.device.columns.Column_A;
import screen.device.columns.Column_AB;
import screen.device.columns.Column_A_Meters;
import screen.device.columns.Column_B1_Inside;
import screen.device.columns.Column_B1_Outside;
import screen.device.columns.Column_B1_Pullout;
import screen.device.columns.Column_B1_Test;
import screen.device.tools.Tools;

/**
 * ...
 * @author Sith
 */

class Device extends Screen {
	
	public static inline var COLUMN : String = 'column';
	
	public var tools(get, null) : Tools;
	
	public var column(get, null) : BasicColumn;
	
	var _container : Sprite;
	var _currentType : String;
	var _bitmap : Bitmap;
	
	public function new() {
		super();
	}
	
	override function init() : Void {
		super.init();
		
		_container = new Sprite();
		addChild(_container);
		
		tools = new Tools();
		tools.x = 1260;
		tools.y = 60;
		addChild(tools);
		
	}
	
	public function showColumn(data : Dynamic) : Void {
		var type : String = Std.string(data.type);
		var smoothing : Bool = data.smoothing == 'true' ? true : false;
		
		if (type == _currentType)
			return;
		
		_currentType = type;
		
		if (column != null) {
			disposeTmpBitmap();
			
			if (smoothing) {
				_bitmap = new Bitmap(column.drawBitmapData(240, 0, 960, 790));
				_bitmap.x = 240;
				_bitmap.alpha = 1.0;
				addChild(_bitmap);
			}
			
			column.destroy();
			column = null;
			
			if (smoothing)
				Actuate.tween(_bitmap, 0.75, {alpha: 0.0}).onComplete(disposeTmpBitmap);
		}
		
		switch (type) {
			case ColumnType.A1 :
			case ColumnType.A :
				column = new Column_A();
			case ColumnType.A_METERS:
				column = new Column_A_Meters();
			case ColumnType.AB :
				column = new Column_AB();
			case ColumnType.B :
			case ColumnType.B1_INSIDE :
				column = new Column_B1_Inside();
			case ColumnType.B1_OUTSIDE :
				column = new Column_B1_Outside();
			case ColumnType.B1_TEST :
				column = new Column_B1_Test();
			case ColumnType.B1_PULLOUT :
				column = new Column_B1_Pullout();
		}
		
		_container.addChild(column);
		
		if (smoothing) {
			column.alpha = 0.0;
			Actuate.tween(column, 0.75, {alpha: 1.0});
		}
	}
	
	public function disposeTmpBitmap() : Void {
		if (_bitmap != null && _bitmap.bitmapData != null) {
			removeChild(_bitmap);
			_bitmap.bitmapData.dispose();
			_bitmap.bitmapData = null;
		}
		_bitmap = null;
	}
	
	// Getters ================================================================================
	
	function get_column() : BasicColumn {
		return column;
	}
	
	function get_tools() : Tools {
		return tools;
	}
	
}