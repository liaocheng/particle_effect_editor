package particleEditor.effect.action
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
	import particleEditor.edit.EditorWithPropertyBase;
	import particleEditor.edit.IExportable;
	import particleEditor.edit.Property;
	import particleEditor.effect.action.global.*;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class GlobalFactory extends JPanel implements IExportable
	{
		
		private static const globalAction:Array = [ new EditorDefinition("velocity",VelocityGlobalEditor) , new EditorDefinition("accelerate",AccelerateGlobalEditor) , new EditorDefinition("billboard",BillboardEditor) ,
													new EditorDefinition("scale by life",ScaleByLifeGlobalEditor), new EditorDefinition("scale by time",ScaleByTimeGlobalEditor), new EditorDefinition("bezier",BezierGlobalEditor),
													new EditorDefinition("broken line", BrokenLineGlobalEditor), new EditorDefinition("color by life", ChangeColorByLifeGlobalEditor), new EditorDefinition("flicker", FlickerGlobalEditor),
													new EditorDefinition("rotate by speed", AutoRotateGlobalEditor), new EditorDefinition("UV linear ease", UVLinearEaseGlobalEditor),new EditorDefinition("UV drift",UVDriftGlobalEditor),
													new EditorDefinition("UV seq pic by time", UVSeqPicByTimeGlobalEditor), new EditorDefinition("UV seq pic by life", UVSeqPicByLifeGlobalEditor)];
		private var comboBox:JComboBox;
		
		private var content:JPanel;
		
		private var _actionsModel:VectorListModel = new VectorListModel();
		private var _comboModel:VectorListModel = new VectorListModel();
		
		private var _titleHandler:Function;
		
		public function GlobalFactory(titleHandler:Function)
		{
			super(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 5));
			_titleHandler = titleHandler;
			
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
			_titleHandler("global actions: has created " + content.getComponentCount());
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
				var _editor:ActionEditorBase = new definition.editorClass;
				_editor.setDefinition(definition);
				_editor.setListModel(_actionsModel);
				_editor.setPane(content);
				refreshCombox();
			}
		}
		
		private function refreshCombox(e:*=null):void
		{
			_comboModel.clear();
			for each(var i:EditorDefinition in globalAction)
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
			return "global";
		}
		
		public function getExportCode():XML
		{
			var xml:XML = new XML("<" + tagName + "/>");
			for each(var i:Property in _actionsModel.toArray())
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
				var _editor:EditorWithPropertyBase = Reflection.createInstance(i.@clazz) as EditorWithPropertyBase;
				for each(var definition:EditorDefinition in globalAction)
				{
					if (_editor is definition.editorClass)
					{
						_editor.setDefinition(definition);
						break;
					}
				}
				_editor.setListModel(_actionsModel);
				_editor.setPane(content);
				_editor.importCode(i);
			}
			refreshCombox();
		}
	}

}