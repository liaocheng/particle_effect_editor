package  particleEditor.effect.param
{
	import particleEditor.edit.IImportable;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class InitParamFactoryS implements IImportable
	{
		
		private var _localVarFactory:LocalVarFactoryS;
		
		private var timeSelectionPane:TimeSelectionS;
		
		public function InitParamFactoryS() 
		{
			_localVarFactory = new LocalVarFactoryS();			
			timeSelectionPane = new TimeSelectionS(getVarListModel());
		}
		
		
		public function getVarListModel():Array
		{
			return _localVarFactory.getVarListModel();
		}
				
		public function createNeedStuff():*
		{
			return _localVarFactory.createNeedStuff();
		}
		
		public function getTimeHanlder():Function
		{
			return timeSelectionPane.createNeedStuff() as Function;
		}
		
		public function get tagName():String
		{
			return _localVarFactory.tagName;
		}
		
		public function importCode(code:XML):void
		{
			_localVarFactory.importCode(code);
			timeSelectionPane.importCode(code.exception.editor[0]);
		}
		
	}

}