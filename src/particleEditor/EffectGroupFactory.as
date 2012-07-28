package particleEditor
{
	import a3dparticle.ParticlesContainer;
	import flash.events.Event;
	import org.aswing.ASColor;
	import org.aswing.AsWingConstants;
	import org.aswing.event.AWEvent;
	import org.aswing.FlowLayout;
	import org.aswing.GeneralListCellFactory;
	import org.aswing.JButton;
	import org.aswing.JList;
	import org.aswing.JPanel;
	import org.aswing.JScrollPane;
	import org.aswing.SoftBoxLayout;
	import org.aswing.VectorListModel;
	import particleEditor.edit.IExportable;
	import particleEditor.effect.EffectFactory;
	import particleEditor.effect.EffectListCell;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class EffectGroupFactory extends JPanel implements IExportable
	{
		
		private var _list:JList;
		
		private var _particleGeneraters:VectorListModel;
				
		private var _selectHandle:Function;
		
		private var _deleteButton:JButton;
		
		
		public function EffectGroupFactory()
		{
			super(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 10));
			
			_particleGeneraters = new VectorListModel();
			
			var addButton:JButton = new JButton("add a new container");
			append(addButton);
			_list = new JList(_particleGeneraters,new GeneralListCellFactory(EffectListCell,false,true,30));
			_list.setVisibleCellWidth(100);
			_list.setVisibleRowCount(5);
			append(new JScrollPane(_list));
			
			_deleteButton = new JButton("delete");
			_deleteButton.setBackground(ASColor.RED);
			var pane:JPanel = new JPanel(new FlowLayout(AsWingConstants.CENTER));
			pane.append(_deleteButton);
			append(pane);
			_deleteButton.addActionListener(onDelete);
			
			
			addButton.addActionListener(addNewContainer);

			_list.addSelectionListener(onSelect);
			_list.addSelectionListener(onChangeButton);
			onChangeButton(null);
			
		}
		
		public function get tagName():String
		{
			return "root";
		}
		
		public function getExportCode():XML
		{
			var xml:XML = new XML("<" + tagName + "/>");
			xml.@main = EffectFormat.MAIN;
			xml.@minor = EffectFormat.MINOR;
			for each(var effect:EffectFactory in _particleGeneraters.toArray())
			{
				xml.appendChild(effect.getExportCode());
			}
			return xml;
		}
		
		public function importCode(code:XML):void
		{
			EffectFormat.verifyFormat(code);
			_particleGeneraters.removeRange(0, _particleGeneraters.getSize() - 1);
			for each(var effect:XML in code.effect)
			{
				var system:EffectFactory = new EffectFactory();
				system.importCode(effect);
				_particleGeneraters.append(system);
			}
		}
		
		public function createNeedStuff():*
		{
			var effects:Array = _particleGeneraters.toArray();
			var _particleContainers:Vector.<ParticlesContainer> = new Vector.<ParticlesContainer>;
			for each(var i:EffectFactory in effects)
			{
				if (i.enable)
				{
					_particleContainers.push(i.createNeedStuff() as ParticlesContainer);
				}
			}
			return new EffectGroup(getExportCode().toString(), _particleContainers);
		}
		
		private function addNewContainer(e:AWEvent):void
		{
			_particleGeneraters.append(new EffectFactory());
			doLayout();
		}
		
		public function setSelectHandler(handle:Function):void
		{
			_selectHandle = handle;
		}
			
		private function onSelect(e:AWEvent):void
		{
			if (_selectHandle != null)_selectHandle(_list.getSelectedValue());
		}
		
		private function onDelete(e:Event):void
		{
			(_list.getModel() as VectorListModel).remove(_list.getSelectedValue());
		}
		
		private function onChangeButton(e:Event):void
		{
			if (_list.getSelectedIndex() >= 0)_deleteButton.setEnabled(true);
			else _deleteButton.setEnabled(false);
		}
		
	}

}