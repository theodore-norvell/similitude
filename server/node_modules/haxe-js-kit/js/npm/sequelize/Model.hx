package js.npm.sequelize;
import atomshell.Package;

typedef DropOptions = {
	?cascade:Bool // postgres only
}

typedef SchemaOptions = {
	?schemaDelimiter:String
}

typedef CreateOptions = {
	?raw:Bool,
	?isNewRecord:Bool,
	?isDirty:Bool,
	?fields:Array<Dynamic>,
	?include:Array<Dynamic>,
	?onDuplicate:String,
	?transaction:Transaction
}

typedef HasOneOptions = {
	hooks:Bool,
	as:Dynamic,
	foreignKey:Dynamic,
	onDelete:String,
	onUpdate:String,
	constrains:Bool
}

typedef BelongsToOptions = {
	hooks:Bool,
	as:Dynamic,
	foreignKey:Dynamic,
	onDelete:String,
	onUpdate:String,
	constrains:Bool
}

typedef HasManyOptions = {
	hooks:Bool,
	through:Dynamic,
	as:String,
	foreignKey:Dynamic,
	scope:Dynamic,
	onDelete:String,
	onUpdate:String,
	constrains:Bool
}

typedef BelongsToManyOptions = {
	hooks:Bool,
	throught:Dynamic,
	as:Dynamic,
	foreignKey:Dynamic,
	scope:Dynamic,
	onDelete:String,
	onUpdate:String,
	constrains:Bool
}

/**
 * Sequelize
 * @author TiagoLr
 */
extern class Model {
	
	
	function hasOne(target:Model, ?options: { } ):Void;
	function belongsTo(target:Model, ?options : { ?as: Dynamic, ?foreignKey:String } ):Void;
	function hasMany(target:Model, ?options: { } ):Void;
	function belongsToMany(target:Model, ?options: { } ):Void;
	
	function addHook(hookType:String, cb:Void->Void):Void;

	function removeAttribute(attribute:String):Void;
	function sync(?options:Sequelize.SyncOptions):Promise;
	function drop(?options:DropOptions):Promise;
	function schema(schema:String, ?options:SchemaOptions):Model;
	function getTableName(options:{}):Dynamic;
	function create(values: { }, ?options:CreateOptions):Promise; // creates and saves a record
	function bulkCreate(values: { }, ?options:CreateOptions):Promise;
	function build(values: { }, ?options:CreateOptions):Instance; // creates but does not save a record
	function find(?args: { }, ?queryOptions:{} ):Promise;
	function findAndCount(?findOptions: { }, ?queryOptions:{} ):Promise;
	function findAll(?args: { }, ?queryOptions: { } ):Promise;
	function findOrInitialize(options: { } ):Promise;
	function findOrCreate(options: { }, ?queryOptions:{}):Promise;
	function upsert(values:Dynamic, ?options: { } ):Promise;
	function aggregate(field:String, aggregateFunction:String, ?options:{}):Promise;
	function count(?options: { } ):Promise;
	function max(field:String, ?options: { } ):Promise;
	function min(field:String, ?options: { } ):Promise;
	function sum(field:String, ?options: { } ):Promise;
	function destroy(options: { } ):Promise;
	function restore(options: { } ):Promise;
	function update(values:Dynamic, options:Dynamic):Promise;
	function describe():Promise;
	
}