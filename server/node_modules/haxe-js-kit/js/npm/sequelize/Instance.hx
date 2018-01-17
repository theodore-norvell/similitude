package js.npm.sequelize;

typedef GetDataOptions = {
	?plain:Bool,
}

typedef SetDataOptions = {
	?raw:Bool,
	?reset:Bool,
	?include:Dynamic
	
}

typedef SaveChangesOptions = {
	?fields:Array<String>,
	?silent:Bool,
	?validate:Bool,
	?transaction:Dynamic
}

typedef DestroyOptions = {
	?force:Bool,
	?transaction:Transaction,
}

typedef RestoreOptions = {
	?transaction:Transaction
}

typedef IncrementOptions = {
	?by:Int,
	?transaction:Transaction
}

extern class Instance {
	
	var isNewRecord:Bool;
	
	function model():Model;
	function sequelize():Sequelize;
	function isDeleted():Bool;
	function isDirty():Bool;
	function primaryKeyValues():Dynamic;
	function getDataValue(key:String):Dynamic;
	function setDataValue(key:String, value:Dynamic):Void;
	function get(key:String, ?options:GetDataOptions):Dynamic;
	function set(key:String, value:Dynamic, ?options:SetDataOptions):Dynamic;
	
	@:overload(function():Array<String>{})
	function changed(key:String):Bool;
	function previous(key:String):Dynamic;
	function save(options:SaveChangesOptions):Promise;
	function reload(options:Dynamic):Promise;
	function validate(options:Dynamic):Promise;
	
	function update(updates:Dynamic, ?options:Dynamic):Promise;
	function destroy(?options: DestroyOptions ):Promise;
	function restore(?options: RestoreOptions ):Promise;
	function increment(?options: IncrementOptions):Promise;
	function decrement(?options: IncrementOptions):Promise;
	function equals(other:Instance):Bool;
	function equalsOneOf(others:Array<Instance>):Bool;
	function toJSON():Dynamic;
	
	
}