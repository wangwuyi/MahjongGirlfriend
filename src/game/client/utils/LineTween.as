package game.client.utils
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import game.core.utils.Timer;

	public class LineTween
	{
		private var _target:Sprite;
		private var _targetWidth:Number;
		private var _targetHeight:Number;
		private var currentFrame:int;
		
		public function startRectLine(target:Sprite):void
		{
			if(target==null)return;
			_target = target;
			_targetWidth = _target.width;
			_targetHeight = _target.height;
			Timer.add(run);
		}
		
		public function startRectLineByWH(target:Sprite, width:Number, height:Number):void{
			if(target==null)return;
			_target = target;
			_targetWidth = width;
			_targetHeight = height;
			Timer.add(run);
		}
		
		private function run(now:int):void{
			currentFrame++;
			if (currentFrame > 210)
			{
				currentFrame=0;
			}
			if(currentFrame%10 == 0){
				_target.graphics.clear();
				_target.graphics.lineStyle(2,Math.random()*0xFFFFFF);
				_target.graphics.moveTo(0, 0);
				_target.graphics.drawRect(0, 0, _targetWidth, _targetHeight);
			}
		}
		
		/**
		 * 清除线条
		 */				
		public function clearLine():void{
			if(_target){
				Timer.remove(run);
				_target.graphics.clear();
				_target = null;
			}
		}
	}
}