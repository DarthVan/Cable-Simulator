package components.scroller;

import openfl.Assets;
import openfl.display.Bitmap;
import sith.core.mvc.view.BasicView;

/**
 * ...
 * @author Sith
 */

class ScrollerHandle extends BasicView {
	
	var _bitmap : Bitmap;
	
	/*public function new() {
		super();		
	}*/
	
	override public function destroy() : Void {
		super.destroy();
		
		if (_bitmap != null || _bitmap.bitmapData != null)
			_bitmap.bitmapData.dispose();
		_bitmap = null;
	}
	
	override function init() : Void {
		super.init();
		
		_bitmap = new Bitmap(Assets.getBitmapData('assets/bitmap/ui/scroll_handle.png'));
		addChild(_bitmap);
		
		width = _bitmap.width;
		height = _bitmap.height;
		
		mouseEnabled = true;
		buttonMode = true;
	}
}