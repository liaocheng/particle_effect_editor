package particleEditor.effect.action.global
{
	import a3dparticle.animators.actions.uv.UVSeqPicByTimeGlobal;
	import particleEditor.effect.action.ActionEditorBase;
	import particleEditor.inputer.BooleanInput;
	import particleEditor.inputer.IntInput;
	import particleEditor.inputer.NumberInput;
	
	/**
	 * ...
	 * @author liaocheng
	 */
	public class UVSeqPicByTimeGlobalEditor extends ActionEditorBase
	{
		private var columns:IntInput;
		private var rows:IntInput;
		private var cycle:NumberInput;
		private var usingNum:IntInput;
		private var startTime:NumberInput;
		private var loop:BooleanInput;
		
		public function UVSeqPicByTimeGlobalEditor()
		{
			super();
			nameInput.getInput().setText("UVSeqPicByTime");
			
			columns = new IntInput("columns:", "2", 2, 3);
			rows = new IntInput("rows:", "1", 2, 3);
			usingNum = new IntInput("usingNum:", "65535", 2, 4);
			cycle = new NumberInput("cycle:", "2", 2, 3);
			startTime = new NumberInput("startTime:", "0", 2, 3);
			loop = new BooleanInput("loop");
			loop.deserialize("1");
			contentPane.appendAll(columns, rows, usingNum, cycle, startTime, loop);
		}
		
		override public function createNeedStuff():*
		{
			return new UVSeqPicByTimeGlobal(columns.getInputInt(), rows.getInputInt(), cycle.getInputNumber(), usingNum.getInputInt(), startTime.getInputNumber(), loop.getValue());
		}
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			xml.@columns = columns.serialize();
			xml.@rows = rows.serialize();
			xml.@usingNum = usingNum.serialize();
			xml.@cycle = cycle.serialize();
			xml.@startTime = startTime.serialize();
			xml.@loop = loop.serialize();
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			columns.deserialize(xml.@columns);
			rows.deserialize(xml.@rows);
			usingNum.deserialize(xml.@usingNum);
			cycle.deserialize(xml.@cycle);
			startTime.deserialize(xml.@startTime);
			loop.deserialize(xml.@loop);
		}
	}

}