package particleEditor.inputer
{
	import flash.geom.Vector3D;
	import org.aswing.AsWingConstants;
	import org.aswing.FlowLayout;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class Vector3dInput extends JPanel implements ISerializable
	{
		protected var titleLabel:JLabel;
		protected var xInput:NumberInput;
		protected var yInput:NumberInput;
		protected var zInput:NumberInput;
		public function Vector3dInput(title:String = "", x:Number = 0, y:Number = 0, z:Number = 0, xLabel:String = "", yLabel:String = "", zLabel:String = "" ) 
		{
			super(new FlowLayout(AsWingConstants.LEFT, 0, 0));
			titleLabel = new JLabel(title);
			xInput = new NumberInput(xLabel, String(x), 2, 3);
			yInput = new NumberInput(yLabel, String(y), 2, 3);
			zInput = new NumberInput(zLabel, String(z), 2, 3);
			createLayout();
		}
		
		protected function createLayout():void
		{
			appendAll(titleLabel, xInput, yInput, zInput);
		}
		
		public function getValue():Vector3D
		{
			return new Vector3D(xInput.getInputNumber(), yInput.getInputNumber(), zInput.getInputNumber());
		}
		
		public function serialize():String
		{
			return String(xInput.getInputNumber()) + "," + String(yInput.getInputNumber()) + "," + String(zInput.getInputNumber());
		}
		
		public function deserialize(value:String):void
		{
			var array:Array = value.split(",");
			xInput.setInputText(array[0]);
			yInput.setInputText(array[1]);
			zInput.setInputText(array[2]);
		}
		
	}

}