package particleEditor.easing
{
	public class Linear
	{
		public static function ease( t : Number, b : Number, c : Number, d : Number ) : Number
		{
			return c * t / d + b;
		}
	}
}
