package particleEditor.effect.generater.material
{
	import a3dparticle.particle.ParticleBitmapMaterial;
	import a3dparticle.particle.ParticleMaterialBase;
	import flash.events.Event;
	import particleEditor.inputer.FileImageInputS;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class BitmapMaterialEditorS extends MaterialEditorBaseS
	{
		
		private var bitmapInput:FileImageInputS;
		private var smoothInput:Boolean;
		private var mipmapInput:Boolean;
		private var repeatinput:Boolean;
		private var alphaThreshold:Number;
		
		private var material:ParticleBitmapMaterial;
		
		public function BitmapMaterialEditorS()
		{
			super();
			bitmapInput = new FileImageInputS();
			smoothInput = true;
			mipmapInput = false;
			repeatinput = false;
			alphaThreshold = 0;
			
		}
			
		override protected function createMaterial():ParticleMaterialBase
		{
			if (!material)
			{
				material = new ParticleBitmapMaterial(bitmapInput.getValue(), smoothInput, repeatinput, mipmapInput, alphaThreshold);
				bitmapInput.addEventListener(Event.COMPLETE, onComplete);
			}
			return material;
		}
		
		private function onComplete(e:Event):void
		{
			bitmapInput.removeEventListener(Event.COMPLETE, onComplete);
			material.bitmapData = bitmapInput.getValue();
		}
		
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			bitmapInput.deserialize(xml.bitmap.text());
			smoothInput=Boolean(int(xml.@smooth));
			mipmapInput=Boolean(int(xml.@minmap));
			repeatinput = Boolean(int(xml.@repeat));
			alphaThreshold = Number(xml.@alphaThreshold);
		}
		
	}

}