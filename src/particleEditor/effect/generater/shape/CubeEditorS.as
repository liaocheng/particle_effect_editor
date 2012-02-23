package particleEditor.effect.generater.shape
{
	import away3d.primitives.CubeGeometry;
	import particleEditor.edit.EditorWithPropertyBaseS;
	
	/**
	 * ...
	 * @author liaocheng
	 */
	public class CubeEditorS extends EditorWithPropertyBaseS
	{
		private var widthInput:Number;
		private var heightInput:Number;
		private var depthInput:Number;
		
		public function CubeEditorS()
		{
			super();
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			widthInput=Number(xml.@width);
			heightInput=Number(xml.@height);
			depthInput=Number(xml.@depth);
		}
		
		override public function createNeedStuff():*
		{
			var cube:CubeGeometry = new CubeGeometry(widthInput, heightInput, depthInput);
			return cube.subGeometries[0];
		}	
	}

}