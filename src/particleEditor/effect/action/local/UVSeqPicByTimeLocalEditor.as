package particleEditor.effect.action.local
{
	import a3dparticle.animators.actions.uv.UVSeqPicByTimeLocal;
	import org.aswing.VectorListModel;
	import particleEditor.edit.EditorWithPropertyBase;
	import particleEditor.inputer.BooleanInput;
	import particleEditor.inputer.IntInput;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class UVSeqPicByTimeLocalEditor extends LocalActionBase
	{
		private var columns:IntInput;
		private var rows:IntInput;
		private var usingNum:IntInput;
		private var hasStartTime:BooleanInput;
		private var loop:BooleanInput;
		
		public function UVSeqPicByTimeLocalEditor(_varListModel:VectorListModel)
		{
			super(_varListModel);
			nameInput.getInput().setText("UVSeqPicByTimeLocal");
			
			columns = new IntInput("columns:", "2", 2, 3);
			rows = new IntInput("rows:", "1", 2, 3);
			usingNum = new IntInput("usingNum:", "65535", 2, 4);
			hasStartTime = new BooleanInput("hasStartTime");
			hasStartTime.deserialize("0");
			loop = new BooleanInput("loop");
			loop.deserialize("1");
			contentPane.appendAll(columns, rows, usingNum, hasStartTime, loop);
			
		}
		
		override public function createNeedStuff():*
		{
			return new UVSeqPicByTimeLocal(columns.getInputInt(), rows.getInputInt(), usingNum.getInputInt(), hasStartTime.getValue(), loop.getValue());
		}
		
		override protected function createParamPane():EditorWithPropertyBase
		{
			return new UVSeqPicByTimeParam(varListModel);
		}
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			xml.@columns = columns.serialize();
			xml.@rows = rows.serialize();
			xml.@usingNum = usingNum.serialize();
			xml.@hasStartTime = hasStartTime.serialize();
			xml.@loop = loop.serialize();
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			columns.deserialize(xml.@columns);
			rows.deserialize(xml.@rows);
			usingNum.deserialize(xml.@usingNum);
			hasStartTime.deserialize(xml.@hasStartTime);
			loop.deserialize(xml.@loop);
		}
	}

}

import a3dparticle.particle.ParticleParam;
import flash.geom.Vector3D;
import flash.utils.Dictionary;
import org.aswing.VectorListModel;
import particleEditor.edit.EditorWithPropertyBase;
import particleEditor.inputer.ComboBoxInput;

class UVSeqPicByTimeParam extends EditorWithPropertyBase
{
	private var cycle:ComboBoxInput;
	private var startTime:ComboBoxInput;
	
	public function UVSeqPicByTimeParam(varListModel:VectorListModel)
	{
		super();
		cycle = new ComboBoxInput("cycle:", varListModel);
		startTime = new ComboBoxInput("startTime:", varListModel);
		contentPane.appendAll(cycle, startTime);
	}
	
	override public function createNeedStuff():*
	{
		return function(param:ParticleParam, localVars:Dictionary):void
		{
			var cycleValue:Number = cycle.getValue()?localVars[cycle.getValue()]:10;
			var startTimeValue:Number = startTime.getValue()?localVars[startTime.getValue()]:0;
			param["UVSeqPicByTimeLocal"] = new Vector3D(cycleValue, startTimeValue);
		}
	}
	
	override public function getExportCode():XML
	{
		var xml:XML = super.getExportCode();
		xml.@cycle = cycle.serialize();
		xml.@startTime = startTime.serialize();
		return xml;
	}
	
	override public function importCode(xml:XML):void
	{
		super.importCode(xml);
		cycle.deserialize(xml.@cycle);
		startTime.deserialize(xml.@startTime);
	}
}