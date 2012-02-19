package particleEditor.inputer 
{
	import away3d.core.base.SubGeometry;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class FileModelInputS implements IDeserializable
	{
		
		protected var subGeometry:SubGeometry;
		
		public function FileModelInputS() 
		{
			super();
		}
		
		
		public function getValue():SubGeometry
		{
			return subGeometry;
		}
		
		public function deserialize(value:String):void
		{
			if (value == "-1")
			{
				return;
			}
			else
			{
				var array:Array = JSON.parse(value) as Array;
				subGeometry = new SubGeometry();
				subGeometry.updateVertexData(Vector.<Number>(array[0]));
				subGeometry.updateIndexData(Vector.<uint>(array[1]));
				subGeometry.updateUVData(Vector.<Number>(array[2]));
			}
		}
		
	}

}