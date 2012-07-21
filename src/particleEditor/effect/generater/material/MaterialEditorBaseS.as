package particleEditor.effect.generater.material
{
	import a3dparticle.particle.ParticleMaterialBase;
	import flash.display.BlendMode;
	import particleEditor.edit.EditorWithPropertyBaseS;
	import particleEditor.inputer.ComboBoxInputS;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class MaterialEditorBaseS extends EditorWithPropertyBaseS
	{
		
		protected var bothSidesCheck:Boolean;
		protected var requiresBlendingCheck:Boolean;
		protected var blendModeCombo:ComboBoxInputS;
		protected var multipleRendering:Boolean;
		protected var renderTimes:int;
		protected var timeInterval:Number;
		protected var fadeFactor:Number;
		
		public function MaterialEditorBaseS()
		{
			super();
			bothSidesCheck = false;
			requiresBlendingCheck = true;
			blendModeCombo = new ComboBoxInputS([BlendMode.NORMAL, BlendMode.MULTIPLY, BlendMode.ADD, BlendMode.ALPHA]);
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
			material.bothSides = bothSidesCheck;
			material.requiresBlending = requiresBlendingCheck;
			if (material.requiresBlending) material.blendMode = blendModeCombo.getValue();
			if (multipleRendering)
			{
				material.renderTimes = renderTimes;
				material.timeInterval = timeInterval;
				material.alphaFade = fadeFactor;
			}
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			bothSidesCheck = Boolean(int(xml.@bothSides));
			requiresBlendingCheck = Boolean(int(xml.@requiresBlending));
			blendModeCombo.deserialize(xml.@blendMode);
			multipleRendering = Boolean(int(xml.@multipleRendering));
			if (multipleRendering)
			{
				renderTimes=int(xml.@renderTimes);
				timeInterval = Number(xml.@timeInterval);
				fadeFactor = Number(xml.@fadeFactor);
			}
		}
		
	}

}