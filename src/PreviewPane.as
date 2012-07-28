package
{
	import away3d.containers.View3D;
	import away3d.debug.AwayStats;
	import away3d.debug.WireframeAxesGrid;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.aswing.ASColor;
	import org.aswing.JButton;
	import org.aswing.JCheckBox;
	import org.aswing.JColorChooser;
	import org.aswing.JPanel;
	import org.aswing.SoftBoxLayout;
	import particleEditor.EffectGroup;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class PreviewPane extends Sprite
	{
		protected var _view:View3D;
		protected var _changeButton:JButton;
		protected var _showGrid:JCheckBox;
		protected var _axesGrid:WireframeAxesGrid;
		
		
		private var _effect:EffectGroup;
		
		public function PreviewPane()
		{
			_view = new View3D();
			_view.width = 256;
			_view.height = 256;
			_view.antiAlias = 4;
			addChild(_view);
			_changeButton = new JButton("background");
			_showGrid = new JCheckBox("grid");
			_showGrid.setSelected(true);
			var pane:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
			pane.setY(100);
			pane.appendAll(_changeButton,_showGrid);
			pane.pack();
			pane.validate();
			addChild(pane);
			addChild(new AwayStats(_view));
			this.addEventListener(Event.ADDED_TO_STAGE, onStage);
			_view.scene.addChild((_axesGrid = new WireframeAxesGrid(4, 1000)));
			
			_changeButton.addActionListener(onChangeBackground);
			_showGrid.addActionListener(onShowGrid);
		}
		
		private function onStage(e:Event):void
		{
			new HoverDragController(_view.camera, _view);
			
			
		}
		
		public function previewEffect(effect:EffectGroup):void
		{
			if (_effect)_view.scene.removeChild(_effect);
			_effect = effect;
			if (_effect)_view.scene.addChild(_effect);
		}
		
		public function setSize(w:int,h:int):void
		{
			_view.width = w;
			_view.height = h;
		}
		
		public function render():void
		{
			_view.render();
		}
		
		private function onChangeBackground(e:Event):void
		{
			JColorChooser.showDialog(null, "select a backgroung color", new ASColor(_view.backgroundColor,_view.backgroundAlpha), true, changeColor);
		}
		
		private function changeColor(color:ASColor):void
		{
			_view.backgroundColor = color.getRGB();
			_view.backgroundAlpha = color.getAlpha();
		}
		
		private function onShowGrid(e:Event):void
		{
			_axesGrid.visible = _showGrid.isSelected();
		}
		
		public function dispose():void
		{
			_view.dispose();
		}
	}

}