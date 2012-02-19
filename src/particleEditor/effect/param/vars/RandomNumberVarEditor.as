package particleEditor.effect.param.vars
{
	import a3dparticle.particle.ParticleParam;
	import flash.utils.Dictionary;
	import particleEditor.inputer.NumberInput;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class RandomNumberVarEditor extends VarEditorBase
	{
		private var minInput:NumberInput;
		private var maxInput:NumberInput;
		
		public function RandomNumberVarEditor() 
		{
			super();
			
			minInput = new NumberInput("min", "0", 2, 5);
			maxInput = new NumberInput("max", "0", 2, 5);
			contentPane.appendAll(minInput,maxInput);
			addVarProperty("");
		}
		
		override public function createNeedStuff():*
		{
			var min:Number = minInput.getInputNumber();
			var max:Number = maxInput.getInputNumber();
			return function(param:ParticleParam,localVars:Dictionary):void {
				localVars[getVarProperty("")] = Math.random() * (max - min) + min;
			};
		}
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			xml.@min = minInput.getInputNumber();
			xml.@max = maxInput.getInputNumber();
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			minInput.setInputText(xml.@min);
			maxInput.setInputText(xml.@max);
		}
	}

}