package game.client.module.ui.rank.data
{
	import game.client.module.ui.rank.list.RankArenaList;
	import game.client.module.ui.rank.list.RankCmpetitvList;
	import game.client.module.ui.rank.list.RankDoyenList;
	import game.client.module.ui.rank.list.RankEquipList;
	import game.client.module.ui.rank.list.RankGuildList;
	import game.client.module.ui.rank.list.RankIntersectionList;
	import game.client.module.ui.rank.list.RankMineList;
	import game.client.module.ui.rank.list.RankOverlordList;
	import game.client.module.ui.rank.list.RankPersonList;
	import game.client.module.ui.rank.list.RankPetList;

	public class RankType
	{

		public static const RANK_MAIN_TYPES:Array = ["个人排行","装备排行","宠物排行","帮会排行","霸主排行","擂台排行","斗法排行","社交排行","达人排行"];
		
		public static const RANK_SUB_TYPES:Array = [["战力排行","等级排行","财富排行","成就排行"],
													  ["武器排行","防具排行","翅膀排行","坐骑排行"],
													  ["宠物战力","宠物等级","宠物资质","宠物成长","宠物真身"],
													  ["帮会等级","帮战积分","个人积分"],
													  ["轮回塔","古天庭","地狱轮回塔","地狱古天庭"],
													  ["本周荣誉"],
													  ["本周积分","总积分"],
													  ["当天送花榜","总送花榜","当天收花榜","总收花榜"],
													  ["练级达人","修行达人","财富达人","淘宝达人"]];
		
		public static const RANK_INSTANCE_LIST:Array = [RankPersonList.getInstance(),RankEquipList.getInstance(),RankPetList.getInstance(),
			RankGuildList.getInstance(),RankOverlordList.getInstance(),RankArenaList.getInstance(),RankCmpetitvList.getInstance(),
			RankIntersectionList.getInstance(),RankDoyenList.getInstance(),RankMineList.getInstance()]; 
		
		public function RankType()
		{
		}
		public static function findBtn(btn:String):Array{
			for(var i:String in RANK_SUB_TYPES){
				for(var j:String in RANK_SUB_TYPES[i]){
					var str:String =RANK_SUB_TYPES[i][j];
					if(str == btn){
						return [i,j];
					}
				}
			}
			return [];
		}
	}
}