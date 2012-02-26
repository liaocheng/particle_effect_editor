package particleEditor.effect.action.global
{
	import a3dparticle.animators.actions.uv.UVSeqPicByLifeGlobal;
	import particleEditor.effect.action.ActionEditorBase;
	import particleEditor.inputer.IntInput;
	
	/**
	 * ...
	 * @author liaocheng
	 */
	public class UVSeqPicByLifeGlobalEditor extends ActionEditorBase
	{
		private var columns:IntInput;
		private var rows:IntInput;
		private var usingNum:IntInput;
		
		public function UVSeqPicByLifeGlobalEditor()
		{
			super();
			nameInput.getInput().setText("UVSeqPicByLifeGlobal");
			
			columns = new IntInput("columns:", "2", 2, 3);
			rows = new IntInput("rows:", "1", 2, 3);
			usingNum = new IntInput("usingNum:", "65535", 2, 4);
			contentPane.appendAll(columns, rows, usingNum);
		}
		
		override public function createNeedStuff():*
		{
			return new UVSeqPicByLifeGlobal(columns.getInputInt(), rows.getInputInt(),usingNum.getInputInt());
		}
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			xml.@columns = columns.serialize();
			xml.@rows = rows.serialize();
			xml.@usingNum = usingNum.serialize();
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			columns.deserialize(xml.@columns);
			rows.deserialize(xml.@rows);
			usingNum.deserialize(xml.@usingNum);
		}
	}

}