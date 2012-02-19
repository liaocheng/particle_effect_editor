package  particleEditor.effect
{
	import a3dparticle.ParticlesContainer;
	import particleEditor.edit.IImportable;
	import particleEditor.inputer.Vector3dInputS;
	import particleEditor.inputer.VectorDegreeInputS;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class SystemFactoryS implements IImportable
	{
		protected var positionInput:Vector3dInputS;
		protected var eulersInput:VectorDegreeInputS;
		protected var loopInput:Boolean;
		protected var duringInput:Boolean;
		public function SystemFactoryS() 
		{
			positionInput = new Vector3dInputS();
			eulersInput = new VectorDegreeInputS();
			duringInput = true;
			loopInput = true;
		}
		
		
		public function createNeedStuff ():*
		{
			var particlesContainer:ParticlesContainer = new ParticlesContainer();
			particlesContainer.hasDuringTime = duringInput;
			particlesContainer.loop = loopInput;
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
			loopInput = Boolean(int(xml.@loop));
			duringInput = Boolean(int(xml.@during));
		}
		
	}

}