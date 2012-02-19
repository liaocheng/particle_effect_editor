package  particleEditor.effect.param
{
	import org.aswing.ASColor;
	import org.aswing.border.EmptyBorder;
	import org.aswing.border.LineBorder;
	import org.aswing.Insets;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.SoftBoxLayout;
	import org.aswing.VectorListModel;
	import particleEditor.edit.IExportable;
	import particleEditor.utils.FrameFolder;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class InitParamFactory extends JPanel implements IExportable
	{
		
		private var _localVarFactory:LocalVarFactory;
		private var actionPane:JPanel;
		
		private var timeSelectionPane:TimeSelection;
		
		public function InitParamFactory() 
		{
			super(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 5));
			var title:JLabel = new JLabel("set local actions' init pram for this system!");
			title.setForeground(ASColor.RED);
			append(title);
			
			
			var folder1:FrameFolder = new FrameFolder("local vars");
			folder1.setLayout(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 1));
			folder1.setBorder(new EmptyBorder(new LineBorder(new EmptyBorder(null,new Insets(2,2,2,2))), new Insets(0, 10, 0, 10)));
			var folder2:FrameFolder = new FrameFolder("action setting");
			folder2.setLayout(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 1));
			folder2.setBorder(new EmptyBorder(new LineBorder(new EmptyBorder(null,new Insets(2,2,2,2))), new Insets(0, 10, 0, 10)));
			
			_localVarFactory = new LocalVarFactory(folder1.setTitle);
			actionPane = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 5));
			
			folder1.setContent(_localVarFactory);
			folder2.setContent(actionPane);
			appendAll(folder1, folder2);
			
			timeSelectionPane = new TimeSelection(getVarListModel());
			actionPane.append(timeSelectionPane);
		}
		
		public function getActionPane():JPanel
		{
			return actionPane;
		}
		
		public function getVarListModel():VectorListModel
		{
			return _localVarFactory.getVarListModel();
		}
				
		public function createNeedStuff():*
		{
			return _localVarFactory.createNeedStuff();
		}
		
		public function getTimeHanlder():Function
		{
			return timeSelectionPane.createNeedStuff() as Function;
		}
		
		public function get tagName():String
		{
			return _localVarFactory.tagName;
		}
		
		public function getExportCode():XML
		{
			var xml:XML = _localVarFactory.getExportCode();
			var exception:XML = new XML("<exception/>");
			exception.@comment = "this if for time action";
			xml.appendChild(exception);
			exception.appendChild(timeSelectionPane.getExportCode());
			return xml;
		}
		public function importCode(code:XML):void
		{
			_localVarFactory.importCode(code);
			timeSelectionPane.importCode(code.exception.editor[0]);
		}
		
	}

}