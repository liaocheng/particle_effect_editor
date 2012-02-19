package particleEditor.effect.param
{
	import a3dparticle.particle.ParticleParam;
	import flash.utils.Dictionary;
	import org.aswing.JComboBox;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.VectorListModel;
	import particleEditor.edit.EditorBase;
	import particleEditor.edit.EditorWithPropertyBase;
	import particleEditor.inputer.ComboBoxInput;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class TimeSelection extends EditorWithPropertyBase
	{
		private var startTimeComboBox:ComboBoxInput;
		private var duringTimeComboBox:ComboBoxInput;
		//private var sleepTimeComboBox:JComboBox;
		
		public function TimeSelection(varListModel:VectorListModel) 
		{
			super();
			setLabel("TimeAction:");
			startTimeComboBox = new ComboBoxInput("start time:", varListModel);
			duringTimeComboBox = new ComboBoxInput("during time:", varListModel);
			contentPane.appendAll(startTimeComboBox, duringTimeComboBox);
		}
		
		override public function createNeedStuff():*
		{
			return function(_param:ParticleParam, localVars:Dictionary):void
			{
				var startTime:Number = startTimeComboBox.getValue()?localVars[startTimeComboBox.getValue()]:0;
				var duringTime:Number = duringTimeComboBox.getValue()?localVars[duringTimeComboBox.getValue()]:1000;
				_param.startTime = startTime;
				_param.duringTime = duringTime;
			}
		}
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			xml.@startTime = startTimeComboBox.serialize();
			xml.@duringTime = duringTimeComboBox.serialize();
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			startTimeComboBox.deserialize(xml.@startTime);
			duringTimeComboBox.deserialize(xml.@duringTime);
		}
		
	}

}