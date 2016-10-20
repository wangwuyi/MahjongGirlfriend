package game.client.module.chatCommon
{
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	
	import game.client.model.GlobalModel;
	import game.client.resource.ResourcePath;
	import game.component.ScaleImage;
	
	public class Face extends Sprite
	{
		private static const FACE_MAX:int = 4;
		public static var list:Array = ["$wx", "$ka", "$hx", "$se", "$tx", 
										"$kb", "$lh", "$ch", "$yy", "$pz",
										"$yw", "$yn", "$tu", "$fd", "$bz",
										"$cy", "$gz", "$wq", "$kl", "$mr",
										"$zj", "$kk", "$jk", "$fn"];
		private static var border:Shape = new Shape();
		
		public static var container:IHasInput;
		
		public function Face()
		{
			var bg:ScaleImage= new ScaleImage();
			bg.skin ={name:ResourcePath.TIP_BG,type:"ScaleImage",x:0,y:0,width:263,height:157,top:4,right:4,bottom:4,left:4,normal:{link:ResourcePath.TIP_BG,x:0,y:0,width:11,height:33}};
			bg.x = -98;
			bg.y = -116;
			addChild(bg);
			bg.width = 263;
			bg.height = 157;
			for (var i:int = 0; i < list.length; i++)
			{
				var face:Sprite = new Sprite();
				face.mouseChildren = false;
				face.graphics.beginFill(0, 0);
				face.graphics.drawRect(0, 0, 34, 30);
				face.graphics.endFill();
				face.name = list[i];
				face.addEventListener(MouseEvent.MOUSE_DOWN, down);
				face.addEventListener(MouseEvent.ROLL_OVER, over);
				face.addEventListener(MouseEvent.ROLL_OUT, out);
				var faceEffect:FaceEffect=new FaceEffect();
				faceEffect.setIndex(i + 1);
				face.addChild(faceEffect);
				face.x = (i % 8) * 30-80;
				face.y = int(i/8) * 30-100;
				addChild(face);
			}
			
			border.graphics.lineStyle(1, 0x0000FF);
			border.graphics.drawRect(0, 0, 28, 28);
			border.graphics.endFill();
			border.visible = false;
			addChild(border);
			
			GlobalModel.stage.addEventListener(MouseEvent.MOUSE_DOWN, hide);
			
			x = 265;
			y = 95;
			this.addEventListener(MouseEvent.ROLL_OUT,onRollOut);
		}
		
		private static function onRollOut(e:MouseEvent):void
		{
			if(FaceCreator.faceInstance.parent != null)
			{
				FaceCreator.faceInstance.parent.removeChild(FaceCreator.faceInstance);
			}
		}
		
		private static function hide(e:MouseEvent):void
		{
			if(FaceCreator.faceInstance.parent != null)
			{
				FaceCreator.faceInstance.parent.removeChild(FaceCreator.faceInstance);
			}
		}
		
		private static function down(e:MouseEvent):void
		{
			GlobalModel.stage.focus = Face.container.input;
			var faceTotal:int = getFaceTotal(Face.container.input.text);
			if(faceTotal < FACE_MAX)
			{
				Face.container.input.text += e.currentTarget.name;
			}
			var len:int = Face.container.input.text.length;
			Face.container.input.setSelection(len, len);
			e.stopPropagation();
		}
		
		private static function getFaceTotal(content:String):int
		{
			var start:int = 0;
			var total:int = 0;
			var index:int = 0;
			while(true)
			{
				index = content.indexOf("$", start);
				if (index == -1)
				{
					break;
				}
				var code:String = content.substr(index, 3);
				var face:int = Face.list.indexOf(code);
				if (face != -1)
				{
					total++;
				}
				start = index + 1;
			}
			return total;
		}
		
		private static function over(e:MouseEvent):void
		{
			border.x = e.target.x - 14;
			border.y = e.target.y - 14;
			border.visible = true;
		}
		
		private static function out(e:MouseEvent):void
		{
			border.visible = false;
		}
		
		private static var sources:Dictionary=new Dictionary(true);
		
		public static function getClass(key:String, property:String):Class
		{
			var cl:*=sources[key];
			if (cl && cl.hasDefinition(property))
			{
				return cl.getDefinition(property);
			}
			return null;
		}
		
		public static function add(url:String, applicationDomain:ApplicationDomain):void
		{
			sources[url]=applicationDomain;
		}
		
		public static function hasResource(key:String):Boolean
		{
			return sources[key] != null;
		}
	}
}
