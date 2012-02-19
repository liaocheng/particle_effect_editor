package particleEditor.inputer
{
	import org.aswing.AsWingConstants;
	import org.aswing.FlowLayout;
	import org.aswing.JComboBox;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class ComboBoxInput extends JPanel implements ISerializable
	{
		protected var comboBox:JComboBox;
		protected var label:JLabel;
		
		public function ComboBoxInput(title:String="",listData:*=null) 
		{
			super(new FlowLayout(AsWingConstants.LEFT,5,0,false));
			comboBox = new JComboBox(listData);
			label = new JLabel(title);
			comboBox.setPreferredWidth(120);
			appendAll(label, comboBox);
		}
		
		public function getValue():*
		{
			return comboBox.getSelectedItem();
		}
		
		public function serialize():String 
		{
			return String(comboBox.getSelectedIndex());
		}
		public function deserialize(value:String):void
		{
			comboBox.setSelectedIndex(int(value));
		}
		
		public function getComboBox():JComboBox
		{
			return comboBox;
		}
		
	}

}