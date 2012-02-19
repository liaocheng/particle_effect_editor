package particleEditor.effect.generater.shape
{
	import away3d.core.base.SubGeometry;
	import particleEditor.inputer.FileModelInput;
	import particleEditor.inputer.NumberInput;
	import particleEditor.edit.VarNameEditorBase;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class FileModelEditor extends VarNameEditorBase
	{
		
		private var modelInput:FileModelInput;
		private var scaleInput:NumberInput;
		public function FileModelEditor() 
		{
			super();
			modelInput = new FileModelInput("model:");
			scaleInput = new NumberInput("scale:", "1", 2, 3);
			scaleInput.setMinMax(0);
			appendAll(modelInput,scaleInput);
		}
			
		override public function createNeedStuff():*
		{
			var geometry:SubGeometry = modelInput.getValue().clone();
			geometry.scale(scaleInput.getInputNumber());
			return geometry;
		}
		
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			var child:XML = new XML("<model/>");
			child.appendChild(new XML(modelInput.serialize()));
			xml.appendChild(child);
			xml.@scale = scaleInput.serialize();
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			modelInput.deserialize(xml.model.text());
			scaleInput.deserialize(xml.@scale);
		}
		
	}

}