package js.npm.sequelize;
import atomshell.Package;
import haxe.Constraints.Function;
import js.npm.sequelize.Promise;

typedef SequelizeOptions = {
	?dialect:String,
	?dialectModulePath:String,
	?dialectOptions: Dynamic,
	?storage:String,
	?host:String,
	?port:Int,
	?protocol:String,
	?define: { },
	?query: { },
	?set: { },
	?sync: { },
	?timezone:String,
	?logging:Dynamic,
	?omitNull:Bool,
	?native:Bool,
	?replication:Bool,
	?pool: {
		?max:Int,
		?min:Int,
		?idle:Int,
		?validateConnection:Dynamic
	},
	?quoteIdentifiers:Bool
}

typedef SyncOptions = {
	?force:Bool,
	?match:String,
	?logging:Dynamic,
	?schema:String,
}

typedef QueryOptions = {
	raw:Bool,
	transaction:Transaction,
	type:String,
	nest:Bool,
	plain:Bool,
	replacements:Dynamic,
	useMaster:Bool
}

typedef TransactionOptions = {
	?autocommit:Bool,
	?isolationLevel:String
}

typedef ModelDefinition = Dynamic<ModelAttributes>;
typedef ModelAttributes = {
    type:DataTypes,
	?field:String,			// If set, sequelize will map the attribute name to a different name in the database
	?defaultValue:Dynamic,	// A literal default value, a javascript function, or an SQL function
	?allowNull:Bool,		// default: true
    ?unique:Bool,			// default: false
	?primaryKey:Bool,		// default: false
	?autoIncrement:Bool,
	?comment:String,
	?references:Dynamic,		// (Strign|Model)	If this column references another table, provide it here as a Model, or a string
	?referencesKey:String,	// default:id 	The column of the foreign table that this column references
	?onUpdate:OnAction,		// What should happen when the referenced key is updated. 
	?onDelete:OnAction,		// What should happen when the referenced key is deleted. 
	?get:Void->Dynamic,		// Provide a custom getter for this column. Use this.getDataValue(String) to manipulate the underlying values.
	?set:Dynamic->Void,		// Provide a custom setter for this column. Use this.setDataValue(String, Value) to manipulate the underlying values.
	?validate:{},
	?states: {
		type:String,
		values:Array<String>
	},
}

@:enum abstract OnAction(String){
	var CASCADE = "CASCADE";
	var RESTRICT = "RESTRICT";
	var SET_DEFAULT = "SET DEFAULT";
	var SET_NULL = "SET NULL";
	var NO_ACTION = "NO ACTION";
}

typedef ModelOptions = {
	?timestamps:Bool,		// default: true -  Adds createdAt and updatedAt timestamps to the model.
	?createdAt:Dynamic,		// bool or string - Override the name of the createdAt column if a string is provided, or disable it if false. Timestamps must be true
	?updatedAt:Dynamic,		// bool or string - Override the name of the updatedAt column if a string is provided, or disable it if false. Timestamps must be true
	?deletedAt:Dynamic,		// bool or string - Override the name of the deletedAt column if a string is provided, or disable it if false. Timestamps must be true
	?tableName:String, 		// Defaults to pluralized model name, unless freezeTableName is true, in which case it uses model name verbatim
	?getterMethods:Dynamic,	// Provide getter functions that work like those defined per column. If you provide a getter method with the same name as a column, it will be used to access the value of that column. If you provide a name that does not match a column, this function will act as a virtual getter, that can fetch multiple other values
	?setterMethods:Dynamic,	// Provide setter functions that work like those defined per column. If you provide a setter method with the same name as a column, it will be used to update the value of that column. If you provide a name that does not match a column, this function will act as a virtual setter, that can act on and set other values, but will not be persisted
	?instanceMethods:Dynamic, // Provide functions that are added to each instance (DAO). If you override methods provided by sequelize, you can access the original method using this.constructor.super_.prototype, e.g. this.constructor.super_.prototype.toJSON.apply(this, arguments)
	?classMethods:Dynamic,	// Provide functions that are added to the model (Model). If you override methods provided by sequelize, you can access the original method using this.constructor.prototype, e.g. this.constructor.prototype.find.apply(this, arguments)
	?schema:String,			 
	?engine:String,
	?charset:String,
	?comment:String, 		
	?collate:String,
	?initialAutoIncrement:String, // Set the initial AUTO_INCREMENT value for the table in MySQL.
	?paranoid:Bool,	 		// default:false  - Calling destroy will not delete the model, but instead set a deletedAt timestamp if this is true. Needs timestamps=true to work
	?underscored:Bool, 		// default:false - Converts camelCased columns to underscored.
	?underscoredAll:Bool, 	// default:false - Converts all camelCased model names to underscored .
	?freezeTableNames:Bool,	// default:false - If freezeTableName is true, sequelize will not try to alter the DAO name to get the table name. Otherwise, the dao name will be pluralized
	?name:String,			// An object with two attributes, singular and plural, which are used when this model is associated to others.
	?ommitNull:Bool, 		// Don't persits null values. This means that all columns with null values will not be saved
	?defaultScope: { },		// Define the default search scope to use for this model. Scopes have the same form as the options passed to find / findAll
	?scopes: { },			// More scopes, defined in the same way as defaultScope above. See Model.scope for more information about how scopes are defined, and what you can do with them
	?indexes: Array<Index>,
	?Hooks:Dynamic,			// An object of hook function that are called before and after certain lifecycle events. The possible hooks are: beforeValidate, afterValidate, beforeBulkCreate, beforeBulkDestroy, beforeBulkUpdate, beforeCreate, beforeDestroy, beforeUpdate, afterCreate, afterDestroy, afterUpdate, afterBulkCreate, afterBulkDestory and afterBulkUpdate. See Hooks for more information about hook functions and their signatures. Each property can either be a function, or an array of functions.
	?validate:Dynamic		// An object of model wide validations. Validations have access to all model values via this. If the validator function takes an argument, it is asumed to be async, and is called with a callback that accepts an optional error.
}

typedef Index = {
	?name:String,			// The name of the index. Defaults to model name + _ + fields concatenated
	?type:String,			// Index type. Only used by mysql. One of UNIQUE, FULLTEXT and SPATIAL
	?method:String,			// The method to create the index by (USING statement in SQL). BTREE and HASH are supported by mysql and postgres, and postgres additionally supports GIST and GIN.
	?unique:Bool,			// Should the index by unique? Can also be triggered by setting type to UNIQUE
	?concurrently:Bool,		// default - false: PostgreSQL will build the index without taking any write locks. Postgres only
	?fields:Array<Dynamic>, // An array of the fields to index. Each field can either be a string containing the name of the field, a sequelize object (e.g sequelize.fn), or an object with the following attributes: attribute (field name), length (create a prefix index of length chars), order (the direction the column should be sorted in), collate (the collation (sort order) for the column)
}

/**
 * Sequelize
 * @author TiagoLr
 */
extern class Sequelize
implements npm.Package.Require < "sequelize", "^3.0.0" > {
	
	// DATATYPES
	static var STRING:String;		
	static var CHAR:String;          
	static var TEXT:String;  		
	static var INTEGER:String;  	
	static var BIGINT:String;   		
	static var FLOAT:String;  	
	static var DECIMAL:String;	
	static var BOOLEAN:String; 		
	static var TIME:String;
	static var DATE:String;    
	static var DATEONLY:String;
	static var HSTORE:String;
	static var JSON:String; 		
	static var JSONB:String;
	static var NOW:String;
	static var BLOB:String;
	static var RANGE:String;
	static var UUID:String;
	static var UUIDV1:String;
	static var UUIDV4:String;
	static var VIRTUAL:String;
	static var ENUM:String; 		
	static var ARRAY:String;		
	
	function new(?database:String, ?username:String, ?password:String, ?options: SequelizeOptions );
	function define(tableName:String, fields:ModelDefinition, ?options:ModelOptions):Model;
	function sync(?options:SyncOptions):Promise;
	function query(sql:String, ?instanceOrModel:Dynamic, ?options: QueryOptions ):Promise;
	function set(variables:Dynamic, options: { } ):Promise;
	function escape(value:String):String;
	
	// postgres only
	function createSchema(schema:Dynamic):Promise; 
	function showAllSchemas():Promise; 
	function dropAllSchemas():Promise;
	//
	
	function drop(options: { } ):Promise;
	function authenticate():Promise;
	function transaction(?f:Transaction->Promise, ?options: TransactionOptions ):Promise;
}
