package particleEditor
{
	import a3dparticle.ParticlesContainer;
	import away3d.containers.ObjectContainer3D;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class EffectGroup extends ObjectContainer3D
	{
		private var _time:Number = 0;
		private var _particleContainers:Vector.<ParticlesContainer> = new Vector.<ParticlesContainer>;
		public function EffectGroup() 
		{
			
		}
		
		public function isEmpty():Boolean
		{
			return _particleContainers.length == 0;
		}
		
		public function addParticleContainer(particleContainer:ParticlesContainer):void
		{
			_particleContainers.push(particleContainer);
			addChild(particleContainer);
		}
		
		public function start():void
		{
			_particleContainers.forEach(function(particleContainer:ParticlesContainer,...rest):void
			{
				particleContainer.start();
			});
		}
		
		public function set time(value:Number):void
		{
			_time = value;
			_particleContainers.forEach(function(particleContainer:ParticlesContainer,...rest):void
			{
				particleContainer.time = _time;
			});
		}
		public function get time():Number
		{
			return _time;
		}
	}

}