package particleEditor.edit 
{
	/**
	 * ...
	 * @author liaocheng
	 */
	public class EditorWithPropertyBaseS extends EditorBaseS
	{
		
		protected var _property:Property;
		protected var _listModel:Array;
		
		
		protected var definition:EditorDefinition;
		
		public function EditorWithPropertyBaseS() 
		{
			super();
			_property = createProperty();
			_property.setCreateHandler(this.createNeedStuff);
		}
		
		protected function createProperty():Property
		{
			return new Property();
		}
		
		public function setListModel(value:Array):void
		{
			_listModel = value;
			_listModel.push(_property);
		}
	}

}