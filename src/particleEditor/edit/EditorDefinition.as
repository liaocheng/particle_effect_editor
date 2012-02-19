package  particleEditor.edit
{
	import flash.utils.getDefinitionByName;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class EditorDefinition 
	{
		private var _name:String;
		private var _editorClass:Class;
		public function EditorDefinition(name:String,editorClass:Class) 
		{
			_name = name;
			_editorClass = editorClass;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get editorClass():Class
		{
			return _editorClass;
		}
		
		public function toString():String
		{
			return _name;
		}
		
		public static function getClassByName(value:String):Class
		{
			return getDefinitionByName(value) as Class;
		}
		
		public static function getClassByNameS(value:String):Class
		{
			return getDefinitionByName(value+"S") as Class;
		}
		
	}

}