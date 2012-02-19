package particleEditor.effect.generater.material
{
	import a3dparticle.particle.ParticleColorMaterial;
	import a3dparticle.particle.ParticleMaterialBase;
	import particleEditor.inputer.LabelInput;
	import org.aswing.ASColor;
	import org.aswing.event.AWEvent;
	import org.aswing.JButton;
	import org.aswing.JColorChooser;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class ColorMaterialEditor extends MaterialEditorBase
	{
		
		private var colorInput:LabelInput;
		
		private var color:ASColor = new ASColor(0xffffff);
		
		public function ColorMaterialEditor() 
		{
			super();
			colorInput = new LabelInput("color", "", 2, 12);
			colorInput.setEditable(false);
			var editButton:JButton = new JButton("edit");
			colorInput.append(editButton);
			contentPane.append(colorInput);
			
			editButton.addActionListener(onEdit);
		}
			
		override protected function createMaterial():ParticleMaterialBase
		{
			return new ParticleColorMaterial(color.getARGB());
		}
		
		private function onEdit(e:AWEvent):void
		{
			JColorChooser.showDialog(null, "select a color", color, true, changeColor);
		}
		
		private function changeColor(value:ASColor):void
		{
			this.color=value
			colorInput.setInputText(color.getARGB().toString(16));
		}
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			xml.@color = color.getARGB().toString(16);
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			color = ASColor.getWithARGB(parseInt(xml.@color,16));
			colorInput.setInputText(color.getARGB().toString(16));
		}
		
	}

}