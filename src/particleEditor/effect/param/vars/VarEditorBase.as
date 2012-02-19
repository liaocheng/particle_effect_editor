package particleEditor.effect.param.vars
{
	import flash.events.Event;
	import org.aswing.event.AWEvent;
	import org.aswing.VectorListModel;
	import particleEditor.edit.Property;
	import particleEditor.edit.VarNameEditorBase;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class VarEditorBase extends VarNameEditorBase
	{
		
		protected var _varListModel:VectorListModel;
		
		protected var _varPropertys:Array = [];
		
		public function VarEditorBase() 
		{
			 super();
		}
				
		public function setVarListModel(varListModel:VectorListModel):void
		{
			_varListModel = varListModel;
			_varListModel.appendAll(_varPropertys);
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
			return getVarName() + "." + name;;
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
		
		override protected function onEnter(e:Event):void
		{
			super.onEnter(e);
			for each(var i:Property in _varPropertys)
			{
				i.name = getVarName() + "." + i.name.split(".")[1];
				_varListModel.valueChanged(i);
			}
		}
		
		override protected function onDelete(e:AWEvent):void
		{
			super.onDelete(e);
			if (_varListModel)
			{
				for each(var i:Property in _varPropertys)
				{
					_varListModel.remove(i);
				}
			}
		}
		
	}

}