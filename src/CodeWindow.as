package
{
	import flash.events.Event;
	import flash.system.System;
	import org.aswing.AsWingConstants;
	import org.aswing.AsWingUtils;
	import org.aswing.BorderLayout;
	import org.aswing.FlowLayout;
	import org.aswing.JButton;
	import org.aswing.JFrame;
	import org.aswing.JPanel;
	import org.aswing.JScrollPane;
	import org.aswing.JTextArea;
	
	/**
	 * ...
	 * @author liaocheng
	 */
	public class CodeWindow extends JFrame
	{
		
		private var bodyText:JTextArea;
		private var okButton:JButton;
		private var okHandler:Function;
		
		public function CodeWindow(title:String, body:String = "", showCopy:Boolean = false)
		{
			super(null, title, true);
			
			bodyText = new JTextArea(body);
			var scrollPane:JScrollPane = new JScrollPane(bodyText);
			getContentPane().append(scrollPane, BorderLayout.CENTER);
			okButton = new JButton("OK");
			var pane:JPanel = new JPanel(new FlowLayout(AsWingConstants.CENTER));
			if (showCopy)
			{
				var copyButton:JButton = new JButton("copy");
				pane.append(copyButton);
				copyButton.addActionListener(onCopy);
				copyButton.requestFocus();
			}
			pane.append(okButton);
			getContentPane().append(pane, BorderLayout.SOUTH);
			okButton.addActionListener(onClickOk);
			if (!showCopy)
			{
				okButton.requestFocus();
			}
		}
		
		private function setOkHandler(handler:Function):void
		{
			this.okHandler = handler;
		}
		
		private function onCopy(e:Event):void
		{
			System.setClipboard(bodyText.getText());
		}
		
		private function onClickOk(e:Event):void
		{
			tryToClose();
			if (okHandler != null)
				okHandler(bodyText.getText());
		}
		
		private function setEditable(value:Boolean):void
		{
			bodyText.setEditable(value);
		}
		
		public static function showExport(code:String):void
		{
			var dialog:CodeWindow = new CodeWindow("export code", code);
			dialog.setSizeWH(600, 400);
			AsWingUtils.centerLocate(dialog);
			dialog.setEditable(false);
			dialog.show();
		}
		
		public static function showImport(handler:Function):void
		{
			var dialog:CodeWindow = new CodeWindow("import code");
			dialog.setSizeWH(600, 400);
			AsWingUtils.centerLocate(dialog);
			dialog.setOkHandler(handler);
			dialog.show();
		}
	
	}

}