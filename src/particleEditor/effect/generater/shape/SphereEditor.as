package particleEditor.effect.generater.shape
{
	import away3d.core.base.SubGeometry;
	import away3d.primitives.SphereGeometry;
	import particleEditor.inputer.IntInput;
	import particleEditor.inputer.NumberInput;
	import particleEditor.edit.VarNameEditorBase;
	
	/**
	 * ...
	 * @author liaocheng
	 */
	public class SphereEditor extends VarNameEditorBase
	{
		private var radiusInput:NumberInput;
		private var segmentsWInput:IntInput;
		private var segmentsHInput:IntInput;
		
		public function SphereEditor()
		{
			super();
			radiusInput = new NumberInput("radius", "10", 2, 4);
			radiusInput.setMinMax(0);
			
			segmentsWInput = new IntInput("segmentsW", "6", 2, 4);
			segmentsWInput.setMinMax(0);
			segmentsHInput = new IntInput("segmentsH", "6", 2, 4);
			segmentsHInput.setMinMax(0);
			contentPane.appendAll(radiusInput, segmentsWInput, segmentsHInput);
		
		}
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			xml.@radius = radiusInput.getInputNumber();
			xml.@segmentsW = segmentsWInput.getInputNumber();
			xml.@segmentsH = segmentsHInput.getInputNumber();
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			radiusInput.setInputText(xml.@radius);
			segmentsWInput.setInputText(xml.@segmentsW);
			segmentsHInput.setInputText(xml.@segmentsH);
		}
		
		override public function createNeedStuff():*
		{
			var sphere:SphereGeometry = new SphereGeometry( radiusInput.getInputNumber(), segmentsWInput.getInputInt(), segmentsHInput.getInputInt());
			return sphere.subGeometries[0];
		}
	
	}

}