package  particleEditor.edit
{
	/**
	 * ...
	 * @author liaocheng
	 */
	public class LocalActionProperty extends Property
	{
		protected var _initParamHandler:Function;
		
		public function LocalActionProperty() 
		{
			
		}
		
		public function setInitParamHandler(value:Function):void
		{
			_initParamHandler = value;
		}
		
		public function getNewInitHanlder():Function
		{
			return _initParamHandler();
		}
		
		
		
	}

}