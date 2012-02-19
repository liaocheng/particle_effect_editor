package particleEditor.effect.action.global
{
	import a3dparticle.animators.actions.ActionBase;
	import a3dparticle.animators.actions.brokenline.BrokenLineGlobal;
	import particleEditor.effect.action.ActionEditorBase;
	import flash.events.Event;
	import flash.geom.Vector3D;
	import org.aswing.JButton;
	import org.aswing.JPanel;
	import org.aswing.SoftBoxLayout;
	
	/**
	 * ...
	 * @author liaocheng
	 */
	public class BrokenLineGlobalEditor extends ActionEditorBase
	{
		private var addButton:JButton;;
		private var segmentContainer:JPanel;
		
		public function BrokenLineGlobalEditor()
		{
			super();
			nameInput.getInput().setText("BrokenLineGlobal");
			
			addButton = new JButton("add segment");
			var pane:JPanel = new JPanel();
			pane.append(addButton);
			segmentContainer = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));

			contentPane.appendAll(pane, segmentContainer);
			
			addButton.addActionListener(addNewSegment);
		}
		
		override public function createNeedStuff():*
		{
			var brokenData:Array = [];
			var segmentPane:SegmentPane;
			for (var i:int = 0; i < segmentContainer.getComponentCount(); i++)
			{
				segmentPane = segmentContainer.getComponent(i) as SegmentPane;
				var velocity:Vector3D = segmentPane.velocityInput.getValue();
				var during:Number = segmentPane.duringInput.getInputNumber();
				velocity.w = during;
				brokenData.push(velocity);
			}
			return new BrokenLineGlobal(brokenData);
		}
		
		private function addNewSegment(e:Event):void
		{
			segmentContainer.append(new SegmentPane());
		}
		
		override public function getExportCode():XML
		{
			var xml:XML = super.getExportCode();
			for (var i:int = 0; i < segmentContainer.getComponentCount(); i++)
			{
				var segment:XML = new XML("<segment/>");
				
				var segmentPane:SegmentPane = segmentContainer.getComponent(i) as SegmentPane;
				segment.@velocity = segmentPane.velocityInput.serialize();
				segment.@during = segmentPane.duringInput.serialize();
				xml.appendChild(segment);
			}
			return xml;
		}
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			for each(var segment:XML in xml.segment)
			{			
				addNewSegment(null);
				var segmentPane:SegmentPane = segmentContainer.getComponent(segmentContainer.getComponentCount() - 1) as SegmentPane;
				segmentPane.velocityInput.deserialize(segment.@velocity);
				segmentPane.duringInput.deserialize(segment.@during);
			}
		}
	
	}

}
import flash.events.Event;
import org.aswing.ASColor;
import org.aswing.border.LineBorder;
import org.aswing.JButton;
import org.aswing.JPanel;
import org.aswing.SoftBoxLayout;
import particleEditor.inputer.NumberInput;
import particleEditor.inputer.Vector3dInput;

class SegmentPane extends JPanel
{
	public var velocityInput:Vector3dInput;
	public var duringInput:NumberInput;
	public var deleteButton:JButton;
	public function SegmentPane()
	{
		super(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
		setBorder(new LineBorder(null, new ASColor(0x666666), 1, 1));
		velocityInput = new Vector3dInput("velocity:");
		duringInput = new NumberInput("during time:", "5", 2, 3);
		duringInput.setMinMax(0);
		deleteButton = new JButton("del");
		var pane:JPanel = new JPanel();
		pane.appendAll(duringInput, deleteButton);
		appendAll(velocityInput, pane);
		deleteButton.addActionListener(onDelete);
	}
	
	private function onDelete(e:Event):void
	{
		getParent().remove(this);
	}
}