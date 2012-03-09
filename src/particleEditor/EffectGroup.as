package particleEditor
{
	import a3dparticle.ParticlesContainer;
	import away3d.containers.ObjectContainer3D;
	import away3d.core.base.Object3D;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class EffectGroup extends ObjectContainer3D
	{
		private var _time:Number = 0;
		private var _particleContainers:Vector.<ParticlesContainer> = new Vector.<ParticlesContainer>;
		private var _hasStart:Boolean;
		
		public function EffectGroup() 
		{
			
		}
		
		public function hasStart():Boolean
		{
			return _hasStart;
		}
		
		public function isEmpty():Boolean
		{
			return _particleContainers.length == 0;
		}
		
		public function addParticleContainer(particleContainer:ParticlesContainer):void
		{
			particleContainer.time = time;
			_particleContainers.push(particleContainer);
			addChild(particleContainer);
			if (_hasStart) particleContainer.start();
		}
		
		public function start():void
		{
			_hasStart = true;
			_particleContainers.forEach(function(particleContainer:ParticlesContainer,...rest):void
			{
				particleContainer.start();
			});
		}
		
		public function stop():void
		{
			_hasStart = false;
			_particleContainers.forEach(function(particleContainer:ParticlesContainer,...rest):void
			{
				particleContainer.stop();
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
			if (isEmpty()) return _time;
			else return _particleContainers[0].time;
		}
		
		override public function clone():Object3D
		{
			var clone : EffectGroup = new EffectGroup();
			clone.pivotPoint = pivotPoint;
			clone.transform = transform;
			clone.partition = partition;
			clone.name = name;
			
			var len : uint = _particleContainers.length;
			var child:ObjectContainer3D;
			for (var i:int = 0; i < len; i++)
			{
				child = getChildAt(i);
				if (_particleContainers.indexOf(child) == -1)
				{
					clone.addChild(ObjectContainer3D(child.clone()));
				}
				else
				{
					clone.addParticleContainer(child.clone() as ParticlesContainer);
				}
				
			}
			clone.time = time;
			return clone;
		}
	}

}