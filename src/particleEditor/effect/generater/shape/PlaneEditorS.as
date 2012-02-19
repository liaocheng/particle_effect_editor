package particleEditor.effect.generater.shape
{
	import away3d.primitives.Plane;
	import away3d.tools.MeshHelper;
	import particleEditor.edit.EditorWithPropertyBaseS;
	
	/**
	 * ...
	 * @author liaocheng
	 */
	public class PlaneEditorS extends EditorWithPropertyBaseS
	{
		private var widthInput:Number;
		private var heightInput:Number;
		
		public function PlaneEditorS()
		{
			super();
			widthInput = 20;
			heightInput = 20;		
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			widthInput=Number(xml.@width);
			heightInput=Number(xml.@height);
		}
		
		override public function createNeedStuff():*
		{
			var plane:Plane = new Plane(null, widthInput, heightInput);
			plane.rotationX = -90;
			MeshHelper.applyRotations(plane);
			return plane.geometry.subGeometries[0];
		}
	
	}

}