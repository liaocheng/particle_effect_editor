package particleEditor.effect.action.local
{
	import a3dparticle.animators.actions.ActionBase;
	import a3dparticle.animators.actions.circle.CircleLocal;
	import particleEditor.inputer.VectorDegreeInput;
	import org.aswing.VectorListModel;
	import particleEditor.edit.EditorWithPropertyBase;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class CircleLocalEditor extends LocalActionBase
	{		
		private var eulersInput:VectorDegreeInput;
		public function CircleLocalEditor(_varListModel:VectorListModel) 
		{
			super(_varListModel);
			nameInput.getInput().setText("CircleLocal");
			eulersInput = new VectorDegreeInput("rotation:");
			contentPane.append(eulersInput);
		}
		
		override public function createNeedStuff():*
		{
			return new CircleLocal(null,eulersInput.getValue());
		}
		
		override protected function createParamPane():EditorWithPropertyBase
		{
			return new CircleParam(varListModel);
		}
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			xml.@eulers = eulersInput.serialize();
			return xml;
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
import particleEditor.inputer.ComboBoxInput;
import org.aswing.VectorListModel;
import particleEditor.edit.EditorWithPropertyBase;

class CircleParam extends EditorWithPropertyBase
{
	private var radiusComboBox:ComboBoxInput;
	private var cycleComboBox:ComboBoxInput;
	public function CircleParam(varListModel:VectorListModel)
	{
		super();
		radiusComboBox = new ComboBoxInput("radius:", varListModel);
		cycleComboBox = new ComboBoxInput("  cycle :", varListModel);
		contentPane.appendAll(radiusComboBox,cycleComboBox);
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
	
	override public function getExportCode():XML
	{
		var xml:XML = super.getExportCode();
		xml.@radius = radiusComboBox.serialize();
		xml.@cycle = cycleComboBox.serialize();
		return xml;
	}
	
	override public function importCode(xml:XML):void
	{
		super.importCode(xml);
		radiusComboBox.deserialize(xml.@radius);
		cycleComboBox.deserialize(xml.@cycle);
	}
}