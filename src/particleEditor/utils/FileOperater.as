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
	public class FileOperater extends EventDispatcher
	{
		private static var FileCLs:Class;
		private static var FileModeCls:Class;
		private static var FileStreamCls:Class;
		
		private static var _openFile:Object;
				
		private static var _handler:Function;
		private static var _data:String;
		
		private static function initCls():void
		{
			FileCLs = getDefinitionByName("flash.filesystem.File") as Class;
			FileModeCls = getDefinitionByName("flash.filesystem.FileMode") as Class;
			FileStreamCls = getDefinitionByName("flash.filesystem.FileStream") as Class;
		}
		
		private static function get openFile():Object
		{
			if (!_openFile)
			{
				initCls();
				_openFile = new FileCLs(FileCLs["applicationDirectory"]["nativePath"]);
			}
			return _openFile;
		}
		
		private static function set openFile(value:Object):void
		{
			if (!_openFile)
			{
				initCls();
			}
			_openFile = value;
		}
		
		public static function readFile(fileFilter:FileFilter, handler:Function):void
		{
			if (Capabilities.playerType != "Desktop")
			{
				JOptionPane.showMessageDialog("Error", "run air version to use this feature");
				handler(null);
			}
			else
			{
				_handler = handler;
				openFile["browseForOpen"]("Select a file", [fileFilter]);
				openFile["addEventListener"](Event.SELECT, fileSelectForRead);
				openFile["addEventListener"](Event.CANCEL, removeListen);
			}
		}
		
		private static function fileSelectForRead(e:Event):void
		{
			removeListen();
			var stream:Object = new FileStreamCls();
			stream["open"](openFile, FileModeCls["READ"]);
			var byteArray:ByteArray = new ByteArray();
			stream["readBytes"](byteArray);
			stream["close"]();
			_handler(byteArray);
			_handler = null;
		}
		
		private static function removeListen(e:Event=null):void
		{
			openFile["removeEventListener"](Event.SELECT, fileSelectForRead);
			openFile["removeEventListener"](Event.SELECT, fileSelectForSave);
			openFile["removeEventListener"](Event.CANCEL, removeListen);
		}
		
		public static function writeFile(data:String):void
		{
			if (Capabilities.playerType != "Desktop")
			{
				JOptionPane.showMessageDialog("Error", "run air version to use this feature");
			}
			else
			{
				_data = data;
				openFile["browseForSave"]("Save As");
				openFile["addEventListener"](Event.SELECT, fileSelectForSave);
				openFile["addEventListener"](Event.CANCEL, removeListen);
			}
		}
		
		private static function fileSelectForSave(e:Event):void
		{
			removeListen();
			var stream:Object = new FileStreamCls();
			stream["open"](openFile, FileModeCls["WRITE"]);
			stream["writeUTFBytes"](_data);
			stream["close"]();
		}
		
	}

}