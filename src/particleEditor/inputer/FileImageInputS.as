package particleEditor.inputer
{
	import away3d.materials.utils.DefaultMaterialManager;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import mx.utils.Base64Decoder;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class FileImageInputS extends EventDispatcher implements IDeserializable
	{
		protected var _byte:ByteArray;
		protected var bitmapData:BitmapData;
		
		public function FileImageInputS()
		{
		}
		
		public function getValue():BitmapData
		{
			if (bitmapData)
			{
				return bitmapData;
			}
			else
			{
				return DefaultMaterialManager.getDefaultTexture().bitmapData;
			}
		}
		
		private function onRead(byte:ByteArray):void
		{
			if (byte)
			{
				_byte = byte;
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoader);
				loader.loadBytes(_byte);
			}
		}
		
		private function onLoader(e:Event):void
		{
			var bitmap:Bitmap = Bitmap(e.target.content);
			bitmapData = Bitmap(e.target.content).bitmapData;
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		
		public function deserialize(value:String):void
		{
			if (value == "-1")
			{
				return;
			}
			else
			{
				var decode:Base64Decoder = new Base64Decoder();
				decode.decode(value)
				onRead(decode.toByteArray());
			}
		}
		
	}

}