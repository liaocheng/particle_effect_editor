package particleEditor.effect.action
{
	import org.aswing.ASColor;
	import org.aswing.border.EmptyBorder;
	import org.aswing.border.LineBorder;
	import org.aswing.Container;
	import org.aswing.Insets;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.SoftBoxLayout;
	import org.aswing.VectorListModel;
	import particleEditor.edit.IExportable;
	import particleEditor.edit.LocalActionProperty;
	import particleEditor.edit.Property;
	import particleEditor.utils.FrameFolder;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class ActionsFactory extends JPanel implements IExportable
	{				
		private var _globalFactory:GlobalFactory;
		private var _localFactory:LocalFactory;
		
		public function ActionsFactory(actionParamPane:Container,varListModel:VectorListModel) 
		{
			super(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 5));
			
			var title:JLabel = new JLabel("add some actions for this system!");
			title.setForeground(ASColor.RED);
			title.setPreferredWidth(250);
			append(title);
			
			
			var folder1:FrameFolder = new FrameFolder("global actions");
			folder1.setLayout(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 1));
			folder1.setBorder(new EmptyBorder(new LineBorder(new EmptyBorder(null,new Insets(2,2,2,2))), new Insets(0, 10, 0, 10)));
			var folder2:FrameFolder = new FrameFolder("local actions");
			folder2.setLayout(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 1));
			folder2.setBorder(new EmptyBorder(new LineBorder(new EmptyBorder(null, new Insets(2, 2, 2, 2))), new Insets(0, 10, 0, 10)));
			
			
			_globalFactory = new GlobalFactory(folder1.setTitle);
			_localFactory = new LocalFactory(folder2.setTitle,actionParamPane,varListModel);
			
			
			folder1.setContent(_globalFactory);
			folder2.setContent(_localFactory);
			appendAll(folder1, folder2);
			
		}
		
		public function createNeedStuff():*
		{
			return getEnableActionList();
		}
		
		private function getEnableActionList():Array
		{
			var actions:Array = [];
			var i:int;
			var _action:ActionEditorBase;
			var property:Property;
			
			var listModel:VectorListModel;
			
			listModel = _globalFactory.createNeedStuff() as VectorListModel;
			for (i = 0; i < listModel.getSize(); i++)
			{
				property = listModel.getElementAt(i) as Property;
				if ((property.getEditorPane() as ActionEditorBase).getEnabled())
				{
					actions.push(property.getNewValue());
				}
			}
			
			listModel = _localFactory.createNeedStuff() as VectorListModel;
			for (i = 0; i < listModel.getSize(); i++)
			{
				property = listModel.getElementAt(i) as Property;
				if ((property.getEditorPane() as ActionEditorBase).getEnabled())
				{
					actions.push(property.getNewValue());
				}
			}
			return actions;
		}
		
		public function getInitParamHandlers():Array
		{
			var listModel:VectorListModel=_localFactory.createNeedStuff() as VectorListModel;
			return listModel.toArray().map(function(property:LocalActionProperty, ...rest):Function{ return property.getNewInitHanlder(); } );
		}
		
		public function get tagName():String
		{
			return "action";
		}
		
		public function getExportCode():XML
		{
			var xml:XML = new XML("<" + tagName + "/>");
			xml.appendChild(_globalFactory.getExportCode());
			xml.appendChild(_localFactory.getExportCode());
			return xml;
		}
		
		public function importCode(xml:XML):void
		{
			_globalFactory.importCode(xml[_globalFactory.tagName][0]);
			_localFactory.importCode(xml[_localFactory.tagName][0]);
		}
		
	}

}