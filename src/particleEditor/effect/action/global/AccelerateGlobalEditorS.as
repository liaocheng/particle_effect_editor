package particleEditor.effect.action.global
{
	import a3dparticle.animators.actions.acceleration.AccelerateGlobal;
	import particleEditor.edit.EditorWithPropertyBaseS;
	import particleEditor.inputer.Vector3dInputS;
	
	/**
	 * ...
	 * @author liaocheng
	 */
	public class AccelerateGlobalEditorS extends EditorWithPropertyBaseS
	{
		private var valueInput:Vector3dInputS;
		
		public function AccelerateGlobalEditorS()
		{
			super();
			
			valueInput = new Vector3dInputS(0, -50, 0);
		}
		
		override public function createNeedStuff():*
		{
			return new AccelerateGlobal(valueInput.getValue());
		}
		
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			valueInput.deserialize(xml.@accelerate);
		}
	
	}

}