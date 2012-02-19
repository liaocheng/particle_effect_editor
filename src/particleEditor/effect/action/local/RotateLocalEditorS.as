package particleEditor.effect.action.local
{
	import a3dparticle.animators.actions.rotation.RandomRotateLocal;
	import particleEditor.edit.EditorWithPropertyBaseS;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class RotateLocalEditorS extends LocalActionBaseS
	{
		
		public function RotateLocalEditorS(_varListModel:Array) 
		{
			super(_varListModel);
		}
		
		override public function createNeedStuff():*
		{
			return new RandomRotateLocal();
		}
		
		override protected function createParamPane():EditorWithPropertyBaseS
		{
			return new RotateParamS(varListModel);
		}
		
	}

}

import a3dparticle.particle.ParticleParam;
import flash.geom.Vector3D;
import flash.utils.Dictionary;
import particleEditor.edit.EditorWithPropertyBaseS;
import particleEditor.inputer.ComboBoxInputS;
import particleEditor.inputer.VectorComboBoxS;

class RotateParamS extends EditorWithPropertyBaseS
{
	private var axisInput:VectorComboBoxS;
	private var cycleComboBox:ComboBoxInputS;
	public function RotateParamS(varListModel:Array)
	{
		super();
		axisInput = new VectorComboBoxS(varListModel);
		
		cycleComboBox = new ComboBoxInputS(varListModel);
	}
	
	override public function createNeedStuff():*
	{
		return function(param:ParticleParam, localVars:Dictionary):void
		{
			var array:Array = axisInput.getValue();
			var x:Number = array[0]?localVars[array[0]]:0;
			var y:Number = array[1]?localVars[array[1]]:0;
			var z:Number = array[2]?localVars[array[2]]:1;
			var cycle:Number = cycleComboBox.getValue()?localVars[cycleComboBox.getValue()]:10;
			param["RandomRotateLocal"] = new Vector3D(x, y, z, cycle);
		}
	}
		
	override public function importCode(xml:XML):void
	{
		super.importCode(xml);
		axisInput.deserialize(xml.@axis);
		cycleComboBox.deserialize(xml.@cycle);
	}
}