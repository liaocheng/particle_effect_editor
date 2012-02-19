package particleEditor.edit 
{
	import flash.events.Event;
	import org.aswing.event.AWEvent;
	import org.aswing.JButton;
	import org.aswing.JCheckBox;
	import org.aswing.JPanel;
	import org.aswing.SoftBoxLayout;
	import particleEditor.inputer.LabelInput;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class VarNameEditorBase extends EditorWithPropertyBase 
	{
		protected var nameInput:LabelInput;
		protected var delButton:JButton;
		protected var enableButton:JCheckBox;
		
		protected var pane:JPanel;
		
		public function VarNameEditorBase() 
		{
			super();
			nameInput = new LabelInput("name:", "", 2, 8);
			delButton = new JButton("Del");
			enableButton = new JCheckBox("Enable");
			enableButton.setSelected(true);
			pane = new JPanel(new SoftBoxLayout());
			pane.appendAll(nameInput,delButton);
			contentPane.append(pane);
			delButton.addActionListener(onDelete);
			nameInput.addEventListener(AWEvent.ACT, onEnter);
		}
		
		protected function setShowEnable(value:Boolean):void
		{
			if (value && !enableButton.getParent())
			{
				pane.removeAll();
				pane.appendAll(nameInput,enableButton,delButton);
			}
			if (!value && enableButton.getParent())
			{
				pane.removeAll();
				pane.appendAll(nameInput,delButton);
			}
		}
		
		public function getEnabled():Boolean
		{
			return enableButton.isSelected();
		}
		
		public function getVarName():String
		{
			return nameInput.getInputText();
		}
		
		protected function onEnter(e:Event):void
		{
			_property.name = getVarName();
			_listModel.valueChanged(_property);
		}
		
		protected function onDelete(e:AWEvent):void
		{
			dispose();
		}
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			xml.@varName = getVarName();
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			nameInput.setInputText(xml.@varName);
			onEnter(null);
		}
	}

}