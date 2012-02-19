package particleEditor.effect.param.vars
{
	import a3dparticle.particle.ParticleParam;
	import flash.geom.Vector3D;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class RandomCircleVarEditorS extends VarEditorBaseS
	{
		
		private var innerRadius:Number;
		private var outerRadius:Number;
		
		private var xInput:Number;
		private var yInput:Number;
		
		public function RandomCircleVarEditorS() 
		{
			super();
			innerRadius = 0;
			outerRadius = 0;
			xInput = 0;
			yInput = 0;			
			addVarProperty("x");
			addVarProperty("y");
		}
		
		override public function createNeedStuff():*
		{
			var min:Number = innerRadius;
			var max:Number = outerRadius;
			var center:Vector3D = new Vector3D(xInput, yInput);
			return function(param:ParticleParam,localVars:Dictionary):void {
				var degree:Number = Math.random() * Math.PI * 2;
				var radius:Number = Math.random() * (max - min) + min;
				localVars[getVarProperty("x")] = Math.cos(degree) * radius + center.x;
				localVars[getVarProperty("y")] = Math.sin(degree) * radius + center.y;
			};
		}
		
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			innerRadius=Number(xml.@innerRadius);
			outerRadius=Number(xml.@outerRadius);
			xInput=Number(xml.@x);
			yInput=Number(xml.@y);
		}
		
	}

}