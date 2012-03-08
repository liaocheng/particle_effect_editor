package  particleEditor.effect
{
	import a3dparticle.ParticlesContainer;
	import flash.geom.Vector3D;
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
		protected var scaleInput:Vector3dInputS;
		protected var eulersInput:VectorDegreeInputS;
		protected var loopInput:Boolean;
		protected var duringInput:Boolean;
		public function SystemFactoryS() 
		{
			positionInput = new Vector3dInputS();
			scaleInput = new Vector3dInputS();
			eulersInput = new VectorDegreeInputS();
			duringInput = true;
			loopInput = true;
		}
		
		
		public function createNeedStuff ():*
		{
			var particlesContainer:ParticlesContainer = new ParticlesContainer();
			particlesContainer.hasDuringTime = duringInput;
			particlesContainer.loop = loopInput;
			particlesContainer.position = positionInput.getValue();
			particlesContainer.eulers = eulersInput.getValue();
			var scale3D:Vector3D = scaleInput.getValue();
			particlesContainer.scaleX = scale3D.x;
			particlesContainer.scaleY = scale3D.y;
			particlesContainer.scaleZ = scale3D.z;
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
			if (String(xml.@scale))
			{
				scaleInput.deserialize(xml.@scale);
			}
			else
			{
				scaleInput.deserialize("1,1,1");
			}
		}
		
	}

}