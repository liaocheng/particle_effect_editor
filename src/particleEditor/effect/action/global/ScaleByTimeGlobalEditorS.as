package particleEditor.effect.action.global
{
	import a3dparticle.animators.actions.scale.ScaleByTimeGlobal;
	import particleEditor.edit.EditorWithPropertyBaseS;
	
	/**
	 * ...
	 * @author liaocheng
	 */
	public class ScaleByTimeGlobalEditorS extends EditorWithPropertyBaseS
	{
		private var minInput:Number;
		private var maxInput:Number;
		private var cycleinput:Number;
		
		public function ScaleByTimeGlobalEditorS()
		{
			super();
			
			minInput = 1;
			maxInput = 1;
			cycleinput = 1;
		}
		
		override public function createNeedStuff():*
		{
			return new ScaleByTimeGlobal(minInput, maxInput, cycleinput);
		}
		
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			minInput=Number(xml.@min);
			maxInput=Number(xml.@max);
			cycleinput=Number(xml.@cycle);
		}
	}

}