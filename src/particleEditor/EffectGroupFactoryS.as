package particleEditor
{
	import a3dparticle.ParticlesContainer;
	import particleEditor.edit.IImportable;
	import particleEditor.effect.EffectFactoryS;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class EffectGroupFactoryS implements IImportable
	{
		private var _particleGeneraters:Vector.<EffectFactoryS>;
		private var _rawData:*;
		
		public function EffectGroupFactoryS()
		{
			_particleGeneraters = new Vector.<EffectFactoryS>;
		}
		
		public function get tagName():String
		{
			return "root";
		}
		
		public function importCode(code:XML):void
		{
			EffectFormat.verifyFormat(code);
			_particleGeneraters = new Vector.<EffectFactoryS>;
			for each(var effect:XML in code.effect)
			{
				var system:EffectFactoryS = new EffectFactoryS();
				system.importCode(effect);
				_particleGeneraters.push(system);
			}
			_rawData = code.toString();
		}
		
		public function createNeedStuff():*
		{
			if (!_rawData)
				throw(new Error("please import a valid data first"));
			
			var _particleContainers:Vector.<ParticlesContainer> = new Vector.<ParticlesContainer>;
			for each(var i:EffectFactoryS in _particleGeneraters)
			{
				_particleContainers.push(i.createNeedStuff() as ParticlesContainer);
			}
			return new EffectGroup(_rawData, _particleContainers);
		}
		
		public static function createEffectGroup(_rawData:*):EffectGroup
		{
			var effectGroupFactory:EffectGroupFactoryS = new EffectGroupFactoryS();
			effectGroupFactory.importCode(XML(_rawData));
			return effectGroupFactory.createNeedStuff() as EffectGroup;
		}
		
	}

}