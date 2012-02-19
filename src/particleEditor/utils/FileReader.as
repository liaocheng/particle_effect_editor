package  particleEditor.utils
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.FileFilter;
	import flash.utils.ByteArray;
	import org.aswing.AsWingManager;
	import org.aswing.JOptionPane;
	import org.aswing.UIManager;
	import flash.system.Capabilities;
	import flash.utils.getDefinitionByName;
	/**
	 * make sure this can be compiled in both player and air environment 
	 * @author liaocheng
	 */
	public class FileReader extends EventDispatcher
	{
		private static var FileCLs:Class;
		private static var FileModeCls:Class;
		private static var FileStreamCls:Class;
		
		private static var openFile:Object;
		
		
		private static var instance:FileReader;
		
		private static var _handler:Function;
		
		public static function readFile(fileFilter:FileFilter, handler:Function):void
		{
			if (Capabilities.playerType != "Desktop")
			{
				JOptionPane.showMessageDialog("Error", "must under air to use this feature");
				handler(null);
			}
			else
			{
				if (!openFile)
				{
					FileCLs = getDefinitionByName("flash.filesystem.File") as Class;
					FileModeCls = getDefinitionByName("flash.filesystem.FileMode") as Class;
					FileStreamCls = getDefinitionByName("flash.filesystem.FileStream") as Class;
					openFile = new FileCLs(FileCLs["applicationDirectory"]["nativePath"]);
				}
				_handler = handler;
				openFile["browseForOpen"]("Select a file", [fileFilter]);
				openFile["addEventListener"](Event.SELECT, fileSelect);
			}
		}
		
		private static function fileSelect(e:Event):void
		{
			var stream:Object = new FileStreamCls();
			stream["open"](openFile, FileModeCls["READ"]);
			var byteArray:ByteArray = new ByteArray();
			stream["readBytes"](byteArray);
			stream["close"]();
			_handler(byteArray);
			_handler = null;
		}
		
	}

}