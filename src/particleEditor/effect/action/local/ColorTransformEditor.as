package particleEditor.effect.action.local
{
	import a3dparticle.animators.actions.color.RandomColorLocal;
	import org.aswing.VectorListModel;
	import particleEditor.edit.EditorWithPropertyBase;
	import particleEditor.inputer.BooleanInput;
	/**
	 * ...
	 * @author Cheng Liao
	 */
	public class ColorTransformEditor extends LocalActionBase
	{
		private var multiply:BooleanInput;
		private var add:BooleanInput;
		public function ColorTransformEditor(_varListModel:VectorListModel)
		{
			super(_varListModel);
			nameInput.getInput().setText("ColorTransform");
			multiply = new BooleanInput("mul:");
			multiply.deserialize("1");
			add = new BooleanInput("add:");
			add.deserialize("0");
			contentPane.appendAll(multiply, add);
		}
		
		override public function createNeedStuff():*
		{
			return new RandomColorLocal(null, multiply.getValue(), add.getValue());
		}
		
		override protected function createParamPane():EditorWithPropertyBase
		{
			return new ColorParam(varListModel);
		}
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			xml.@multiply = multiply.serialize();
			xml.@add = add.serialize();
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			multiply.deserialize(xml.@multiply);
			add.deserialize(xml.@add);
		}
	}

}

import a3dparticle.particle.ParticleParam;
import flash.geom.ColorTransform;
import flash.utils.Dictionary;
import org.aswing.VectorListModel;
import particleEditor.edit.EditorWithPropertyBase;
import particleEditor.inputer.ComboBoxInput;

class ColorParam extends EditorWithPropertyBase
{

	private var redMultiplierComboBox:ComboBoxInput;
	private var greeMultiplierComboBox:ComboBoxInput;
	private var blueMultiplierComboBox:ComboBoxInput;
	private var alphaMultiplierComboBox:ComboBoxInput;
	private var redOffsetComboBox:ComboBoxInput;
	private var greenOffsetComboBox:ComboBoxInput;
	private var blueOffsetComboBox:ComboBoxInput;
	private var alphaOffsetComboBox:ComboBoxInput;
	public function ColorParam(varListModel:VectorListModel)
	{
		super();
		redMultiplierComboBox = new ComboBoxInput("redMultiplier:", varListModel);
		greeMultiplierComboBox = new ComboBoxInput("greenMultiplier:", varListModel);
		blueMultiplierComboBox = new ComboBoxInput("blueMultiplier:", varListModel);
		alphaMultiplierComboBox = new ComboBoxInput("alphaMultiplier:", varListModel);
		redOffsetComboBox = new ComboBoxInput("redOffset:", varListModel);
		greenOffsetComboBox = new ComboBoxInput("greenOffset:", varListModel);
		blueOffsetComboBox = new ComboBoxInput("blueOffset:", varListModel);
		alphaOffsetComboBox = new ComboBoxInput("alphaOffset:", varListModel);
		contentPane.appendAll(redMultiplierComboBox,greeMultiplierComboBox,blueMultiplierComboBox,alphaMultiplierComboBox,redOffsetComboBox,greenOffsetComboBox,blueOffsetComboBox,alphaOffsetComboBox);
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
	
	override public function getExportCode():XML
	{
		var xml:XML = super.getExportCode();
		xml.@redMultiplier = redMultiplierComboBox.serialize();
		xml.@greeMultiplier = greeMultiplierComboBox.serialize();
		xml.@blueMultiplier = blueMultiplierComboBox.serialize();
		xml.@alphaMultiplier = alphaMultiplierComboBox.serialize();
		xml.@redOffset = redOffsetComboBox.serialize();
		xml.@greenOffset = greenOffsetComboBox.serialize();
		xml.@blueOffset = blueOffsetComboBox.serialize();
		xml.@alphaOffset = alphaOffsetComboBox.serialize();
		return xml;
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