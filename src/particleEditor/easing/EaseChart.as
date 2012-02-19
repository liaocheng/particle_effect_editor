package particleEditor.easing
{
	import org.aswing.AssetPane;
	import org.aswing.AsWingConstants;
	import org.aswing.AsWingUtils;
	import org.aswing.border.LineBorder;
	import org.aswing.BorderLayout;
	import org.aswing.JFrame;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class EaseChart extends JFrame
	{
		protected var lineChart:LineChart;
		
		public function EaseChart() 
		{
			super(null, "ease chart", true);
			lineChart = new LineChart();
			
			var assetPane:AssetPane = new AssetPane(lineChart);
			//assetPane.setBorder(new LineBorder());
			//assetPane.setScaleMode(AssetPane.SCALE_STRETCH_PANE);
			assetPane.setHorizontalAlignment(AsWingConstants.CENTER);
			assetPane.setVerticalAlignment(AsWingConstants.CENTER);
			getContentPane().setLayout(new BorderLayout(0, 0));
			getContentPane().append(assetPane, BorderLayout.CENTER);
			
			//addChild(lineChart);
			
		}
		
		public function drawChart(start:Number, end:Number, easeFun:Function):void
		{
			var delta:Number = end - start;
			var res:Array = [];
			for (var i:int = 0; i <= 100; i++)
			{
				var mid:Number = easeFun(i, start, delta, 100);
				res.push(mid);
			}
			lineChart.drawChart(res);
		}
		
		public static function showChartWindow(start:Number, end:Number, easeFun:Function):void
		{
			var fram:EaseChart = new EaseChart();
			fram.setSizeWH(400, 360);
			AsWingUtils.centerLocate(fram);
			fram.drawChart(start, end, easeFun);
			fram.show();
		}
		
	}

}
import flash.display.Shape;
import flash.display.Sprite;

class LineChart extends Sprite
{
	protected var _data:Array
	protected var _chartHolder:Shape;
	protected var _width:Number = 0;
	protected var _height:Number = 0;

	public function LineChart()
	{
		this.width = 304;
		this.height = 304;
		_chartHolder = new Shape();
		addChild(_chartHolder);
	}
	public function drawChart(value:Array):void
	{
		_data = value;
		if (_data)
		{
			var border:Number = 2;
			var lineWidth:Number = (width - border*2) / (_data.length - 1);
			var chartHeight:Number = height - border*2;
			_chartHolder.x = 0;
			_chartHolder.y = height;
			var xpos:Number = border;
			var max:Number = getMaxValue();
			var min:Number = getMinValue();
			var scale:Number = chartHeight / (max - min);
			
			_chartHolder.graphics.clear();
			_chartHolder.graphics.lineStyle(1, 0xffff0000);
			_chartHolder.graphics.moveTo(xpos, ((_data[0] - min) * -scale)-border);
			xpos += lineWidth;
			for(var i:int = 1; i < _data.length; i++)
			{
				if(_data[i] != null)
				{
					_chartHolder.graphics.lineTo(xpos, ((_data[i] - min) * -scale)-border);
				}
				xpos += lineWidth;
			}
		}
	}
	
	protected function getMaxValue():Number
	{
		var maxValue:Number = Number.NEGATIVE_INFINITY;
		for(var i:int = 0; i < _data.length; i++)
		{
			if(_data[i] != null)
			{
				maxValue = Math.max(_data[i], maxValue);
			}
		}
		return maxValue;
	}
	
	protected function getMinValue():Number
	{
		var minValue:Number = Number.POSITIVE_INFINITY;
		for(var i:int = 0; i < _data.length; i++)
		{
			if(_data[i] != null)
			{
				minValue = Math.min(_data[i], minValue);
			}
		}
		return minValue;
	}
	
	override public function set width(w:Number):void
	{
		_width = w;
		drawChart(_data);
	}
	override public function get width():Number
	{
		return _width;
	}
	

	override public function set height(h:Number):void
	{
		_height = h;
		drawChart(_data);
	}
	override public function get height():Number
	{
		return _height;
	}

}