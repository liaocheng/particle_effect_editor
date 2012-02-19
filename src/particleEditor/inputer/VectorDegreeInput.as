package particleEditor.inputer
{
	import flash.geom.Vector3D;
	import org.aswing.AsWingConstants;
	import org.aswing.FlowLayout;
	import org.aswing.JAdjuster;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class VectorDegreeInput extends JPanel implements ISerializable
	{
		protected var label:JLabel;
		private var adjuster1:JAdjuster;
		private var adjuster2:JAdjuster;
		private var adjuster3:JAdjuster;
		
		public function VectorDegreeInput(labelText:String = "", gap:int = 2) 
		{
			super(new FlowLayout(AsWingConstants.LEFT, gap, 0));
			label = new JLabel(labelText);
			adjuster1 = new JAdjuster(2);
			adjuster1.setMaximum(360);
			adjuster1.setMinimum(-360);
			adjuster1.setValue(0);
			adjuster2 = new JAdjuster(2);
			adjuster2.setMaximum(360);
			adjuster2.setMinimum(-360);
			adjuster2.setValue(0);
			adjuster3 = new JAdjuster(2);
			adjuster3.setMaximum(360);
			adjuster3.setMinimum(-360);
			adjuster3.setValue(0);
			appendAll(label, adjuster1, adjuster2, adjuster3);
		}
		public function serialize():String
		{
			return String(adjuster1.getValue()) + "," + String(adjuster2.getValue()) + "," + String(adjuster3.getValue());
		}
		public function deserialize(value:String):void
		{
			var array:Array = value.split(",");
			adjuster1.setValue(array[0]);
			adjuster2.setValue(array[1]);
			adjuster3.setValue(array[2]);
		}
		
		public function getValue():Vector3D
		{
			return new Vector3D(adjuster1.getValue(), adjuster2.getValue(), adjuster3.getValue());
		}
		
	}

}