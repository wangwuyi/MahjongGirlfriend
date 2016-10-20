package game.client.module.popUI.skin
{
	import game.client.resource.ResourcePath;

	public class MsgBoxSkin
	{
		public static var skin:Object=
			{name:"MsgBox",type:"Container",x:0,y:0,width:278,height:151,
				children:
				[
					{name:"beijing",type:"Image",x:0,y:0,width:278,height:151,normal:{link:"tipBg",x:0,y:0,width:278,height:151}},
					{name:"beijing2",type:"Image",x:9,y:31,width:260,height:111,normal:{link:"tipBg",x:0,y:0,width:260,height:111}},
					{name:"xingzhuang1",type:"Image",x:2,y:13,width:274,height:19,normal:{link:"tipBg",x:0,y:0,width:274,height:19}},
					{name:"xingzhuang2",type:"Image",x:2,y:1,width:274,height:21,normal:{link:"tipBg",x:0,y:0,width:274,height:21}},
					{name:"tishi",type:"Image",x:116,y:6,width:52,height:24,normal:{link:"tipBg",x:0,y:0,width:52,height:24}},
					{name:"txtshuomingwenzi",type:"Label",x:32,y:54,width:216,height:17,content:"<font color='#ffffff'>是否确定花费</font><font color='#fff600'>30元</font><font color='#ffffff'>宝购买1个</font><font color='#ff00b4'>紫色洗练石</font>",format:{align:"center",bold:false,color:0xffffff,font:"SimSun",italic:false,leading:10,letterSpacing:0,size:12,underline:false}},
					{name:"quxiao",type:"Button",x:155,y:105,width:61,height:27,
						children:
						[
							{name:"myScaleImage",type:"ScaleImage",x:0,y:0,width:61,height:27,top:4,right:4,bottom:4,left:4,normal:{link:"tipBg",x:0,y:0,width:61,height:27},over:{link:"tipBg",x:0,y:0,width:61,height:27}},
							{name:"txtquxiao",type:"Label",x:17,y:5,width:30,height:17,content:"<font color='#ffffff'>取消</font>",format:{align:"left",bold:false,color:0xffffff,font:"SimSun",italic:false,leading:21,letterSpacing:0,size:12,underline:false}}
						]
					},
					{name:"close",type:"Button",x:248,y:4,width:24,height:24,
						children:
						[
							{name:"myImage",type:"Image",x:0,y:0,width:24,height:24,normal:{link:"tipBg",x:0,y:0,width:24,height:24}}
						]
					},
					{name:"queding",type:"Button",x:66,y:105,width:61,height:27,
						children:
						[
							{name:"myScaleImage",type:"ScaleImage",x:0,y:0,width:61,height:27,top:4,right:4,bottom:4,left:4,normal:{link:"tipBg",x:0,y:0,width:61,height:27},over:{link:"tipBg",x:0,y:0,width:61,height:27}},
							{name:"quedingtxt",type:"Label",x:17,y:5,width:30,height:17,content:"<font color='#ffffff'>确定</font>",format:{align:"left",bold:false,color:0xffffff,font:"SimSun",italic:false,leading:21,letterSpacing:0,size:12,underline:false}}
						]
					},
					{name:"250x33",type:"DragBar",x:0,y:0,width:250,height:33}
				]
			};
	}
}