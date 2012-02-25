package particleEditor.effect.action.global
{
	import a3dparticle.animators.actions.uv.UVDriftGlobal;
	import particleEditor.edit.EditorWithPropertyBaseS;
	
	/**
	 * ...
	 * @author liaocheng
	 */
	public class UVDriftGlobalEditorS extends EditorWithPropertyBaseS
	{
		private var cycle:Number;
		private var scale:Number;
		
		public function UVDriftGlobalEditorS()
		{
			super();
		}
		
		override public function createNeedStuff():*
		{
			return new UVDriftGlobal(cycle, scale);
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			cycle=Number(xml.@cycle);
			scale=Number(xml.@scale);
		}
	}

}