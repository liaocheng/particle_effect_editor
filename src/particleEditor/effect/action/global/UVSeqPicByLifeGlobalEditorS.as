package particleEditor.effect.action.global
{
	import a3dparticle.animators.actions.uv.UVSeqPicByLifeGlobal;
	import particleEditor.edit.EditorWithPropertyBaseS;
	import particleEditor.inputer.IntInput;
	
	/**
	 * ...
	 * @author liaocheng
	 */
	public class UVSeqPicByLifeGlobalEditorS extends EditorWithPropertyBaseS
	{
		private var columns:int;
		private var rows:int;
		private var usingNum:int;
		
		public function UVSeqPicByLifeGlobalEditorS()
		{
			super();
		}
		
		override public function createNeedStuff():*
		{
			return new UVSeqPicByLifeGlobal(columns, rows,usingNum);
		}
		
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			columns=int(xml.@columns);
			rows=int(xml.@rows);
			usingNum=int(xml.@usingNum);
		}
	}

}