package particleEditor.effect.generater 
{
	import flash.events.Event;
	import org.aswing.border.LineBorder;
	import org.aswing.event.AWEvent;
	import org.aswing.event.ContainerEvent;
	import org.aswing.JButton;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.SoftBoxLayout;
	import org.aswing.VectorListModel;
	import particleEditor.edit.EditorBase;
	import particleEditor.edit.IExportable;
	import particleEditor.edit.Property;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class SamplesFactory extends JPanel implements IExportable
	{
		private var content:JPanel;
		
		private var shapeModel:VectorListModel;
		private var materialModel:VectorListModel;
		
		private var _sampleModel:VectorListModel = new VectorListModel;
		
		private var title:JLabel;
		
		public function SamplesFactory(shapeModel:VectorListModel,materialModel:VectorListModel) 
		{
			super(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 5));
			
			this.shapeModel = shapeModel;
			this.materialModel = materialModel;
			
			setBorder(new LineBorder());
			
			var addButton:JButton = new JButton("add new sample");
			var pane:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS,5));
			pane.appendAll(addButton);
			
			content = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 5));
			
			title = new JLabel("", null, JLabel.LEFT);
			refreshTitle(null);
			content.addEventListener(ContainerEvent.COM_ADDED, refreshTitle);
			content.addEventListener(ContainerEvent.COM_REMOVED, refreshTitle);
			
			appendAll(title, pane, content);
			addButton.addActionListener(addSample);
		}
		
		public function get tagName():String
		{
			return "sample";
		}
		
		public function getExportCode():XML
		{
			var xml:XML = new XML("<" + tagName + "/>");
			for each(var i:Property in _sampleModel.toArray())
			{
				var shapeEditor:EditorBase = i.getEditorPane() as EditorBase;
				xml.appendChild(shapeEditor.getExportCode());
			}
			return xml;
		}
		public function importCode(xml:XML):void
		{
			for each(var i:XML in xml.editor)
			{
				var _editor:SampleEdior = new SampleEdior(shapeModel,materialModel);
				_editor.setListModel(_sampleModel);
				_editor.setPane(content);
				_editor.importCode(i);
			}
		}
		
		public function createNeedStuff():*
		{
			return _sampleModel;
		}
		
		
		private function addSample(e:AWEvent):void
		{
			var _editor:SampleEdior = new SampleEdior(shapeModel,materialModel);
			_editor.setListModel(_sampleModel);
			_editor.setPane(content);
		}
		
		private function refreshTitle(e:Event):void
		{
			title.setText("samples: has created " + content.getComponentCount());
		}
		
	}

}
import a3dparticle.particle.ParticleMaterialBase;
import a3dparticle.particle.ParticleSample;
import away3d.core.base.SubGeometry;
import particleEditor.edit.Property;
import particleEditor.edit.VarNameEditorBase;
import org.aswing.JComboBox;
import org.aswing.JLabel;
import org.aswing.JPanel;
import org.aswing.VectorListModel;
import particleEditor.inputer.ComboBoxInput;

class SampleEdior extends VarNameEditorBase
{
	private var materialCombo:ComboBoxInput;
	private var shapeCombo:ComboBoxInput;
	
	public function SampleEdior(shapeModel:VectorListModel,materialModel:VectorListModel)
	{
		super();

		setLabel("sample:");
		materialCombo = new ComboBoxInput("material:", materialModel);
		shapeCombo = new ComboBoxInput("  shape :", shapeModel);
		contentPane.appendAll(shapeCombo, materialCombo );
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
			throw new Error("can not get sample:", this.getVarName());
			return null;
		}
	}
	
	override public function getExportCode():XML
	{
		var xml:XML = super.getExportCode();
		xml.@material = materialCombo.serialize();
		xml.@shape = shapeCombo.serialize();
		return xml;
	}
	
	override public function importCode(xml:XML):void
	{
		super.importCode(xml);
		materialCombo.deserialize(xml.@material);
		shapeCombo.deserialize(xml.@shape);
	}
}