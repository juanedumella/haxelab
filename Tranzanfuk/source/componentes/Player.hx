package componentes;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.ui.FlxVirtualPad;
import flixel.util.FlxAngle;
import flixel.util.FlxColor;
import flixel.FlxG;


/**
 * ...
 * @author jemella
 */
class Player extends FlxSprite
{

	private var _player:Player;
	private var speed:Float = 200;
	var _up:Bool = false;
	var _down:Bool = false;
	var _left:Bool = false;
	var _right:Bool = false;
	var _esc:Bool = false;
	
	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		drag.x = drag.y = 1600; 
		setSize(8, 14);
		offset.set(4, 2);
		//makeGraphic(16, 16, FlxColor.BLUE);
		loadGraphic(AssetPaths.player__png, true, 16, 16); // Cargamos Monito		
		//
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		// Definir Animacion
		animation.add("lr", [3, 4, 3, 5], 6, false);
		animation.add("u", [6, 7, 6, 8], 6, false);
		animation.add("d", [0, 1, 0, 2], 6, false);
		
		
		
	}
	
	// Funcion que permite administrar el movimiento del jugador
	public function movement():Void {
		
		/*_up = FlxG.keys.anyPressed(["UP", "W"]);
		_down = FlxG.keys.anyPressed(["DOWN", "S"]);
		_left = FlxG.keys.anyPressed(["LEFT", "A"]);
		_right = FlxG.keys.anyPressed(["RIGHT", "D"]);
		_esc = FlxG.keys.anyPressed(["ESCAPE", "ESCAPE"]);*/
		
		#if !FLX_NO_KEYBOARD
		_up = FlxG.keys.anyPressed(["UP", "W"]);
		_down = FlxG.keys.anyPressed(["DOWN", "S"]);
		_left = FlxG.keys.anyPressed(["LEFT", "A"]);
		_right = FlxG.keys.anyPressed(["RIGHT", "D"]);
		_esc = FlxG.keys.anyPressed(["ESCAPE", "ESCAPE"]);
		#end
		#if mobile
		_up = _up || PlayState.virtualPad.buttonUp.status == FlxButton.PRESSED;
		_down = _down || PlayState.virtualPad.buttonDown.status == FlxButton.PRESSED;
		_left  = _left || PlayState.virtualPad.buttonLeft.status == FlxButton.PRESSED;
		_right = _right || PlayState.virtualPad.buttonRight.status == FlxButton.PRESSED;
		#end
		

		
		if ((_up && _down)){ 
			_up = _down = false;
			
		}	
		if ((_left && _right) ) {
			
			_left = _right = false;
			
		}
		if ( _up || _down || _left || _right ){
			velocity.x = speed;
			velocity.y = speed;	
			var mA:Float = 0;
			if (_up ){
				mA = -90;
			if (_left)
				mA -= 45;
			else if (_right)
				mA += 45;
			facing = FlxObject.UP;	
			}
			else if (_down ){
			mA = 90;
			if (_left )
				mA += 45;
			else if (_right )
				mA -= 45;
			facing = FlxObject.DOWN;	
			}
			else if (_left ){
				mA = 180;
				facing = FlxObject.LEFT;
			}	
			else if (_right ){
				mA = 0;
				facing = FlxObject.RIGHT;
			}	
			FlxAngle.rotatePoint(speed, 0, 0, 0, mA, velocity);	
			
			if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE) {// if the player is moving (velocity is not 0 for either axis), we need to change the animation to match their facing

				switch(facing){
					case FlxObject.LEFT, FlxObject.RIGHT:
					animation.play("lr");
					case FlxObject.UP:
					animation.play("u");
					case FlxObject.DOWN:
					animation.play("d");
				}
			}
		}
	}
	
	
	
}