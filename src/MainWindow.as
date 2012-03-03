package  
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.utils.ByteArray;
	import org.aswing.ASColor;
	import org.aswing.AssetPane;
	import org.aswing.AsWingConstants;
	import org.aswing.BorderLayout;
	import org.aswing.event.ResizedEvent;
	import org.aswing.FlowLayout;
	import org.aswing.JButton;
	import org.aswing.JOptionPane;
	import org.aswing.JPanel;
	import org.aswing.JSplitPane;
	import org.aswing.JWindow;
	import org.aswing.SoftBoxLayout;
	import particleEditor.effect.EffectFactory;
	import particleEditor.EffectGroup;
	import particleEditor.EffectGroupFactory;
	import particleEditor.utils.FileOperater;

	/**
	 * ...
	 * @author liaocheng
	 */
	public class MainWindow extends JWindow
	{
		
		private var _previewPane:PreviewPane;
		
		private var _rightPane:JPanel;
		private var _leftPane:JPanel;
		
		private var _effectGroupFactory:EffectGroupFactory;
		
		private var _playPane:PlayPane;
		
		//set particleContainer's property
		private var _systemContainer:JPanel;
		
		public function MainWindow(parent:DisplayObject) 
		{
			super(parent);
			addEventListener(Event.ENTER_FRAME, onRender);
			
			
			_previewPane = new PreviewPane();
			
			
			var _assetPane:AssetPane = new AssetPane(null, AssetPane.PREFER_SIZE_LAYOUT);
			_assetPane.setAsset(_previewPane);

			_assetPane.addEventListener(ResizedEvent.RESIZED, function(e:Event):void { _previewPane.setSize(_assetPane.getSize().width, _assetPane.getSize().height); } );
			
			_rightPane = new JPanel(new BorderLayout());
			_leftPane = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 10));
			_effectGroupFactory = new EffectGroupFactory();
			
			_leftPane.append(_effectGroupFactory);
			
			var showButton:JButton = new JButton("preview");
			showButton.setBackground(ASColor.GREEN);
			showButton.addActionListener(preview);
			_leftPane.append(showButton);
			
			_playPane = new PlayPane();
			_leftPane.append(_playPane);
			
			var _exportButton:JButton = new JButton("export");
			var _importButton:JButton = new JButton("import");
			var _pane:JPanel = new JPanel(new FlowLayout(AsWingConstants.CENTER,10,0));
			_pane.appendAll(_exportButton, _importButton);
			_leftPane.append(_pane);
			var _openButton:JButton = new JButton(" open ");
			var _saveButton:JButton = new JButton(" save ");
			_pane = new JPanel(new FlowLayout(AsWingConstants.CENTER,10,0));
			_pane.appendAll(_saveButton, _openButton);
			_leftPane.append(_pane);
			
			_importButton.addActionListener(importCode);
			_exportButton.addActionListener(exportCode);
			_openButton.addActionListener(openFile);
			_saveButton.addActionListener(saveFile);
			
			_effectGroupFactory.setSelectHandler(selectEffect);

			var temp1:JSplitPane = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT, false, _assetPane, _rightPane);
			var temp2:JSplitPane = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT, false, _leftPane, temp1);
			temp1.setResizeWeight(0.6);
			temp2.setResizeWeight(0.2);
			setContentPane(temp2);
			
			_systemContainer = new JPanel(new FlowLayout(AsWingConstants.CENTER));
			_leftPane.append(_systemContainer);
		}
		
		private function preview(e:Event):void
		{
			try
			{
				var effectGroup:EffectGroup = _effectGroupFactory.createNeedStuff() as EffectGroup;
				_playPane.setEffect(effectGroup);
				_previewPane.previewEffect(effectGroup);
			}
			catch (e:Error)
			{
				JOptionPane.showMessageDialog("error", e.message + "\n" + e.getStackTrace());
			}
		}
		
		private function selectEffect(effect:EffectFactory):void
		{
			_rightPane.removeAll();
			_systemContainer.removeAll();
			if (effect)
			{
				_rightPane.append(effect, BorderLayout.CENTER);
				_systemContainer.append(effect.getSystemPane(), BorderLayout.CENTER);
			}
			this.revalidate();
		}
		
		private function exportCode(e:Event):void
		{
			CodeWindow.showExport(_effectGroupFactory.getExportCode());
		}
		
		private function openFile(e:Event):void
		{ 
			FileOperater.readFile(new FileFilter("open a valid xml file", "*.*"), onReadFile);
		}
		
		private function onReadFile(byte:ByteArray):void
		{
			if (byte)
			{
				onImportCode(byte.toString());
			}
		}
		
		private function saveFile(e:Event):void
		{ 
			FileOperater.writeFile(_effectGroupFactory.getExportCode());
		}
		
		private function importCode(e:Event):void
		{
			CodeWindow.showImport(onImportCode);
		}
		private function onImportCode(code:String):void
		{
			try
			{
				_effectGroupFactory.importCode(new XML(code));
			}
			catch (e:Error)
			{
				JOptionPane.showMessageDialog("error", e.message + "\n" + e.getStackTrace());
				var effectGroup:EffectGroup = new EffectGroup(); 
				_playPane.setEffect(effectGroup);
				_previewPane.previewEffect(effectGroup);
			}
		}
		
		private function onRender(e:Event):void
		{
			try
			{
				_previewPane.render();
			}
			catch (e:Error)
			{
				JOptionPane.showMessageDialog("error", e.message + "\n" + e.getStackTrace());
				var effectGroup:EffectGroup = new EffectGroup(); 
				_playPane.setEffect(effectGroup);
				_previewPane.previewEffect(effectGroup);
			}
		}
		
	}

}