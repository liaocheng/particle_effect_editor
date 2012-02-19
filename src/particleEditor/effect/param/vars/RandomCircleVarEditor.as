package particleEditor.effect.param.vars
{
	import a3dparticle.particle.ParticleParam;
	import flash.geom.Vector3D;
	import flash.utils.Dictionary;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.JTextField;
	import particleEditor.inputer.NumberInput;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class RandomCircleVarEditor extends VarEditorBase
	{
		
		private var innerRadius:NumberInput;
		private var outerRadius:NumberInput;
		
		private var xInput:JTextField;
		private var yInput:JTextField;
		
		public function RandomCircleVarEditor() 
		{
			super();
			
			innerRadius = new NumberInput("inner radius:", "0", 2, 4);
			
			outerRadius = new NumberInput("outer radius:", "0", 2, 4);
			
			xInput = new JTextField("", 4);
			xInput.setText("0");
			xInput.setRestrict("0-9 . \\-");
			yInput = new JTextField("", 4);
			yInput.setText("0");
			yInput.setRestrict("0-9 . \\-");
			var center:JLabel = new JLabel("center:");
			var pane:JPanel = new JPanel();
			pane.appendAll(center, xInput, yInput);
			
			contentPane.appendAll(innerRadius,outerRadius,pane);
			
			addVarProperty("x");
			addVarProperty("y");
		}
		
		override public function createNeedStuff():*
		{
			var min:Number = Number(innerRadius.getInput().getText());
			var max:Number = Number(outerRadius.getInput().getText());
			var center:Vector3D = new Vector3D(Number(xInput.getText()), Number(yInput.getText()));
			return function(param:ParticleParam,localVars:Dictionary):void {
				var degree:Number = Math.random() * Math.PI * 2;
				var radius:Number = Math.random() * (max - min) + min;
				localVars[getVarProperty("x")] = Math.cos(degree) * radius + center.x;
				localVars[getVarProperty("y")] = Math.sin(degree) * radius + center.y;
			};
		}
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			xml.@innerRadius = innerRadius.getInputNumber();
			xml.@outerRadius = outerRadius.getInputNumber();
			xml.@x = xInput.getText();
			xml.@y = yInput.getText();
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			innerRadius.setInputText(xml.@innerRadius);
			outerRadius.setInputText(xml.@outerRadius);
			xInput.setText(xml.@x);
			yInput.setText(xml.@y);
		}
		
	}

}