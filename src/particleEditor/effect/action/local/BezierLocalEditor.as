package particleEditor.effect.action.local
{
	import a3dparticle.animators.actions.ActionBase;
	import a3dparticle.animators.actions.bezier.BezierCurvelocal;
	import org.aswing.VectorListModel;
	import particleEditor.edit.EditorWithPropertyBase;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class BezierLocalEditor extends LocalActionBase
	{
		
		public function BezierLocalEditor(_varListModel:VectorListModel) 
		{
			super(_varListModel);
			nameInput.getInput().setText("BezierCurveLocal");
		}
		
		override public function createNeedStuff():*
		{
			return new BezierCurvelocal();
		}
		
		override protected function createParamPane():EditorWithPropertyBase
		{
			return new BezierParam(varListModel);
		}
		
	}

}

import a3dparticle.particle.ParticleParam;
import flash.geom.Vector3D;
import flash.utils.Dictionary;
import particleEditor.inputer.VectorComboBox;
import org.aswing.geom.IntDimension;
import org.aswing.JSpacer;
import org.aswing.VectorListModel;
import particleEditor.edit.EditorWithPropertyBase;

class BezierParam extends EditorWithPropertyBase
{
	private var controlInput:VectorComboBox;
	private var endInput:VectorComboBox;
	public function BezierParam(varListModel:VectorListModel)
	{
		super();
		controlInput = new VectorComboBox("control point:", varListModel, "x", "y", "z");
		endInput = new VectorComboBox("end point:", varListModel, "x", "y", "z");

		contentPane.append(controlInput);
		contentPane.append(new JSpacer(new IntDimension(10, 10)));
		contentPane.append(endInput);
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
	
	override public function getExportCode():XML
	{
		var xml:XML = super.getExportCode();
		xml.@control = controlInput.serialize();
		xml.@end = endInput.serialize();
		return xml;
	}
	
	override public function importCode(xml:XML):void
	{
		super.importCode(xml);
		controlInput.deserialize(xml.@control);
		endInput.deserialize(xml.@end);
	}
}