package particleEditor.edit 
{
	/**
	 * ...
	 * @author liaocheng
	 */
	public class EditorBaseS implements IImportable
	{
		
		public function get tagName():String
		{
			return "editor";
		}
		
		public function createNeedStuff():*
		{
			return null;
		}
		
		public function importCode(xml:XML):void
		{
			
		}
		
	}

}