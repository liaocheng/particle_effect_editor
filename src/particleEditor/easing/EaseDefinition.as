package particleEditor.easing
{
	/**
	 * ...
	 * @author liaocheng
	 */
	public class EaseDefinition 
	{
		public static const ALL_EASE:Array = [new EaseDefinition("Linear", Linear.ease), 
											new EaseDefinition("Expo.easeIn", Expo.easeIn), new EaseDefinition("Expo.easeOut", Expo.easeOut), new EaseDefinition("Expo.easeInOut", Expo.easeInOut),
											new EaseDefinition("Sine.easeIn", Sine.easeIn), new EaseDefinition("Sine.easeOut", Sine.easeOut), new EaseDefinition("Sine.easeInOut", Sine.easeInOut),
											new EaseDefinition("Circular.easeIn", Circular.easeIn), new EaseDefinition("Circular.easeOut", Circular.easeOut), new EaseDefinition("Circular.easeInOut", Circular.easeInOut),
											new EaseDefinition("Bounce.easeIn", Bounce.easeIn), new EaseDefinition("Bounce.easeOut", Bounce.easeOut), new EaseDefinition("Bounce.easeInOut", Bounce.easeInOut),
											new EaseDefinition("Back.easeIn", Back.easeIn), new EaseDefinition("Back.easeOut", Back.easeOut), new EaseDefinition("Back.easeInOut", Back.easeInOut),
											new EaseDefinition("Cubic.easeIn", Cubic.easeIn), new EaseDefinition("Cubic.easeOut", Cubic.easeOut), new EaseDefinition("Cubic.easeInOut", Cubic.easeInOut),
											new EaseDefinition("Quartic.easeIn", Quartic.easeIn), new EaseDefinition("Quartic.easeOut", Quartic.easeOut), new EaseDefinition("Quartic.easeInOut", Quartic.easeInOut),
											new EaseDefinition("Quintic.easeIn", Quartic.easeIn), new EaseDefinition("Quintic.easeOut", Quartic.easeOut), new EaseDefinition("Quintic.easeInOut", Quartic.easeInOut),
											new EaseDefinition("Elastic.easeIn", Elastic.easeIn), new EaseDefinition("Elastic.easeOut", Elastic.easeOut), new EaseDefinition("Elastic.easeInOut", Elastic.easeInOut)];
											
		
		private var _name:String;
		private var _easeFunction:Function;
		public function EaseDefinition(name:String,easeFunction:Function) 
		{
			_name = name;
			_easeFunction = easeFunction;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get easeFunction():Function
		{
			return _easeFunction;
		}
		
		public function toString():String
		{
			return _name;
		}
		
	}

}