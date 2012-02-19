package particleEditor.effect.action.global
{
	import a3dparticle.animators.actions.scale.ScaleByLifeGlobal;
	import particleEditor.edit.EditorWithPropertyBaseS;
	
	/**
	 * ...
	 * @author liaocheng
	 */
	public class ScaleByLifeGlobalEditorS extends EditorWithPropertyBaseS
	{
		private var startInput:Number;
		private var endInput:Number;
		
		public function ScaleByLifeGlobalEditorS()
		{
			super();
			startInput = 1;
			endInput = 2;
		}
		
		override public function createNeedStuff():*
		{
			return new ScaleByLifeGlobal(startInput, endInput);
		}
		
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			startInput=Number(xml.@start);
			endInput=Number(xml.@end);
		}
	
	}

}