package;
import openfl.text.TextField;
import openfl.text.TextFieldType;
import openfl.text.TextFormatAlign;
import openfl.text.TextFormat;
import openfl.display.DisplayObject;
import openfl.display.Stage;


class TextFields extends TextField
{
	
	public function new(x, y) 
	{
		super();
		this.x = x;
		this.y = y;
		this.type = TextFieldType.INPUT;
		this.selectable = true;
		this.border = true;
		this.width = 60;
		this.height = 20;
		this.borderColor = (0x000000);
		this.text = "cherry";
		this.multiline = false;
	}
	
	private function getValue () 
	{
		return this.getLineText(0);
	}
}