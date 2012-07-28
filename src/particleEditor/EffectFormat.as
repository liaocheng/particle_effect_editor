package particleEditor
{
	/**
	 * This effect format is experimental now . The new version may be not backward compatibility .
	 * @author Cheng Liao
	 */
	public class EffectFormat
	{
		public static const MAIN:int = 0;
		public static const MINOR:int = 0;
		public static const ROOT_NAME:String = "root";
		
		public static function verifyFormat(xml:XML):void
		{
			if (xml.localName().toString() != ROOT_NAME)
			{
				throw(new Error("invalid format"));
			}
			if (int(xml.@main) != MAIN)
			{
				throw(new Error("main version is not compatible"));
			}
			if (int(xml.@minor) > MINOR)
			{
				throw(new Error("minor version is not compatible , please update your lib version "));
			}
		}
	}
}