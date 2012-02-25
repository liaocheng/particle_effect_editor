package particleEditor.effect.action.global
{
	import a3dparticle.animators.actions.uv.UVSeqPicByTimeGlobal;
	import particleEditor.edit.EditorWithPropertyBaseS;
	
	/**
	 * ...
	 * @author liaocheng
	 */
	public class UVSeqPicByTimeGlobalEditorS extends EditorWithPropertyBaseS
	{
		private var columns:int;
		private var rows:int;
		private var cycle:Number;
		private var usingNum:int;
		private var startTime:Number;
		private var loop:Boolean;
		
		public function UVSeqPicByTimeGlobalEditorS()
		{
			super();
		}
		
		override public function createNeedStuff():*
		{
			return new UVSeqPicByTimeGlobal(columns, rows, cycle, usingNum, startTime, loop);
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			columns=int(xml.@columns);
			rows=int(xml.@rows);
			usingNum=int(xml.@usingNum);
			cycle=Number(xml.@cycle);
			startTime=Number(xml.@startTime);
			loop = Boolean(int(xml.@loop));
		}
	}

}