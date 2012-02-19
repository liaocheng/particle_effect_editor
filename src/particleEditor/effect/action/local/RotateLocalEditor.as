package particleEditor.effect.action.local
{
	import a3dparticle.animators.actions.ActionBase;
	import a3dparticle.animators.actions.rotation.RandomRotateLocal;
	import org.aswing.VectorListModel;
	import particleEditor.edit.EditorWithPropertyBase;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class RotateLocalEditor extends LocalActionBase
	{
		
		public function RotateLocalEditor(_varListModel:VectorListModel) 
		{
			super(_varListModel);
			nameInput.getInput().setText("RandomRotateLocal");
		}
		
		override public function createNeedStuff():*
		{
			return new RandomRotateLocal();
		}
		
		override protected function createParamPane():EditorWithPropertyBase
		{
			return new RotateParam(varListModel);
		}
		
	}

}

import a3dparticle.particle.ParticleParam;
import flash.geom.Vector3D;
import flash.utils.Dictionary;
import org.aswing.VectorListModel;
import particleEditor.edit.EditorWithPropertyBase;
import particleEditor.inputer.ComboBoxInput;
import particleEditor.inputer.VectorComboBox;

class RotateParam extends EditorWithPropertyBase
{
	private var axisInput:VectorComboBox;
	private var cycleComboBox:ComboBoxInput;
	public function RotateParam(varListModel:VectorListModel)
	{
		super();
		axisInput = new VectorComboBox("rotation axis:", varListModel, "x:", "y:", "z:");
		
		cycleComboBox = new ComboBoxInput("cycle:", varListModel);
		
		contentPane.appendAll(axisInput,cycleComboBox);
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
	
	override public function getExportCode():XML
	{
		var xml:XML = super.getExportCode();
		xml.@axis = axisInput.serialize();
		xml.@cycle = cycleComboBox.serialize();
		return xml;
	}
	
	override public function importCode(xml:XML):void
	{
		super.importCode(xml);
		axisInput.deserialize(xml.@axis);
		cycleComboBox.deserialize(xml.@cycle);
	}
}