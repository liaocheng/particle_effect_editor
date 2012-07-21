package particleEditor.effect.generater.material
{
	import a3dparticle.particle.ParticleMaterialBase;
	import flash.display.BlendMode;
	import org.aswing.AsWingConstants;
	import org.aswing.FlowLayout;
	import org.aswing.SoftBoxLayout;
	import particleEditor.inputer.BooleanInput;
	import particleEditor.inputer.ComboBoxInput;
	import org.aswing.event.AWEvent;
	import org.aswing.JPanel;
	import particleEditor.edit.VarNameEditorBase;
	import particleEditor.inputer.IntInput;
	import particleEditor.inputer.NumberInput;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class MaterialEditorBase extends VarNameEditorBase
	{
		
		protected var bothSidesCheck:BooleanInput;
		protected var requiresBlendingCheck:BooleanInput;
		protected var blendModeCombo:ComboBoxInput;
		protected var multipleRendering:BooleanInput;
		protected var multiplePane:JPanel;
		protected var renderTimes:IntInput;
		protected var timeInterval:NumberInput;
		protected var fadeFactor:NumberInput;
		
		
		public function MaterialEditorBase()
		{
			super();
			bothSidesCheck = new BooleanInput("bothSides");
			requiresBlendingCheck = new BooleanInput("requiresBlending");
			requiresBlendingCheck.setSelected(true);
			requiresBlendingCheck.addSelectionListener(onChange);
			blendModeCombo = new ComboBoxInput("",[BlendMode.NORMAL, BlendMode.MULTIPLY, BlendMode.ADD, BlendMode.ALPHA]);
			blendModeCombo.getComboBox().setPreferredWidth(80);
			blendModeCombo.getComboBox().setSelectedIndex(0);
			var pane:JPanel = new JPanel();
			pane.appendAll(requiresBlendingCheck, blendModeCombo);
			multipleRendering = new BooleanInput("multipleRendering");
			multiplePane = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 1));
			renderTimes = new IntInput("render times:", "1", 2, 4);
			timeInterval = new NumberInput(" time interval:", "0.1", 2, 4);
			fadeFactor = new NumberInput("  fade   factor:", "0.5", 2, 4);
			contentPane.appendAll(bothSidesCheck, pane, multipleRendering, multiplePane);
			multipleRendering.addActionListener(onMultipleChange);
		}
		
		private function onMultipleChange(e:AWEvent):void
		{
			if (multipleRendering.getValue())
			{
				multiplePane.appendAll(renderTimes, timeInterval, fadeFactor);
			}
			else
			{
				multiplePane.removeAll();
			}
		}
		
		private function onChange(e:AWEvent):void
		{
			blendModeCombo.getComboBox().setEnabled(requiresBlendingCheck.getValue());
		}
		
		override public function createNeedStuff():*
		{
			var material:ParticleMaterialBase = createMaterial();
			setMaterialProperty(material);
			return material;
		}
		
		protected function createMaterial():ParticleMaterialBase
		{
			throw(new Error("abstract method"));
			return null;
		}
		
		protected function setMaterialProperty(material:ParticleMaterialBase):void
		{
			material.bothSides = bothSidesCheck.getValue();
			material.requiresBlending = requiresBlendingCheck.getValue();
			if (material.requiresBlending) material.blendMode = blendModeCombo.getValue();
			if (multipleRendering.getValue())
			{
				material.renderTimes = renderTimes.getInputInt();
				material.timeInterval = timeInterval.getInputNumber();
				material.alphaFade = fadeFactor.getInputNumber();
			}
		}
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			xml.@bothSides = bothSidesCheck.serialize();
			xml.@requiresBlending = requiresBlendingCheck.serialize();
			xml.@blendMode = blendModeCombo.serialize();
			xml.@multipleRendering = multipleRendering.serialize();
			xml.@renderTimes = renderTimes.serialize();
			xml.@timeInterval = timeInterval.serialize();
			xml.@fadeFactor = fadeFactor.serialize();
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			bothSidesCheck.deserialize(xml.@bothSides);
			requiresBlendingCheck.deserialize(xml.@requiresBlending);
			blendModeCombo.deserialize(xml.@blendMode);
			multipleRendering.deserialize(xml.@multipleRendering);
			renderTimes.deserialize(xml.@renderTimes);
			timeInterval.deserialize(xml.@timeInterval);
			fadeFactor.deserialize(xml.@fadeFactor);
			onMultipleChange(null);
			onChange(null);
		}
		
	}

}