package particleEditor.effect.generater.shape 
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
	public class ShapeFactory extends JPanel implements IExportable
	{
		
		private static const shapeEditors:Array = [ new EditorDefinition("shpere", SphereEditor) , new EditorDefinition("plane", PlaneEditor) , 
													new EditorDefinition("cube", CubeEditor), new EditorDefinition("external model", FileModelEditor)];
		
		private var comboBox:JComboBox;
		
		private var content:JPanel;
		
		private var _shapesModel:VectorListModel = new VectorListModel();
		
		private var title:JLabel;
		
		public function ShapeFactory() 
		{
			super(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 5));
			setBorder(new LineBorder());

			comboBox = new JComboBox(shapeEditors);
			comboBox.setPreferredWidth(120);
			var addButton:JButton = new JButton("add");
			var pane:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS,5));
			pane.appendAll(new JLabel("new shape"), comboBox, addButton);
			
			content = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 5));
			
			title = new JLabel("", null, JLabel.LEFT);
			refreshTitle(null);
			content.addEventListener(ContainerEvent.COM_ADDED, refreshTitle);
			content.addEventListener(ContainerEvent.COM_REMOVED, refreshTitle);
			appendAll(title, pane, content);
			
			addButton.addActionListener(addShape);
		}
		
		public function get tagName():String
		{
			return "shape";
		}
		
		public function getExportCode():XML
		{
			var xml:XML = new XML("<" + tagName + "/>");
			for each(var i:Property in _shapesModel.toArray())
			{
				var shapeEditor:EditorBase = i.getEditorPane() as EditorBase;
				xml.appendChild(shapeEditor.getExportCode());
			}
			return xml;
		}
		public function importCode(xml:XML):void
		{
			for each(var i:XML in xml.editor)
			{
				var _editor:EditorWithPropertyBase = Reflection.createInstance(i.@clazz) as EditorWithPropertyBase;
				for each(var definition:EditorDefinition in shapeEditors)
				{
					if (_editor is definition.editorClass)
					{
						_editor.setDefinition(definition);
						break;
					}
				}
				_editor.setListModel(_shapesModel);
				_editor.setPane(content);
				_editor.importCode(i);
			}
		}
		
		public function createNeedStuff():*
		{
			return _shapesModel;
		}
		
		
		private function addShape(e:AWEvent):void
		{
			var definition:EditorDefinition = comboBox.getSelectedItem() as EditorDefinition;
			if (definition)
			{
				var _editor:EditorWithPropertyBase = new definition.editorClass;
				_editor.setDefinition(definition);
				_editor.setListModel(_shapesModel);
				_editor.setPane(content);
			}
		}
		
		private function refreshTitle(e:Event):void
		{
			title.setText("shapes: has created " + content.getComponentCount());
		}
		
	}

}