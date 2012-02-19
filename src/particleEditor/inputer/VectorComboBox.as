package particleEditor.inputer
{
	import org.aswing.AsWingConstants;
	import org.aswing.FlowLayout;
	import org.aswing.geom.IntDimension;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.JSpacer;
	import org.aswing.SoftBoxLayout;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class VectorComboBox extends JPanel implements ISerializable
	{
		protected var titleLabel:JLabel;
		protected var xComboInput:ComboBoxInput;
		protected var yComboInput:ComboBoxInput;
		protected var zComboInput:ComboBoxInput;
		public function VectorComboBox(title:String = "", listData:*= null, xLabel:String = "", yLabel:String = "", zLabel:String = "" )
		{
			titleLabel = new JLabel(title);
			xComboInput = new ComboBoxInput(xLabel, listData);
			yComboInput = new ComboBoxInput(yLabel, listData);
			zComboInput = new ComboBoxInput(zLabel, listData);
			createLayout();
		}
		
		protected function createLayout():void
		{
			setLayout(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
			var pane:JPanel;
			pane = new JPanel(new FlowLayout(AsWingConstants.LEFT,0,0,false));
			pane.append(titleLabel);
			append(pane);
			pane = new JPanel();
			pane.appendAll(new JSpacer(new IntDimension(10)), xComboInput);
			append(pane);
			pane = new JPanel();
			pane.appendAll(new JSpacer(new IntDimension(10)), yComboInput);
			append(pane);
			pane = new JPanel();
			pane.appendAll(new JSpacer(new IntDimension(10)), zComboInput);
			append(pane);
		}
		
		public function getValue():Array
		{
			return [xComboInput.getValue(), yComboInput.getValue(), zComboInput.getValue()];
		}
		
		public function serialize():String
		{
			return xComboInput.serialize() + "," + yComboInput.serialize() + "," + zComboInput.serialize();
		}
		
		public function deserialize(value:String):void
		{
			var array:Array = value.split(",");
			xComboInput.deserialize(array[0]);
			yComboInput.deserialize(array[1]);
			zComboInput.deserialize(array[2]);
		}
		
	}

}