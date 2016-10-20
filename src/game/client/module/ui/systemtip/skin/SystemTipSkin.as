package game.client.module.ui.systemtip.skin
{

	public class SystemTipSkin
	{
		public static var skin:Object=
			{name:"SystemTip",type:"Container",x:0,y:0,width:187,height:22,
				children:
				[
					{name:"txtContent",type:"Label",x:-2,y:5,width:54,height:17,content:"<font color='#292721'>文字提示</font>",format:{align:"left",bold:false,color:0x292721,font:"SimSun",italic:false,leading:0,letterSpacing:0,size:12,underline:false}},
					{name:"jiahao",type:"Button",x:164,y:0,width:25,height:24,
						children:
						[
							{name:"myImage",type:"Image",x:0,y:0,width:15,height:14,
								normal:{link:"shared.xin",x:0,y:0,width:15,height:14},
								over:{link:"shared.xin",x:0,y:0,width:15,height:14},
								down:{link:"shared.xin",x:0,y:0,width:15,height:14}
							}
						]
					}
				]
			};
	}
}