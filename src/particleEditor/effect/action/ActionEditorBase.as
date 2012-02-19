package particleEditor.effect.action
{
	import a3dparticle.animators.actions.ActionBase;
	import particleEditor.edit.VarNameEditorBase;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class ActionEditorBase extends VarNameEditorBase
	{
		public function ActionEditorBase() 
		{
			super();
			nameInput.getInput().setEditable(false);
			setShowEnable(true);
		}
		
	}

}