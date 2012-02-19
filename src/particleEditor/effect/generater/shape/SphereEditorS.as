package particleEditor.effect.generater.shape
{
	import away3d.primitives.Sphere;
	import particleEditor.edit.EditorWithPropertyBaseS;
	
	/**
	 * ...
	 * @author liaocheng
	 */
	public class SphereEditorS extends EditorWithPropertyBaseS
	{
		private var radiusInput:Number;
		private var segmentsWInput:int;
		private var segmentsHInput:int;
		
		public function SphereEditorS()
		{
			super();
			radiusInput = 10;
			segmentsWInput = 6;
			segmentsHInput = 6;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			radiusInput=Number(xml.@radius);
			segmentsWInput=int(xml.@segmentsW);
			segmentsHInput=int(xml.@segmentsH);
		}
		
		override public function createNeedStuff():*
		{
			var sphere:Sphere = new Sphere(null, radiusInput, segmentsWInput, segmentsHInput);
			return sphere.geometry.subGeometries[0];
		}
	
	}

}