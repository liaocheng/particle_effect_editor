package particleEditor.effect.action.local
{
	import a3dparticle.animators.actions.position.OffsetPositionLocal;
	import particleEditor.edit.EditorWithPropertyBaseS;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class OffsetActionEditorS extends LocalActionBaseS
	{
		
		public function OffsetActionEditorS(_varListModel:Array) 
		{
			super(_varListModel);
		}
		
		override public function createNeedStuff():*
		{
			return new OffsetPositionLocal();
		}
		
		override protected function createParamPane():EditorWithPropertyBaseS
		{
			return new OffsetParamS(varListModel);
		}
		
	}

}

import a3dparticle.particle.ParticleParam;
import flash.geom.Vector3D;
import flash.utils.Dictionary;
import particleEditor.edit.EditorWithPropertyBaseS;
import particleEditor.inputer.VectorComboBoxS;

class OffsetParamS extends EditorWithPropertyBaseS
{
	private var valueInput:VectorComboBoxS;
	
	public function OffsetParamS(varListModel:Array)
	{
		super();
		valueInput = new VectorComboBoxS(varListModel);
	}
	
	override public function createNeedStuff():*
	{
		return function(param:ParticleParam, localVars:Dictionary):void
		{
			var array:Array = valueInput.getValue();
			var x:Number = array[0]?localVars[array[0]]:0;
			var y:Number = array[1]?localVars[array[1]]:0;
			var z:Number = array[2]?localVars[array[2]]:0;
			param["OffsetPositionLocal"] = new Vector3D(x, y, z);
		}
	}
	
	override public function importCode(xml:XML):void
	{
		super.importCode(xml);
		valueInput.deserialize(xml.@offset);
	}
}