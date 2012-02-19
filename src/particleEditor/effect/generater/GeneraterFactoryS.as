package  particleEditor.effect.generater
{
	import a3dparticle.generater.GeneraterBase;
	import particleEditor.edit.EditorBaseS;
	import particleEditor.edit.EditorDefinition;
	import particleEditor.edit.IImportable;
	import particleEditor.effect.generater.material.MaterialFactoryS;
	import particleEditor.effect.generater.shape.ShapeFactoryS;
	import particleEditor.effect.generater.subGenerate.SingleGeneraterEditorS;
	import particleEditor.effect.generater.subGenerate.WeightGeneraterEditorS;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class GeneraterFactoryS implements IImportable
	{
		private static var generaterEditors:Array = [ new EditorDefinition("single", SingleGeneraterEditorS), new EditorDefinition("weight", WeightGeneraterEditorS)];
		
		private var _shapeFactory:ShapeFactoryS;
		
		private var _materialFactory:MaterialFactoryS;
		
		private var _samplesFactory:SamplesFactoryS;
		
		private var _editorPane:EditorBaseS;
		
		public function GeneraterFactoryS() 
		{
			_shapeFactory = new ShapeFactoryS();
			_materialFactory = new MaterialFactoryS();
			_samplesFactory = new SamplesFactoryS(_shapeFactory.createNeedStuff() as Array,_materialFactory.createNeedStuff() as Array);	
			
		}
		
		public function get tagName():String
		{
			return "generater";
		}
		
		public function importCode(xml:XML):void
		{
			_shapeFactory.importCode(xml[_shapeFactory.tagName][0]);
			_materialFactory.importCode(xml[_materialFactory.tagName][0]);
			_samplesFactory.importCode(xml[_samplesFactory.tagName][0]);
			
			var cls:Class = EditorDefinition.getClassByNameS(xml.output.editor.@clazz) as Class;
			_editorPane = new cls(_samplesFactory.createNeedStuff()) as EditorBaseS;
			_editorPane.importCode(xml.output[_editorPane.tagName][0]);
		}
		
		public function createNeedStuff():*
		{
			return _editorPane.createNeedStuff() as GeneraterBase;
		}
	}

}