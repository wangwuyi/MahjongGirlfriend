package game.client.module.tip
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import game.client.manager.SingletonFactory;
	import game.client.model.GlobalModel;
	import game.client.utils.UIUtil;

	public class TipManager
	{
		private static var _currentTip:ITip;
		private static var _tipObj:TipBindObject;
		private static var _tipParent:Sprite;
		private static var _targetObj:DisplayObject;
		private static var _targetDic:Dictionary;
		private static var _timeId:int;
		init();
		
		private static function init():void
		{
			initParent();
			addListener();
			initDic();
		}
		
		private static function initParent():void
		{
			_tipParent = new Sprite();
			GlobalModel.stage.addChild(_tipParent);
		}
		
		private static function addListener():void
		{
			GlobalModel.stage.addEventListener(MouseEvent.MOUSE_MOVE, onGridMouseMove);
		}
		
		private static function initDic():void
		{
			_targetDic = new Dictionary()
		}
		
		public static function bind(userData:Object, target:DisplayObject, tipClass:Class = null, overFn:Function = null, outFn:Function = null):void
		{
			var obj:TipBindObject = new TipBindObject();
			obj.target = target;
			obj.userData = userData;
			if(tipClass == null)
			{
				tipClass = CommonTip;
			}
			obj.tipClass = tipClass;
			obj.isShowClose = false;
			obj.isPosition = false;
			obj.overFun = overFn != null ? overFn : showTip;
			obj.outFun = outFn != null ? outFn : hide;
			_targetDic[target] = obj;
			
			target.addEventListener(MouseEvent.MOUSE_OVER, onTargetOver);
			target.addEventListener(MouseEvent.MOUSE_OUT, onTargetOut);
		}
		
		/**
		 * 将Tip显示在指定位置 
		 * @param userData
		 * @param x
		 * @param y
		 * @param isShowClose
		 * @param tipClass
		 * @param overFn
		 * @param outFn
		 * 
		 */		
		public static function bindByPosition(userData:Object, x:int, y:int, isShowClose:Boolean = true, tipClass:Class = null, overFn:Function = null, outFn:Function = null):void
		{
			var obj:TipBindObject = new TipBindObject();
			obj.userData = userData;
			if(tipClass == null)
			{
				tipClass = CommonTip;
			}
			obj.tipClass = tipClass;
			obj.isPosition = true;
			obj.x = x;
			obj.y = y;
			obj.isShowClose = isShowClose;
			showTip(obj);
		}
		
		public static function unBind(target:DisplayObject):void
		{
			for(var keyTarget:Object in _targetDic)
			{
				if(keyTarget == target)
				{
					removeListener(target);
					_targetDic[target] = null
					delete _targetDic[target];
				}
			}
		}
		
		private static function removeListener(target:DisplayObject):void
		{
			target.removeEventListener(MouseEvent.MOUSE_OVER, onTargetOver);
			target.removeEventListener(MouseEvent.MOUSE_OUT, onTargetOut);
		}
		
		private static function onTargetOver(evt:MouseEvent):void
		{
			var target:Object = evt.target;
			var obj:Object = _targetDic[target];
			if(obj != null && obj.userData !=null)
			{
				_timeId = setTimeout(obj.overFun, 200, obj);
			}
			evt.stopPropagation();
		}
		
		private static function onTargetOut(evt:MouseEvent):void
		{
			var target:Object = evt.target;
			var obj:Object = _targetDic[target];
			if(obj != null)
			{
				clearTimeout(_timeId);
				obj.outFun(obj);
			}
			evt.stopPropagation();
		}
		
		private static function showTip(obj:Object):void
		{
			if(obj is TipBindObject)
			{
				_targetObj = (obj as TipBindObject).target;
				_currentTip = SingletonFactory.createObject((obj as TipBindObject).tipClass) as ITip;
				/*if((_currentTip is EquipTip) == false)
				{
					_currentTip.setClose(obj.isShowClose);
				}*/
				if(obj.isPosition == true)
				{
					setTipPosition(obj.x, obj.y);
				}
				else
				{
					tradeTipTarget();
				}
				configTip(obj);
			}
		}
		
		private static function configTip(obj:Object):void
		{
			(_currentTip as Tip).tipBindObject = obj as TipBindObject;
			_tipParent.addChild(_currentTip as DisplayObject);
			_currentTip.show();
		}
		
		public static function showUpdateDataTip(target:Object,updateData:Object):void{
			var obj:Object = _targetDic[target];
			if(obj != null)
			{
				obj.userData = updateData;
				_targetDic[target] = obj;
			}
			showTip(obj);
		}
		
		public static function hide(obj:Object = null):void
		{
			if(_currentTip != null)
			{
				(_currentTip as Tip).tipBindObject.needShowClose = false;
				_currentTip.hide();
			}
			UIUtil.closeWindow(_currentTip as DisplayObject);
			_currentTip = null;
			_targetObj = null;
			_tipObj = null;
		}
		
		private static function onGridMouseMove(evt:MouseEvent):void
		{
			if(_targetObj == null || _currentTip == null)
			{
				return;
			}
			if(_tipObj != null)
			{
				if(_tipObj.needShowClose == true)
				{
					return;
				}
			}
			var bound:Rectangle = _targetObj.getRect(_targetObj.root);
			var stage:Stage = GlobalModel.stage;
			if(stage.mouseX > bound.left && stage.mouseX < bound.right
			&& stage.mouseY > bound.top && stage.mouseY < bound.bottom)
			{
				tradeTipTarget();
			}
		}
		
		private static function tradeTipTarget():void
		{
			var stage:Stage = GlobalModel.stage;
			var px:int = stage.mouseX + 10;
			var py:int = stage.mouseY;
			setTipPosition(px, py);
		}
		
		private static function setTipPosition(px:int, py:int):void
		{
			var stage:Stage = GlobalModel.stage;
			var displayObj:DisplayObject = _currentTip as DisplayObject;
			if(px + displayObj.width > stage.stageWidth)
			{
				px = stage.mouseX - (displayObj.width+10);
			}
			if(py + displayObj.height > stage.stageHeight)
			{
				py = stage.stageHeight - displayObj.height;
			}
			if(py < 0)
			{
				py = 0;
			}
			(displayObj as DisplayObject).x = px;
			(displayObj as DisplayObject).y = py;
		}
	}
}