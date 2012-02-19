package particleEditor.inputer
{
	
	import flash.events.Event;
	import org.aswing.event.AWEvent;
	import org.aswing.event.FocusKeyEvent;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	
	public class IntInput extends LabelInput
	{
		
		private var min:int;
		private var max:int;
		
		public function IntInput(labelText:String = "", inputText:String = "", gap:int = 2, column:int = 0, editable:Boolean = true)
		{
			super(labelText, inputText, gap, column, editable);
			setInputType(LabelInput.INT);
			input.addEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __intKeyDown);
			setMinMax();
		}
		
		public function setMinMax(min:Number = int.MIN_VALUE, max:Number = int.MAX_VALUE):void
		{
			this.min = min;
			this.max = max;
		}
		
		private function __intKeyDown(e:FocusKeyEvent):void
		{
			var value:int = getInputInt();
			var code:uint = e.keyCode;
			var enableKey:Boolean = false;
			if (code == Keyboard.UP)
			{
				value++;
				enableKey = true;
			}
			else if (code == Keyboard.DOWN)
			{
				value--;
				enableKey = true;
			}
			else if (code == Keyboard.PAGE_UP)
			{
				value += 10;
				enableKey = true;
			}
			else if (code == Keyboard.PAGE_DOWN)
			{
				value -= 10;
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
			return String(getInputInt());
		}
	}
}