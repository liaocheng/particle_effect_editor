package particleEditor.effect.action.global
{
	import a3dparticle.animators.actions.rotation.BillboardGlobal;
	import particleEditor.edit.EditorWithPropertyBaseS;
	import particleEditor.effect.action.ActionEditorBase;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class BillboardEditorS extends EditorWithPropertyBaseS
	{
		
		public function BillboardEditorS() 
		{
			super();
		}
		
		override public function createNeedStuff():*
		{
			return new BillboardGlobal();
		}
		
	}

}