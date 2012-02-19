package particleEditor.edit 
{
	/**
	 * ...
	 * @author liaocheng
	 */
	public interface IImportable 
	{
		function get tagName():String;
		function importCode(xml:XML):void;
		function createNeedStuff():*;
		
	}

}