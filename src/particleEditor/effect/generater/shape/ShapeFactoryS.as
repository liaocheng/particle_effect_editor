package particleEditor.effect.generater.shape 
{
	import particleEditor.edit.EditorDefinition;
	import particleEditor.edit.EditorWithPropertyBaseS;
	import particleEditor.edit.IImportable;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class ShapeFactoryS implements IImportable
	{
		
		private static const shapeEditors:Array = [ new EditorDefinition("shpere", SphereEditorS) , new EditorDefinition("plane", PlaneEditorS) , 
													new EditorDefinition("cube", CubeEditorS), new EditorDefinition("external model", FileModelEditorS)];
		
		private var _shapesModel:Array = new Array();
		
		
		public function ShapeFactoryS() 
		{
		}
		
		public function get tagName():String
		{
			return "shape";
		}
		
		public function importCode(xml:XML):void
		{
			for each(var i:XML in xml.editor)
			{
				var cls:Class = EditorDefinition.getClassByNameS(i.@clazz);
				var _editor:EditorWithPropertyBaseS = new cls() as EditorWithPropertyBaseS;
				_editor.setListModel(_shapesModel);
				_editor.importCode(i);
			}
		}
		
		public function createNeedStuff():*
		{
			return _shapesModel;
		}
		
	}

}