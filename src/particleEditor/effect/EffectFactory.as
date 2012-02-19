package  particleEditor.effect
{
	import a3dparticle.animators.actions.ActionBase;
	import a3dparticle.particle.ParticleParam;
	import a3dparticle.ParticlesContainer;
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	import org.aswing.BorderLayout;
	import org.aswing.JPanel;
	import a3dparticle.generater.GeneraterBase;
	import a3dparticle.ParticlesContainer;
	import org.aswing.ASColor;
	import org.aswing.AsWingConstants;
	import org.aswing.border.EmptyBorder;
	import org.aswing.border.LineBorder;
	import org.aswing.BorderLayout;
	import org.aswing.Insets;
	import org.aswing.JPanel;
	import org.aswing.JScrollPane;
	import org.aswing.JSplitPane;
	import org.aswing.JViewport;
	import particleEditor.edit.IExportable;
	import particleEditor.effect.action.ActionsFactory;
	import particleEditor.effect.generater.GeneraterFactory;
	import particleEditor.effect.param.InitParamFactory;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class EffectFactory extends JPanel implements IExportable
	{	
		public var enable:Boolean = true;
		
		private var _generaterFactory:GeneraterFactory;
		
		private var _systemFactory:SystemFactory;
		
		private var _actionsFactory:ActionsFactory;
		private var _initParamFactory:InitParamFactory;
		
		public function EffectFactory() 
		{
			super(new BorderLayout());
			
			_generaterFactory = new GeneraterFactory();
			_initParamFactory = new InitParamFactory();
			
			_actionsFactory = new ActionsFactory(_initParamFactory.getActionPane(),_initParamFactory.getVarListModel());
			
			_systemFactory = new SystemFactory();
			
			//set ui
			var scorlPane1:JScrollPane = new JScrollPane(_generaterFactory, JScrollPane.SCROLLBAR_AS_NEEDED, JScrollPane.SCROLLBAR_NEVER);
			(scorlPane1.getViewport() as JViewport).setTracksWidth(true);
			(scorlPane1.getViewport() as JViewport).setVerticalAlignment(AsWingConstants.TOP);

			var scorlPane2:JScrollPane = new JScrollPane(_actionsFactory, JScrollPane.SCROLLBAR_AS_NEEDED, JScrollPane.SCROLLBAR_NEVER);
			(scorlPane2.getViewport() as JViewport).setTracksWidth(true);
			(scorlPane2.getViewport() as JViewport).setVerticalAlignment(AsWingConstants.TOP);
			
			var scorlPane3:JScrollPane = new JScrollPane(_initParamFactory, JScrollPane.SCROLLBAR_AS_NEEDED, JScrollPane.SCROLLBAR_NEVER);
			(scorlPane3.getViewport() as JViewport).setTracksWidth(true);
			(scorlPane3.getViewport() as JViewport).setVerticalAlignment(AsWingConstants.TOP);
			
			var temp1:JSplitPane = new JSplitPane(JSplitPane.VERTICAL_SPLIT, false, scorlPane1, scorlPane2);
			var temp2:JSplitPane = new JSplitPane(JSplitPane.VERTICAL_SPLIT, false, temp1, scorlPane3);
			temp1.setResizeWeight(0.5);
			temp2.setResizeWeight(0.66);
			append(temp2);
			
			//set border
			scorlPane1.setBorder(new EmptyBorder(new LineBorder(new EmptyBorder(null,new Insets(2,2,2,2)),ASColor.BLUE,2),new Insets(2,2,2,2)));
			scorlPane2.setBorder(new EmptyBorder(new LineBorder(new EmptyBorder(null,new Insets(2,2,2,2)),ASColor.BLUE,2),new Insets(2,2,2,2)));
			scorlPane3.setBorder(new EmptyBorder(new LineBorder(new EmptyBorder(null,new Insets(2,2,2,2)),ASColor.BLUE,2),new Insets(2,2,2,2)));
			setBorder(new LineBorder());
		}
		
		public function get tagName():String
		{
			return "effect";
		}
		
		
		public function createNeedStuff ():*
		{
			var particlesContainer:ParticlesContainer = _systemFactory.createNeedStuff() as ParticlesContainer;
			var allActions:Array = _actionsFactory.createNeedStuff() as Array;
			allActions.forEach(function(action:ActionBase, ...rest):void
				{
					particlesContainer.addAction(action);
				});
			
			
			particlesContainer.initParticleFun = initParticleFun();
			particlesContainer.generate(_generaterFactory.createNeedStuff() as GeneraterBase);
			return particlesContainer;
		}
		
		public function importCode(xml:XML):void
		{
			_systemFactory.importCode(xml[_systemFactory.tagName][0]);
			_generaterFactory.importCode(xml[_generaterFactory.tagName][0]);
			_initParamFactory.importCode(xml[_initParamFactory.tagName][0]);
			_actionsFactory.importCode(xml[_actionsFactory.tagName][0]);
		}
		
		public function getExportCode():XML
		{
			var xml:XML = new XML("<" + tagName + "/>");
			xml.appendChild(_systemFactory.getExportCode());
			xml.appendChild(_generaterFactory.getExportCode());
			xml.appendChild(_initParamFactory.getExportCode());
			xml.appendChild(_actionsFactory.getExportCode());
			return xml;
		}
		
		private function initParticleFun():Function
		{
			
			return function(param:ParticleParam):void
			{
				var localVars:Dictionary = new Dictionary();
				(_initParamFactory.createNeedStuff() as Array).forEach(function(handler:Function, ...rest):void
				{
					handler(param,localVars);
				});
				// for an exception action -- TimeAction
				_initParamFactory.getTimeHanlder()(param, localVars);
				// for normal actions
				_actionsFactory.getInitParamHandlers().forEach(function(handler:Function, ...rest):void
				{
					handler(param, localVars);
				});
			}
		}
		
		public function getSystemPane():JPanel
		{
			return _systemFactory;
		}
		
	}

}