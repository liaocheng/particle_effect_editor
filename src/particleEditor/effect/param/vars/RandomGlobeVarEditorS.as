package particleEditor.effect.param.vars
{
	import a3dparticle.particle.ParticleParam;
	import flash.geom.Vector3D;
	import flash.utils.Dictionary;
	import particleEditor.inputer.NumberInput;
	import particleEditor.inputer.Vector3dInputS;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class RandomGlobeVarEditorS extends VarEditorBaseS
	{
		
		private var innerRadius:Number;
		private var outerRadius:Number;
		
		private var centerVector:Vector3dInputS;
		
		public function RandomGlobeVarEditorS() 
		{
			super();
			
			innerRadius = 0;
			outerRadius = 10;
			centerVector = new Vector3dInputS();
			
			addVarProperty("x");
			addVarProperty("y");
			addVarProperty("z");
		}
		
		override public function createNeedStuff():*
		{
			var min:Number = innerRadius;
			var max:Number = outerRadius;
			var center:Vector3D = centerVector.getValue();
			return function(param:ParticleParam,localVars:Dictionary):void {
				var degree1:Number = Math.random() * Math.PI * 2;
				var degree2:Number = Math.random() * Math.PI * 2;
				var radius:Number = Math.random() * (max - min) + min;
				localVars[getVarProperty("x")] = radius * Math.sin(degree1) * Math.cos(degree2) + center.x;
				localVars[getVarProperty("y")] = radius * Math.cos(degree1) * Math.cos(degree2) + center.y;
				localVars[getVarProperty("z")] = radius * Math.sin(degree2) + center.z;
			};
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			innerRadius=Number(xml.@innerRadius);
			outerRadius=Number(xml.@outerRadius);
			centerVector.deserialize(xml.@center);
		}
		
	}

}