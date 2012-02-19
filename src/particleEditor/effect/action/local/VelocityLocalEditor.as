package particleEditor.effect.action.local
{
	import a3dparticle.animators.actions.ActionBase;
	import a3dparticle.animators.actions.velocity.VelocityLocal;
	import org.aswing.VectorListModel;
	import particleEditor.edit.EditorWithPropertyBase;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class VelocityLocalEditor extends LocalActionBase
	{
		
		public function VelocityLocalEditor(_varListModel:VectorListModel) 
		{
			super(_varListModel);
			nameInput.getInput().setText("VelocityLocal");
		}
		
		override public function createNeedStuff():*
		{
			return new VelocityLocal();
		}
		
		override protected function createParamPane():EditorWithPropertyBase
		{
			return new VelocityParam(varListModel);
		}
		
	}

}

import a3dparticle.particle.ParticleParam;
import flash.geom.Vector3D;
import flash.utils.Dictionary;
import org.aswing.VectorListModel;
import particleEditor.edit.EditorWithPropertyBase;
import particleEditor.inputer.VectorComboBox;

class VelocityParam extends EditorWithPropertyBase
{
	private var valueInput:VectorComboBox;
	public function VelocityParam(varListModel:VectorListModel)
	{
		super();
		valueInput = new VectorComboBox("value:", varListModel, "x:", "y:", "z:");
		contentPane.append(valueInput);
	}
	
	override public function createNeedStuff():*
	{
		return function(param:ParticleParam, localVars:Dictionary):void
		{
			var array:Array = valueInput.getValue();
			var x:Number = array[0]?localVars[array[0]]:0;
			var y:Number = array[1]?localVars[array[1]]:0;
			var z:Number = array[2]?localVars[array[2]]:0;
			param["VelocityLocal"] = new Vector3D(x, y, z);
		}
	}
	
	override public function getExportCode():XML
	{
		var xml:XML = super.getExportCode();
		xml.@velocity = valueInput.serialize();
		return xml;
	}
	
	override public function importCode(xml:XML):void
	{
		super.importCode(xml);
		valueInput.deserialize(xml.@velocity);
	}
}