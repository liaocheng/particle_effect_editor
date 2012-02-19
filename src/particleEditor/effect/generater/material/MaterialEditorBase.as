package particleEditor.effect.generater.material
{
	import a3dparticle.particle.ParticleMaterialBase;
	import flash.display.BlendMode;
	import particleEditor.inputer.BooleanInput;
	import particleEditor.inputer.ComboBoxInput;
	import org.aswing.event.AWEvent;
	import org.aswing.JPanel;
	import particleEditor.edit.VarNameEditorBase;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class MaterialEditorBase extends VarNameEditorBase
	{
		
		protected var bothSidesCheck:BooleanInput;
		protected var requiresBlendingCheck:BooleanInput;
		protected var blendModeCombo:ComboBoxInput;
		
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
			contentPane.appendAll(bothSidesCheck, pane);
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
		}
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			xml.@bothSides = bothSidesCheck.serialize();
			xml.@requiresBlending = requiresBlendingCheck.serialize();
			xml.@blendMode = blendModeCombo.serialize();
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			bothSidesCheck.deserialize(xml.@bothSides);
			requiresBlendingCheck.deserialize(xml.@requiresBlending);
			blendModeCombo.deserialize(xml.@blendMode);
		}
		
	}

}