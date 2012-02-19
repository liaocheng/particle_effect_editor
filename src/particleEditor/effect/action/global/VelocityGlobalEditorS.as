package particleEditor.effect.action.global
{
	import a3dparticle.animators.actions.velocity.VelocityGlobal;
	import particleEditor.edit.EditorWithPropertyBaseS;
	import particleEditor.inputer.Vector3dInputS;
	
	/**
	 * ...
	 * @author liaocheng
	 */
	public class VelocityGlobalEditorS extends EditorWithPropertyBaseS
	{
		private var valueInput:Vector3dInputS;
		
		public function VelocityGlobalEditorS()
		{
			super();
			
			valueInput = new Vector3dInputS(0, 200, 0);
		}
		
		override public function createNeedStuff():*
		{
			return new VelocityGlobal(valueInput.getValue());
		}
				
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			valueInput.deserialize(xml.@velocity);
		}
	}

}