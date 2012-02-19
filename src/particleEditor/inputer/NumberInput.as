package particleEditor.inputer
{
	
	import flash.events.Event;
	import flash.ui.Keyboard;
	import org.aswing.event.AWEvent;
	import org.aswing.event.FocusKeyEvent;
	
	public class NumberInput extends LabelInput
	{
		
		private var min:Number;
		private var max:Number;
		private var unit:Number;
		
		public function NumberInput(labelText:String = "", inputText:String = "", gap:int = 2, column:int = 0, editable:Boolean = true)
		{
			super(labelText, inputText, gap, column, editable);
			setInputType(LabelInput.FLOAT);
			input.addEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __intKeyDown);
			setMinMax(-Number.MAX_VALUE);
			unit = 1;
		}
		
		public function setMinMax(min:Number , max:Number = Number.MAX_VALUE):void
		{
			this.min = min;
			this.max = max;
		}
			
		private function __intKeyDown(e:FocusKeyEvent):void
		{
			var value:Number = getInputNumber();
			var code:uint = e.keyCode;
			var enableKey:Boolean = false;
			if (code == Keyboard.UP)
			{
				value += unit;
				enableKey = true;
			}
			else if (code == Keyboard.DOWN)
			{
				value -= unit;
				enableKey = true;
			}
			else if (code == Keyboard.PAGE_UP)
			{
				value += unit * 10;
				enableKey = true;
			}
			else if (code == Keyboard.PAGE_DOWN)
			{
				value -= unit * 10;
				enableKey = true;
			}
			if (value > max)
				value = max;
			if (value < min)
				value = min;
			if (enableKey)
			{
				setInputText(value + "");
				dispatchEvent(new AWEvent(AWEvent.ACT));
			}
		}
		
		override protected function __action(e:Event):void
		{
			var value:int = getInputInt();
			if (value > max)
			{
				value = max;
				setInputText(value + "");
			}
			if (value < min)
			{
				value = min;
				setInputText(value + "");
			}
			super.__action(e);
		}
		
		override public function serialize():String
		{
			return String(getInputNumber());
		}
	}
}