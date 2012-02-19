package particleEditor.effect.action.global
{
	import a3dparticle.animators.actions.ActionBase;
	import a3dparticle.animators.actions.velocity.VelocityGlobal;
	import particleEditor.effect.action.ActionEditorBase;
	import particleEditor.inputer.Vector3dInput;
	
	/**
	 * ...
	 * @author liaocheng
	 */
	public class VelocityGlobalEditor extends ActionEditorBase
	{
		private var valueInput:Vector3dInput;
		
		public function VelocityGlobalEditor()
		{
			super();
			nameInput.getInput().setText("VelocityGlobal");
			
			valueInput = new Vector3dInput("value:", 0, 200, 0);
			contentPane.appendAll(valueInput);
		}
		
		override public function createNeedStuff():*
		{
			return new VelocityGlobal(valueInput.getValue());
		}
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			xml.@velocity = valueInput.serialize();
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			valueInput.deserialize(xml.@velocity);
		}
	}

}