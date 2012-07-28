package particleEditor.effect.action
{
	import particleEditor.edit.EditorDefinition;
	import particleEditor.edit.IImportable;
	import particleEditor.effect.action.local.*;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class LocalFactoryS implements IImportable
	{
		
		private static const localAction:Array = [ new EditorDefinition("velocity",VelocityLocalEditorS) , new EditorDefinition("offset", OffsetActionEditorS), new EditorDefinition("accelerate",AccelerateLocalEditorS) ,
													new EditorDefinition("circle",CircleLocalEditorS) , new EditorDefinition("drift",DriftLocalEditorS), new EditorDefinition("scale",RandomScaleLocalEditorS) ,
													new EditorDefinition("bezier", BezierLocalEditorS), new EditorDefinition("rotation", RotateLocalEditorS), new EditorDefinition("UV seq pic by time", UVSeqPicByTimeLocalEditorS),
													new EditorDefinition("color", ColorTransformEditorS)];
		
		
		private var _actionsModel:Array = new Array();
		
		private var _varListModel:Array;
		
		
		public function LocalFactoryS(varListModel:Array)
		{
			_varListModel = varListModel;
		}
		
			
		public function createNeedStuff():*
		{
			return _actionsModel;
		}
		
		public function get tagName():String
		{
			return "local";
		}
		
		
		public function importCode(xml:XML):void
		{
			for each(var i:XML in xml.editor)
			{
				var cls:Class = EditorDefinition.getClassByNameS(i.@clazz);
				var _editor:LocalActionBaseS = new cls(_varListModel) as LocalActionBaseS;
				_editor.setListModel(_actionsModel);
				_editor.importCode(i);
			}
		}
		
	}

}