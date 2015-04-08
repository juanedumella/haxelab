package lime;


import lime.utils.Assets;


class AssetData {

	private static var initialized:Bool = false;
	
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var path = new #if haxe3 Map <String, #else Hash <#end String> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();	
	
	public static function initialize():Void {
		
		if (!initialized) {
			
			path.set ("assets/data/data-goes-here.txt", "assets/data/data-goes-here.txt");
			type.set ("assets/data/data-goes-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/level00.oel", "assets/data/level00.oel");
			type.set ("assets/data/level00.oel", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/tranzanfuk.oep", "assets/data/tranzanfuk.oep");
			type.set ("assets/data/tranzanfuk.oep", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/images/coin.png", "assets/images/coin.png");
			type.set ("assets/images/coin.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/enemy-0.png", "assets/images/enemy-0.png");
			type.set ("assets/images/enemy-0.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/enemy-1.png", "assets/images/enemy-1.png");
			type.set ("assets/images/enemy-1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/health.png", "assets/images/health.png");
			type.set ("assets/images/health.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/images-go-here.txt", "assets/images/images-go-here.txt");
			type.set ("assets/images/images-go-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/images/louse.png", "assets/images/louse.png");
			type.set ("assets/images/louse.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/manito.png", "assets/images/manito.png");
			type.set ("assets/images/manito.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/player.png", "assets/images/player.png");
			type.set ("assets/images/player.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/pointer.png", "assets/images/pointer.png");
			type.set ("assets/images/pointer.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/tiles.png", "assets/images/tiles.png");
			type.set ("assets/images/tiles.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/music/music-goes-here.txt", "assets/music/music-goes-here.txt");
			type.set ("assets/music/music-goes-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/sounds/sounds-go-here.txt", "assets/sounds/sounds-go-here.txt");
			type.set ("assets/sounds/sounds-go-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/sounds/beep.ogg", "assets/sounds/beep.ogg");
			type.set ("assets/sounds/beep.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/flixel.ogg", "assets/sounds/flixel.ogg");
			type.set ("assets/sounds/flixel.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			
			
			initialized = true;
			
		} //!initialized
		
	} //initialize
	
	
} //AssetData
