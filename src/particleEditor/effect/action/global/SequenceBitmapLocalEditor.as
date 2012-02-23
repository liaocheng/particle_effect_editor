package particleEditor.effect.action.local
{
	import a3dparticle.animators.actions.uv.SequenceBitmapLocal;
	import org.aswing.VectorListModel;
	import particleEditor.edit.EditorWithPropertyBase;
	import particleEditor.inputer.BooleanInput;
	import particleEditor.inputer.IntInput;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class SequenceBitmapLocalEditor extends LocalActionBase
	{		
		private var cuttingNum:IntInput;
		private var usingNum:IntInput;
		private var smooth:BooleanInput;
		private var hasStartTime:BooleanInput;
		
		public function SequenceBitmapLocalEditor(_varListModel:VectorListModel) 
		{
			super(_varListModel);
			nameInput.getInput().setText("SequenceBitmapLocal");
			cuttingNum = new IntInput("cuttingNum:", "2");
			cuttingNum.setMinMax(1);
			usingNum = new IntInput("usingNum:", "2");
			usingNum.setMinMax(1);
			smooth = new BooleanInput("smooth:");
			smooth.deserialize("1");
			hasStartTime = new BooleanInput("hasStartTime:");
			hasStartTime.deserialize("0");
			contentPane.appendAll(cuttingNum, usingNum, smooth, hasStartTime);
		}
		
		override public function createNeedStuff():*
		{
			return new SequenceBitmapLocal(cuttingNum.getInputInt(), smooth.getValue(), usingNum.getInputInt(),  hasStartTime.getValue());
		}
		
		override protected function createParamPane():EditorWithPropertyBase
		{
			return new SequenceBitmapParam(varListModel);
		}
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			xml.@cuttingNum = cuttingNum.serialize();
			xml.@usingNum = usingNum.serialize();
			xml.@smooth = smooth.serialize();
			xml.@hasStartTime = hasStartTime.serialize();
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			cuttingNum.deserialize(xml.@cuttingNum);
			usingNum.deserialize(xml.@usingNum);
			smooth.deserialize(xml.@smooth);
			hasStartTime.deserialize(xml.@hasStartTime);
		}
		
	}

}

import a3dparticle.particle.ParticleParam;
import flash.geom.Vector3D;
import flash.utils.Dictionary;
import org.aswing.VectorListModel;
import particleEditor.edit.EditorWithPropertyBase;
import particleEditor.inputer.ComboBoxInput;

class SequenceBitmapParam extends EditorWithPropertyBase
{
	private var cycleComboBox:ComboBoxInput;
	private var offestComboBox:ComboBoxInput;
	private var startTimeComboBox:ComboBoxInput;
	
	public function SequenceBitmapParam(varListModel:VectorListModel)
	{
		super();
		cycleComboBox = new ComboBoxInput("cycle:", varListModel);
		offestComboBox = new ComboBoxInput("offest:", varListModel);
		startTimeComboBox = new ComboBoxInput("startTime:", varListModel);
		contentPane.appendAll(cycleComboBox, offestComboBox, startTimeComboBox);
	}
	
	override public function createNeedStuff():*
	{
		return function(param:ParticleParam, localVars:Dictionary):void
		{
			var cycle:Number = cycleComboBox.getValue()?localVars[cycleComboBox.getValue()]:1;
			var offest:Number = offestComboBox.getValue()?localVars[offestComboBox.getValue()]:0;
			var startTime:Number = startTimeComboBox.getValue()?localVars[startTimeComboBox.getValue()]:0;
			param["SequenceBitmapLocal"] = new Vector3D(offest, cycle, startTime);
		}
	}
	
	override public function getExportCode():XML
	{
		var xml:XML = super.getExportCode();
		xml.@cycle = cycleComboBox.serialize();
		xml.@offest = offestComboBox.serialize();
		xml.@startTime = startTimeComboBox.serialize();
		return xml;
	}
	
	override public function importCode(xml:XML):void
	{
		super.importCode(xml);
		cycleComboBox.deserialize(xml.@cycle);
		offestComboBox.deserialize(xml.@offest);
		startTimeComboBox.deserialize(xml.@startTime);
	}
}