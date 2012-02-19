package  particleEditor.utils
{
	import flash.events.Event;
	import org.aswing.ASColor;
	import org.aswing.ASFont;
	import org.aswing.AsWingConstants;
	import org.aswing.AsWingUtils;
	import org.aswing.BorderLayout;
	import org.aswing.Component;
	import org.aswing.Container;
	import org.aswing.event.PopupEvent;
	import org.aswing.ext.Folder;
	import org.aswing.JFrame;
	import org.aswing.JPanel;
	import org.aswing.JScrollPane;
	import org.aswing.JToggleButton;
	import org.aswing.JViewport;
	/**
	 * it is windowable folder
	 * @author liaocheng
	 */
	public class FrameFolder extends Folder
	{
		protected var frame:JFrame;
		protected var frameViewPort:JViewport;
		protected var windowButton:JToggleButton;
		protected var content:Component;
		
		public function FrameFolder(title:String="") 
		{
			super(title);
			setContentPane(new JPanel(new BorderLayout()));
			windowButton.addActionListener(onWindowMode);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
		}

		override public function setTitle(t:String):void
		{
			super.setTitle(t);
			if(frame)frame.setTitle(t);
		}
		
		private function onWindowMode(e:Event):void
		{
			if (windowButton.isSelected())
			{
				titleButton.setSelected(true);
				if (content)
				{
					(getContentPane() as Container).remove(content);
					if (!frame)
					{
						frame = new JFrame(null, getTitle());
						frame.setDefaultCloseOperation(JFrame.HIDE_ON_CLOSE);
						frame.setSizeWH(500, 600);
						AsWingUtils.centerLocate(frame);
						frame.getContentPane().setLayout(new BorderLayout());
						frameViewPort = new JViewport();
						var scrollPane:JScrollPane = new JScrollPane(frameViewPort);
						(scrollPane.getViewport() as JViewport).setTracksWidth(true);
						(scrollPane.getViewport() as JViewport).setVerticalAlignment(AsWingConstants.TOP);
						frame.getContentPane().append(scrollPane, BorderLayout.CENTER);
						frame.addEventListener(PopupEvent.POPUP_CLOSED, onRemove);
					}
					frameViewPort.setView(content);
					frame.show();
				}
				
				titleButton.setSelected(false);
				titleButton.setEnabled(false);
			}
			else
			{
				if (frame)
				{
					frame.hide();
					frameViewPort.setView(null);
				}
				if(content)(getContentPane() as Container).append(content);
				titleButton.setSelected(true);
				titleButton.setEnabled(true);
			}
		}
		
		public function setContent(value:Component):void
		{
			content = value;
			onWindowMode(null);
		}
		
		override protected function initTitleBar():void
		{
			windowButton = new JToggleButton("window");
			windowButton.setBackground(ASColor.RED);
			setFont(new ASFont("Dialog", 12, true));
			titleButton.setFont(null);
			titleButton.setHorizontalAlignment(AsWingConstants.LEFT);
			var pane:JPanel = new JPanel(new BorderLayout());
			pane.append(titleButton, BorderLayout.CENTER);
			pane.append(windowButton, BorderLayout.EAST);
			if(titlePosition == BOTTOM){
				pane.setConstraints(BorderLayout.SOUTH);
			}else{
				pane.setConstraints(BorderLayout.NORTH);
			}
			super.insertImp(0, pane);
		}
		
		private function onRemove(e:Event):void
		{
			windowButton.setSelected(false);
			onWindowMode(null);
		}
		
	}

}