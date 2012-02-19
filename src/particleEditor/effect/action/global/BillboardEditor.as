package particleEditor.effect.action.global
{
	import a3dparticle.animators.actions.ActionBase;
	import a3dparticle.animators.actions.rotation.BillboardGlobal;
	import particleEditor.effect.action.ActionEditorBase;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class BillboardEditor extends ActionEditorBase
	{
		
		public function BillboardEditor() 
		{
			super();
			nameInput.getInput().setText("BillboardGlobal");
		}
		
		override public function createNeedStuff():*
		{
			return new BillboardGlobal();
		}
		
	}

}