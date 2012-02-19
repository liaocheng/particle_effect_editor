package particleEditor.effect.param
{
	import a3dparticle.particle.ParticleParam;
	import flash.utils.Dictionary;
	import particleEditor.edit.EditorWithPropertyBaseS;
	import particleEditor.inputer.ComboBoxInputS;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class TimeSelectionS extends EditorWithPropertyBaseS
	{
		private var startTimeComboBox:ComboBoxInputS;
		private var duringTimeComboBox:ComboBoxInputS;
		//private var sleepTimeComboBox:JComboBox;
		
		public function TimeSelectionS(varListModel:Array) 
		{
			super();
			startTimeComboBox = new ComboBoxInputS(varListModel);
			duringTimeComboBox = new ComboBoxInputS(varListModel);
		}
		
		override public function createNeedStuff():*
		{
			return function(_param:ParticleParam, localVars:Dictionary):void
			{
				var afsdf:*= startTimeComboBox.getValue();
				var startTime:Number = startTimeComboBox.getValue()?localVars[startTimeComboBox.getValue()]:0;
				var duringTime:Number = duringTimeComboBox.getValue()?localVars[duringTimeComboBox.getValue()]:1000;
				_param.startTime = startTime;
				_param.duringTime = duringTime;
			}
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			startTimeComboBox.deserialize(xml.@startTime);
			duringTimeComboBox.deserialize(xml.@duringTime);
		}
		
	}

}