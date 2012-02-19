package particleEditor.effect.generater.material
{
	import flash.events.Event;
	import org.aswing.border.LineBorder;
	import org.aswing.event.AWEvent;
	import org.aswing.event.ContainerEvent;
	import org.aswing.JButton;
	import org.aswing.JComboBox;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.SoftBoxLayout;
	import org.aswing.util.Reflection;
	import org.aswing.VectorListModel;
	import particleEditor.edit.EditorBase;
	import particleEditor.edit.EditorDefinition;
	import particleEditor.edit.EditorWithPropertyBase;
	import particleEditor.edit.IExportable;
	import particleEditor.edit.Property;
	
	/**
	 * ...
	 * @author liaocheng
	 */
	public class MaterialFactory extends JPanel implements IExportable
	{
		
		private static const materialEditors:Array = [new EditorDefinition("color material", ColorMaterialEditor),new EditorDefinition("bitmap material",BitmapMaterialEditor)];
		
		private var comboBox:JComboBox;
		
		private var content:JPanel;
		
		private var _materialsModel:VectorListModel = new VectorListModel();
		
		private var title:JLabel;
		
		public function MaterialFactory()
		{
			super(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 5));
			setBorder(new LineBorder());

			comboBox = new JComboBox(materialEditors);
			comboBox.setPreferredWidth(120);
			var addButton:JButton = new JButton("add");
			var pane:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 5));
			pane.appendAll(new JLabel("new material"), comboBox, addButton);
			
			content = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 5));
			
			title = new JLabel("", null, JLabel.LEFT);
			refreshTitle(null);
			content.addEventListener(ContainerEvent.COM_ADDED, refreshTitle);
			content.addEventListener(ContainerEvent.COM_REMOVED, refreshTitle);
			
			appendAll(title, pane, content);
			
			addButton.addActionListener(addMaterial);
		}
		
		public function get tagName():String
		{
			return "material";
		}
		
		public function getExportCode():XML
		{
			var xml:XML = new XML("<" + tagName + "/>");
			for each (var i:Property in _materialsModel.toArray())
			{
				var _editor:EditorBase = i.getEditorPane() as EditorBase;
				xml.appendChild(_editor.getExportCode());
			}
			return xml;
		}
		
		public function importCode(xml:XML):void
		{
			for each (var i:XML in xml.editor)
			{
				var _editor:EditorWithPropertyBase = Reflection.createInstance(i.@clazz) as EditorWithPropertyBase;
				for each(var definition:EditorDefinition in materialEditors)
				{
					if (_editor is definition.editorClass)
					{
						_editor.setDefinition(definition);
						break;
					}
				}
				_editor.setListModel(_materialsModel);
				_editor.setPane(content);
				_editor.importCode(i);
			}
		}
		
		public function createNeedStuff():*
		{
			return _materialsModel;
		}
		
		private function addMaterial(e:AWEvent):void
		{
			var definition:EditorDefinition = comboBox.getSelectedItem() as EditorDefinition;
			if (definition)
			{
				var _editor:EditorWithPropertyBase = new definition.editorClass;
				_editor.setDefinition(definition);
				_editor.setListModel(_materialsModel);
				_editor.setPane(content);
			}
		}
		
		private function refreshTitle(e:Event):void
		{
			title.setText("material: has created " + content.getComponentCount());
		}
	
	}

}