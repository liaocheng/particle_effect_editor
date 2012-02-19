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
	public class EditorBase extends JPanel implements IExportable
	{
		
		protected var _parentPane:Container;
		
		public function EditorBase() 
		{
			super(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 1));
			setBorder(new EmptyBorder(new LineBorder(new EmptyBorder(null,new Insets(2,2,2,2)), new ASColor(0xff0000)), new Insets(0, 10, 0, 10)));
		}
		
		public function get tagName():String
		{
			return "editor";
		}
		
		public function setPane(value:Container):void
		{
			_parentPane = value;
			_parentPane.append(this);
		}
		
		public function getExportCode():XML
		{
			var xml:XML = new XML("<" + tagName + "/>");
			xml.@clazz = Reflection.getFullClassName(this);
			return xml;
		}
		
		public function createNeedStuff():*
		{
			return null;
		}
		
		public function importCode(xml:XML):void
		{
			
		}
		
		public function dispose():void
		{
			if (_parentPane)
			{
				_parentPane.remove(this);
			}
		}
	}

}