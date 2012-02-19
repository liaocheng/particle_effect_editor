package particleEditor.effect.action.global
{
	import a3dparticle.animators.actions.ActionBase;
	import a3dparticle.animators.actions.scale.ScaleByLifeGlobal;
	import particleEditor.effect.action.ActionEditorBase;
	import particleEditor.inputer.NumberInput;
	
	/**
	 * ...
	 * @author liaocheng
	 */
	public class ScaleByLifeGlobalEditor extends ActionEditorBase
	{
		private var startInput:NumberInput;
		private var endInput:NumberInput;
		
		public function ScaleByLifeGlobalEditor()
		{
			super();
			nameInput.getInput().setText("ScaleByLifeGlobal");
			
			startInput = new NumberInput("start scale:", "1", 2, 3);
			startInput.setMinMax(0);
			endInput = new NumberInput(" end scale:", "2", 2, 3);
			endInput.setMinMax(0);
			contentPane.appendAll(startInput, endInput);
		}
		
		override public function createNeedStuff():*
		{
			return new ScaleByLifeGlobal(startInput.getInputNumber(), endInput.getInputNumber());
		}
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			xml.@start = startInput.serialize();
			xml.@end = endInput.serialize();
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			startInput.deserialize(xml.@start);
			endInput.deserialize(xml.@end);
		}
	
	}

}