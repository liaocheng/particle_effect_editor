package 
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.setTimeout;
	import org.aswing.ASColor;
	import org.aswing.AsWingManager;
	
	/**
	 * ...
	 * @author liaocheng.Email:liaocheng210@126.com
	 */
	[SWF(width="1024", height="768", frameRate="60")]
	public class Main extends Sprite 
	{
		private var mainWindow:MainWindow;
		private var _root:Sprite;
		
		public function Main():void 
		{
			if (stage) setTimeout(init,0);
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			var k:uint = parseInt(ASColor.RED.getARGB().toString(16),16);
			trace(k.toString(16));
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.RESIZE, onStageResize);
			
			//make mainWindow alaways at bottom 
			var sprite:Sprite = new Sprite();
			addChild(sprite);
			mainWindow = new MainWindow(sprite);
			_root = new Sprite();
			addChild(_root);
			AsWingManager.initAsStandard(_root);
			mainWindow.show();
			mainWindow.setSizeWH(stage.stageWidth, stage.stageHeight);
		}
		
		private function onStageResize(e:Event):void
		{
			mainWindow.setSizeWH(stage.stageWidth, stage.stageHeight);
		}

	}
	
}