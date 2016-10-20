package game.client.live
{
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	import game.core.utils.Utils;

	public class Live extends Sprite
	{
		private var netConnection:NetConnection;
		private var netStream:NetStream;
		private var video:Video;
		private var videoWidth:int = 960;
		private var videoHeight:int = 640;
		
		public function Live() {
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddStage);
		}
		
		private static var instance:Live;
		
		public static function getInstance():Live {
			if (instance == null) {
				instance=new Live();
			}
			return instance;
		}
		
		private function onAddStage(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			this.stage.addEventListener(Event.RESIZE, onStageResize);
		}
		
		private function onRemove(e:Event):void {
			this.removeEventListener(Event.RESIZE, onStageResize);
		}
		
		private function onStageResize(e:Event):void {
			if(video != null){
				video.x = (stage.stageWidth-videoWidth)/2;
				video.y = (stage.stageHeight-videoHeight)/2;
			}
		}
		
		public function show(parent:Sprite):void{
			parent.addChild(this);
			video = new Video();
			this.addChild(video);
		}
		
		public function connect(address:String):void{
			netConnection = new NetConnection();
			netConnection.addEventListener(NetStatusEvent.NET_STATUS, connectStatusHandler);
			netConnection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler)
			netConnection.client = this;
			netConnection.connect(address);
		}
		
		private function connectStatusHandler(event:NetStatusEvent):void{
			Utils.log("NetConnection:"+event.info.level+"_"+event.info.code, Utils.LOG_INFO);
			switch(event.info.code){
				case "NetConnection.Connect.Success":{
					play("hks");
//					play("34632");
					break;
				}
				case "NetConnection.Connect.Failed":{
					break;
				}
				case "NetConnection.Connect.Rejected":{
					break;
				}
				case "NetConnection.Connect.Closed":{
					break;
				}
			}
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			Utils.log("securityErrorHandler: " + event, Utils.LOG_ERR);
		}
		
		private function play(room:String):void{
			netStream = new NetStream(netConnection);
			netStream.client = this;
			netStream.addEventListener(NetStatusEvent.NET_STATUS, netStreamStatusHandler);
			netStream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, doAsyncError);
			netStream.play(room);
		}
		
		private function netStreamStatusHandler(event:NetStatusEvent):void { 
			Utils.log("NetStream:"+event.info.level+"_"+event.info.code, Utils.LOG_INFO);
			switch(event.info.code){
				case "NetStream.Play.Reset":{
					break;
				}
				case "NetStream.Play.Start":{
					break;
				}
				case "NetStream.Play.PublishNotify":{
					video.attachNetStream(netStream);
					break;
				}
			}
		} 
		
		private function doAsyncError (event:AsyncErrorEvent):void { 
			Utils.log("asyncErrorHandler: " + event.text, Utils.LOG_ERR);
		}
		
		//-------------LiveClient Start-----------------
		
		public function onCuePoint(info:Object):void { 
			Utils.log("cuepoint: time=" + info.time + " name=" + info.name + " type=" + info.type, Utils.LOG_INFO); 
		} 
		
		public function onImageData(info:Object):void { 
			Utils.log("onImageData: imageData length=" + info.data.length, Utils.LOG_INFO); 
		} 
		
		public function onMetaData(info:Object):void { 
			Utils.log("onMetaData: duration=" + info.duration + " width=" + info.width + 
				" height=" + info.height + " framerate=" + info.framerate, Utils.LOG_INFO);
			videoWidth = info.width;
			videoHeight = info.height;
			video.x = (stage.stageWidth-videoWidth)/2;
			video.y = (stage.stageHeight-videoHeight)/2;
			video.width = videoWidth;
			video.height = videoHeight;
		}
		
		public function onPlayStatus( info:Object ):void{ 
			Utils.log("onPlayStatus", Utils.LOG_INFO); 
			for ( var key:String in info ) {  
				Utils.log(key + "=" + info[key], Utils.LOG_INFO); 
			} 
		} 
		
		public function onSeekPoint(info:Object):void{
			Utils.log("onSeekPoint", Utils.LOG_INFO);
		}
		
		public function onTextData(info:Object):void{
			Utils.log("onTextData", Utils.LOG_INFO);
		}
		
		public function onXMPData(info:Object):void{
			Utils.log("onXMPData", Utils.LOG_INFO);
		}
		
		public function onBWDone(...rest):void{
			if (rest.length > 0){
				var p_bw:Number = rest[0];
				Utils.log("onBWDone: bandwidth = " + p_bw + " Kbps.", Utils.LOG_INFO);
			}
		}
		
		//-------------LiveClient End-----------------
	}
}