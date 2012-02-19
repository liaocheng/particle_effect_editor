package  particleEditor.effect.param
{
	import flash.events.Event;
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
	import particleEditor.edit.IExportable;
	import particleEditor.edit.Property;
	import particleEditor.effect.param.vars.ConstNumberVarEditor;
	import particleEditor.effect.param.vars.RandomNumberVarEditor;
	import particleEditor.effect.param.vars.EaseNumberEditor;
	import particleEditor.effect.param.vars.RandomCircleVarEditor;
	import particleEditor.effect.param.vars.RandomGlobeVarEditor;
	import particleEditor.effect.param.vars.VarEditorBase;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class LocalVarFactory extends JPanel implements IExportable
	{
		
		private static const varEditors:Array = [ new EditorDefinition("const number", ConstNumberVarEditor), new EditorDefinition("random number", RandomNumberVarEditor), new EditorDefinition("ease number", EaseNumberEditor),
												 new EditorDefinition("random circle", RandomCircleVarEditor),new EditorDefinition("random globe", RandomGlobeVarEditor) ];
		
		private var comboBox:JComboBox;
		
		private var content:JPanel;
		
		private var _varsModel:VectorListModel = new VectorListModel();
		
		private var _funModel:VectorListModel = new VectorListModel();
		
		private var _titleHandler:Function;
		
		public function LocalVarFactory(titleHandler:Function)
		{
			super(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 5));
			_titleHandler = titleHandler;
			
			comboBox = new JComboBox(varEditors);
			comboBox.setPreferredWidth(120);
			var addButton:JButton = new JButton("add");
			var pane:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS,5));
			pane.appendAll(new JLabel("new var"), comboBox, addButton);
			
			content = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 5));
			
			appendAll(pane, content);
			
			addButton.addActionListener(addVar);
			
			content.addEventListener(ContainerEvent.COM_ADDED, refreshTitle);
			content.addEventListener(ContainerEvent.COM_REMOVED, refreshTitle);
			refreshTitle(null);
		}
		
		private function refreshTitle(e:Event):void
		{
			_titleHandler("local vars: has created " + content.getComponentCount());
		}
		
		private function addVar(e:AWEvent):void
		{
			var definition:EditorDefinition = comboBox.getSelectedItem() as EditorDefinition;
			if (definition)
			{
				var _editor:VarEditorBase = new definition.editorClass;
				_editor.setDefinition(definition);
				_editor.setListModel(_funModel);
				_editor.setPane(content);
				_editor.setVarListModel(_varsModel);
			}
		}
		
		public function getVarListModel():VectorListModel
		{
			return _varsModel;
		}
		
		public function createNeedStuff():*
		{
			return _funModel.toArray().map(function(property:Property,...rest):* { return property.getNewValue();});
		}
		
		public function get tagName():String
		{
			return "vars";
		}
		
		public function getExportCode():XML
		{
			var xml:XML = new XML("<" + tagName + "/>");
			for each(var i:Property in _funModel.toArray())
			{
				var _editor:EditorBase = i.getEditorPane() as EditorBase;
				xml.appendChild(_editor.getExportCode());
			}
			return xml;
		}
		
		public function importCode(xml:XML):void
		{
			for each(var i:XML in xml.editor)
			{
				var _editor:VarEditorBase = Reflection.createInstance(i.@clazz) as VarEditorBase;
				for each(var definition:EditorDefinition in varEditors)
				{
					if (_editor is definition.editorClass)
					{
						_editor.setDefinition(definition);
						break;
					}
				}
				_editor.setListModel(_funModel);
				_editor.setPane(content);
				_editor.setVarListModel(_varsModel);
				_editor.importCode(i);
			}
		}
		
	}

}