package particleEditor.effect.param.vars
{
	import a3dparticle.particle.ParticleParam;
	import flash.geom.Vector3D;
	import flash.utils.Dictionary;
	import particleEditor.inputer.NumberInput;
	import particleEditor.inputer.Vector3dInput;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class RandomGlobeVarEditor extends VarEditorBase
	{
		
		private var innerRadius:NumberInput;
		private var outerRadius:NumberInput;
		
		private var centerVector:Vector3dInput;
		
		public function RandomGlobeVarEditor() 
		{
			super();
			
			innerRadius = new NumberInput("inner radius","0",2, 4);
			innerRadius.setMinMax(0);
			
			outerRadius = new NumberInput("outer radius","10",2, 4);
			outerRadius.setMinMax(0)
			
			centerVector = new Vector3dInput("center:");
			
			contentPane.appendAll(innerRadius, outerRadius, centerVector);
			
			addVarProperty("x");
			addVarProperty("y");
			addVarProperty("z");
		}
		
		override public function createNeedStuff():*
		{
			var min:Number = innerRadius.getInputNumber();
			var max:Number = outerRadius.getInputNumber();
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
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			xml.@innerRadius = innerRadius.getInputNumber();
			xml.@outerRadius = outerRadius.getInputNumber();
			xml.@center = centerVector.serialize();
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			innerRadius.setInputText(xml.@innerRadius);
			outerRadius.setInputText(xml.@outerRadius);
			centerVector.deserialize(xml.@center);
		}
		
	}

}