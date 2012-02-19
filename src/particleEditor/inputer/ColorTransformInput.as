package particleEditor.inputer
{
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import org.aswing.JButton;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.JTextField;
	/**
	 * ...
	 * @author liaocheng
	 */
	public class ColorTransformInput extends JPanel implements ISerializable
	{
		protected var label:JLabel;
		protected var textfield:JTextField;
		protected var editorButton:JButton;
		
		protected var colorTransform:ColorTransform;
		
		public function ColorTransformInput(title:String="",defaultColor:ColorTransform=null) 
		{
			super();
			label = new JLabel(title);
			textfield = new JTextField("", 8);
			textfield.setEditable(false);
			editorButton = new JButton("edit");
			appendAll(label, textfield, editorButton);
			
			editorButton.addActionListener(editColorTransform);
			
			if (defaultColor)
			{
				colorTransform = defaultColor;
			}
			else
			{
				colorTransform = new ColorTransform();
			}
			changeColor(colorTransform);
			editorButton.addActionListener(editColorTransform);
		}
		
		protected function editColorTransform(e:Event):void
		{
			ColorTransformWindow.showColorTransformWindow(changeColor,colorTransform);
		}
		
		protected function changeColor(value:ColorTransform):void
		{
			colorTransform = value;
			textfield.setText(colorTransform.toString());
		}
		
		public function serialize():String
		{
			return String(colorTransform.redMultiplier) + "," + String(colorTransform.greenMultiplier) + "," + String(colorTransform.blueMultiplier) + "," + String(colorTransform.alphaMultiplier) + "," +
				String(colorTransform.redOffset) + "," + String(colorTransform.greenOffset) + "," + String(colorTransform.blueOffset) + "," + String(colorTransform.alphaOffset);
		}
		
		public function deserialize(value:String):void
		{
			var array:Array = value.split(",");
			changeColor(new ColorTransform(array[0], array[1], array[2], array[3], array[4], array[5], array[6], array[7]));
		}
		
		public function getValue():ColorTransform
		{
			return colorTransform;
		}
		
	}

}
import flash.display.Shape;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import flash.geom.Transform;
import org.aswing.ASColor;
import org.aswing.AssetPane;
import org.aswing.AsWingConstants;
import org.aswing.AsWingUtils;
import org.aswing.BorderLayout;
import org.aswing.event.InteractiveEvent;
import org.aswing.ext.Form;
import org.aswing.FlowLayout;
import org.aswing.geom.IntDimension;
import org.aswing.JAdjuster;
import org.aswing.JButton;
import org.aswing.JColorChooser;
import org.aswing.JFrame;
import org.aswing.JLabel;
import org.aswing.JPanel;
import org.aswing.JSpacer;
import org.aswing.SoftBoxLayout;

class ColorTransformWindow extends JFrame
{
	protected var form:Form;
	
	protected var OKButton:JButton;
	
	protected var redMultiplier:JAdjuster;
	protected var greenMultiplier:JAdjuster;
	protected var blueMultiplier:JAdjuster;
	protected var alphaMultiplier:JAdjuster;
	
	protected var redOffset:JAdjuster;
	protected var greenOffset:JAdjuster;
	protected var blueOffset:JAdjuster;
	protected var alphaOffset:JAdjuster;
	
	protected var original:Rect;
	protected var transformed:Rect;
	protected var _transform:Transform;

	private const _adjusterWidth:int = 80;
	
	private var okHandler:Function;
	
	public function ColorTransformWindow(defaultColorTransform:ColorTransform,handler:Function)
	{
		super(null, "color transform edit", true);
		okHandler = handler;
		
		original = new Rect(80, 80);
		transformed = new Rect(80, 80);
		
		
		var pane:JPanel;
		this.getContentPane().setLayout(new SoftBoxLayout(SoftBoxLayout.Y_AXIS,5,AsWingConstants.TOP));
		this.getContentPane().append(new JSpacer(new IntDimension(0, 30)), BorderLayout.NORTH);
		
		form = new Form();
		form.setHGap(5);
		pane = new JPanel(new FlowLayout(AsWingConstants.CENTER));
		pane.append(form);
		this.getContentPane().append(pane);
		OKButton = new JButton("OK");
		
		var assetPane1:AssetPane = new AssetPane(original);
		var assetPane2:AssetPane = new AssetPane(transformed);
		var pane1:JPanel = new JPanel(new FlowLayout(AsWingConstants.CENTER));
		var pane2:JPanel = new JPanel(new FlowLayout(AsWingConstants.CENTER));
		pane1.append(assetPane1);
		pane2.append(assetPane2);
		var label1:JLabel = new JLabel("original");
		var label2:JLabel = new JLabel("transformed");
		
		
		
		pane = new JPanel(new FlowLayout(AsWingConstants.CENTER));
		pane.append(OKButton);
		this.getContentPane().append(pane);
		
		redMultiplier = new JAdjuster();
		redMultiplier.setValue(100);
		redMultiplier.setMaximum(200);
		redMultiplier.setPreferredWidth(_adjusterWidth);
		redMultiplier.setValueTranslator(valueTranslator);
		redMultiplier.addEventListener(InteractiveEvent.STATE_CHANGED, onChange);
		greenMultiplier = new JAdjuster();
		greenMultiplier.setValue(100);
		greenMultiplier.setMaximum(200);
		greenMultiplier.setPreferredWidth(_adjusterWidth);
		greenMultiplier.setValueTranslator(valueTranslator);
		greenMultiplier.addEventListener(InteractiveEvent.STATE_CHANGED, onChange);
		blueMultiplier = new JAdjuster();
		blueMultiplier.setValue(100);
		blueMultiplier.setMaximum(200);
		blueMultiplier.setPreferredWidth(_adjusterWidth);
		blueMultiplier.setValueTranslator(valueTranslator);
		blueMultiplier.addEventListener(InteractiveEvent.STATE_CHANGED, onChange);
		alphaMultiplier = new JAdjuster();
		alphaMultiplier.setValue(100);
		alphaMultiplier.setMaximum(200);
		alphaMultiplier.setPreferredWidth(_adjusterWidth);
		alphaMultiplier.setValueTranslator(valueTranslator);
		alphaMultiplier.addEventListener(InteractiveEvent.STATE_CHANGED, onChange);
		
		redOffset = new JAdjuster();
		redOffset.setValue(0);
		redOffset.setMinimum(-255);
		redOffset.setMaximum(255);
		redOffset.setPreferredWidth(_adjusterWidth);
		redOffset.addEventListener(InteractiveEvent.STATE_CHANGED, onChange);
		greenOffset = new JAdjuster();
		greenOffset.setValue(0);
		greenOffset.setMinimum(-255);
		greenOffset.setMaximum(255);
		greenOffset.setPreferredWidth(_adjusterWidth);
		greenOffset.addEventListener(InteractiveEvent.STATE_CHANGED, onChange);
		blueOffset = new JAdjuster();
		blueOffset.setValue(0);
		blueOffset.setMinimum(-255);
		blueOffset.setMaximum(255);
		blueOffset.setPreferredWidth(_adjusterWidth);
		blueOffset.addEventListener(InteractiveEvent.STATE_CHANGED, onChange);
		alphaOffset = new JAdjuster();
		alphaOffset.setValue(0);
		alphaOffset.setMinimum(-255);
		alphaOffset.setMaximum(255);	
		alphaOffset.setPreferredWidth(_adjusterWidth);
		alphaOffset.addEventListener(InteractiveEvent.STATE_CHANGED, onChange);
		form.addRow(redMultiplier, greenMultiplier, blueMultiplier, alphaMultiplier, redOffset, greenOffset, blueOffset, alphaOffset);
		form.addRow(new JLabel("redMultiplier"), new JLabel("greenMultiplier"), new JLabel("blueMultiplier"), new JLabel("alphaMultiplier"), new JLabel("redOffset"), new JLabel("greenOffset"), new JLabel("blueOffset"), new JLabel("alphaOffset"));
		form.addRow(null, null, null, pane1, pane2, null, null, null);
		form.addRow(null, null, null, label1, label2, null, null, null);
		
		
		_transform = new Transform(transformed);
		OKButton.addActionListener(onOK);
		assetPane1.addEventListener(MouseEvent.CLICK, onChangeOriginal);		
		setValue(defaultColorTransform);
		_transform.colorTransform = getValue();
	}
	
	private function onChangeOriginal(e:Event):void
	{
		JColorChooser.showDialog(null, "select a color", original.color, true, changeOriginal);
	}
	
	private function changeOriginal(color:ASColor):void
	{
		original.color = color;
		transformed.color = color;
	}
	
	private function onChange(e:Event):void
	{
		_transform.colorTransform = getValue();
	}
	
	private function onOK(e:Event):void
	{
		if (okHandler != null) okHandler(getValue());
		tryToClose();
	}
	
	private function valueTranslator(value:int):String
	{
		return String(value)+" %";
	}
	
	public function getValue():ColorTransform
	{
		return new ColorTransform(redMultiplier.getValue() / 100, greenMultiplier.getValue() / 100, blueMultiplier.getValue() / 100, alphaMultiplier.getValue() / 100,
								redOffset.getValue(), greenOffset.getValue(), blueOffset.getValue(), alphaOffset.getValue());
	}
	
	private function setValue(value:ColorTransform):void
	{
		redMultiplier.setValue(value.redMultiplier * 100);
		greenMultiplier.setValue(value.greenMultiplier * 100);
		blueMultiplier.setValue(value.blueMultiplier * 100);
		alphaMultiplier.setValue(value.alphaMultiplier * 100);
		
		redOffset.setValue(value.redOffset);
		greenOffset.setValue(value.greenOffset);
		blueOffset.setValue(value.blueOffset);
		alphaOffset.setValue(value.alphaOffset);
	}
	
	public static function showColorTransformWindow(hanlder:Function,defaultColorTransform:ColorTransform=null):void
	{
		var value:ColorTransform = defaultColorTransform;
		if (!value) value = new ColorTransform();
		var fram:ColorTransformWindow = new ColorTransformWindow(value,hanlder);
		fram.setSizeWH(760, 400);
		AsWingUtils.centerLocate(fram);
		fram.show();
	}
}

class Rect extends Shape 
{
	private var _width:Number;
	private var _height:Number;
	private var _color:ASColor;

	public function Rect( width:Number = 1, height:Number = 1, color:ASColor=null)
	{
		_width = width;
		_height = height;
		_color = color;
		if (!_color)_color = ASColor.WHITE;
		draw();
	}
	
	private function draw():void
	{
		graphics.clear();
		graphics.beginFill( _color.getRGB(), _color.getAlpha() );
		graphics.drawRect( 0, 0, _width, _height );
		graphics.endFill();
	}
	
	override public function get width():Number
	{
		return _width;
	}
	override public function set width( value:Number ):void
	{
		_width = value;
		draw();
	}
	
	override public function get height():Number
	{
		return _height;
	}
	override public function set height( value:Number ):void
	{
		_height = value;
		draw();
	}

	public function get color():ASColor
	{
		return _color;
	}
	public function set color( value:ASColor ):void
	{
		_color = value;
		draw();
	}
}