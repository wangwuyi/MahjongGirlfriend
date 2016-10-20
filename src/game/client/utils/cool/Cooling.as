package game.client.utils.cool
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*;

	/**
	 * 冷却
	 * @author an
	 *
	 */
	public class Cooling extends Bitmap
	{
		public var color:uint;
		private var transformAngle:Number;
		public var startFrom:Number=0;
		private var postTime:Number=0;
		public var totalTime:Number=0;
		public var beginTime:Number=0;
		private var alreadyAngle:Number=0;
		public var running:Boolean=false;
		private var slices:Dictionary;

		public function Cooling(bw:Number, bh:Number, radius:Number=30)
		{
			var cd:CD;
			var index:int;
			var bitmapData:BitmapData;
			var matrix:Matrix;
			if (slices == null)
			{
				slices=new Dictionary();
				cd=new CD(bw, bh, radius);
				index=1;
				while (index <= 180)
				{
					cd.draw(360 - 2 * index);
					cd.cacheAsBitmap=true;
					bitmapData=new BitmapData(bw, bh, true, 0);
					matrix=new Matrix();
					matrix.tx=bw/2;
					matrix.ty=bh/2;
					bitmapData.draw(cd, matrix);
					slices[index]=bitmapData;
					index++;
				}
			}
		}

		public function getStandardAngle():Number
		{
			return this.alreadyAngle + this.startFrom;
		}

		public function stop():void
		{
			if (hasEventListener(Event.ENTER_FRAME))
			{
				removeEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
			}
			this.running=false;
		}

		public function start(totalTime:Number, startFrom:Number=0):void
		{
			this.startFrom=startFrom;
			this.changeAngle();
			this.totalTime=totalTime;
			this.beginTime=getTimer();
			this.running=true;
			this.drawSlice(startFrom);
			if (!hasEventListener(Event.ENTER_FRAME))
			{
				addEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
			}
		}

		private function changeAngle():void
		{
			if (this.startFrom < 0)
			{
				this.transformAngle=this.startFrom + 90;
			}
			else
			{
				this.transformAngle=this.startFrom - 90;
			}
		}

		private function drawSlice(value:Number):void
		{
			var number:int=value / 2;
			bitmapData=slices[number];
		}

		public function setTarget(display:DisplayObject):void
		{
			this.x=display.x;
			this.y=display.y;
			display.parent.addChildAt(this, display.parent.getChildIndex(display) + 1);
		}

		private function enterFrameHandler(event:Event):void
		{
			var startFrom:int;
			var number:Number;
			this.postTime=getTimer() - this.beginTime;
			if (this.postTime >= this.totalTime)
			{
				removeEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
				bitmapData=null;
				this.running=false;
				dispatchEvent(new Event(Event.COMPLETE));
			}
			else
			{
				startFrom=360 - this.startFrom;
				number=startFrom * this.postTime / this.totalTime;
				this.alreadyAngle=number;
				this.drawSlice(number + this.startFrom);
			}
		}

		public function getRestTime():int
		{
			return this.totalTime - this.postTime;
		}

	}
}
