package particleEditor.effect.generater.subGenerate 
{
	import a3dparticle.generater.SingleGenerater;
	import a3dparticle.particle.ParticleSample;
	import particleEditor.edit.Property;
	import particleEditor.inputer.ComboBoxInputS;
	import particleEditor.edit.EditorBaseS;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class SingleGeneraterEditorS extends EditorBaseS
	{
		private var comboBox:ComboBoxInputS;
		private var countInput:int;
		
		public function SingleGeneraterEditorS(samples:Array) 
		{
			comboBox = new ComboBoxInputS(samples);
		}
		
		override public function createNeedStuff():*
		{
			if (comboBox.getValue())
			{
				var sample:ParticleSample = (comboBox.getValue() as Property).getNewValue() as ParticleSample;
				return new SingleGenerater(sample,countInput);
			}
			else
			{
				throw new Error("can not get generater");
				return null;
			}
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			comboBox.deserialize(xml.@sample);
			countInput = int(xml.@count);
		}
		
	}

}