package particleEditor.effect.param.vars
{
	import a3dparticle.particle.ParticleParam;
	import flash.utils.Dictionary;
	import particleEditor.easing.EaseDefinition;
	import particleEditor.inputer.ComboBoxInputS;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class EaseNumberEditorS extends VarEditorBaseS
	{
		
		private var startInput:Number;
		private var endInput:Number;
		
		private var easeInput:ComboBoxInputS;
		
		public function EaseNumberEditorS() 
		{
			super();
			
			startInput = 0;
			endInput = 0;
			easeInput = new ComboBoxInputS(EaseDefinition.ALL_EASE);		
			addVarProperty("");
		}
		
		
		override public function createNeedStuff():*
		{
			var start:Number = startInput;
			var end:Number = endInput;
			var ease:EaseDefinition = easeInput.getValue() as EaseDefinition;
			return function(_param:ParticleParam, localVars:Dictionary):void 
			{
				localVars[getVarProperty("")] = ease.easeFunction(_param.index,start,end-start,_param.total);
			};
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			startInput=Number(xml.@start);
			endInput=Number(xml.@end);
			easeInput.deserialize(xml.@ease);
		}
		
	}

}