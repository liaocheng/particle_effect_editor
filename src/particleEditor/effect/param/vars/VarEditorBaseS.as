package particleEditor.effect.param.vars
{
	import particleEditor.edit.EditorWithPropertyBaseS;
	import particleEditor.edit.Property;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class VarEditorBaseS extends EditorWithPropertyBaseS
	{
		
		protected var _varListModel:Array;
		
		protected var _varPropertys:Array = [];
		
		public function VarEditorBaseS() 
		{
			 super();
		}
		
		public function setVarListModel(varListModel:Array):void
		{
			_varListModel = varListModel;
			for each(var i:* in _varPropertys)
			{
				_varListModel.push(i);
			}
		}
		
		protected function addVarProperty(name:String):void
		{
			var property:Property = new Property();
			property.name = getVarPropertyName(name);
			_varPropertys.push(property);
			if (_varListModel)_varListModel.append(property);
		}
		
		protected function getVarPropertyName(name:String):String
		{
			return name;;
		}
		
		protected function getVarProperty(name:String):Property
		{
			for each(var i:Property in _varPropertys)
			{
				if (i.name == getVarPropertyName(name))
				{
					return i;
				}
			}
			return null;
		}
		
	}

}