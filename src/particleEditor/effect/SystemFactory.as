package  particleEditor.effect
{
	import a3dparticle.ParticlesContainer;
	import flash.events.Event;
	import particleEditor.inputer.BooleanInput;
	import particleEditor.inputer.Vector3dInput;
	import particleEditor.inputer.VectorDegreeInput;
	import org.aswing.ASColor;
	import org.aswing.border.EmptyBorder;
	import org.aswing.border.LineBorder;
	import org.aswing.Insets;
	import org.aswing.JPanel;
	import org.aswing.SoftBoxLayout;
	import particleEditor.edit.IExportable;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class SystemFactory extends JPanel implements IExportable
	{
		protected var positionInput:Vector3dInput;
		protected var eulersInput:VectorDegreeInput;
		protected var loopInput:BooleanInput;
		protected var duringInput:BooleanInput;
		public function SystemFactory() 
		{
			super(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 1));
			setBorder(new EmptyBorder(new LineBorder(new EmptyBorder(null,new Insets(2,2,2,2)), new ASColor(0xff0000)), new Insets(0, 10, 0, 10)));
			positionInput = new Vector3dInput("position:");
			eulersInput = new VectorDegreeInput("rotation:");
			duringInput = new BooleanInput("during");
			loopInput = new BooleanInput("loop");
			loopInput.addActionListener(onLoop);
			duringInput.setSelected(true);
			loopInput.setSelected(true);
			appendAll(positionInput, eulersInput, duringInput, loopInput);
		}
		
		protected function onLoop(e:Event):void
		{
			if (loopInput.getValue())
			{
				duringInput.setEnabled(false);
				duringInput.setSelected(true);
			}
			else
			{
				duringInput.setEnabled(true);
			}
		}
		
		public function createNeedStuff ():*
		{
			var particlesContainer:ParticlesContainer = new ParticlesContainer();
			particlesContainer.hasDuringTime = duringInput.getValue();
			particlesContainer.loop = loopInput.getValue();
			particlesContainer.position = eulersInput.getValue();
			particlesContainer.eulers = eulersInput.getValue();
			return particlesContainer;
		}
		
		public function get tagName():String
		{
			return "system";
		}
		
		public function importCode(xml:XML):void
		{
			positionInput.deserialize(xml.@position);
			eulersInput.deserialize(xml.@eulers);
			loopInput.deserialize(xml.@loop);
			duringInput.deserialize(xml.@during);
		}
		
		public function getExportCode():XML
		{
			var xml:XML = new XML("<"+tagName+"/>");
			xml.@position = positionInput.serialize();
			xml.@eulers = eulersInput.serialize();
			xml.@loop = loopInput.serialize();
			xml.@during = duringInput.serialize();
			return xml;
		}
		
	}

}