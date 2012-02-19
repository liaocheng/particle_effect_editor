package particleEditor.effect.action.global
{
	import a3dparticle.animators.actions.acceleration.AccelerateGlobal;
	import a3dparticle.animators.actions.ActionBase;
	import particleEditor.effect.action.ActionEditorBase;
	import particleEditor.inputer.Vector3dInput;
	
	/**
	 * ...
	 * @author liaocheng
	 */
	public class AccelerateGlobalEditor extends ActionEditorBase
	{
		private var valueInput:Vector3dInput;
		
		public function AccelerateGlobalEditor()
		{
			super();
			nameInput.getInput().setText("AccelerateGlobal");
			
			valueInput = new Vector3dInput("value:", 0, -50, 0);
			contentPane.appendAll(valueInput);
		}
		
		override public function createNeedStuff():*
		{
			return new AccelerateGlobal(valueInput.getValue());
		}
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			xml.@accelerate = valueInput.serialize();
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			valueInput.deserialize(xml.@accelerate);
		}
	
	}

}