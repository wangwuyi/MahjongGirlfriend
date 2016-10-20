package game.client.net.handler.user
{
	import game.client.utils.HashMap;

	public class HeroVO extends PlayerVO
	{
		public var atkmode:int;
		public var timeServer:int;
		public var mapId:int;
		public var maptype:int;
		public var mode:int;
		public var mapWidth:int;
		public var mapHeight:int;
		
		/**
		 *人物体力值 
		 */		
		public var physical:int;
		/**
		 * 擂台积分
		 */		
		public var arenaScore:int;
		/**
		 * 斗法积分
		 */		
		public var doufaScore:int;
		/**
		 * 诛仙积分
		 */		
		public var zhuxianScore:int;
		/**
		 * 帮战积分
		 */		
		public var guildcombatScore:int;
		/**
		 * 传道积分
		 */		
		public var chuandaoScore:int;
		/**
		 * 蟠桃积分
		 */		
		public var pantaoScore:int; 
		
		public function HeroVO()
		{
		}
		
		public function initialize(rolename:String,job:int,sex:int,level:int,speed:int,atkmode:int,
							 camp:int,timeServer:int,objid:int,mapid:int,maptype:int,scenex:int,
							 sceney:int,mode:int,mapWidth:int,mapHeight:int, status:int ,guildName:String,
							 bodyId:int,horseIcon:int,horsePower:int):void
		{
			this.rolename = rolename;
			this.job = job;
			this.sex = sex;
			this.level = level;
			this.speed = speed;
			this.atkmode = atkmode;
			this.camp = camp;
			this.timeServer = timeServer;
			this.objid = objid;
			this.mapId = mapid;
			this.maptype = maptype;
			this.sceneX = scenex;
			this.sceneY = sceney;
			this.mode = mode;
			this.mapWidth = mapWidth;
			this.mapHeight = mapHeight;
			this.status = status;
			this.guildName = guildName;
			this.bodyId = bodyId;
			this.horseIcon = horseIcon;
			this.horsePower = horsePower;
		}
		public var heroEquipData:HashMap = new HashMap();
		
		public function get totalMoney():int{
			return money+bindmoney;
		}
		
	}
}