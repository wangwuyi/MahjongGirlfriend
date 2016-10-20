package game.client.module.chatCommon
{
	import flash.display.DisplayObject;
	
	import game.client.module.BasePanel;
	import game.client.module.chatCommon.Face;
	import game.client.module.chatCommon.IHasInput;
	import game.client.module.ui.chat.ChatPanel;
	
	
	public class FaceCreator
	{
		static public var faceInstance:Face;
		 
		static public function createFace(target:IHasInput, trigger:DisplayObject,panel:BasePanel):Face
		{
			if (FaceCreator.faceInstance == null)
				FaceCreator.faceInstance = new Face();
			Face.container = target;
			FaceCreator.faceInstance.x = trigger.x + panel.x;
			FaceCreator.faceInstance.y = trigger.y -50 + panel.y;
			return FaceCreator.faceInstance;
		}
		
		public function FaceCreator(pvt:PrivateClass)
		{
		}
	}
}
class PrivateClass
{
}
