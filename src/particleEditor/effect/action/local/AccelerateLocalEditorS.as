package particleEditor.effect.action.local
{
	import a3dparticle.animators.actions.acceleration.AccelerateLocal;
	import particleEditor.edit.EditorWithPropertyBaseS;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class AccelerateLocalEditorS extends LocalActionBaseS
	{
				
		public function AccelerateLocalEditorS(_varListModel:Array) 
		{
			super(_varListModel);
		}
		
		override public function createNeedStuff():*
		{
			return new AccelerateLocal();
		}
		
		override protected function createParamPane():EditorWithPropertyBaseS
		{
			return new AccelerateParamS(varListModel);
		}
		
	}
		

}

import a3dparticle.particle.ParticleParam;
import flash.geom.Vector3D;
import flash.utils.Dictionary;
import particleEditor.edit.EditorWithPropertyBaseS;
import particleEditor.inputer.VectorComboBoxS;

class AccelerateParamS extends EditorWithPropertyBaseS
{
	private var valueInput:VectorComboBoxS;

	public function AccelerateParamS(varListModel:Array)
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
			param["AccelerateLocal"] = new Vector3D(x, y, z);
		}
	}
	
	override public function importCode(xml:XML):void
	{
		super.importCode(xml);
		valueInput.deserialize(xml.@accelerate);
	}
}