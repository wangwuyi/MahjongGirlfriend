package game.client.module.ui.bag
{
	import flash.events.MouseEvent;
	
	import game.client.module.BasePanel;
	import game.client.module.ui.bag.skin.BagPanelSkin;
	import game.component.Button;
	import game.component.ScaleImage;
	
	public class BagPanel extends BasePanel
	{
		public static var instance:BagPanel = new BagPanel();
		
		private var _guanbi:Button;
		
		private var _diban:ScaleImage;
		
		public function BagPanel()
		{
			this.closeeffect=true;
			this.skin = BagPanelSkin.skin;
			init();
		}
		
		private function init():void{
			_guanbi=getChildByName("close") as Button;
			_guanbi.guideKey = "beibaoguanbi";
		}
		
		protected override function configChildren():void{
			_diban = getChildByName("diban") as ScaleImage;
			_diban.width = 500;
		}
		
	}
}