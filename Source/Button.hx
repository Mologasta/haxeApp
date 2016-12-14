package;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.display.SimpleButton;
import openfl.display.DisplayObject;

class Button extends Sprite
{
	
	public function new(x, y, coverImg:Bitmap)
    {
        super();
        this.graphics.beginFill( 0xffffff );
        this.graphics.drawRoundRect( x, y, coverImg.width, coverImg.height, 0, 0 );
        this.graphics.endFill();
		this.buttonMode = true;
		this.useHandCursor = true;
		coverImg.x = x;
		coverImg.y = y;
		addChild(coverImg);
		
    }
}