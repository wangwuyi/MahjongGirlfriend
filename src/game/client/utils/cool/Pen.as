package game.client.utils.cool
{
	import flash.display.*;
	import flash.geom.*;

	/**
	 *画图
	 * @author an
	 *
	 */
	public class Pen
	{
		private var _bLineStyleSet:Boolean;
		private var _gTarget:Graphics;

		public function Pen(graphics:Graphics)
		{
			this._gTarget=graphics;
		}

		/**
		 *使用当前线条样式和由 (controlX, controlY) 指定的控制点绘制一条从当前绘画位置开始到 (anchorX, anchorY) 结束的曲线。传递到此方法的坐标以图表数据形式表示，而不是以屏幕坐标表示。
		 * @param controlX
		 * @param controlY
		 * @param anchorX
		 * @param anchorY
		 *
		 */
		public function curveTo(controlX:Number, controlY:Number, anchorX:Number, anchorY:Number):void
		{
			if (!this._bLineStyleSet)
			{
				this.lineStyle();
			}
			this._gTarget.curveTo(controlX, controlY, anchorX, anchorY);
		}

		/**
		 * 画线
		 * @param x
		 * @param y
		 * @param controlX
		 * @param controlY
		 * @param anchorX
		 * @param anchorY
		 *
		 */
		public function drawCurve(x:Number, y:Number, controlX:Number, controlY:Number, anchorX:Number, anchorY:Number):void
		{
			if (!this._bLineStyleSet)
			{
				this.lineStyle();
			}
			this._gTarget.moveTo(x, y);
			this._gTarget.curveTo(controlX, controlY, anchorX, anchorY);
		}

		public function beginFill(color:Number, alpha:Number=1):void
		{
			this._gTarget.beginFill(color, alpha);
		}

		/**
		 *   一个控制渐变的焦点位置的数字。值 0 表示焦点位于中心。值 1 表示焦点位于渐变圆的一条边界上。值 -1 表示焦点位于渐变圆的另一条边界上。小于 -1 或大于 1 的值将舍入为 -1 或 1。下列图像显示 focalPointRatio 为 -0.75 的渐变：
		 * @param type  用于指定要使用哪种渐变类型的 GradientType 类的值：GradientType.LINEAR 或 GradientType.RADIAL。
		 * @param colors 要在渐变中使用的 RGB 十六进制颜色值数组（例如，红色为 0xFF0000，蓝色为 0x0000FF 等等）。
		 * @param alphas  colors 数组中对应颜色的 alpha 值数组；有效值为 0 到 1。如果值小于 0，则默认值为 0。如果值大于 1，则默认值为 1。
		 * @param ratios 颜色分布比率的数组；有效值为 0 到 255。该值定义 100% 采样的颜色所在位置的宽度百分比。值 0 表示渐变框中的左侧位置，255 表示渐变框中的右侧位置。该值表示渐变框中的位置，而不是最终渐变的坐标空间，坐标空间可能比渐变框宽或窄。为 colors 参数中的每个值指定一个值。
		 * @param matrix 一个由 flash.geom.Matrix 类定义的转换矩阵。flash.geom.Matrix 类包括 createGradientBox() 方法，通过该方法可以方便地设置矩阵，以便与 lineGradientStyle() 方法一起使用。
		 * @param spreadMethod 用于指定要使用哪种 spread 方法的 SpreadMethod 类的值：
		 * @param interpolationMethod 用于指定要使用哪个值的 InterpolationMethod 类的值
		 * @param focalPointRatio  一个控制渐变的焦点位置的数字。值 0 表示焦点位于中心。值 1 表示焦点位于渐变圆的一条边界上。值 -1 表示焦点位于渐变圆的另一条边界上。小于 -1 或大于 1 的值将舍入为 -1 或 1。下列图像显示 focalPointRatio 为 -0.75 的渐变：
		 *
		 */
		public function lineGradientStyle(type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix=null, spreadMethod:String="pad", interpolationMethod:String="rgb", focalPointRatio:Number=0):void
		{
			if (!this._bLineStyleSet)
			{
				this.lineStyle();
			}
			this._gTarget.lineGradientStyle(type, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio);
		}

		public function lineTo(x:Number, y:Number):void
		{
			if (!this._bLineStyleSet)
			{
				this.lineStyle();
			}
			this._gTarget.lineTo(x, y);
		}

		public function get target():Graphics
		{
			return this._gTarget;
		}

		public function clear():void
		{
			this._gTarget.clear();
			this._bLineStyleSet=false;
		}

		public function drawRect(x:Number, y:Number, width:Number, height:Number):void
		{
			if (!this._bLineStyleSet)
			{
				this.lineStyle();
			}
			this._gTarget.drawRect(x, y, width, height);
		}

		/**
		 *绘制直线
		 * @param startX
		 * @param startY
		 * @param endX
		 * @param endY
		 *
		 */
		public function drawLine(startX:Number, startY:Number, endX:Number, endY:Number):void
		{
			if (!this._bLineStyleSet)
			{
				this.lineStyle();
			}
			this._gTarget.moveTo(startX, startY);
			this._gTarget.lineTo(endX, endY);
		}

		/**
		 * 用位图图像填充绘图区。可以重复或平铺位图以填充该区域。该填充将保持有效，直到您调用 beginFill()、beginBitmapFill() 或 beginGradientFill() 方法。调用 clear() 方法会清除填充。
		 *
		 * @param bitmap 包含要显示的位的透明或不透明位图图像
		 * @param matrix 一个 matrix 对象（属于 flash.geom.Matrix 类），您可以使用它在位图上定义转换。例如，您可以使用以下矩阵将位图旋转 45 度（pi/4 弧度）：
		 * @param repeat 如果为 true，则位图图像按平铺模式重复。如果为 false，位图图像不会重复，并且位图边缘将用于所有扩展出位图的填充区域。
		 * @param smooth 如果为 false，则使用最近邻点算法来呈现放大的位图图像，而且该图像看起来是像素化的。如果为 true，则使用双线性算法来呈现放大的位图图像。使用最近邻点算法呈现通常较快。
		 *
		 */
		public function beginBitmapFill(bitmap:BitmapData, matrix:Matrix=null, repeat:Boolean=true, smooth:Boolean=false):void
		{
			this._gTarget.beginBitmapFill(bitmap, matrix, repeat, smooth);
		}

		/**
		 * 指定一种渐变填充，在绘制时该填充将在随后对其他 Graphics 方法（如 lineTo() 或 drawCircle()）的调用中使用。该填充将保持有效，直到您调用 beginFill()、beginBitmapFill() 或 beginGradientFill() 方法。调用 clear() 方法会清除填充。
		 * @param type 用于指定要使用哪种渐变类型的 GradientType 类的值：GradientType.LINEAR 或 GradientType.RADIAL。
		 * @param colors 要在渐变中使用的 RGB 十六进制颜色值数组（例如，红色为 0xFF0000，蓝色为 0x0000FF，等等）。可以至多指定 15 种颜色。对于每种颜色，请确保在 alphas 和 ratios 参数中指定对应的值。
		 * @param alphas colors 数组中对应颜色的 alpha 值数组；有效值为 0 到 1。如果值小于 0，则默认值为 0。如果值大于 1，则默认值为 1。
		 * @param ratios 颜色分布比例的数组；有效值为 0 到 255。该值定义 100% 采样的颜色所在位置的宽度百分比。值 0 表示渐变框中的左侧位置，255 表示渐变框中的右侧位置。
		 * @param matrix 一个由 flash.geom.Matrix 类定义的转换矩阵。flash.geom.Matrix 类包括 createGradientBox() 方法，通过该方法可以方便地设置矩阵，以便与 beginGradientFill() 方法一起使用。
		 * @param spreadMethod 用于指定要使用哪种 spread 方法的 SpreadMethod 类的值：SpreadMethod.PAD、SpreadMethod.REFLECT 或 SpreadMethod.REPEAT。
		 * @param interpolationMethod 用于指定要使用哪个值的 InterpolationMethod 类的值：InterpolationMethod.linearRGB 或 InterpolationMethod.RGB
		 * @param focalPointRatio  一个控制渐变的焦点位置的数字。0 表示焦点位于中心。1 表示焦点位于渐变圆的一条边界上。-1 表示焦点位于渐变圆的另一条边界上。小于 -1 或大于 1 的值将舍入为 -1 或 1。例如，下例显示 focalPointRatio 设置为 0.75：
		 *
		 */
		public function beginGradientFill(type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix=null, spreadMethod:String="pad", interpolationMethod:String="rgb", focalPointRatio:Number=0):void
		{
			this._gTarget.beginGradientFill(type, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio);
		}

		/**
		 *指定一种线条样式，Flash 可将该样式用于随后调用对象的其它 Graphics 方法（如 lineTo() 或 drawCircle()）。线条样式仍然有效，直到使用不同的参数调用 lineGradientStyle() 方法或 lineStyle() 方法为止。可以在绘制路径的中间调用 lineStyle()，以便为路径中的不同线段指定不同的样式。
		 * @param thickness一个整数，以磅为单位表示线条的粗细；有效值为 0 到 255。如果未指定数字，或者未定义该参数，则不绘制线条。如果传递的值小于 0，则默认值为 0。值 0 表示极细的粗细；最大粗细为 255。如果传递的值大于 255，则默认值为 255。
		 * @param color 线条的十六进制颜色值（例如，红色为 0xFF0000，蓝色为 0x0000FF 等）。如果未指明值，则默认值为 0x000000（黑色）。可选。
		 * @param alpha 表示线条颜色的 Alpha 值的数字；有效值为 0 到 1。如果未指明值，则默认值为 1（纯色）。如果值小于 0，则默认值为 0。如果值大于 1，则默认值为 1。
		 * @param pixelHinting  用于指定是否提示笔触采用完整像素的布尔值。它同时影响曲线锚点的位置以及线条笔触大小本身。在 pixelHinting 设置为 true 的情况下，线条宽度会调整到完整像素宽度。在 pixelHinting 设置为 false 的情况下，对于曲线和直线可能会出现脱节。例如，下面的插图显示了 Flash Player 或 Adobe AIR 如何呈现两个相同的圆角矩形，不同之处是 lineStyle() 方法中使用的 pixelHinting 参数的设置不同（图像已放大 200% 以强调差异）：
		 * @param scaleMode 用于指定要使用哪种缩放模式的 LineScaleMode 类的值：
		 * @param caps 用于指定线条末端处端点类型的 CapsStyle 类的值。有效值为：CapsStyle.NONE、CapsStyle.ROUND 和 CapsStyle.SQUARE。如果未指示值，则 Flash 使用圆头端点。
		 * @param joints JointStyle 类的值，指定用于拐角的连接外观的类型。有效值为：JointStyle.BEVEL、
		 * @param miterLimit 一个表示将在哪个限制位置切断尖角的数字。有效值的范围是 1 到 255（超出该范围的值将舍入为 1 或 255）。此值只可用于 jointStyle 设置为 "miter" 的情况下。miterLimit 值表示向外延伸的尖角可以超出角边相交所形成的结合点的长度。此值表示为线条 thickness 的因子。例如，miterLimit 因子为 2.5 且 thickness 为 10 像素时，尖角将在 25 像素处切断。
		 *
		 */
		public function lineStyle(thickness:Number=1, color:uint=0, alpha:Number=1, pixelHinting:Boolean=false, scaleMode:String="normal", caps:String=null, joints:String=null, miterLimit:Number=3):void
		{
			this._gTarget.lineStyle(thickness, color, alpha, pixelHinting, scaleMode, caps, joints, miterLimit);
			this._bLineStyleSet=true;
		}

		public function set target(graphics:Graphics):void
		{
			this._gTarget=graphics;
		}

		/**
		 *使用绘制圆角的半径大小来绘制圆角矩形。必须在调用 drawRoundRectComplex() 方法之前通过调用 linestyle()、lineGradientStyle()、beginFill()、beginGradientFill() 或 beginBitmapFill() 来设置 Graphics 对象上的线条样式、填充，或同时设置二者
		 * @param x
		 * @param y
		 * @param width
		 * @param height
		 * @param topLeftRadius 左上角的半径（以像素为单位）。
		 * @param topRightRadius  右上角的半径（以像素为单位）。
		 * @param bottomLeftRadius 左下角的半径（以像素为单位）。
		 * @param bottomRightRadius 右下角的半径（以像素为单位）。
		 *
		 */
		public function drawRoundRectComplex(x:Number, y:Number, width:Number, height:Number, topLeftRadius:Number, topRightRadius:Number, bottomLeftRadius:Number, bottomRightRadius:Number):void
		{
			if (!this._bLineStyleSet)
			{
				this.lineStyle();
			}
			this._gTarget.drawRoundRectComplex(x, y, width, height, topLeftRadius, topRightRadius, bottomLeftRadius, bottomRightRadius);
		}

		public function moveTo(x:Number, y:Number):void
		{
			this._gTarget.moveTo(x, y);
		}

		/**
		 *画弧形
		 * @param x
		 * @param y
		 * @param radius
		 * @param startFrom 开始角度
		 * @param angle 角度
		 * @param bAntiClockwise  是否是逆时针，设置为true意味着弧形的绘制是逆时针标的目的的
		 *
		 */
		public function drawArc(x:Number, y:Number, radius:Number, startFrom:Number, angle:Number=0, bAntiClockwise:Boolean=false):void
		{
			angle=(Math.abs(angle) > 360) ? 360 : angle;
			var n:Number=Math.ceil(Math.abs(angle) / 45);
			var angleA:Number=angle / n;
			angleA=angleA * Math.PI / 180;
			startFrom=startFrom * Math.PI / 180;
			var endX:Number=x + radius * Math.cos(startFrom);
			var endY:Number=y + radius * Math.sin(startFrom);
			if (bAntiClockwise)
			{
				this.moveTo(x, y);
				this.lineTo(endX, -endY);
			}
			else
			{
				this.moveTo(x, y);
				this.lineTo(endX, endY);
			}
			for (var i:int=1; i <= n; i++)
			{
				startFrom+=angleA;
				var angleMid:Number=startFrom - angleA / 2;
				var bx:Number=x + radius / Math.cos(angleA / 2) * Math.cos(angleMid);
				var cx:Number=x + radius * Math.cos(startFrom);
				var by:Number;
				var cy:Number;
				if (bAntiClockwise)
				{
					by=y - radius / Math.cos(angleA / 2) * Math.sin(angleMid);
					cy=y - radius * Math.sin(startFrom);
				}
				else
				{
					by=y + radius / Math.cos(angleA / 2) * Math.sin(angleMid);
					cy=y + radius * Math.sin(startFrom);
				}
				this.curveTo(bx, by, cx, cy);
			}
			if (angle != 360)
			{
				if (bAntiClockwise)
				{
					this.lineTo(x, -y);
				}
				else
				{
					this.lineTo(x, y);
				}
			}
		}


		/**
		 *绘制一个圆。您必须在调用 drawCircle() 方法之前，通过调用 linestyle()、lineGradientStyle()、beginFill()、beginGradientFill() 或 beginBitmapFill() 方法来设置线条样式和/或填充。
		 * @param x
		 * @param y
		 * @param radius
		 *
		 */
		public function drawCircle(x:Number, y:Number, radius:Number):void
		{
			if (!this._bLineStyleSet)
			{
				this.lineStyle();
			}
			this._gTarget.drawCircle(x, y, radius);
		}

		/**
		 * 绘制一个圆角矩形。您必须在调用 drawRoundRect() 方法之前，通过调用 linestyle()、lineGradientStyle()、beginFill()、beginGradientFill() 或 beginBitmapFill() 方法来设置线条样式和/或填充。
		 * @param x
		 * @param y
		 * @param width
		 * @param height
		 * @param ellipseWidth  用于绘制圆角的椭圆的宽度（以像素为单位）。
		 * @param ellipseHeight  用于绘制圆角的椭圆的高度（以像素为单位）。（可选）如果未指定值，则默认值与为 ellipseWidth 参数提供的值相匹配。
		 *
		 */
		public function drawRoundRect(x:Number, y:Number, width:Number, height:Number, ellipseWidth:Number, ellipseHeight:Number=NaN):void
		{
			if (!this._bLineStyleSet)
			{
				this.lineStyle();
			}
			this._gTarget.drawRoundRect(x, y, width, height, ellipseWidth, ellipseHeight);
		}

		/**
		 *  绘制一个椭圆。您必须在调用 drawEllipse() 方法之前，通过调用 linestyle()、lineGradientStyle()、beginFill()、beginGradientFill() 或 beginBitmapFill() 方法来设置线条样式和/或填充。
		 * @param x
		 * @param y
		 * @param width
		 * @param height
		 *
		 */
		public function drawEllipse(x:Number, y:Number, width:Number, height:Number):void
		{
			var controlX:Number;
			var controlY:Number;
			var anchorX:Number;
			var anchorY:Number;
			var pi:Number=Math.PI / 4;
			var angle:Number;
			var eWidth:Number=width / Math.cos(pi / 2);
			var eHeight:Number=height / Math.cos(pi / 2);
			this.moveTo(x + width, y);
			var index:Number;
			while (index++ < 8)
			{
				angle=angle + pi;
				controlX=x + Math.cos(angle - pi / 2) * eWidth;
				controlY=y + Math.sin(angle - pi / 2) * eHeight;
				anchorX=x + Math.cos(angle) * width;
				anchorY=y + Math.sin(angle) * height;
				this.curveTo(controlX, controlY, anchorX, anchorY);
			}
		}


		public function drawSlice(x:Number, y:Number, radius:Number, startForm:Number, angle:Number):void
		{
			this.drawArc(x, y, radius, startForm, angle, true);
		}

		public function endFill():void
		{
			this._gTarget.endFill();
		}

	}
}
