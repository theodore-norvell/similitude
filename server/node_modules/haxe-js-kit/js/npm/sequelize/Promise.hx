package js.npm.sequelize;

// Sequelize uses bluebird for promises.
// TODO - extern for bluebird
@:native("Promise")
extern class Promise {
	public function then(cb:Dynamic):Promise;
	@:native("catch")
	function Catch(cb:Dynamic):Promise;
	@:native("try")
	public static function Try(f:Dynamic):Promise;
	function new(f:Dynamic);
	
	static function resolve(v:Dynamic):Promise;
	static function reject( ?value : Dynamic ) : Promise;
}