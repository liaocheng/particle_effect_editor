package particleEditor.inputer
{
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class VectorDegreeInputS implements IDeserializable
	{
		private var adjuster1:Number;
		private var adjuster2:Number;
		private var adjuster3:Number;
		
		public function VectorDegreeInputS() 
		{
			adjuster1 = 0;
			adjuster2 = 0;
			adjuster3 = 0;
		}
		public function deserialize(value:String):void
		{
			var array:Array = value.split(",");
			adjuster1 = Number(array[0]);
			adjuster2 = Number(array[1]);
			adjuster3 = Number(array[2]);
		}
		
		public function getValue():Vector3D
		{
			return new Vector3D(adjuster1, adjuster2, adjuster3);
		}
		
	}

}