package particleEditor.effect.action
{
	import flash.events.Event;
	import org.aswing.Container;
	import org.aswing.event.AWEvent;
	import org.aswing.event.ContainerEvent;
	import org.aswing.JButton;
	import org.aswing.JComboBox;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.SoftBoxLayout;
	import org.aswing.util.Reflection;
	import org.aswing.VectorListModel;
	import particleEditor.edit.EditorDefinition;
	import particleEditor.edit.IExportable;
	import particleEditor.edit.Property;
	import particleEditor.effect.action.local.*;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class LocalFactory extends JPanel implements IExportable
	{
		
		private static const localAction:Array = [ new EditorDefinition("velocity",VelocityLocalEditor) , new EditorDefinition("offset", OffsetActionEditor), new EditorDefinition("accelerate",AccelerateLocalEditor) ,
													new EditorDefinition("circle",CircleLocalEditor) , new EditorDefinition("drift",DriftLocalEditor), new EditorDefinition("scale",RandomScaleLocalEditor) ,
													new EditorDefinition("bezier", BezierLocalEditor), new EditorDefinition("rotation", RotateLocalEditor), new EditorDefinition("UV seq pic by time", UVSeqPicByTimeLocalEditor),
													new EditorDefinition("color", ColorTransformEditor)];
		private var comboBox:JComboBox;
		
		private var content:JPanel;
		
		
		private var _actionsModel:VectorListModel = new VectorListModel();
		private var _comboModel:VectorListModel = new VectorListModel();
		
		private var _actionParamPane:Container;
		private var _varListModel:VectorListModel;
		
		private var _titleHandler:Function;
		
		public function LocalFactory(titleHandler:Function,actionParamPane:Container,varListModel:VectorListModel)
		{
			super(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 5));
			_titleHandler = titleHandler;
			_actionParamPane = actionParamPane;
			_varListModel = varListModel;
			comboBox = new JComboBox(_comboModel);
			comboBox.setPreferredWidth(140);
			var addButton:JButton = new JButton("add");
			var pane:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS,5));
			pane.appendAll(new JLabel("new action"), comboBox, addButton);
			
			content = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 5));
			
			appendAll( pane, content);
			
			addButton.addActionListener(addAction);
			content.addEventListener(ContainerEvent.COM_REMOVED, refreshCombox);
			content.addEventListener(ContainerEvent.COM_REMOVED, refreshTitle);
			content.addEventListener(ContainerEvent.COM_ADDED, refreshTitle);
			refreshCombox();
			refreshTitle(null);
		}
		
		private function refreshTitle(e:Event):void
		{
			_titleHandler("local actions: has created " + content.getComponentCount());
		}
			
		public function createNeedStuff():*
		{
			return _actionsModel;
		}
		
		private function addAction(e:AWEvent):void
		{
			var definition:EditorDefinition = comboBox.getSelectedItem() as EditorDefinition;
			if (definition)
			{
				var _editor:LocalActionBase = new definition.editorClass(_varListModel);
				_editor.setDefinition(definition);
				_editor.setListModel(_actionsModel);
				_editor.setPane(content);
				_editor.setParamContainer(_actionParamPane);
				refreshCombox();
			}
		}
		
		private function refreshCombox(e:*=null):void
		{
			_comboModel.clear();
			for each(var i:EditorDefinition in localAction)
			{
				var j:int;
				for (j = 0; j < content.getComponentCount(); j++)
				{
					if (i == (content.getComponent(j) as ActionEditorBase).getDefinition()) break;
				}
				if (j == content.getComponentCount())
				{
					_comboModel.append(i);
				}
			}
			comboBox.setSelectedIndex( -1);
		}
		
		public function get tagName():String
		{
			return "local";
		}
		
		public function getExportCode():XML
		{
			var xml:XML = new XML("<" + tagName + "/>");
			for each(var i:Property in _actionsModel.toArray())
			{
				var _editor:LocalActionBase = i.getEditorPane() as LocalActionBase;
				xml.appendChild(_editor.getExportCode());
			}
			return xml;
		}
		
		public function importCode(xml:XML):void
		{
			for each(var i:XML in xml.editor)
			{
				var cls:Class = Reflection.getClass(i.@clazz);
				var _editor:LocalActionBase = new cls(_varListModel) as LocalActionBase;
				for each(var definition:EditorDefinition in localAction)
				{
					if (_editor is definition.editorClass)
					{
						_editor.setDefinition(definition);
						break;
					}
				}
				_editor.setListModel(_actionsModel);
				_editor.setPane(content);
				_editor.setParamContainer(_actionParamPane);
				_editor.importCode(i);
			}
			refreshCombox();
		}
		
	}

}