package particleEditor.effect.generater.material
{
	import a3dparticle.particle.ParticleColorMaterial;
	import a3dparticle.particle.ParticleMaterialBase;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class ColorMaterialEditorS extends MaterialEditorBaseS
	{
		
		private var color:uint = 0xffffff;
		
		public function ColorMaterialEditorS() 
		{
			super();
		}
			
		override protected function createMaterial():ParticleMaterialBase
		{	
			return new ParticleColorMaterial(color);
		}
			
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			color = parseInt(xml.@color, 16);
		}
		
	}

}