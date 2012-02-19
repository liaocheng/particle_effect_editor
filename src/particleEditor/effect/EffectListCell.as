package particleEditor.effect
{
	
	import org.aswing.Component;
	import org.aswing.event.AWEvent;
	import org.aswing.JCheckBox;
	import org.aswing.JLabel;
	import org.aswing.JList;
	import org.aswing.JLoadPane;
	import org.aswing.JPanel;
	import org.aswing.ListCell;
	
	
	public class EffectListCell implements ListCell
	{
		private var pane:JPanel;
		private var loadPane:JLoadPane;
		private var label:JLabel;
		private var check:JCheckBox;
		private var value:EffectFactory;
		
		public function EffectListCell()
		{
			pane = new JPanel();
			label = new JLabel();
			check = new JCheckBox("enable");
			
			label.setPreferredWidth(80);
			check.addActionListener(onCheck);
			pane.append(label);
			pane.append(check);
			pane.setOpaque(true);
			label.setOpaque(false);
		
		}
		
		public function setCellValue(v:*):void
		{
			value = v as EffectFactory;
			check.setSelected(value.enable);
		}
		
		public function getCellValue():*
		{
			return value;
		}
		
		public function setListCellStatus(list:JList, selected:Boolean, index:int):void
		{
			if (selected)
			{
				pane.setBackground(list.getSelectionBackground());
				pane.setForeground(list.getSelectionForeground());
			}
			else
			{
				pane.setBackground(list.getBackground());
				pane.setForeground(list.getForeground());
			}
			label.setText("effect" + index);
			label.setFont(list.getFont());
		}
		
		public function getCellComponent():Component
		{
			return pane;
		}
		
		private function onCheck(e:AWEvent):void
		{
			value.enable = check.isSelected();
		}
	}
}