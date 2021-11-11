package components.scroller;

import components.scroller.ScrollerHandle;
import motion.Actuate;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.Rectangle;
import sith.core.mvc.view.ComplexView;

/**
 * ...
 * @author Sith
 */

class Scroller extends ComplexView {
	
	public var container(get, null) : Sprite;
	@:isVar public var currentY(get, set): Int;
	
	var _mask : Shape;
	var _handle : ScrollerHandle;
	var _handleBounds : Rectangle;
	var _bar : Bitmap;
	
	var _tweenEndY : Int;
	
	/*public function new() {
		super();
	}*/
	
	override public function destroy() : Void {
		super.destroy();
		
		container = null;
		_mask = null;
		_handle = null;
		if (_bar != null && _bar.bitmapData != null)
			_bar.bitmapData.dispose();
		_bar = null;
	}
	
	public function update() : Void {
		checkContentHeight();
	}
	
	override function init() : Void {
		super.init();
		
		_bar = new Bitmap(Assets.getBitmapData('assets/bitmap/ui/scroll_bar.png'));
		addChild(_bar);
		
		container = new Sprite();
		addChild(container);
		
		_mask = new Shape();
		addChild(_mask);
		
		container.mask = _mask;
		
		_handle = new ScrollerHandle();
		addChild(_handle);
		destroyablePool.add(_handle);
		
		_handleBounds = new Rectangle(0, 0, 0, 0);
		
		listenerPool.create('press', _handle, MouseEvent.MOUSE_DOWN, onHandlePress).activate();
		listenerPool.create('release', _handle, MouseEvent.MOUSE_UP, onHandleRelease);
		listenerPool.create('release_outside', _handle, MouseEvent.RELEASE_OUTSIDE, onHandleRelease);
		listenerPool.create('move', this, Event.ENTER_FRAME, onMouseMove);
		//listenerPool.create('wheel', this, MouseEvent.MOUSE_WHEEL, onMouseWheel).activate();
		listenerPool.create('add', container, Event.ADDED, onSomeAdd).activate();
		listenerPool.create('remove', container, Event.REMOVED, onSomeRemove).activate();
		
		width = 200;
		height = 200;
	}
	
	override function set_width(value : Float) : Float {
		super.set_width(value);
		
		updateMask();
		updateBar();
		updateHandle();
		
		_handleBounds.x = _width - _handle.width;
		_handleBounds.width = 0;
		
		return _width;
	}
	
	override function set_height(value : Float) : Float {
		super.set_height(value);
		
		updateMask();
		updateBar();
		updateHandle();
		
		_handleBounds.y = 0;
		_handleBounds.height = _height - _handle.height;
		
		return _height;
	}
	
	function onHandlePress(e : MouseEvent) : Void {
		listenerPool.activate('release');
		listenerPool.activate('release_outside');
		listenerPool.activate('move');
		listenerPool.deactivate('press');
		
		_handle.startDrag(false, _handleBounds);
	}
	
	function onHandleRelease(e : MouseEvent) : Void {
		listenerPool.deactivate('release');
		listenerPool.deactivate('release_outside');
		listenerPool.deactivate('move');
		listenerPool.activate('press');
		
		_handle.stopDrag();
	}
	
	function onMouseMove(e : Event) : Void {
		//container.y = -Std.int((_handle.y / _handleBounds.height) * (container.height - _height));
		Actuate.tween(container, 0.5, {y: -Std.int((_handle.y / _handleBounds.height) * (container.height - _height))});
	}
	
	/*function onMouseWheel(e : MouseEvent) : Void {
		if (!_handle.visible)
			return;
		container.y += e.delta * 2;
	}*/
	
	function onSomeAdd(e : Event) : Void {
		checkContentHeight();
	}
	
	function onSomeRemove(e : Event) : Void {
		checkContentHeight();
	}
	
	function updateMask() : Void {
		_mask.graphics.clear();
		_mask.graphics.beginFill(0xFF0000);
		_mask.graphics.drawRect(0, 0, _width - 10, _height);
		_mask.graphics.endFill();
	}
	
	function updateBar() : Void {
		_bar.x = _width - _bar.width;
		_bar.height = _height;
	}
	
	function updateHandle() :  Void {
		_handle.x = _width - _bar.width;
		
		//var contentYPercent : Float = -container.y / (container.height - _height);
		//_handle.y = _handleBounds.height * contentYPercent;
		var contentYPercent : Float = -_tweenEndY / (container.height - _height);
		Actuate.tween(_handle, 0.5, {y: _handleBounds.height * contentYPercent});
		
	}
	
	function checkContentHeight() : Void {
		container.graphics.clear();
		
		if (container.height > _mask.height) {
			container.graphics.beginFill(0xFF0000, 0.0);
			container.graphics.drawRect(0, 0, _mask.width, container.height + 50);
			container.graphics.endFill();
			_bar.visible = true;
			_handle.visible = true;
			updateHandle();
		} else {
			container.y = 0;
			_bar.visible = false;
			_handle.visible = false;
		}
	}
	
	function get_container() : Sprite {
		return container;
	}
	
	function get_currentY() : Int {
		return Std.int(container.y);
	}
	
	function set_currentY(value : Int) : Int {
		if (value < -(container.height - _height))
			value = -Std.int(container.height - _height);
		if (value > 0)
			value = 0;
		_tweenEndY = value;
		Actuate.tween(container, 0.5, {y: value});
		//container.y = value;
		updateHandle();
		return Std.int(container.y);
	}
}