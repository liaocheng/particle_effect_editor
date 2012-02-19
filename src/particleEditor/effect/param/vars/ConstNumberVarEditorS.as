package particleEditor.effect.param.vars
{
	import a3dparticle.particle.ParticleParam;
	import flash.utils.Dictionary;
	import particleEditor.inputer.NumberInput;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class ConstNumberVarEditorS extends VarEditorBaseS
	{
		private var constInput:Number;
		
		public function ConstNumberVarEditorS() 
		{
			super();
			constInput = 0;			
			addVarProperty("");
		}
		
		override public function createNeedStuff():*
		{
			return function(param:ParticleParam,localVars:Dictionary):void {
				localVars[getVarProperty("")] = constInput;
			};
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			constInput = Number(xml.@number);
		}
		
	}

}