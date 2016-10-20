package game.client.module.ui.rank.skin
{

	public class RankMineListSkin
	{
		public static var skin:Object=
			{name:"RankMineList",type:"Container",x:0,y:0,width:502,height:59,
				children:
				[
					{name:"tiao222",type:"Image",x:1,y:0,width:501,height:27,normal:{link:"RankMineList_tiao222",x:0,y:0,width:501,height:27}},
					{name:"fengexian2",type:"Image",x:110,y:7,width:2,height:14,normal:{link:"RankMineList_fengexian2",x:0,y:0,width:2,height:14}},
					{name:"mingzi",type:"List",x:0,y:29,width:502,height:30,
						item:
							{name:"myItem",type:"Container",x:0,y:0,width:502,height:30,
							children:
							[
								{name:"fenggex",type:"Image",x:10,y:28,width:485,height:2,normal:{link:"RankMineList_fenggex",x:0,y:0,width:485,height:2}},
								{name:"xuanzhongxx21",type:"Image",x:0,y:0,width:502,height:26,normal:{link:"RankMineList_xuanzhongxx21",x:0,y:0,width:502,height:26}},
								{name:"txtmingzi11",type:"Label",x:272,y:5,width:90,height:17,content:"<font color='#ffffff'>[精良]真是尊+9</font>",format:{align:"left",bold:false,color:0xffffff,font:"SimSun",italic:false,leading:12,letterSpacing:0,size:12,underline:false}},
								{name:"txtpaim11",type:"Label",x:46,y:5,width:24,height:17,content:"<font color='#ffffff'>100</font>",format:{align:"left",bold:false,color:0xffffff,font:"SimSun",italic:false,leading:12,letterSpacing:0,size:12,underline:false}}
							]
						},
						children:
						[

						]
					},
					{name:"txtpaiming",type:"Label",x:46,y:6,width:30,height:17,content:"<font color='#ffff00'>排名</font>",format:{align:"left",bold:false,color:0xffff00,font:"SimSun",italic:false,leading:12,letterSpacing:0,size:12,underline:false}},
					{name:"txtmingzi",type:"Label",x:297,y:6,width:30,height:17,content:"<font color='#ffff00'>榜单</font>",format:{align:"left",bold:false,color:0xffff00,font:"SimSun",italic:false,leading:12,letterSpacing:0,size:12,underline:false}}
				]
			};
	}
}