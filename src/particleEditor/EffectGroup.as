package particleEditor
{
	import a3dparticle.ParticlesContainer;
	import away3d.bounds.AxisAlignedBoundingBox;
	import away3d.bounds.BoundingVolumeBase;
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
		private var _rawData:*;
		private var _bounds:BoundingVolumeBase;
		private var _showBounds : Boolean;
		private var _boundsIsShown : Boolean = false;
		
		public function EffectGroup(rawData:*,particleContainers:Vector.<ParticlesContainer>)
		{
			this._rawData = rawData;
			_bounds = new AxisAlignedBoundingBox();
			_particleContainers = particleContainers;
			for (var i:int = 0; i < _particleContainers.length; i++)
			{
				_particleContainers[i].time = time;
				addChild(_particleContainers[i]);
				checkBorder(_particleContainers[i]);
			}
		}
		

		override public function set mouseEnabled(value : Boolean) : void
		{
			super.mouseEnabled = value;
			for (var i:int = 0; i < _particleContainers.length; i++)
			{
				_particleContainers[i].mouseEnabled = value;
			}
		}
		
		public function bounds():BoundingVolumeBase
		{
			return _bounds;
		}
		
		public function get rawData():XML
		{
			return _rawData;
		}
		
		public function hasStart():Boolean
		{
			return _hasStart;
		}
		
		public function isEmpty():Boolean
		{
			return _particleContainers.length == 0;
		}
		
		private function checkBorder(particleContainer:ParticlesContainer):void
		{
			var _minX:Number = particleContainer.bounds.min.x * particleContainer.scaleX + particleContainer.x;
			var _minY:Number = particleContainer.bounds.min.y * particleContainer.scaleY + particleContainer.y;
			var _minZ:Number = particleContainer.bounds.min.z * particleContainer.scaleZ + particleContainer.z;
			var _maxX:Number = particleContainer.bounds.max.x * particleContainer.scaleX + particleContainer.x;
			var _maxY:Number = particleContainer.bounds.max.x * particleContainer.scaleY + particleContainer.y;
			var _maxZ:Number = particleContainer.bounds.max.x * particleContainer.scaleZ + particleContainer.z;
			if (_bounds.min.x > _minX || _bounds.min.y > _minY || _bounds.min.z > _minZ ||
				_bounds.max.x < _maxX || _bounds.max.y < _maxY || _bounds.max.z < _maxZ)
			_bounds.fromExtremes(_minX, _minY, _minZ, _maxX, _maxY, _maxZ);
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
			var len : uint = _particleContainers.length;
			var _clonedContainers:Vector.<ParticlesContainer> = new Vector.<ParticlesContainer>;
			for (var i:int = 0; i < len; i++)
			{
				_clonedContainers.push(_particleContainers[i].clone() as ParticlesContainer);
			}
			var clone : EffectGroup = new EffectGroup(_rawData,_clonedContainers);
			clone.time = time;
			clone.pivotPoint = pivotPoint;
			clone.transform = transform;
			clone.partition = partition;
			clone.name = name;
			return clone;
		}
		
		public function get showBounds() : Boolean
		{
			return _showBounds;
		}

		public function set showBounds(value : Boolean) : void
		{
			if (value == _showBounds)
				return;
			
			_showBounds = value;
			
			if (_showBounds)
				addBounds();
			else
				removeBounds();
		}
		
		private function addBounds():void
		{
			if (!_boundsIsShown)
			{
				_boundsIsShown = true;
				addChild(_bounds.boundingRenderable);
			}
		}
		private function removeBounds():void
		{
			if (_boundsIsShown)
			{
				_boundsIsShown = false;
				removeChild(_bounds.boundingRenderable);
				_bounds.disposeRenderable();
			}
		}
		
	}

}