package particleEditor.effect.action.local
{
	import a3dparticle.animators.actions.bezier.BezierCurvelocal;
	import particleEditor.edit.EditorWithPropertyBaseS;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class BezierLocalEditorS extends LocalActionBaseS
	{
		
		public function BezierLocalEditorS(_varListModel:Array) 
		{
			super(_varListModel);
		}
		
		override public function createNeedStuff():*
		{
			return new BezierCurvelocal();
		}
		
		override protected function createParamPane():EditorWithPropertyBaseS
		{
			return new BezierParamS(varListModel);
		}
		
	}

}

import a3dparticle.particle.ParticleParam;
import flash.geom.Vector3D;
import flash.utils.Dictionary;
import particleEditor.edit.EditorWithPropertyBaseS;
import particleEditor.inputer.VectorComboBoxS;

class BezierParamS extends EditorWithPropertyBaseS
{
	private var controlInput:VectorComboBoxS;
	private var endInput:VectorComboBoxS;
	public function BezierParamS(varListModel:Array)
	{
		super();
		controlInput = new VectorComboBoxS(varListModel);
		endInput = new VectorComboBoxS(varListModel);
	}
	
	override public function createNeedStuff():*
	{
		return function(param:ParticleParam, localVars:Dictionary):void
		{
			var array:Array = controlInput.getValue();
			var x1:Number = array[0]?localVars[array[0]]:0;
			var y1:Number = array[1]?localVars[array[1]]:0;
			var z1:Number = array[2]?localVars[array[2]]:0;
			
			array = endInput.getValue();
			var x2:Number = array[0]?localVars[array[0]]:0;
			var y2:Number = array[1]?localVars[array[1]]:0;
			var z2:Number = array[2]?localVars[array[2]]:0;
			param["BezierCurvelocal"] = [new Vector3D(x1, y1, z1), new Vector3D(x2, y2, z2)];
		}
	}
	
	override public function importCode(xml:XML):void
	{
		super.importCode(xml);
		controlInput.deserialize(xml.@control);
		endInput.deserialize(xml.@end);
	}
}