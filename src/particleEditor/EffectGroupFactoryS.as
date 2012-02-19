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
			_particleGeneraters = new Vector.<EffectFactoryS>;
			for each(var effect:XML in code.effect)
			{
				var system:EffectFactoryS = new EffectFactoryS();
				system.importCode(effect);
				_particleGeneraters.push(system);
			}
		}
		
		public function createNeedStuff():*
		{
			var effectGroup:EffectGroup = new EffectGroup();
			for each(var i:EffectFactoryS in _particleGeneraters)
			{
				effectGroup.addParticleContainer(i.createNeedStuff() as ParticlesContainer);
			}
			return effectGroup;
		}
		
	}

}