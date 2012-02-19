package particleEditor.effect.action.global
{
	import a3dparticle.animators.actions.brokenline.BrokenLineGlobal;
	import flash.geom.Vector3D;
	import particleEditor.edit.EditorWithPropertyBaseS;
	
	/**
	 * ...
	 * @author liaocheng
	 */
	public class BrokenLineGlobalEditorS extends EditorWithPropertyBaseS
	{
		private var segmentContainer:Array;
		
		public function BrokenLineGlobalEditorS()
		{
			super();
		}
		
		override public function createNeedStuff():*
		{
			var brokenData:Array = [];
			var segmentPane:SegmentPaneS;
			for (var i:int = 0; i < segmentContainer.getComponentCount(); i++)
			{
				segmentPane = segmentContainer[i] as SegmentPaneS;
				var velocity:Vector3D = segmentPane.velocityInput.getValue();
				var during:Number = segmentPane.duringInput;
				velocity.w = during;
				brokenData.push(velocity);
			}
			return new BrokenLineGlobal(brokenData);
		}		
		
		override public function importCode(xml:XML):void
		{
			super.importCode(xml);
			for each(var segment:XML in xml.segment)
			{			
				var segmentPane:SegmentPaneS = new SegmentPaneS();
				segmentPane.velocityInput.deserialize(segment.@velocity);
				segmentPane.duringInput = Number(segment.@during);
				segmentContainer.push(segmentPane);
			}
		}
	
	}

}
import particleEditor.inputer.Vector3dInputS;

class SegmentPaneS
{
	public var velocityInput:Vector3dInputS;
	public var duringInput:Number;
	public function SegmentPaneS()
	{
		duringInput = 5;
		velocityInput = new Vector3dInputS();
	}
}