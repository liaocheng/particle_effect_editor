package particleEditor.effect.action.local
{
	import a3dparticle.animators.actions.uv.SequenceBitmapLocal;
	import particleEditor.edit.EditorWithPropertyBaseS;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class SequenceBitmapLocalEditorS extends LocalActionBaseS
	{		
		private var cuttingNum:int;
		private var usingNum:int;
		private var smooth:Boolean;
		private var hasStartTime:Boolean;
		
		public function SequenceBitmapLocalEditorS(_varListModel:Array) 
		{
			super(_varListModel);
		}
		
		override public function createNeedStuff():*
		{
			return new SequenceBitmapLocal(cuttingNum, smooth, usingNum, hasStartTime);
		}
		
		override protected function createParamPane():EditorWithPropertyBaseS
		{
			return new SequenceBitmapParamS(varListModel);
		}
		
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			cuttingNum = int(xml.@cuttingNum);
			usingNum = int(xml.@usingNum);
			smooth = Boolean(int(xml.@smooth));
			hasStartTime = Boolean(int(xml.@hasStartTime));
		}
		
	}

}

import a3dparticle.particle.ParticleParam;
import flash.geom.Vector3D;
import flash.utils.Dictionary;
import particleEditor.edit.EditorWithPropertyBaseS;
import particleEditor.inputer.ComboBoxInputS;

class SequenceBitmapParamS extends EditorWithPropertyBaseS
{
	private var cycleComboBox:ComboBoxInputS;
	private var offestComboBox:ComboBoxInputS;
	private var startTimeComboBox:ComboBoxInputS;
	
	public function SequenceBitmapParamS(varListModel:Array)
	{
		super();
		cycleComboBox = new ComboBoxInputS(varListModel);
		offestComboBox = new ComboBoxInputS(varListModel);
		startTimeComboBox = new ComboBoxInputS(varListModel);
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
	override public function importCode(xml:XML):void
	{
		super.importCode(xml);
		cycleComboBox.deserialize(xml.@cycle);
		offestComboBox.deserialize(xml.@offest);
		startTimeComboBox.deserialize(xml.@startTime);
	}
}