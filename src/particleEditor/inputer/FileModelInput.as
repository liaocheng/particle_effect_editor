package particleEditor.inputer
{
	import away3d.core.base.SubGeometry;
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.library.assets.AssetType;
	import away3d.loaders.Loader3D;
	import away3d.loaders.misc.AssetLoaderContext;
	import away3d.loaders.parsers.Max3DSParser;
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.utils.ByteArray;
	import org.aswing.JButton;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import particleEditor.utils.FileOperater;
	
	/**
	 * ...
	 * @author liaocheng
	 */
	public class FileModelInput extends JPanel implements ISerializable
	{
		
		protected var vertexCount:LabelInput;
		protected var faceCount:LabelInput;
		protected var subGeometry:SubGeometry;
		
		public function FileModelInput(title:String) 
		{
			super();
			var label:JLabel = new JLabel(title);
			vertexCount = new LabelInput("vertex", "0");
			faceCount = new LabelInput("face", "0");
			vertexCount.getInput().setEditable(false);
			faceCount.getInput().setEditable(false);
			var button:JButton = new JButton("open");
			appendAll(label, vertexCount, faceCount, button);
			button.addActionListener(onOpen);
		}
		
		protected function onOpen(E:Event):void
		{ 
			FileOperater.readFile(new FileFilter("select a model", "*.3ds"), onRead);
		}
		
		private function onRead(byte:ByteArray):void
		{
			if (byte)
			{
				var loader:Loader3D = new Loader3D();
				loader.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetComplete);
				loader.loadData(byte, new AssetLoaderContext(false), null, new Max3DSParser());
			}
		}
		
		private function onAssetComplete(e:AssetEvent):void
		{
			switch(e.asset.assetType)
			{
				case AssetType.MESH:
					var mesh:Mesh = Mesh(e.asset);
					subGeometry = mesh.geometry.subGeometries[0];
					showGeometry();
					break;
			}
		}
		
		private function showGeometry():void
		{
			vertexCount.setInputText(String(subGeometry.numVertices));
			faceCount.setInputText(String(subGeometry.numTriangles));

		}
		
		public function getValue():SubGeometry
		{
			return subGeometry;
		}
		
		public function serialize():String
		{
			if (subGeometry)
			{
				var json:String = JSON.stringify([subGeometry.vertexData, subGeometry.indexData, subGeometry.UVData]);
				return json;
			}
			else
			{
				return "-1";
			}
		}
		
		public function deserialize(value:String):void
		{
			if (value == "-1")
			{
				return;
			}
			else
			{
				var array:Array = JSON.parse(value) as Array;
				subGeometry = new SubGeometry();
				subGeometry.updateVertexData(Vector.<Number>(array[0]));
				subGeometry.updateIndexData(Vector.<uint>(array[1]));
				subGeometry.updateUVData(Vector.<Number>(array[2]));
				showGeometry();
			}
		}
		
	}

}