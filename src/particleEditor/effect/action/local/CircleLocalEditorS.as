package particleEditor.effect.action.local
{
	import a3dparticle.animators.actions.circle.CircleLocal;
	import particleEditor.edit.EditorWithPropertyBaseS;
	import particleEditor.inputer.VectorDegreeInputS;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class CircleLocalEditorS extends LocalActionBaseS
	{		
		private var eulersInput:VectorDegreeInputS;
		public function CircleLocalEditorS(_varListModel:Array) 
		{
			super(_varListModel);
			eulersInput = new VectorDegreeInputS();
		}
		
		override public function createNeedStuff():*
		{
			return new CircleLocal(null,eulersInput.getValue());
		}
		
		override protected function createParamPane():EditorWithPropertyBaseS
		{
			return new CircleParamS(varListModel);
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			eulersInput.deserialize(xml.@eulers);
		}
		
	}

}

import a3dparticle.particle.ParticleParam;
import flash.geom.Vector3D;
import flash.utils.Dictionary;
import particleEditor.edit.EditorWithPropertyBaseS;
import particleEditor.inputer.ComboBoxInputS;

class CircleParamS extends EditorWithPropertyBaseS
{
	private var radiusComboBox:ComboBoxInputS;
	private var cycleComboBox:ComboBoxInputS;
	public function CircleParamS(varListModel:Array)
	{
		super();
		radiusComboBox = new ComboBoxInputS(varListModel);
		cycleComboBox = new ComboBoxInputS(varListModel);
	}
	
	override public function createNeedStuff():*
	{
		return function(param:ParticleParam, localVars:Dictionary):void
		{
			var radius:Number = radiusComboBox.getValue()?localVars[radiusComboBox.getValue()]:10;
			var cycle:Number = cycleComboBox.getValue()?localVars[cycleComboBox.getValue()]:10;
			param["CircleLocal"] = new Vector3D(radius, cycle);
		}
	}
	
	override public function importCode(xml:XML):void
	{
		super.importCode(xml);
		radiusComboBox.deserialize(xml.@radius);
		cycleComboBox.deserialize(xml.@cycle);
	}
}