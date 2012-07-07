package particleEditor.effect.action.local
{
	import a3dparticle.animators.actions.drift.DriftLocal;
	import particleEditor.edit.EditorWithPropertyBaseS;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class DriftLocalEditorS extends LocalActionBaseS
	{
		public function DriftLocalEditorS(_varListModel:Array) 
		{
			super(_varListModel);
		}
		
		override public function createNeedStuff():*
		{
			return new DriftLocal();
		}
		
		override protected function createParamPane():EditorWithPropertyBaseS
		{
			return new DriftParamS(varListModel);
		}
		
	}

}

import a3dparticle.particle.ParticleParam;
import flash.geom.Vector3D;
import flash.utils.Dictionary;
import particleEditor.edit.EditorWithPropertyBaseS;
import particleEditor.inputer.ComboBoxInputS;
import particleEditor.inputer.VectorComboBoxS;

class DriftParamS extends EditorWithPropertyBaseS
{
	private var offsetInput:VectorComboBoxS;
	private var cycleComboBox:ComboBoxInputS;
	public function DriftParamS(varListModel:Array)
	{
		super();
		offsetInput = new VectorComboBoxS(varListModel);
		cycleComboBox = new ComboBoxInputS(varListModel);
	}
	
	override public function createNeedStuff():*
	{
		return function(param:ParticleParam, localVars:Dictionary):void
		{
			var array:Array = offsetInput.getValue();
			var x:Number = array[0]?localVars[array[0]]:0;
			var y:Number = array[1]?localVars[array[1]]:0;
			var z:Number = array[2]?localVars[array[2]]:0;
			var cycle:Number = cycleComboBox.getValue()?localVars[cycleComboBox.getValue()]:10;
			param["DriftLocal"] = new Vector3D(x, y, z, cycle);
		}
	}
	
	override public function importCode(xml:XML):void
	{
		super.importCode(xml);
		offsetInput.deserialize(xml.@offset);
		cycleComboBox.deserialize(xml.@cycle);
	}
}