package particleEditor.effect.action.local
{
	import a3dparticle.animators.actions.ActionBase;
	import a3dparticle.animators.actions.scale.RandomScaleLocal;
	import org.aswing.VectorListModel;
	import particleEditor.edit.EditorWithPropertyBase;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class RandomScaleLocalEditor extends LocalActionBase
	{
		
		public function RandomScaleLocalEditor(_varListModel:VectorListModel) 
		{
			super(_varListModel);
			nameInput.getInput().setText("RandomScaleLocal");
		}
		
		override public function createNeedStuff():*
		{
			return new RandomScaleLocal();
		}
		
		override protected function createParamPane():EditorWithPropertyBase
		{
			return new ScaleParam(varListModel);
		}
		
	}

}

import a3dparticle.particle.ParticleParam;
import flash.geom.Vector3D;
import flash.utils.Dictionary;
import particleEditor.inputer.VectorComboBox;
import org.aswing.VectorListModel;
import particleEditor.edit.EditorWithPropertyBase;

class ScaleParam extends EditorWithPropertyBase
{
	private var valueInput:VectorComboBox;
	
	public function ScaleParam(varListModel:VectorListModel)
	{
		super();
		valueInput = new VectorComboBox("value:", varListModel, "scaleX:", "scaleY:", "scaleZ:");
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
			param["RandomScaleLocal"] = new Vector3D(x, y, z);
		}
	}
	
	override public function getExportCode():XML
	{
		var xml:XML = super.getExportCode();
		xml.@scale = valueInput.serialize();
		return xml;
	}
	
	override public function importCode(xml:XML):void
	{
		super.importCode(xml);
		valueInput.deserialize(xml.@scale);
	}
}