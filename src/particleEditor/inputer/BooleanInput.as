package particleEditor.inputer
{
	import org.aswing.JCheckBox;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class BooleanInput extends JCheckBox implements ISerializable
	{
		
		public function BooleanInput(title:String) 
		{
			super(title);
		}
		
		public function serialize():String
		{
			return String(int(isSelected()));
		}
		public function deserialize(value:String):void
		{
			setSelected(Boolean(int(value)));
		}
		
		public function getValue():Boolean
		{
			return isSelected();
		}
		
	}

}