package game.client.net
{
	import flash.display.Stage;
	import flash.events.ContextMenuEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.System;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import game.core.utils.FileStorage;
	import game.core.utils.Utils;

	public class ServerConfig
	{
		/**
		 *服务器IP
		 */		
		public static var ip:String;
		/**
		 *服务器端口 
		 */		
		public static var port:int;
		/**
		 *官网 
		 */		
		public static var officialHome:String;
		/**
		 *充值地址 
		 */		
		public static var chargeLink:String;
		/**
		 *key-CD
		 */		
		public static var newCardLink:String = "http://www.baidu.com";
		/**
		 *时间截 
		 */		
		public static var timestamp:int;
		/**
		 *防沉迷 
		 */		
		public static var fcm:int;
		/**
		 *校验key 
		 */		
		public static var key:String;
		/**
		 *帐号 
		 */		
		public static var account:String;
		/**
		 *资源路径 
		 */		
		public static var resourceHost:String = "";
		/**
		 *版本号
		 */		
		public static var version:String;
		/**
		 * 服务器时间
		 */		
		public static var timeServer:int;
		/**
		 * 登陆服务器时，客户端当前getTimer 时间
		 */		
		public static var timeLogin:int;
		/**
		 * 服务器名
		 */		
		public static var svrName:String;
		/**
		 * 城市号
		 */		
		public static var address:int;
		
		public static function init(stage:Stage):void
		{
			var parameters:Object = stage.loaderInfo.parameters
			for (var key:String in parameters)
			{
				trace(key+":"+parameters[key]+":"+unescape(parameters[key]));
				parameters[key] = unescape(parameters[key]);
			}
			if(ExternalInterface.available == true)
			{
				parameters = ExternalInterface.call('getConfig');
				ip = parameters["ip"];
				port = parameters["port"];
				officialHome = parameters["office"] ? parameters["office"] : "http://www.baidu.com";
				timestamp = parameters["timestamp"] ? parameters["timestamp"] : 0;
				fcm = parameters["fcm"] ? parameters["fcm"] : 1;
				key = parameters["ticket"] ? parameters["ticket"] : "123456";
				account = parameters["account"];
				address = parameters["address"];
				chargeLink = parameters["chargeLink"] ? parameters["chargeLink"] : "http://www.baidu.com";
				resourceHost = parameters["resourceHost"] ? parameters["resourceHost"] : "../";
				version = parameters["version"] ? parameters["version"] : "9527";
				svrName =  parameters["serverId"] ? parameters["serverId"] : "[01]";
			}
		}
		
		public static function getContextMenu():ContextMenu
		{
			var myContextMenu:ContextMenu = new ContextMenu();
			myContextMenu.hideBuiltInItems();
//			var menuItemFavorite:ContextMenuItem = new ContextMenuItem("收藏《XXX》");
			var menuItemOfficial:ContextMenuItem = new ContextMenuItem("开发商：广州XXX信息科技有限公司");
			var menuItemCopy:ContextMenuItem = new ContextMenuItem(version);
			var menuItemClearCache:ContextMenuItem = new ContextMenuItem("清空本地缓存");
//			myContextMenu.customItems.push(menuItemFavorite);
			myContextMenu.customItems.push(menuItemOfficial);
			myContextMenu.customItems.push(menuItemCopy);
			myContextMenu.customItems.push(menuItemClearCache);
//			menuItemFavorite.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,onSelectFavorite);
			menuItemOfficial.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,onSelectOfficial);
			menuItemCopy.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,onSelectCopy);
			menuItemClearCache.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,onSelectClearCache);
			return myContextMenu;
		}
		
		public static function goTofficialHome(window:String = "_blank"):void
		{
			var urlReq:URLRequest = new URLRequest(officialHome);
			navigateToURL(urlReq,window);
		}
		
		/**
		 * 收藏 
		 * @param e
		 * 
		 */		
		private static function onSelectFavorite(e:ContextMenuEvent):void
		{
			ExternalInterface.call("bookmarkit");
		}
		
		/**
		 * 官网 
		 * @param e
		 * 
		 */		
		private static function onSelectOfficial(e:ContextMenuEvent):void
		{
			goTofficialHome()
		}
		
		/**
		 * 复制 
		 * @param e
		 * 
		 */		
		private static function onSelectCopy(e:ContextMenuEvent):void
		{
			try
			{
				System.setClipboard(version);
			}
			catch (err:Error)
			{
			}
		}
		
		/**
		 * 清楚缓存 
		 * @param e
		 * 
		 */		
		private static function onSelectClearCache(e:ContextMenuEvent):void
		{
			FileStorage.clearAll();
		}
	}
}