package  
{
	import flash.events.Event;
	import flash.utils.getTimer;
	import org.aswing.ASColor;
	import org.aswing.AsWingConstants;
	import org.aswing.border.EmptyBorder;
	import org.aswing.border.LineBorder;
	import org.aswing.event.AWEvent;
	import org.aswing.event.InteractiveEvent;
	import org.aswing.FlowLayout;
	import org.aswing.Insets;
	import org.aswing.JPanel;
	import org.aswing.JScrollBar;
	import org.aswing.JToggleButton;
	import org.aswing.SoftBoxLayout;
	import particleEditor.EffectGroup;
	import particleEditor.inputer.IntInput;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class PlayPane extends JPanel
	{
		private var _scrollBar:JScrollBar;
		private var _maxInput:IntInput;
		private var _playButton:JToggleButton;
		private var _nowInput:IntInput;
		
		private var _effect:EffectGroup;
		
		private var _isPlay:Boolean;
		private var _lastTime:int;
		
		public function PlayPane() 
		{
			super(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 10));

			setBorder(new EmptyBorder(new LineBorder(new EmptyBorder(null, new Insets(5, 5, 5, 5))), new Insets(5, 5, 5, 5)));
			
			_scrollBar = new JScrollBar(AsWingConstants.HORIZONTAL, 0, 1, 0, 100);
			_scrollBar.setBackground(ASColor.HALO_GREEN)
			var pane:JPanel;
			pane = new JPanel(new FlowLayout(AsWingConstants.CENTER));
			_nowInput = new IntInput("now", "0", 2, 3);
			_nowInput.setEditable(false);
			_maxInput = new IntInput("total", "100", 2, 3);
			_maxInput.setMinMax(1);
			pane.appendAll(_nowInput,_maxInput);
			append(_scrollBar);
			append(pane);
			pane = new JPanel(new FlowLayout(AsWingConstants.CENTER));
			_playButton = new JToggleButton("play");
			pane.append(_playButton);
			append(pane);
			setState(false);
			setMax(10);
			
			_lastTime = getTimer();
			addEventListener(Event.ENTER_FRAME, onUpdate);
			_scrollBar.addStateListener(scrollChange);
			_playButton.addActionListener(onClick);
			_maxInput.addEventListener(AWEvent.ACT, onMaxChange);
			
		}
		
		public function setEffect(effect:EffectGroup):void
		{
			_effect = effect;
			if (_effect && !_effect.isEmpty())
			{
				setState(true);
				play();
			}
			else
			{
				setState(false);
			}
		}
		
		private function play():void
		{
			_isPlay = true;
			_playButton.setSelected(true);
			_playButton.setText("pause");
			_playButton.revalidate();
		}
		
		private function stop():void
		{
			_isPlay = false;
			_playButton.setSelected(false);
			_playButton.setText("play");
			_playButton.revalidate();
		}
		
		private function setState(value:Boolean):void
		{
			if (!value)
			{
				stop();
				_playButton.setEnabled(false);
				setTime(0);
			}
			else
			{
				_playButton.setEnabled(true);
			}
		}
		
		private function onUpdate(e:Event):void
		{
			if (_isPlay)
			{
				if (_effect&&!_effect.isEmpty())
				{
					if (_effect.time > _maxInput.getInputInt())
					{
						stop();
					}
					var delta:Number = (getTimer() - _lastTime) / 1000;
					setTime(_effect.time+delta);
				}
				else
				{
					setState(false);
				}
			}
			_lastTime = getTimer();
		}
		
		private function setTime(time:Number):void
		{
			if(_effect)_effect.time = time;
			_nowInput.setInputText(String(Number(int(time * 100) / 100)));
			_scrollBar.setValue(time/_maxInput.getInputInt()* 100);
			
		}
		
		private function setMax(value:int):void
		{
			_maxInput.setInputText(value + "");
		}
		
		private function scrollChange(e:InteractiveEvent):void
		{
			if (!e.isProgrammatic())
			{
				var time:Number = _scrollBar.getValue() * _maxInput.getInputInt() / 100;
				if(_effect)_effect.time = time;
				_nowInput.setInputText(String(Number(int(time * 100) / 100)));
			}
		}
		
		private function onClick(e:Event):void
		{
			if (_playButton.isSelected()) play();
			else stop();
		}
		
		private function onMaxChange(e:Event):void
		{
			setMax(_maxInput.getInputInt());
		}
		
	}

}