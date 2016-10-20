package game.client.net.handler.user
{
	
	public class PlayerVO extends BaseAttributeVO
	{
		public var stealPig:int;
		public function PlayerVO()
		{
		}
		
		public function init(rolename:String,level:int,status:int,job:int,guild:String,camp:int,bodyId:int,friendSit:String,horseIcon:int,horsePower:int,wingIcon:int,copyStatus:int,stealPig:int,title:Array,objid:int,posx:int,posy:int,
							 targetPos:Array,targetDirection:int,maxhp:int,maxmp:int,hp:int,mp:int,speed:int,diaphaneity:int,isjump:int):void 
		{
			this.sex = 1;
			this.rolename = rolename;
			this.level = level;
			this.status = status;
			this.job = job;
			this.guildName = guildName;
			this.camp = camp;
			this.bodyId = bodyId;
			this.objid = objid;
			this.sceneX = posx;
			this.sceneY = posy;
			this.targetPos = targetPos;
			this.targetDirection = targetDirection;
			this.maxhp = maxhp;
			this.maxmp = maxmp;
			this.hp = hp;
			this.mp = mp;
			this.speed = speed;
			this.alphaNum = diaphaneity / 100;
			this.isJump = isjump;
			this.friendSit = friendSit;
			this.horseIcon = horseIcon;
			this.horsePower = horsePower;
			this.wing = 1
			this.isSoul = copyStatus;
			this.stealPig = stealPig;
			for(var i:int=0; i<title.length; i++)
			{
				title[i] = title[i][0];
			}
			this.title = title;
		}
	}
}