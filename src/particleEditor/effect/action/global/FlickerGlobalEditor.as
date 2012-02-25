package particleEditor.effect.action.global
{
	import a3dparticle.animators.actions.ActionBase;
	import a3dparticle.animators.actions.color.FlickerGlobal;
	import particleEditor.effect.action.ActionEditorBase;
	import particleEditor.inputer.ColorTransformInput;
	import particleEditor.inputer.NumberInput;
	
	/**
	 * ...
	 * @author liaocheng
	 */
	public class FlickerGlobalEditor extends ActionEditorBase
	{
		private var minInput:ColorTransformInput;
		private var maxInput:ColorTransformInput;
		private var cycleInput:NumberInput;
		private var phaseAngleInput:NumberInput;
		
		public function FlickerGlobalEditor()
		{
			super();
			nameInput.getInput().setText("FlickerGlobal");
			
			minInput = new ColorTransformInput("min transform:");
			maxInput = new ColorTransformInput("max transform:");
			cycleInput = new NumberInput("     cycle     :", "10", 2, 3);
			cycleInput.setMinMax(0);
			phaseAngleInput = new NumberInput("phase angle:", "0", 2, 3);
			phaseAngleInput.setMinMax(0, 360);
			contentPane.appendAll(minInput,maxInput,cycleInput,phaseAngleInput);
		}
		
		override public function createNeedStuff():*
		{
			return new FlickerGlobal(minInput.getValue(),maxInput.getValue(),cycleInput.getInputNumber(),phaseAngleInput.getInputNumber());
		}
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			xml.@min = minInput.serialize();
			xml.@max = maxInput.serialize();
			xml.@cycle = cycleInput.serialize();
			xml.@phase = phaseAngleInput.serialize();
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			minInput.deserialize(xml.@min);
			maxInput.deserialize(xml.@max);
			cycleInput.deserialize(xml.@cycle);
			phaseAngleInput.deserialize(xml.@phase);
		}
	}

}