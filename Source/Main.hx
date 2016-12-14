package;

import openfl.display.Bitmap;
import openfl.display.Tile;
import openfl.display.Tilemap;
import openfl.display.Tileset;
import openfl.display.Sprite;
import openfl.display.DisplayObject;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.Rectangle;
import openfl.utils.Timer;
import openfl.Assets;



class Main extends Sprite {
	
		private var tilemap:Tilemap;
		private var tileset:Tileset;
		private var firstColChars:Array<Character>;
		private	var secondColChars:Array<Character>;
		private var thirdColChars:Array<Character>;
		private var apple:Int;
		private var grape:Int;
		private var lemon:Int;
		private var cherry:Int;
		private var	question:Int;
		private var firstColItems:Array<Int>;
		private var secondColItems:Array<Int>;
		private var thirdColItems:Array<Int>;
		private var spinButton:Button;
		private var fieldWidth:Float;
		private var cnt:Int;
		private var textFieldsArr:Array<TextFields>;
		
		public function new () {
			
			super ();
			tileset = new Tileset(Assets.getBitmapData("assets/img/fruits.png"));
			tilemap = new Tilemap(stage.stageWidth, stage.stageHeight, tileset);
			var bitmap = new Bitmap (Assets.getBitmapData ("assets/img/field.png"));
			var spin = new Bitmap (Assets.getBitmapData ("assets/img/spinButton.png"));
			addChild (bitmap);
			fieldWidth = bitmap.width;
			
			spinButton = new Button((stage.stageWidth + fieldWidth)/2 + 50, stage.stageHeight/2, spin);
			spinButton.addEventListener(MouseEvent.MOUSE_DOWN, spinStart);
			addChild(spinButton);
			
			bitmap.x = (stage.stageWidth - fieldWidth) / 2 ;
			bitmap.y = (stage.stageHeight - bitmap.height) / 2;
			apple = tileset.addRect(new Rectangle(0, 0, 150, 100));
			grape = tileset.addRect(new Rectangle(150, 0, 150, 100));
			lemon = tileset.addRect(new Rectangle(300, 0, 150, 100));
			cherry = tileset.addRect(new Rectangle(450, 0, 150, 100));
			question = tileset.addRect(new Rectangle(450, 100, 150, 100));
			var startImg = tileset.addRect(new Rectangle(0, 10, 430, 300));
			
			firstColItems = [apple, grape, cherry, lemon, apple, grape,
			cherry, lemon, grape, apple, grape, cherry];
			secondColItems = [lemon, grape, lemon, lemon, grape,
			cherry, cherry, lemon, grape, lemon, cherry, cherry, grape, lemon];
			thirdColItems = [lemon, apple, grape, cherry, apple,
			grape, cherry, apple, grape, cherry, lemon, cherry, lemon, cherry, cherry, grape, lemon, cherry];
			
			textFieldsArr = [];
			firstColChars = [];
			secondColChars = [];
			thirdColChars = [];
			
			addChild(tilemap);
			stage.addEventListener(Event.ENTER_FRAME, onFrame);
			setChildIndex (bitmap, numChildren - 1);
			startState(startImg);
			setItems (9);
			cnt = 0;
			
		}
		
		private function setItems (num:Int) {
			var i:Int = 0;
			var coordX:Float = -40; 
			var coordY:Float = 0;
			var xOffset:Float = 70;
			var yOffset:Float = -25;
			for (i in 0...num) {
				if (i % 3 == 0) {
					coordY = 0;
					coordX += xOffset;
				} 
				var text:TextFields = new TextFields((stage.stageWidth + fieldWidth) / 2 + coordX,
				stage.stageHeight / 3 + coordY);
				addChild (text);
				textFieldsArr.push(text);
				trace(textFieldsArr.length);
				coordY += yOffset;
			}
		}
		
		private function pushItems () {
			var i:Int = 0;
			var trgtArr:Array<Int>;
			for (i in 0...textFieldsArr.length){
				var val = textFieldsArr[i].getLineText(0);
				if (0 <= i && i < 3) {
						trgtArr = firstColItems;
					} else if (3 <= i && i < 6) {
						trgtArr = secondColItems;
					} else {
						trgtArr = thirdColItems;
					}
				switch(val) {
					case "cherry": trgtArr.push(cherry);
					case "lemon": trgtArr.push(lemon);
					case "apple": trgtArr.push(apple);
					case "grape": trgtArr.push(grape);
					default: trgtArr.push(question);
				}
				trace(trgtArr.length);
			}
		}
		
		private function colItems(items:Array<Int>, colNum:Int, characters:Array<Character>){
			var offset:Int = 0;
			var colWidth:Int = 150;
			var i:Int = 0;
			var step = new haxe.Timer (150);
			cnt ++;
			if (colNum == 2){
				offset += colWidth;
			} else if (colNum == 3){
				offset = colWidth*2;
			}
			step.run = function () {
				var posX:Float = (stage.stageWidth - fieldWidth)/2 + offset;
				var posY:Float = (stage.stageHeight/100)*20;
				var velY:Float = 9.5;
				var char:Character = new Character(items[i], posX, posY, velY);
				tilemap.addTile(char);
				characters[i] = char;
				i++;
				if (i == items.length) {
					characters[characters.length - 1].velocity.y = 0;
					characters[characters.length - 2].velocity.y = 0;
					characters[characters.length - 3].velocity.y = 0;
					step.stop();
					if (cnt == 3) {
						spinButton.addEventListener(MouseEvent.MOUSE_DOWN, spinStart);
						cnt = 0;
					}
				} 
			}
		}
		
		private function startState(item:Int) {
			var posX:Float = (stage.stageWidth - fieldWidth)/2;
			var posY:Float = (stage.stageHeight/100)*20;
			var velY:Float = 0;
			var state:Character = new Character(item, posX, posY, velY);
			tilemap.addTile(state);
		}
		
		private function animate (colChars:Array<Character>) {
			
			colChars[colChars.length - 1].velocity.y = 9.5;
			colChars[colChars.length - 2].velocity.y = 9.5;
			colChars[colChars.length - 3].velocity.y = 9.5;
			
		}
		
		private function spinStart(e:Event) {
			pushItems ();
			spinButton.removeEventListener(MouseEvent.MOUSE_DOWN, spinStart);
			var curState:Tile = tilemap.getTileAt(0);
			curState.visible = false;
			colItems(firstColItems, 1, firstColChars);
			colItems(secondColItems, 2, secondColChars);
			colItems(thirdColItems, 3, thirdColChars);
			animate (firstColChars);
			animate (secondColChars);
			animate (thirdColChars);
			
		}
		
		private function onFrame(e:Event){
		for (char in firstColChars){
			char.y += char.velocity.y;
			if(char.y > stage.stageHeight && char.velocity.y > 0){
				char.velocity.y = 0;
				char.visible = false;
			}
		}
		for (char in secondColChars){
			char.y += char.velocity.y;
			if(char.y > stage.stageHeight && char.velocity.y > 0){
				char.velocity.y = 0;
				char.visible = false;
			}
		}
		for (char in thirdColChars){
			char.y += char.velocity.y;
			if(char.y > stage.stageHeight && char.velocity.y > 0){
				char.velocity.y = 0;
				char.visible = false;
			}
		}
	}
}