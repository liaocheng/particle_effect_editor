package particleEditor.effect.action.global
{
	import a3dparticle.animators.actions.uv.UVDriftGlobal;
	import particleEditor.effect.action.ActionEditorBase;
	import particleEditor.inputer.NumberInput;
	
	/**
	 * ...
	 * @author liaocheng
	 */
	public class UVDriftGlobalEditor extends ActionEditorBase
	{
		private var cycle:NumberInput;
		private var scale:NumberInput;
		
		public function UVDriftGlobalEditor()
		{
			super();
			nameInput.getInput().setText("UVDriftGlobal");
			
			cycle = new NumberInput("cycle:", "2", 2, 3);
			scale = new NumberInput("scale:", "1", 2, 3);
			contentPane.appendAll(cycle, scale);
		}
		
		override public function createNeedStuff():*
		{
			return new UVDriftGlobal(cycle.getInputNumber(), scale.getInputNumber());
		}
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			xml.@cycle = cycle.serialize();
			xml.@scale = scale.serialize();
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			cycle.deserialize(xml.@cycle);
			scale.deserialize(xml.@scale);
		}
	}

}