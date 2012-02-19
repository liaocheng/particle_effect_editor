package particleEditor.effect.action.global
{
	import a3dparticle.animators.actions.ActionBase;
	import a3dparticle.animators.actions.color.ChangeColorByLifeGlobal;
	import particleEditor.effect.action.ActionEditorBase;
	import particleEditor.inputer.ColorTransformInput;
	
	/**
	 * ...
	 * @author liaocheng
	 */
	public class ChangeColorByLifeGlobalEditor extends ActionEditorBase
	{
		private var startInput:ColorTransformInput;
		private var endInput:ColorTransformInput;
		
		public function ChangeColorByLifeGlobalEditor()
		{
			super();
			nameInput.getInput().setText("ChangeColorByLifeGlobal");
			
			startInput = new ColorTransformInput("start transform:");
			endInput = new ColorTransformInput("end  transform:");
			contentPane.appendAll(startInput,endInput);
		}
		
		override public function createNeedStuff():*
		{
			return new ChangeColorByLifeGlobal(startInput.getValue(),endInput.getValue());
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