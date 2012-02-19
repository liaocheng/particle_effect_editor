package  particleEditor.effect.generater
{
	import a3dparticle.generater.GeneraterBase;
	import org.aswing.ASColor;
	import org.aswing.BorderLayout;
	import org.aswing.event.AWEvent;
	import org.aswing.JComboBox;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.SoftBoxLayout;
	import org.aswing.util.Reflection;
	import org.aswing.VectorListModel;
	import particleEditor.edit.EditorBase;
	import particleEditor.edit.EditorDefinition;
	import particleEditor.edit.IExportable;
	import particleEditor.effect.generater.material.MaterialFactory;
	import particleEditor.effect.generater.shape.ShapeFactory;
	import particleEditor.effect.generater.subGenerate.SingleGeneraterEditor;
	import particleEditor.effect.generater.subGenerate.WeightGeneraterEditor;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class GeneraterFactory extends JPanel implements IExportable
	{
		private static var generaterEditors:Array = [ new EditorDefinition("single", SingleGeneraterEditor) ,new EditorDefinition("weight",WeightGeneraterEditor)];
		
		private var _shapeFactory:ShapeFactory;
		
		private var _materialFactory:MaterialFactory;
		
		private var _samplesFactory:SamplesFactory;
		
		private var _comboBox:JComboBox;
		private var _content:JPanel;
		
		private var _editorPane:EditorBase;
		
		public function GeneraterFactory() 
		{
			super(new SoftBoxLayout(SoftBoxLayout.Y_AXIS,10));
			var title:JLabel = new JLabel("create a generater for this system!");
			title.setForeground(ASColor.RED);
			append(title);
			_shapeFactory = new ShapeFactory();
			_materialFactory = new MaterialFactory();
			_samplesFactory = new SamplesFactory(_shapeFactory.createNeedStuff() as VectorListModel,_materialFactory.createNeedStuff() as VectorListModel);	
			appendAll(_shapeFactory, _materialFactory, _samplesFactory);
			
			
			_comboBox = new JComboBox(generaterEditors);
			_content = new JPanel(new BorderLayout());
			appendAll(_comboBox, _content);
			
			_comboBox.addActionListener(select);
			_comboBox.setSelectedIndex(0);
			
		}
		
		public function get tagName():String
		{
			return "generater";
		}
		
		public function getExportCode():XML
		{
			var xml:XML = new XML("<" + tagName + "/>");
			xml.appendChild(_shapeFactory.getExportCode());
			xml.appendChild(_materialFactory.getExportCode());
			xml.appendChild(_samplesFactory.getExportCode());
			var generaterXMl:XML = new XML("<output/>");
			generaterXMl.appendChild(_editorPane.getExportCode());
			xml.appendChild(generaterXMl);
			return xml;
		}
		
		public function importCode(xml:XML):void
		{
			_shapeFactory.importCode(xml[_shapeFactory.tagName][0]);
			_materialFactory.importCode(xml[_materialFactory.tagName][0]);
			_samplesFactory.importCode(xml[_samplesFactory.tagName][0]);
			
			var cls:Class = Reflection.getClass(xml.output.editor.@clazz) as Class;
			for each(var i:EditorDefinition in generaterEditors)
			{
				if (i.editorClass == cls)
				{
					_comboBox.setSelectedItem(i);
					select(null);
					_editorPane.importCode(xml.output.editor[0]);
					break;
				}
			}
		}
		
		private function select(e:AWEvent):void
		{
			
			var definition:EditorDefinition = _comboBox.getSelectedItem() as EditorDefinition;
			if (definition)
			{
				if (_editorPane)_editorPane.dispose();
				_editorPane = new definition.editorClass(_samplesFactory.createNeedStuff() as VectorListModel);
				_editorPane.setPane(_content);
				doLayout();
			}
			
		}
		
		
		public function createNeedStuff():*
		{
			return _editorPane.createNeedStuff() as GeneraterBase;
		}
	}

}