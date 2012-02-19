package particleEditor.easing
{
	public class Sine
	{
		public static function easeIn( t : Number, b : Number, c : Number, d : Number ) : Number
		{
			return -c * Math.cos( t / d * ( Math.PI * 0.5 ) ) + c + b;
		}

		public static function easeOut( t : Number, b : Number, c : Number, d : Number ) : Number
		{
			return c * Math.sin( t / d * ( Math.PI * 0.5 ) ) + b;
		}

		public static function easeInOut( t : Number, b : Number, c : Number, d : Number ) : Number
		{
			return -c * 0.5 * ( Math.cos( Math.PI * t / d ) - 1 ) + b;
		}
	}
}
