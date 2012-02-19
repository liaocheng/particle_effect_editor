package particleEditor.effect.generater.subGenerate 
{
	import a3dparticle.generater.MutiWeightGenerater;
	import a3dparticle.particle.ParticleSample;
	import particleEditor.edit.EditorBaseS;
	import particleEditor.edit.Property;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class WeightGeneraterEditorS extends EditorBaseS
	{
		private var _sampleModel:Array;
		private var weightSampleContainer:Array;
		private var countInput:int;
		
		public function WeightGeneraterEditorS(sampleModel:Array) 
		{
			super();
			_sampleModel = sampleModel;
			weightSampleContainer = [];
		}
		
		
		override public function createNeedStuff():*
		{
			var samples:Array = [];
			var weights:Array = [];
			var pane:WeightSampePaneS;
			for (var i:int = 0; i < weightSampleContainer.length; i++)
			{
				pane = weightSampleContainer[i] as WeightSampePaneS;
				var sample:ParticleSample = (pane.sampleCombo.getValue() as Property).getNewValue() as ParticleSample;;
				var weight:int = pane.weightInput;
				samples.push(sample);
				weights.push(weight);
			}
			return new MutiWeightGenerater(samples,weights,countInput);
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			for each(var segment:XML in xml.weight_sample)
			{			
				var pane:WeightSampePaneS = new WeightSampePaneS(_sampleModel);
				pane.sampleCombo.deserialize(segment.@sample);
				pane.weightInput = int(segment.@weight);
				weightSampleContainer.push(pane);
			}
			countInput = int(xml.@count);
		}	
	}
}
import particleEditor.inputer.ComboBoxInputS;

class WeightSampePaneS
{
	public var weightInput:int;
	public var sampleCombo:ComboBoxInputS;
	public function WeightSampePaneS(sampleModel:Array)
	{
		sampleCombo = new ComboBoxInputS(sampleModel);
	}
}