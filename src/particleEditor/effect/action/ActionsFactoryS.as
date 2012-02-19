package particleEditor.effect.action
{
	import particleEditor.edit.EditorWithPropertyBaseS;
	import particleEditor.edit.IImportable;
	import particleEditor.edit.LocalActionProperty;
	import particleEditor.edit.Property;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class ActionsFactoryS implements IImportable
	{				
		private var _globalFactory:GlobalFactoryS;
		private var _localFactory:LocalFactoryS;
		
		public function ActionsFactoryS(varListModel:Array) 
		{			
			_globalFactory = new GlobalFactoryS();
			_localFactory = new LocalFactoryS(varListModel);
			
		}
		
		public function createNeedStuff():*
		{
			return getEnableActionList();
		}
		
		private function getEnableActionList():Array
		{
			var actions:Array = [];
			var i:int;
			var _action:EditorWithPropertyBaseS;
			var property:Property;
			
			var listModel:Array;
			
			listModel = _globalFactory.createNeedStuff() as Array;
			for (i = 0; i < listModel.length; i++)
			{
				property = listModel[i] as Property;
				actions.push(property.getNewValue());
			}
			
			listModel = _localFactory.createNeedStuff() as Array;
			for (i = 0; i < listModel.length; i++)
			{
				property = listModel[i] as Property;
				actions.push(property.getNewValue());
			}
			return actions;
		}
		
		public function getInitParamHandlers():Array
		{
			var listModel:Array=_localFactory.createNeedStuff() as Array;
			return listModel.map(function(property:LocalActionProperty, ...rest):Function{ return property.getNewInitHanlder(); } );
		}
		
		public function get tagName():String
		{
			return "action";
		}
		
		public function importCode(xml:XML):void
		{
			_globalFactory.importCode(xml[_globalFactory.tagName][0]);
			_localFactory.importCode(xml[_localFactory.tagName][0]);
		}
		
	}

}