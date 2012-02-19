package particleEditor.effect.action.global
{
	import a3dparticle.animators.actions.bezier.BezierCurvelGlobal;
	import particleEditor.edit.EditorWithPropertyBaseS;
	import particleEditor.inputer.Vector3dInputS;
	
	/**
	 * ...
	 * @author liaocheng
	 */
	public class BezierGlobalEditorS extends EditorWithPropertyBaseS
	{
		private var controlInput:Vector3dInputS;
		private var endInput:Vector3dInputS;
		
		public function BezierGlobalEditorS()
		{
			super();
			
			controlInput = new Vector3dInputS( 200, 200, 0);
			
			endInput = new Vector3dInputS(100, 0, 0);
		}
		
		override public function createNeedStuff():*
		{
			return new BezierCurvelGlobal(controlInput.getValue(), endInput.getValue());
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			controlInput.deserialize(xml.@control);
			endInput.deserialize(xml.@end);
		}
	
	}

}