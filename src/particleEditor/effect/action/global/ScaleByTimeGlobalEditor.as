package particleEditor.effect.action.global
{
	import a3dparticle.animators.actions.ActionBase;
	import a3dparticle.animators.actions.scale.ScaleByTimeGlobal;
	import particleEditor.effect.action.ActionEditorBase;
	import particleEditor.inputer.NumberInput;
	
	/**
	 * ...
	 * @author liaocheng
	 */
	public class ScaleByTimeGlobalEditor extends ActionEditorBase
	{
		private var minInput:NumberInput;
		private var maxInput:NumberInput;
		private var cycleinput:NumberInput;
		
		public function ScaleByTimeGlobalEditor()
		{
			super();
			nameInput.getInput().setText("ScaleByTimeGlobal");
			
			minInput = new NumberInput(" min scale:", "1", 2, 3);
			minInput.setMinMax(0);
			maxInput = new NumberInput("max scale:", "1", 2, 3);
			maxInput.setMinMax(0);
			cycleinput = new NumberInput("     cycle     :", "1", 2, 3);
			cycleinput.setMinMax(0);
			contentPane.appendAll(minInput, maxInput, cycleinput);
		}
		
		override public function createNeedStuff():*
		{
			return new ScaleByTimeGlobal(minInput.getInputNumber(), maxInput.getInputNumber(), cycleinput.getInputNumber());
		}
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			xml.@min = minInput.getInputNumber();
			xml.@max = maxInput.getInputNumber();
			xml.@cycle = cycleinput.getInputNumber();
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			minInput.setInputText(xml.@min);
			maxInput.setInputText(xml.@max);
			cycleinput.setInputText(xml.@cycle);
		}
	}

}