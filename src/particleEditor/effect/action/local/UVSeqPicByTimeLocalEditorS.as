package particleEditor.effect.action.local
{
	import a3dparticle.animators.actions.uv.UVSeqPicByTimeLocal;
	import particleEditor.edit.EditorWithPropertyBaseS;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class UVSeqPicByTimeLocalEditorS extends LocalActionBaseS
	{
		private var columns:int;
		private var rows:int;
		private var usingNum:int;
		private var hasStartTime:Boolean;
		private var loop:Boolean;
		
		public function UVSeqPicByTimeLocalEditorS(_varListModel:Array) 
		{
			super(_varListModel);
			
		}
		
		override public function createNeedStuff():*
		{
			return new UVSeqPicByTimeLocal(columns, rows, usingNum, hasStartTime, loop);
		}
		
		override protected function createParamPane():EditorWithPropertyBaseS
		{
			return new UVSeqPicByTimeParamS(varListModel);
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			columns=int(xml.@columns);
			rows=int(xml.@rows);
			usingNum=int(xml.@usingNum);
			hasStartTime = Boolean(int(xml.@hasStartTime));
			loop = Boolean(int(xml.@loop));
		}
		
	}

}

import a3dparticle.particle.ParticleParam;
import flash.geom.Vector3D;
import flash.utils.Dictionary;
import particleEditor.edit.EditorWithPropertyBaseS;
import particleEditor.inputer.ComboBoxInputS;

class UVSeqPicByTimeParamS extends EditorWithPropertyBaseS
{
	private var cycle:ComboBoxInputS;
	private var startTime:ComboBoxInputS;
	
	public function UVSeqPicByTimeParamS(varListModel:Array)
	{
		super();
		cycle = new ComboBoxInputS(varListModel);
		startTime = new ComboBoxInputS(varListModel);
	}
	
	override public function createNeedStuff():*
	{
		return function(param:ParticleParam, localVars:Dictionary):void
		{
			var cycle:Number = cycle.getValue()?localVars[cycle.getValue()]:10;
			var startTime:Number = startTime.getValue()?localVars[startTime.getValue()]:0;
			param["UVSeqPicByTimeLocal"] = new Vector3D(cycle, startTime);
		}
	}
	
	override public function importCode(xml:XML):void
	{
		super.importCode(xml);
		cycle.deserialize(xml.@cycle);
		startTime.deserialize(xml.@startTime);
	}
}