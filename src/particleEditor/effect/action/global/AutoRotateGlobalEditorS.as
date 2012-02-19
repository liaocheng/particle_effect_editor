package particleEditor.effect.action.global
{
	import a3dparticle.animators.actions.rotation.AutoRotateGlobal;
	import particleEditor.edit.EditorWithPropertyBaseS;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class AutoRotateGlobalEditorS extends EditorWithPropertyBaseS
	{
		
		public function AutoRotateGlobalEditorS() 
		{
			super();
		}
		
		override public function createNeedStuff():*
		{
			return new AutoRotateGlobal();
		}
		
	}

}