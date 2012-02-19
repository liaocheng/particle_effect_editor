package particleEditor.effect.action.global
{
	import a3dparticle.animators.actions.ActionBase;
	import a3dparticle.animators.actions.bezier.BezierCurvelGlobal;
	import particleEditor.effect.action.ActionEditorBase;
	import org.aswing.geom.IntDimension;
	import org.aswing.JSpacer;
	import particleEditor.inputer.Vector3dInput;
	
	/**
	 * ...
	 * @author liaocheng
	 */
	public class BezierGlobalEditor extends ActionEditorBase
	{
		private var controlInput:Vector3dInput;
		private var endInput:Vector3dInput;
		
		public function BezierGlobalEditor()
		{
			super();
			nameInput.getInput().setText("BezierCurvelGlobal");
			
			controlInput = new Vector3dInput("control:", 200, 200, 0);
			
			endInput = new Vector3dInput("  end   :", 100, 0, 0);

			contentPane.appendAll(controlInput, new JSpacer(new IntDimension(10, 10)), endInput);
		}
		
		override public function createNeedStuff():*
		{
			return new BezierCurvelGlobal(controlInput.getValue(), endInput.getValue());
		}
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			xml.@control = controlInput.serialize();
			xml.@end = endInput.serialize();
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			controlInput.deserialize(xml.@control);
			endInput.deserialize(xml.@end);
		}
	
	}

}