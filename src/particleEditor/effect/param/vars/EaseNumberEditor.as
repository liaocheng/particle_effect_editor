package particleEditor.effect.param.vars
{
	import a3dparticle.particle.ParticleParam;
	import flash.utils.Dictionary;
	import particleEditor.easing.EaseChart;
	import particleEditor.easing.EaseDefinition;
	import flash.events.Event;
	import particleEditor.inputer.ComboBoxInput;
	import particleEditor.inputer.NumberInput;
	import org.aswing.JButton;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class EaseNumberEditor extends VarEditorBase
	{
		
		private var startInput:NumberInput;
		private var endInput:NumberInput;
		
		private var easeInput:ComboBoxInput;
		
		public function EaseNumberEditor() 
		{
			super();
			
			startInput = new NumberInput("start value","0",2, 4);
			
			endInput = new NumberInput(" end  value","1",2, 4);
			
			easeInput = new ComboBoxInput("ease:",EaseDefinition.ALL_EASE);
			easeInput.deserialize("0");
			
			var chartButton:JButton = new JButton("show chart");
			chartButton.addActionListener(showChart);
			easeInput.append(chartButton);
			contentPane.appendAll(startInput, endInput, easeInput);
			
			addVarProperty("");
		}
		
		protected function showChart(e:Event):void
		{
			EaseChart.showChartWindow(startInput.getInputNumber(), endInput.getInputNumber(), (easeInput.getValue() as EaseDefinition).easeFunction);
		}
		
		override public function createNeedStuff():*
		{
			var start:Number = startInput.getInputNumber();
			var end:Number = endInput.getInputNumber();
			var ease:EaseDefinition = easeInput.getValue() as EaseDefinition;
			return function(_param:ParticleParam, localVars:Dictionary):void 
			{
				localVars[getVarProperty("")] = ease.easeFunction(_param.index,start,end-start,_param.total);
			};
		}
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			xml.@start = startInput.getInputNumber();
			xml.@end = endInput.getInputNumber();
			xml.@ease = easeInput.serialize();
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			startInput.deserialize(xml.@start);
			endInput.deserialize(xml.@end);
			easeInput.deserialize(xml.@ease);
		}
		
	}

}