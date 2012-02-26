package particleEditor.effect.action
{
	import particleEditor.edit.EditorDefinition;
	import particleEditor.edit.EditorWithPropertyBaseS;
	import particleEditor.edit.IImportable;
	import particleEditor.effect.action.global.*;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class GlobalFactoryS implements IImportable
	{
		
		private static const globalAction:Array = [ new EditorDefinition("velocity",VelocityGlobalEditorS) , new EditorDefinition("accelerate",AccelerateGlobalEditorS) , new EditorDefinition("billboard",BillboardEditorS) ,
													new EditorDefinition("scale by life",ScaleByLifeGlobalEditorS), new EditorDefinition("scale by time",ScaleByTimeGlobalEditorS), new EditorDefinition("bezier",BezierGlobalEditorS),
													new EditorDefinition("broken line", BrokenLineGlobalEditorS), new EditorDefinition("color by life", ChangeColorByLifeGlobalEditorS), new EditorDefinition("flicker", FlickerGlobalEditorS),
													new EditorDefinition("rotate by speed", AutoRotateGlobalEditorS), new EditorDefinition("UV linear ease", UVLinearEaseGlobalEditorS), new EditorDefinition("UV drift", UVDriftGlobalEditorS)
													,new EditorDefinition("UV seq pic by time",UVSeqPicByTimeGlobalEditorS), new EditorDefinition("UV seq pic by life", UVSeqPicByLifeGlobalEditorS)];
		private var _actionsModel:Array = new Array();
		
		public function GlobalFactoryS()
		{
		}
		
		public function createNeedStuff():*
		{
			return _actionsModel;
		}		
		
		
		public function get tagName():String
		{
			return "global";
		}
		
		public function importCode(xml:XML):void
		{
			for each(var i:XML in xml.editor)
			{
				var cls:Class = EditorDefinition.getClassByNameS(i.@clazz);
				var _editor:EditorWithPropertyBaseS = new cls() as EditorWithPropertyBaseS;
				_editor.setListModel(_actionsModel);
				_editor.importCode(i);
			}
		}
	}

}