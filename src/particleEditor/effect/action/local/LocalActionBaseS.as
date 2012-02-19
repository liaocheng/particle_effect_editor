package particleEditor.effect.action.local
{
	import particleEditor.edit.EditorWithPropertyBaseS;
	import particleEditor.edit.LocalActionProperty;
	import particleEditor.edit.Property;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class LocalActionBaseS extends EditorWithPropertyBaseS
	{
		protected var paramPane:EditorWithPropertyBaseS;
		protected var varListModel:Array;
		
		public function LocalActionBaseS(_varListModel:Array) 
		{
			super();
			varListModel = _varListModel;
			paramPane = createParamPane();			
			(_property as LocalActionProperty).setInitParamHandler(paramPane.createNeedStuff);
		}
		
		
		override protected function createProperty():Property
		{
			return new LocalActionProperty();
		}
		
		
		protected function createParamPane():EditorWithPropertyBaseS
		{
			throw(new Error("abstract  method!"));
			return null;
		}
		
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			paramPane.importCode(xml[paramPane.tagName][0]);
		}
		
	}

}