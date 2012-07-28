package particleEditor.effect.action.local
{
	import a3dparticle.animators.actions.color.RandomColorLocal;
	import particleEditor.edit.EditorWithPropertyBaseS;
	/**
	 * ...
	 * @author Cheng Liao
	 */
	public class ColorTransformEditorS extends LocalActionBaseS
	{
		private var multiply:Boolean;
		private var add:Boolean;
		
		public function ColorTransformEditorS(_varListModel:Array)
		{
			super(_varListModel);
		}
		
		
		override public function createNeedStuff():*
		{
			return new RandomColorLocal(null,multiply,add);
		}
		
		override protected function createParamPane():EditorWithPropertyBaseS
		{
			return new ColorParamS(varListModel);
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			multiply = Boolean(int(xml.@multiply));
			add = Boolean(int(xml.@add));
		}
		
	}

}

import a3dparticle.particle.ParticleParam;
import flash.geom.ColorTransform;
import flash.utils.Dictionary;
import particleEditor.edit.EditorWithPropertyBaseS;
import particleEditor.inputer.ComboBoxInputS;

class ColorParamS extends EditorWithPropertyBaseS
{

	private var redMultiplierComboBox:ComboBoxInputS;
	private var greeMultiplierComboBox:ComboBoxInputS;
	private var blueMultiplierComboBox:ComboBoxInputS;
	private var alphaMultiplierComboBox:ComboBoxInputS;
	private var redOffsetComboBox:ComboBoxInputS;
	private var greenOffsetComboBox:ComboBoxInputS;
	private var blueOffsetComboBox:ComboBoxInputS;
	private var alphaOffsetComboBox:ComboBoxInputS;
	public function ColorParamS(varListModel:Array)
	{
		super();
		redMultiplierComboBox = new ComboBoxInputS(varListModel);
		greeMultiplierComboBox = new ComboBoxInputS(varListModel);
		blueMultiplierComboBox = new ComboBoxInputS(varListModel);
		alphaMultiplierComboBox = new ComboBoxInputS(varListModel);
		redOffsetComboBox = new ComboBoxInputS(varListModel);
		greenOffsetComboBox = new ComboBoxInputS(varListModel);
		blueOffsetComboBox = new ComboBoxInputS(varListModel);
		alphaOffsetComboBox = new ComboBoxInputS(varListModel);
	}
	
	override public function createNeedStuff():*
	{
		return function(param:ParticleParam, localVars:Dictionary):void
		{
			var redMultiplier:Number = redMultiplierComboBox.getValue()?localVars[redMultiplierComboBox.getValue()]:1;
			var greeMultiplier:Number = greeMultiplierComboBox.getValue()?localVars[greeMultiplierComboBox.getValue()]:1;
			var blueMultiplier:Number = blueMultiplierComboBox.getValue()?localVars[blueMultiplierComboBox.getValue()]:1;
			var alphaMultiplier:Number = alphaMultiplierComboBox.getValue()?localVars[alphaMultiplierComboBox.getValue()]:1;
			var redOffset:Number = redOffsetComboBox.getValue()?localVars[redOffsetComboBox.getValue()]:0;
			var greenOffset:Number = greenOffsetComboBox.getValue()?localVars[greenOffsetComboBox.getValue()]:0;
			var blueOffset:Number = blueOffsetComboBox.getValue()?localVars[blueOffsetComboBox.getValue()]:0;
			var alphaOffset:Number = alphaOffsetComboBox.getValue()?localVars[alphaOffsetComboBox.getValue()]:0;
			param["RandomColorLocal"] = new ColorTransform(redMultiplier, greeMultiplier, blueMultiplier, alphaMultiplier, redOffset, greenOffset, blueOffset, alphaOffset);
		}
	}
	
	override public function importCode(xml:XML):void
	{
		super.importCode(xml);
		redMultiplierComboBox.deserialize(xml.@redMultiplier);
		greeMultiplierComboBox.deserialize(xml.@greeMultiplier);
		blueMultiplierComboBox.deserialize(xml.@blueMultiplier);
		alphaMultiplierComboBox.deserialize(xml.@alphaMultiplier);
		redOffsetComboBox.deserialize(xml.@redOffset);
		greenOffsetComboBox.deserialize(xml.@greenOffset);
		blueOffsetComboBox.deserialize(xml.@blueOffset);
		alphaOffsetComboBox.deserialize(xml.@alphaOffset);
	}
}