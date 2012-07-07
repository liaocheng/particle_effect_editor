package particleEditor.effect.action.local
{
	import a3dparticle.animators.actions.ActionBase;
	import a3dparticle.animators.actions.drift.DriftLocal;
	import org.aswing.VectorListModel;
	import particleEditor.edit.EditorWithPropertyBase;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class DriftLocalEditor extends LocalActionBase
	{
		public function DriftLocalEditor(_varListModel:VectorListModel) 
		{
			super(_varListModel);
			nameInput.getInput().setText("DriftLocal");
		}
		
		override public function createNeedStuff():*
		{
			return new DriftLocal();
		}
		
		override protected function createParamPane():EditorWithPropertyBase
		{
			return new DriftParam(varListModel);
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

class DriftParam extends EditorWithPropertyBase
{
	private var offsetInput:VectorComboBox;
	private var cycleComboBox:ComboBoxInput;
	public function DriftParam(varListModel:VectorListModel)
	{
		super();
		offsetInput = new VectorComboBox("offset:", varListModel, "x:", "y:", "z:");
		
		cycleComboBox = new ComboBoxInput("cycle:", varListModel);
		
		contentPane.appendAll(offsetInput,cycleComboBox);
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
	
	override public function getExportCode():XML
	{
		var xml:XML = super.getExportCode();
		xml.@offset = offsetInput.serialize();
		xml.@cycle = cycleComboBox.serialize();
		return xml;
	}
	
	override public function importCode(xml:XML):void
	{
		super.importCode(xml);
		offsetInput.deserialize(xml.@offset);
		cycleComboBox.deserialize(xml.@cycle);
	}
}