package  particleEditor.edit
{
	import flash.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class Property 
	{
		public var name:String;
		private var _handler:Function;
		private var _editorPane:DisplayObjectContainer;
		
		public function Property() 
		{
			 
		}
		
		public function setCreateHandler(value:Function):void
		{
			_handler = value;
		}
		
		public function getNewValue():*
		{
			return _handler();
		}
		
		public function toString():String
		{
			return name;
		}
		
		public function setEditorPane(value:DisplayObjectContainer):void
		{
			_editorPane = value;
		}
		
		public function getEditorPane():DisplayObjectContainer
		{
			return _editorPane;
		}
	}

}