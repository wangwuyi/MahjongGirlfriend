package game.core.gameUnit.role
{
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import game.core.manager.ResourceManager;
	import game.core.utils.Tween;
	
	public class HitNumber extends Sprite
	{
		private static function range(num1:Number, num2:Number):Number
		{
			var num:Number=Math.random()*(num2 - num1 + 1) + num1;
			return num=Math.floor(num);
		}

		private static var pool:Array = [];
		
		public static function get instance():HitNumber
		{
			return pool.length ? pool.shift() : new HitNumber();
		}
		
		private static var numPool:Vector.<Bitmap> = new Vector.<Bitmap>();
		
		public static function getNum():Bitmap
		{
			return numPool.length ? numPool.shift() : new Bitmap();
		}
		
		public function HitNumber()
		{
			this.mouseEnabled = false;
			this.mouseChildren = false;
		}
		
		private var heavyHit:int;
		private var yStart:int;
		
		public function init(isMiss:Boolean, type:int, hp:int, heavyHit:int, isHero:Boolean):void
		{
			var url:String = "assets/image/hitNum/";
			if (isMiss)
			{
				var duoshan:Bitmap = getNum();
				ResourceManager.getBitmap(duoshan, url + (isHero ? "hong" : "huang") + ".png");
				addChild(duoshan);
			}
			else
			{
				var prefix:String;
				if (heavyHit == 1)
				{
					prefix = "da";
					var baoji:Bitmap = getNum();
					ResourceManager.getBitmap(baoji, url + (isHero ? "hong" : "huang") + ".png");
					baoji.x = 0;
					baoji.y = -10;
					addChild(baoji);
				}
				else
				{
					prefix = "xiao";
				}
				
				var jiajian:Bitmap = getNum();
				if (hp > 0)
				{
					ResourceManager.getBitmap(jiajian, url + (isHero ? "hong" : "huang") + "jian.png");
				}
				else if (hp < 0)
				{
					ResourceManager.getBitmap(jiajian, url + "lvjia.swf");
				}
				if (numChildren > 0)
				{
					var last:Bitmap = getChildAt(numChildren - 1) as Bitmap;
					jiajian.x = last.x + last.width;
				}
				else
				{
					jiajian.x = 0;
				}
				jiajian.y = -2;
				if (hp)
				{
					addChild(jiajian);
				}
				var hurt:String = hp ? String(Math.abs(hp)) : "";
				for (var i:int = 0; i < hurt.length; i++)
				{
					var num:Bitmap = getNum();
					var str:String;
					if (hp > 0)
					{
						str = prefix + (isHero ? "hong" : "huang");
					}
					else
					{
						str = "lv";
					}
					ResourceManager.getBitmap(num, url + str + hurt.charAt(i) + ".png");
					if (numChildren > 0)
					{
						last = getChildAt(numChildren - 1) as Bitmap;
						//第一次资源还未载入的时候，使用默认的宽度30.
						var gap:int = 24;
						num.x = last.x + gap - 5;
						num.y = 0;
					}
					else
					{
						num.x = 0;
						num.y = 0;
					}
					addChild(num);
				}
			}
			x = -(width >> 1) + range(-20,20);
			yStart = range(-5,5);
			this.heavyHit = heavyHit;
		}
		
		public function start():void
		{
			if (heavyHit == 1)
			{
				Tween.to(this, 350, {y: [yStart - 100, yStart - 160]}, step1);
			}
			else
			{
				Tween.to(this, 350, {y: [yStart - 100, yStart - 160]}, step1);
			}
		}
		
		private function step1():void
		{
			if (heavyHit == 1)
			{
				Tween.to(this, 650, {y: [yStart - 160, yStart - 200], alpha: [1, 0]}, dispose);
			}
			else
			{
				Tween.to(this, 650, {y: [yStart - 160, yStart - 200], alpha: [1, 0]}, dispose);
			}
		}
		
		public function dispose():void
		{
			if (parent)
			{
				parent.removeChild(this);
			}
			while (numChildren)
			{
				numPool.push(removeChildAt(0));
			}
			this.alpha = 1;
			x = 0;
			y = 0;
			pool.push(this);
		}
	}
}
