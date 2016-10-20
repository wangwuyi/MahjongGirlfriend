package game.client.module
{
	import com.greensock.TweenLite;
	import com.greensock.plugins.TransformAroundCenterPlugin;
	import com.greensock.plugins.TransformAroundPointPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	
	import game.client.manager.StageManager;
	import game.client.map.BaseScene;
	import game.client.model.GlobalModel;
	import game.client.module.ui.broadcast.Alert;
	import game.client.module.ui.mainMenu.MainMenuPanel;
	import game.client.resource.ResourcePath;
	import game.client.utils.GlowTween;
	import game.client.utils.UIUtil;
	import game.component.Button;
	import game.component.Component;
	import game.component.Image;
	import game.component.Panel;
	import game.core.manager.SoundManager;
	import game.core.utils.MassLoader;
	import game.core.utils.Tween;

	public class BasePanel extends Panel
	{
		
		private var _uiParent:DisplayObjectContainer = BaseScene.getInstance().uiParent;
		
		private var _visible:Boolean = false;
		private var isLoad:Boolean = false;
		public function BasePanel()
		{
			TweenPlugin.activate([TransformAroundPointPlugin]);
			TweenPlugin.activate([TransformAroundCenterPlugin]);
			addListener();
		}
		
		private function addListener():void
		{
			this.addEventListener(MouseEvent.MOUSE_DOWN, onDownPanel);
		}
		
		private function onDownPanel(evt:MouseEvent):void
		{
			evt.stopPropagation();
		}
		
		public override function set visible(value:Boolean):void
		{
			if(value){
				doChangeVisiblity(value);
			}else{
				if(closeeffect && name !=null && name.length > 0){
					closeShow(name);
				}else{
					doChangeVisiblity(value);
				}
			}
		}
		
		public override function get visible():Boolean
		{
			return _visible;
		}
		
		protected function doChangeVisiblity(value:Boolean):void
		{
			super.visible = value;
			if(_visible == value)
			{
				return;
			}
			_visible = value;
			if(isLoad == false)
			{
				loadSwf();
				return;
			}
			if (_visible == true)
			{
				show();
				onResize();
			}
			else
			{
				if(this.parent == uiParent)
				{
					uiParent.removeChild(this);
				}
			}
			finishInitSkin(_visible);
		}
		
		public function clearTxtFilter(displayObject:DisplayObject):void
		{
			if(displayObject is Component)
			{
				var component:Component = displayObject as Component;
				var num:int = component.numChildren;
				var displayObj:DisplayObject;
				for(var i:int = 0; i < num; i++)
				{
					displayObj = component.getChildAt(i);
					if(displayObj is Component)
					{
						clearTxtFilter(displayObj);
					}
				}
			}
		}
		
		private function getCoexistChildByName(name:String):DisplayObject
		{
			var len:int = uiParent.numChildren;
			var index:int = 0;
			while(index < len)
			{
				var child:DisplayObject = uiParent.getChildAt(index);
				if(child.name == name)
				{
					return child;
				}
				index++;
			}
			return null;
		}
		
		private function show():void
		{
			if(this.parent == null)
			{
				uiParent.addChild(this);
			}
		}
		
		private function loadSwf():void
		{
			MassLoader.add(ResourcePath.UI + name +".swf",loadComplete,null,null,null,loadIOError,MassLoader.HIGH,Component.domain);
		}
		
		private function loadComplete(info:Object):void
		{
			isLoad = true;
			show();
			onResize();
			configClose();
			finishInitSkin(_visible);
			configSkin(this);
		}
		
		protected function finishInitSkin(value:Boolean):void
		{
		
		}
		private function configClose():void
		{
			var closeBtn:DisplayObject = getChildByName("close");
			if(closeBtn != null)
			{
				closeBtn.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void
				{
					SoundManager.play("min",1);
					visible = false;
				});
			}
		}
		
		protected function getBaseCloseBtn():Button
		{
			return getChildByName("close") as Button;
		}
		
		private function loadIOError(info:Object):void
		{
			Alert.show("加载" + info.url + "出错");
			//测试用
			isLoad = true;
			show();
			onResize();
			configClose();
		}
		
		public function onResize():void
		{
			this.x = (GlobalModel.stage.stageWidth - this.width) >> 1;
			this.y = (GlobalModel.stage.stageHeight - this.height) >> 1;
			if(hasLeftPanel() == true)
			{
				resizeAsRight();
			}
			else if(hasRightPanel() == true)
			{
				resizeAsLeft();
			}
		}
		
		protected function getIsLoaded():Boolean
		{
			return isLoad;
		}
		
		private function hasRightPanel():Boolean
		{
			var rightArr:Array = PanelCoexistConfig.leftDic[this.name];
			if(rightArr != null)
			{
				return true;
			}
			return false;
		}
		
		private function hasLeftPanel():Boolean
		{
			var leftArr:Array = PanelCoexistConfig.rightDic[this.name];
			if(leftArr != null)
			{
				return true;
			}
			return false;
		}
		
		protected function resizeAsLeft():void
		{
			var arr:Array = PanelCoexistConfig.leftDic[this.name];
			for each(var str:String in arr)
			{
				var rightPanel:Panel = getCoexistChildByName(str) as Panel;
				if(rightPanel && rightPanel.visible == true)
				{
					var currentMid:int = (StageManager.stage.stageWidth - this.width) >> 1;
					Tween.to(this, 200, {x:[this.x, currentMid - (this.width >> 1)]});
					var rightMid:int = (StageManager.stage.stageWidth - rightPanel.width) >> 1;
					Tween.to(rightPanel, 200, {x:[rightPanel.x, rightMid + (rightPanel.width >> 1)]});
					UIUtil.shiftToTop(rightPanel);
					return;
				}
			}
		}
		
		protected function resizeAsRight():void
		{
			var arr:Array = PanelCoexistConfig.rightDic[this.name];
			for each(var str:String in arr)
			{
				var leftPanel:Panel = getCoexistChildByName(str) as Panel;
				if(leftPanel && leftPanel.visible == true)
				{
					var currentMid:int = (StageManager.stage.stageWidth - this.width) >> 1;
					Tween.to(this, 200, {x:[this.x, currentMid + (this.width >> 1)]});
					var leftMid:int = (StageManager.stage.stageWidth - leftPanel.width) >> 1;
					Tween.to(leftPanel, 200,{x:[leftPanel.x, leftMid - (leftPanel.width >> 1)]});
					UIUtil.shiftToTop(leftPanel);
					return;
				}
			}
		}
		
		private function closeShow(panelName:String):void{
			var button:Component = MainMenuPanel.instance.mainMenuHashMap.get(panelName);
			if(button!=null){
				var curBounds:Rectangle=button.getBounds(button.root);
				TweenLite.to(this, 0.2, {transformAroundPoint:{point:new Point(curBounds.x+(button.width>>1),curBounds.y+(button.height>>1)), scaleX:0.1, scaleY:0.1}, onComplete:closeComplete, onCompleteParams:[button]});
			}else{
				TweenLite.to(this, 0.2, {transformAroundCenter:{scaleX:0.1, scaleY:0.1}, onComplete:closeComplete, onCompleteParams:[null]});
			}
		}
		
		private var glowTweenCache:Array = [];
		private var glowTween:GlowTween;
		
		private function closeComplete(target:Component):void{
			doChangeVisiblity(false);
			this.scaleX = 1;
			this.scaleY = 1;
			if(target!=null){
				glowTween = glowTweenCache.shift() as GlowTween;
				if(glowTween == null){
					glowTween = new GlowTween();
				}
				glowTween.startGlow(target, 0xffff00, 0.8);
				setTimeout(stopGlow,200);
			}
		}
		
		private function stopGlow():void {
			if (glowTween) {
				glowTween.stopGlow();
				glowTweenCache.push(glowTween);
			}
		}
		
		public function set uiParent(value:DisplayObjectContainer):void
		{
			this._uiParent = value;
		}
		
		public function get uiParent():DisplayObjectContainer
		{
			return _uiParent;
		}
		
		public function panelEntry(e:MouseEvent=null):void
		{
			SoundManager.play("min",1);
			this.visible = !this.visible;
		}
		
		private function configSkin(component:Component):void
		{
			var len:int = component.numChildren;
			var index:int = 0;
			while(index < len)
			{
				var child:DisplayObject = component.getChildAt(index);
				if(child is Component)
				{
					configSkin(child as Component);
				}
				else if(child is Image)
				{
					(child as Image).configSkin();
				}
				index++;
			}
		}

	}
}