package particleEditor.inputer
{
	/**
	 * ...
	 * @author liaocheng
	 */
	public class ComboBoxInputS 
	{
		
		private var _listData:Array;
		private var _selectedIndex:int;
		public function ComboBoxInputS(listData:Array) 
		{
			_listData = listData;
		}
		
		public function deserialize(value:String):void
		{
			_selectedIndex = int(value);
		}
		
		public function getValue():*
		{
			if (_listData && _selectedIndex >= 0)
			{
				return _listData[_selectedIndex];
			}
			else
			{
				return null;
			}
			
		}
		
	}

}