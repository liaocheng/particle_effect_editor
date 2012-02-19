package particleEditor.inputer
{
	import flash.geom.ColorTransform;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class ColorTransformInputS implements IDeserializable
	{		
		protected var colorTransform:ColorTransform;
		
		public function ColorTransformInputS() 
		{
			super();
		}
				
		public function deserialize(value:String):void
		{
			var array:Array = value.split(",");
			colorTransform = new ColorTransform(array[0], array[1], array[2], array[3], array[4], array[5], array[6], array[7]);
		}
		
		public function getValue():ColorTransform
		{
			return colorTransform;
		}
		
	}

}