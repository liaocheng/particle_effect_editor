package particleEditor.effect.action.local
{
	import org.aswing.Container;
	import org.aswing.event.AWEvent;
	import org.aswing.VectorListModel;
	import particleEditor.edit.EditorDefinition;
	import particleEditor.edit.EditorWithPropertyBase;
	import particleEditor.edit.LocalActionProperty;
	import particleEditor.edit.Property;
	import particleEditor.effect.action.ActionEditorBase;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class LocalActionBase extends ActionEditorBase
	{
		protected var paramContentPane:Container;
		protected var paramPane:EditorWithPropertyBase;
		protected var varListModel:VectorListModel;
		
		public function LocalActionBase(_varListModel:VectorListModel) 
		{
			super();
			varListModel = _varListModel;
			paramPane = createParamPane();			
			(_property as LocalActionProperty).setInitParamHandler(paramPane.createNeedStuff);
		}
		
		override public function setDefinition(value:EditorDefinition):void
		{
			super.setDefinition(value);
			paramPane.setLabel(value.name);
		}
		
		override protected function createProperty():Property
		{
			return new LocalActionProperty();
		}
		
		public function setParamContainer(pane:Container):void
		{
			paramContentPane = pane;
			paramContentPane.append(paramPane);
		}
		
		override protected function onDelete(e:AWEvent):void
		{
			super.onDelete(e);
			paramContentPane.remove(paramPane);
			
		}
		
		protected function createParamPane():EditorWithPropertyBase
		{
			throw(new Error("abstract  method!"));
			return null;
		}
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			xml.appendChild(paramPane.getExportCode());
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			paramPane.importCode(xml[paramPane.tagName][0]);
		}
		
	}

}