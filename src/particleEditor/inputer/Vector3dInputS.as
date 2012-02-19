package particleEditor.inputer
{
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class Vector3dInputS implements IDeserializable
	{
		protected var xInput:Number;
		protected var yInput:Number;
		protected var zInput:Number;
		public function Vector3dInputS(x:Number = 0, y:Number = 0, z:Number = 0) 
		{
			xInput = x;
			yInput = y;
			zInput = z;
		}
		
		public function getValue():Vector3D
		{
			return new Vector3D(xInput, yInput, zInput);
		}
		
		public function deserialize(value:String):void
		{
			var array:Array = value.split(",");
			xInput=Number(array[0]);
			yInput=Number(array[1]);
			zInput=Number(array[2]);
		}
		
	}

}