package particleEditor.effect.action.global
{
	import a3dparticle.animators.actions.ActionBase;
	import a3dparticle.animators.actions.rotation.AutoRotateGlobal;
	import particleEditor.effect.action.ActionEditorBase;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class AutoRotateGlobalEditor extends ActionEditorBase
	{
		
		public function AutoRotateGlobalEditor() 
		{
			super();
			nameInput.getInput().setText("AutoRotateGlobal");
		}
		
		override public function createNeedStuff():*
		{
			return new AutoRotateGlobal();
		}
		
	}

}