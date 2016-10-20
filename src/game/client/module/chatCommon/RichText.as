package game.client.module.chatCommon
{
	
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.TextEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import game.client.module.ui.chat.ChatConstant;
	import game.component.Label;
	import game.core.gameUnit.magic.Effect;
	
	public class RichText extends Sprite
	{
		private static const FACE_NUM:int = 4;
		private static const TOKEN_LEFT:String = "【";
		private static const TOKEN_RIGHT:String = "】";
		
		private static const key:String = String.fromCharCode(3);
		private static const space:String = "   ";
		private var listFace:Array = [];
		private var text:Label = new Label();
		
		public function RichText()
		{
			text.selectable = false;
			text.mouseEnabled = true;
			text.width = 235;
			text.wordWrap = true;
			text.multiline = true;
			text.leading = 5;
			text.addEventListener(TextEvent.LINK,ChatConstant.onTextEventLink);
			addChild(text);
		}
	
		public function get textField():Label
		{
			return text;
		}
		
		public override function set width(value:Number):void
		{
			text.width = value;
		}
		
		public override function get width():Number
		{
			return text.width;
		}
		
		public override function set height(value:Number):void
		{
			text.height = value;
		}
		
		public override function get height():Number
		{
			return text.height;
		}
		
		public  function get textWidth():Number
		{
			return text.textWidth;
		}
		
		public function get textHeight():Number
		{
			return text.textHeight;
		}
		
		public function set htmlText(value:String):void
		{
			if(value==null||value==""){
				return;
			}
			var result:String = value;
			text.htmlText = result;
			var tokenRect:Rectangle = findTokenBoundary(text);
			fillTokenBoundary(tokenRect);
			result = replaceToken(result);
			
			while (listFace.length)
			{
				listFace.pop().dispose();
			}
			
			var start:int = 0;
			var index:int;
			while (1)
			{
				index = result.indexOf("$", start);
				if (index == -1)
					break;
				var code:String = result.substr(index, 3);
				var face:int = Face.list.indexOf(code);
				if (face != -1)
				{
					if(listFace.length == FACE_NUM)
					{
						result = result.substr(0, index) + result.substr(index+3);
						continue;
						break;
					}
					var effect:FaceEffect = new FaceEffect(); 
					effect.setIndex(face + 1);
					addChild(effect);
					listFace.push(effect);
					result = result.substr(0, index) + key + space + result.substr(index+3);
				}
				start = index + 1;
			}
			
			text.htmlText = result;
			var k:int = 0;
			start = 0;
			var storeHeight:Number = text.height;
			while (1)
			{
				index = text.text.indexOf(key, start);
				if (index == -1)
					break;
//				text.height = text.textHeight;
				var rect:Rectangle = text.getCharBoundaries(index);
//				text.height = storeHeight;
				if (rect)
				{
					effect = listFace[k];
					effect.x=rect.x + 11;
					effect.y = rect.y + 6;
				}
				else
				{
					index = index + 1;
					rect =  text.getCharBoundaries(index);
					if(rect)
					{
						effect = listFace[k];
						effect.x=rect.x + 11;
						effect.y = rect.y + 6;
					}
				}
				start = index + 1;
				k++;
			}
			var textHeight:int = text.textHeight;
			while(result.indexOf(key) > -1)
			{
				result = result.replace(key, "		");	
			}
			
			text.htmlText = result;
//			text.height = textHeight + 5;
		}
		
		private function findTokenBoundary(text:TextField):Rectangle
		{
			var indexLeft:int = text.text.indexOf(TOKEN_LEFT);
			var indexRight:int = text.text.indexOf(TOKEN_RIGHT);
			if(indexLeft == -1 || indexRight == -1)
			{
				return null;
			}
			var rectLeft:Rectangle = text.getCharBoundaries(indexLeft);
			var rectRight:Rectangle = text.getCharBoundaries(indexRight);
			if(rectLeft == null || rectRight == null)
			{
				return null;
			}
			return rectLeft.union(rectRight);
		}
		
		private function fillTokenBoundary(rect:Rectangle):void
		{
			var g:Graphics = this.graphics;
			g.clear();
			if(rect != null)
			{
				g.beginFill(0x000000, 0.6);
				g.drawRoundRect(rect.x , rect.y - 2, rect.width - 16, rect.height + 5, 5, 5);
				g.endFill();
			}
		}
		
		//替换“【”和“】”
		private function replaceToken(str:String):String
		{
			str = str.replace(TOKEN_LEFT, " ");
			str = str.replace(TOKEN_RIGHT, " ");
			return str;
		}
		
	}
}
