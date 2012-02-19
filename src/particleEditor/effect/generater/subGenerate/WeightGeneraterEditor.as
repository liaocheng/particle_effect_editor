package particleEditor.effect.generater.subGenerate 
{
	import a3dparticle.generater.GeneraterBase;
	import a3dparticle.generater.MutiWeightGenerater;
	import a3dparticle.particle.ParticleSample;
	import flash.events.Event;
	import org.aswing.JButton;
	import org.aswing.JPanel;
	import org.aswing.SoftBoxLayout;
	import org.aswing.VectorListModel;
	import particleEditor.edit.EditorBase;
	import particleEditor.edit.Property;
	import particleEditor.inputer.IntInput;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class WeightGeneraterEditor extends EditorBase
	{
		private var _sampleModel:VectorListModel;
		private var weightSampleContainer:JPanel;
		private var countInput:IntInput;
		
		public function WeightGeneraterEditor(sampleModel:VectorListModel) 
		{
			super();
			_sampleModel = sampleModel;
			countInput = new IntInput("total count:", "1", 2, 4);
			countInput.setMinMax(1);
			var addButton:JButton = new JButton("add");
			weightSampleContainer = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
			countInput.append(addButton);
			appendAll(countInput,weightSampleContainer);
			addButton.addActionListener(onAdd);
		}
		
		protected function onAdd(e:Event):void
		{
			weightSampleContainer.append(new WeightSampePane(_sampleModel));
		}
		
		override public function createNeedStuff():*
		{
			var samples:Array = [];
			var weights:Array = [];
			var pane:WeightSampePane;
			for (var i:int = 0; i < weightSampleContainer.getComponentCount(); i++)
			{
				pane = weightSampleContainer.getComponent(i) as WeightSampePane;
				var sample:ParticleSample = (pane.sampleCombo.getValue() as Property).getNewValue() as ParticleSample;;
				var weight:int = pane.weightInput.getInputInt();
				samples.push(sample);
				weights.push(weight);
			}
			return new MutiWeightGenerater(samples,weights,countInput.getInputInt());
		}
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			for (var i:int = 0; i < weightSampleContainer.getComponentCount(); i++)
			{
				var segment:XML = new XML("<weight_sample/>");
				
				var pane:WeightSampePane = weightSampleContainer.getComponent(i) as WeightSampePane;
				segment.@sample = pane.sampleCombo.serialize();
				segment.@weight = pane.weightInput.serialize();
				xml.appendChild(segment);
			}
			xml.@count = countInput.serialize();
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			for each(var segment:XML in xml.weight_sample)
			{			
				onAdd(null);
				var pane:WeightSampePane = weightSampleContainer.getComponent(weightSampleContainer.getComponentCount() - 1) as WeightSampePane;
				pane.sampleCombo.deserialize(segment.@sample);
				pane.weightInput.deserialize(segment.@weight);
			}
			countInput.deserialize(xml.@count);
		}	
	}
}
import flash.events.Event;
import particleEditor.inputer.ComboBoxInput;
import particleEditor.inputer.IntInput;
import org.aswing.JButton;
import org.aswing.JPanel;
import org.aswing.VectorListModel;

class WeightSampePane extends JPanel
{
	public var weightInput:IntInput;
	public var sampleCombo:ComboBoxInput;
	public function WeightSampePane(sampleModel:VectorListModel)
	{
		sampleCombo = new ComboBoxInput("sample:", sampleModel);
		sampleCombo.getComboBox().setPreferredWidth(80);
		weightInput = new IntInput("weight:", "1", 0, 2);
		var delButton:JButton = new JButton("del");
		appendAll(sampleCombo, weightInput, delButton);
		delButton.addActionListener(onDelete);
	}
	
	private function onDelete(e:Event):void
	{
		getParent().remove(this);
	}
}