package particleEditor.edit 
{
	import org.aswing.ASColor;
	import org.aswing.border.EmptyBorder;
	import org.aswing.border.LineBorder;
	import org.aswing.Container;
	import org.aswing.ext.Folder;
	import org.aswing.Insets;
	import org.aswing.JPanel;
	import org.aswing.SoftBoxLayout;
	import org.aswing.util.Reflection;
	import org.aswing.VectorListModel;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class EditorWithPropertyBase extends EditorBase
	{
		protected var contentPane:JPanel;
		protected var folder:Folder;
		
		protected var _property:Property;
		protected var _listModel:VectorListModel;
		
		
		protected var definition:EditorDefinition;
		
		public function EditorWithPropertyBase() 
		{
			super();
			contentPane = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 1));
			folder = new Folder();
			folder.setLayout(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 1));
			folder.append(contentPane);
			folder.setExpanded(true);
			append(folder);
			_property = createProperty();
			_property.setEditorPane(this);
			_property.setCreateHandler(this.createNeedStuff);
		}
		
		public function setDefinition(value:EditorDefinition):void
		{
			definition = value;
			setLabel(value.name);
		}
		
		public function getDefinition():EditorDefinition
		{
			return definition;
		}
		
		protected function createProperty():Property
		{
			return new Property();
		}
		
		public function setListModel(value:VectorListModel):void
		{
			_listModel = value;
			_listModel.append(_property);
		}
		
		
		public function setLabel(value:String):void
		{
			folder.setTitle(value);
		}
		
		public function getLabel():String
		{
			return folder.getTitle();
		}
		
		override public function dispose():void
		{
			super.dispose();
			if (_listModel)
			{
				_listModel.remove(_property);
			}
		}
	}

}