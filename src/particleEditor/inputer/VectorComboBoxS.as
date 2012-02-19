package particleEditor.inputer
{
	/**
	 * ...
	 * @author liaocheng
	 */
	public class VectorComboBoxS implements IDeserializable
	{
		protected var xComboInput:ComboBoxInputS;
		protected var yComboInput:ComboBoxInputS;
		protected var zComboInput:ComboBoxInputS;
		public function VectorComboBoxS(listData:*= null)
		{
			xComboInput = new ComboBoxInputS(listData);
			yComboInput = new ComboBoxInputS(listData);
			zComboInput = new ComboBoxInputS(listData);
		}
		
		public function getValue():Array
		{
			return [xComboInput.getValue(), yComboInput.getValue(), zComboInput.getValue()];
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