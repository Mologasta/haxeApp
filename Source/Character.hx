package;


import lime.math.Vector2;
import openfl.display.Tile;

class Character extends Tile
{
	public var velocity:Vector2;
	
	public function new(type:Int, x:Float, y:Float, velocityY:Float) 
	{
		super(type, x, y);
		var velocityX = 0;
		velocity = new Vector2(velocityX, velocityY);
	}
	
}