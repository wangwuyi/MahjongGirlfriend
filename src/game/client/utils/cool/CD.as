package game.client.utils.cool
{
	import flash.display.*;

	/**
	 * 冷却
	 * @author an
	 *
	 */
	public class CD extends Sprite
	{
		private var pen:Pen;
		private var rect:Shape;
		private var radius:Number=30;

		public function CD(w:Number, h:Number, radius:Number)
		{
			this.radius=radius;
			this.rect=new Shape();
			this.rect.graphics.beginFill(0, 0.5);
			this.rect.graphics.drawRect(-w/2, -h/2, w, h);
			this.rect.graphics.endFill();
			addChild(this.rect);
			var shape:Shape=new Shape();
			shape.x=this.rect.x;
			shape.y=this.rect.y;
			addChild(shape);
			this.rect.mask=shape;
			this.pen=new Pen(shape.graphics);
		}

		/**
		 *画切片
		 * @param startAngle 开始角度
		 * @param angle  角度
		 *
		 */
		public function draw(angle:Number,startAngle:Number=90):void
		{
			this.pen.clear();
			this.pen.beginFill(0, 0.6);
			this.pen.drawSlice(0, 0, radius, startAngle, angle);
			this.pen.endFill();
		}
	}
}
