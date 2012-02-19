package particleEditor.effect.generater.shape
{
	import away3d.core.base.SubGeometry;
	import away3d.primitives.CubeGeometry;
	import particleEditor.inputer.NumberInput;
	import particleEditor.edit.VarNameEditorBase;
	
	/**
	 * ...
	 * @author liaocheng
	 */
	public class CubeEditor extends VarNameEditorBase
	{
		private var widthInput:NumberInput;
		private var heightInput:NumberInput;
		private var depthInput:NumberInput;
		
		public function CubeEditor()
		{
			super();
			widthInput = new NumberInput("width", "20", 2, 4);
			widthInput.setMinMax(0);
			
			heightInput = new NumberInput("height", "20", 2, 4);
			heightInput.setMinMax(0);
			depthInput = new NumberInput("depth", "20", 2, 4);
			depthInput.setMinMax(0);
			contentPane.appendAll(widthInput, heightInput, depthInput);
		}
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			xml.@width = widthInput.getInputNumber();
			xml.@height = heightInput.getInputNumber();
			xml.@depth = depthInput.getInputNumber();
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			widthInput.setInputText(xml.@width);
			heightInput.setInputText(xml.@height);
			depthInput.setInputText(xml.@depth);
		}
		
		override public function createNeedStuff():*
		{
			var cube:CubeGeometry = new CubeGeometry( widthInput.getInputNumber(), heightInput.getInputNumber(), depthInput.getInputNumber());
			return cube.subGeometries[0];
		}	
	}

}