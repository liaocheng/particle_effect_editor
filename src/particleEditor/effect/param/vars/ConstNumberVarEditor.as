package particleEditor.effect.param.vars
{
	import a3dparticle.particle.ParticleParam;
	import flash.utils.Dictionary;
	import particleEditor.inputer.NumberInput;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class ConstNumberVarEditor extends VarEditorBase
	{
		private var constInput:NumberInput;
		
		public function ConstNumberVarEditor() 
		{
			super();
			
			constInput = new NumberInput("const", "0", 2, 4);
			contentPane.appendAll(constInput);
			
			addVarProperty("");
		}
		
		override public function createNeedStuff():*
		{
			return function(param:ParticleParam,localVars:Dictionary):void {
				localVars[getVarProperty("")] = constInput.getInputNumber();
			};
		}
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			xml.@number = constInput.getInputNumber();
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			constInput.setInputText(xml.@number);
		}
		
	}

}