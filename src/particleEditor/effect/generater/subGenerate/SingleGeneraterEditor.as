package particleEditor.effect.generater.subGenerate 
{
	import a3dparticle.generater.GeneraterBase;
	import a3dparticle.generater.SingleGenerater;
	import a3dparticle.particle.ParticleSample;
	import particleEditor.edit.Property;
	import particleEditor.inputer.ComboBoxInput;
	import particleEditor.inputer.IntInput;
	import org.aswing.JComboBox;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.VectorListModel;
	import particleEditor.edit.EditorBase;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class SingleGeneraterEditor extends EditorBase
	{
		private var comboBox:ComboBoxInput;
		private var countInput:IntInput;
		public function SingleGeneraterEditor(sampleModel:VectorListModel) 
		{
			super();
			comboBox = new ComboBoxInput("",sampleModel);
			comboBox.setPreferredWidth(130);
			var label:JLabel = new JLabel("select a sample:");
			var pane:JPanel = new JPanel();
			pane.appendAll(label, comboBox);
			countInput = new IntInput("total count:", "1", 2, 4);
			countInput.setMinMax(1);
			appendAll(pane, countInput);
		}
		
		override public function createNeedStuff():*
		{
			if (comboBox.getValue())
			{
				var sample:ParticleSample = (comboBox.getValue() as Property).getNewValue() as ParticleSample;
				return new SingleGenerater(sample,countInput.getInputInt());
			}
			else
			{
				throw new Error("can not get generater");
				return null;
			}
		}
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			xml.@sample = comboBox.serialize();
			xml.@count = countInput.serialize();
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			comboBox.deserialize(xml.@sample);
			countInput.deserialize(xml.@count);
		}
		
	}

}