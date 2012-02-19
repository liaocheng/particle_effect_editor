package particleEditor.effect.generater.material
{
	import a3dparticle.particle.ParticleBitmapMaterial;
	import a3dparticle.particle.ParticleMaterialBase;
	import particleEditor.inputer.BooleanInput;
	import particleEditor.inputer.FileImageInput;
	import particleEditor.inputer.NumberInput;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class BitmapMaterialEditor extends MaterialEditorBase
	{
		
		private var bitmapInput:FileImageInput;
		private var smoothInput:BooleanInput;
		private var mipmapInput:BooleanInput;
		private var repeatinput:BooleanInput;
		private var alphaThreshold:NumberInput;
		
		public function BitmapMaterialEditor()
		{
			super();
			bitmapInput = new FileImageInput("bitmap:");
			smoothInput = new BooleanInput("smooth ");
			smoothInput.deserialize("1");
			mipmapInput = new BooleanInput("mipmap");
			repeatinput = new BooleanInput("  repeat  ");
			alphaThreshold = new NumberInput("alphaThreshold:", "0", 2, 2);
			
			contentPane.appendAll(bitmapInput,smoothInput,mipmapInput,repeatinput,alphaThreshold);
		}
			
		override protected function createMaterial():ParticleMaterialBase
		{
			var material:ParticleBitmapMaterial = new ParticleBitmapMaterial(bitmapInput.getValue(), smoothInput.getValue(), repeatinput.getValue(), mipmapInput.getValue(), alphaThreshold.getInputNumber());
			return material;
		}
		
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			var child:XML = new XML("<bitmap/>");
			child.appendChild(new XML(bitmapInput.serialize()));
			xml.appendChild(child);
			xml.@smooth = smoothInput.serialize();
			xml.@minmap = mipmapInput.serialize();
			xml.@repeat = repeatinput.serialize();
			xml.@alphaThreshold = alphaThreshold.serialize();
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			bitmapInput.deserialize(xml.bitmap.text());
			smoothInput.deserialize(xml.@smooth);
			mipmapInput.deserialize(xml.@minmap);
			repeatinput.deserialize(xml.@repeat);
			alphaThreshold.deserialize(xml.@alphaThreshold);
		}
		
	}

}