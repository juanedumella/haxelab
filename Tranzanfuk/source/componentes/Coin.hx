package componentes;

import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author jemella
 */
class Coin extends FlxSprite
{

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		try {
			loadGraphic(AssetPaths.coin__png, true, 8, 8); // Cargamos Monedas
		} catch (msg :String ){
			trace(">> Error: " + msg);
		}
	}
	
	
	override public function kill():Void{
		alive = false;		
		FlxTween.tween(this, { alpha:0, y:y - 16 }, .66, { type:FlxTween.ONESHOT, ease:FlxEase.circOut, complete:finishKill } );
	}

	private function finishKill(T:FlxTween):Void {
		exists = false;
	}
}