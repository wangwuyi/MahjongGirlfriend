package game.client.map
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import game.client.module.BasePanel;

	public class BaseScene extends Sprite
	{
		private static var baseScene:BaseScene = new BaseScene();

		public static function getInstance():BaseScene
		{
			return baseScene;
		}
		
		public var uiParent:Sprite = new Sprite;
		
		public var isOnUI:Boolean = false;
		
		public function BaseScene()
		{
			addChild(uiParent);
			this.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			stage.addEventListener(Event.RESIZE, onResize);
		}
		
		private function onResize(e:Event):void
		{
			var index:int;
			var len:int = uiParent.numChildren;
			while (index < len)
			{
				var child:DisplayObject = uiParent.getChildAt(index);
				if (child is BasePanel)
				{
					(child as BasePanel).onResize();
				}
				index++;
			}
		}
	}
}
