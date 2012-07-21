package particleEditor.inputer
{
	import away3d.materials.utils.DefaultMaterialManager;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.utils.ByteArray;
	import mx.utils.Base64Decoder;
	import mx.utils.Base64Encoder;
	import org.aswing.AssetPane;
	import org.aswing.geom.IntDimension;
	import org.aswing.JButton;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import particleEditor.utils.FileOperater;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class FileImageInput extends JPanel
	{
		protected var _byte:ByteArray;
		protected var assetPane:AssetPane;
		protected var bitmapData:BitmapData;
		
		public function FileImageInput(title:String)
		{
			super();
			var label:JLabel = new JLabel(title);
			var button:JButton = new JButton("open");
			assetPane = new AssetPane(new Bitmap(getValue()),AssetPane.PREFER_SIZE_LAYOUT);
			assetPane.setScaleMode(AssetPane.SCALE_STRETCH_PANE);
			assetPane.setPreferredSize(new IntDimension(64, 64));
			appendAll(label, assetPane, button);
			button.addActionListener(onOpen);
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
		
		private function onOpen(e:Event):void
		{
			FileOperater.readFile(new FileFilter("select a image", "*.jpg;*.png;*.bmp"), onRead);
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
			assetPane.setAsset(bitmap);
			bitmapData = Bitmap(e.target.content).bitmapData;
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function serialize():String
		{
			if (_byte)
			{
				var encode:Base64Encoder = new Base64Encoder();
				encode.encodeBytes(_byte);
				return encode.toString();
			}
			else
			{
				return "-1";
			}
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