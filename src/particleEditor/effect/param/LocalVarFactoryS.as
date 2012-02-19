package  particleEditor.effect.param
{
	import particleEditor.edit.EditorDefinition;
	import particleEditor.edit.IImportable;
	import particleEditor.edit.Property;
	import particleEditor.effect.param.vars.*;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class LocalVarFactoryS  implements IImportable
	{
		
		private static const varEditors:Array = [ new EditorDefinition("const number", ConstNumberVarEditorS), new EditorDefinition("random number", RandomNumberVarEditorS), new EditorDefinition("ease number", EaseNumberEditorS),
												 new EditorDefinition("random circle", RandomCircleVarEditorS),new EditorDefinition("random globe", RandomGlobeVarEditorS) ];
		
		private var _varsModel:Array = new Array();
		
		private var _funModel:Array = new Array();
		
		
		public function LocalVarFactoryS()
		{
		}
		
		public function getVarListModel():Array
		{
			return _varsModel;
		}
		
		public function createNeedStuff():*
		{
			return _funModel.map(function(property:Property,...rest):* { return property.getNewValue();});
		}
		
		public function get tagName():String
		{
			return "vars";
		}
		
		public function importCode(xml:XML):void
		{
			for each(var i:XML in xml.editor)
			{
				var cls:Class = EditorDefinition.getClassByNameS(i.@clazz);
				var _editor:VarEditorBaseS = new cls() as VarEditorBaseS;
				_editor.setListModel(_funModel);
				_editor.setVarListModel(_varsModel);
				_editor.importCode(i);
			}
		}
		
	}

}