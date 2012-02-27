package particleEditor.effect.generater.shape
{
	import away3d.core.base.SubGeometry;
	import away3d.primitives.PlaneGeometry;
	import particleEditor.inputer.NumberInput;
	import particleEditor.edit.VarNameEditorBase;
	
	/**
	 * ...
	 * @author liaocheng
	 */
	public class PlaneEditor extends VarNameEditorBase
	{
		private var widthInput:NumberInput;
		private var heightInput:NumberInput;
		
		public function PlaneEditor()
		{
			super();
			widthInput = new NumberInput("width", "20", 2, 4);
			widthInput.setMinMax(0);
			heightInput = new NumberInput("height", "20", 2, 4);
			heightInput.setMinMax(0);
			contentPane.appendAll(widthInput, heightInput);
		
		}
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			xml.@width = widthInput.getInputNumber();
			xml.@height = heightInput.getInputNumber();
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			widthInput.setInputText(xml.@width);
			heightInput.setInputText(xml.@height);
		}
		
		override public function createNeedStuff():*
		{
			var plane:PlaneGeometry = new PlaneGeometry(widthInput.getInputNumber(), heightInput.getInputNumber(), 1, 1, false);
			return plane.subGeometries[0];
		}
	
	}

}