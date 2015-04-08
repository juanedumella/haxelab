package;

import componentes.Coin;
import componentes.CombatHUD;
import componentes.Enemy;
import componentes.HUD;
import componentes.Player;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.XboxButtonID;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.ui.FlxVirtualPad;
import flixel.util.FlxMath;
import flixel.util.FlxDestroyUtil;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	// Define el Jugador
	private var _player:Player;
	
	// define enemigos	
	private var _grpEnemies:FlxTypedGroup<Enemy>;
	
	// Define Monedas 
	private var _grpCoins:FlxTypedGroup<Coin>;
	
	// Define Mapa de Juego 
	private var _map:FlxOgmoLoader;
	
	// Define Muros
	private var _mWalls:FlxTilemap;
	
	// TEST Piojo
	private var _sprlouse:FlxSprite;	
	
	// Define Panel de Juego
	private var _hud:HUD;
	private var _money:Int = 0;
	private var _health:Int = 3;
	
	// Define Panel de Combate
	private var _inCombat:Bool = false;
	private var _combatHud:CombatHUD;
	
	// Defino Joystick Virutal
		
	#if mobile
		public static var virtualPad:FlxVirtualPad;
	#end
	
	// tecla Escape
	var _esc:Bool = false;
	
	override public function create():Void
	{
		super.create();
		
		
		//_player = new Player(20,20);
		// Configuracion de Escenario
		_map = new FlxOgmoLoader(AssetPaths.level00__oel);
		_mWalls = _map.loadTilemap(AssetPaths.tiles__png, 16, 16, "walls");
		_mWalls.setTileProperties(1, FlxObject.NONE);
		_mWalls.setTileProperties(2, FlxObject.ANY);
		add(_mWalls);		
		
		// Creamos las Monedas
		_grpCoins = new FlxTypedGroup<Coin>();
		add(_grpCoins);
		
		// Creamos Enemigos
		_grpEnemies = new FlxTypedGroup<Enemy>();
		add(_grpEnemies);
		
		// Creamos Jugador
		_player = new Player();
		_map.loadEntities(placeEntities, "entities");
		FlxG.camera.follow(_player, FlxCamera.STYLE_TOPDOWN, 1); // La Camara sigue al Jugador
		add(_player);
		
		// Creamos Panel de Juego
		_hud = new HUD();
		add(_hud);
		
		// Creamos Panel de Combate	
		_combatHud = new CombatHUD();
		add(_combatHud);
		
		// TEST Piojo
		_sprlouse = new FlxSprite().loadGraphic(AssetPaths.louse__png, true, 32, 32);
		_sprlouse.x = 300;
		_sprlouse.y = 300;
		add(_sprlouse);
		
		#if mobile
		virtualPad = new FlxVirtualPad(FULL, NONE);	
		virtualPad.alpha = 0.50;
		add(virtualPad);
		#end

	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
		_player = FlxDestroyUtil.destroy(_player);
		_mWalls = FlxDestroyUtil.destroy(_mWalls);
		_grpCoins = FlxDestroyUtil.destroy(_grpCoins);
		_grpEnemies = FlxDestroyUtil.destroy(_grpEnemies);
		_hud = FlxDestroyUtil.destroy(_hud);
		_combatHud = FlxDestroyUtil.destroy(_combatHud);
		
		#if mobile
		virtualPad = FlxDestroyUtil.destroy(virtualPad);
		#end
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		
		// 
		// Important: can be null if there's no active gamepad yet!
       // _gamePad = FlxG.gamepads.lastActive;

        //if (_gamePad != null)
        /*{
            gamepadControls();
        }*/
		
		// Validacion de Salida
		_esc = FlxG.keys.anyPressed(["ESCAPE", "ESCAPE"]);	
		
		if (_esc) {		
				
				FlxG.switchState(new MenuState());
		}
		
		// Combate
		if (!_inCombat) {
			FlxG.collide(_player, _mWalls);
			FlxG.collide(_grpEnemies, _mWalls);
			checkEnemyVision();
			FlxG.overlap(_player, _grpEnemies, playerTouchEnemy);
			FlxG.overlap(_player, _grpCoins, playerTouchCoin);
		} else {
			if (!_combatHud.visible){
				_health = _combatHud.playerHealth;
				_hud.updateHUD(_health, _money);
				if (_combatHud.outcome == VICTORY){
					_combatHud.e.kill();
				}
				else{
					//_combatHud.e.flicker();
				}
				#if mobile
					virtualPad.visible = true;
				#end
				_inCombat = false;
				_player.active = true;
				_grpEnemies.active = true; 
			}
		}	
		
		
		//FlxG.collide(_player, _mWalls);
		//FlxG.overlap(_player, _grpCoins, playerTouchCoin);
		_player.movement();
		//FlxG.collide(_grpEnemies, _mWalls);
		//_grpEnemies.forEachAlive(checkEnemyVision());
		
	}	
	
	// Posicionamiento de Entidades del Juego
	private function placeEntities(entityName:String, entityData:Xml):Void {
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		if (entityName == "player"){
			_player.x = x;
			_player.y = y;
		} else if (entityName == "coin") {
			_grpCoins.add(new Coin(Std.parseInt(entityData.get("x")) + 4, Std.parseInt(entityData.get("y")) + 4));
			
		} else if (entityName == "enemy"){
			_grpEnemies.add(new Enemy(x + 4, y, Std.parseInt(entityData.get("etype"))));
		}
	}
	
	
	private function playerTouchCoin(P:Player, C:Coin):Void {
		if (P.alive && P.exists && C.alive && C.exists){
			C.kill();
			_money++;
			_hud.updateHUD(_health, _money);
		}
	}
	
	private function checkEnemyVision():Void {
		for (e in _grpEnemies.members){
			if (_mWalls.ray(e.getMidpoint(), _player.getMidpoint())){
				e.seesPlayer = true;
				e.playerPos.copyFrom(_player.getMidpoint());
			} else
				e.seesPlayer = false;
		}
	}
	
	private function playerTouchEnemy(P:Player, E:Enemy):Void {
		if (P.alive && P.exists && E.alive && E.exists  ){
			startCombat(E);
		}
	}

	private function startCombat(E:Enemy):Void{
		_inCombat = true;
		_player.active = false;
		_grpEnemies.active = false;
		_combatHud.initCombat(_health, E);
		#if mobile
		virtualPad.visible = false;
		#end
	}
	
	/*private function gamepadControls():Void {
		
        if (_gamePad.pressed(XboxButtonID.A))
        {
            trace("The A button of the Xbox 360 controller is pressed.");
        }

        if (_gamePad.getAxis(XboxButtonID.LEFT_ANALOGUE_X) != 0)
        {
            trace("The x axis of the left analogue stick of the Xbox 360 controller has been moved.");
        }
    }*/
}