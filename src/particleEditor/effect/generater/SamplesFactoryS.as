package particleEditor.effect.generater 
{
	import particleEditor.edit.IImportable;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class SamplesFactoryS implements IImportable
	{
		
		private var shapeModel:Array;
		private var materialModel:Array;
		
		private var _sampleModel:Array = new Array();
		
		
		public function SamplesFactoryS(shapeModel:Array,materialModel:Array) 
		{		
			this.shapeModel = shapeModel;
			this.materialModel = materialModel;
		}
		
		public function get tagName():String
		{
			return "sample";
		}
		
		public function importCode(xml:XML):void
		{
			for each(var i:XML in xml.editor)
			{
				var _editor:SampleEdiorS = new SampleEdiorS(shapeModel,materialModel);
				_editor.setListModel(_sampleModel);
				_editor.importCode(i);
			}
		}
		
		public function createNeedStuff():*
		{
			return _sampleModel;
		}		
	}

}



import a3dparticle.particle.ParticleMaterialBase;
import a3dparticle.particle.ParticleSample;
import away3d.core.base.SubGeometry;
import particleEditor.edit.EditorWithPropertyBaseS;
import particleEditor.edit.Property;
import particleEditor.inputer.ComboBoxInputS;

class SampleEdiorS extends EditorWithPropertyBaseS
{
	private var materialCombo:ComboBoxInputS;
	private var shapeCombo:ComboBoxInputS;
	
	
	public function SampleEdiorS(shapeModel:Array,materialModel:Array)
	{
		super();
		materialCombo = new ComboBoxInputS(materialModel);
		shapeCombo = new ComboBoxInputS(shapeModel);
	}
	
	override public function createNeedStuff():*
	{
		if (shapeCombo.getValue() && materialCombo.getValue())
		{
			var shape:SubGeometry = (shapeCombo.getValue() as Property).getNewValue() as SubGeometry;
			var material:ParticleMaterialBase = (materialCombo.getValue() as Property).getNewValue() as ParticleMaterialBase;;
			return new ParticleSample(shape, material);
		}
		else
		{
			throw new Error("can not get sample:");
			return null;
		}
	}
	
	override public function importCode(xml:XML):void
	{
		super.importCode(xml);
		materialCombo.deserialize(xml.@material);
		shapeCombo.deserialize(xml.@shape);
	}
}