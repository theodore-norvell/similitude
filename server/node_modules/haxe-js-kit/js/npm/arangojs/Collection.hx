package js.npm.arangojs;
import js.support.Either;

typedef CollectionMetadata = {
	error : Bool,
	_id : String,
	_rev: String,
	_key: String
}

typedef CollectionImportResult = {
	error : Bool,
	created : Int,
	errors : Int,
	empty : Int,
	updated : Int,
	ignored : Int
}

@:enum abstract CollectionListType(String) from String to String {
	var id = "id";
	var key = "key";
	var path = "path";
}

extern class Collection
{
	// Getting information about the collection

	public function get(cb : ArangoCallback<{}>) : Void;
	public function properties(cb : ArangoCallback<{}>) : Void;
	public function count(cb : ArangoCallback<Int>) : Void;
	public function figures(cb : ArangoCallback<{}>) : Void;
	public function revision(cb : ArangoCallback<String>) : Void;	
	@:overload(function(cb : ArangoCallback<{}>) : Void {})
	public function checksum(opts : {}, cb : ArangoCallback<{}>) : Void;

	// Manipulating the collection

	@:overload(function(cb : ArangoCallback<{}>) : Void {})
	public function create(properties : {}, cb : ArangoCallback<{}>) : Void;
	@:overload(function(cb : ArangoCallback<{}>) : Void {})
	public function load(count : Bool, cb : ArangoCallback<{}>) : Void;
	public function unload(cb : ArangoCallback<{}>) : Void;
	public function setProperties(properties : {}, cb : ArangoCallback<{}>) : Void;
	public function rename(name : String, cb : ArangoCallback<{}>) : Void;
	public function rotate(cb : ArangoCallback<{}>) : Void;
	public function truncate(cb : ArangoCallback<{}>) : Void;
	public function drop(cb : ArangoCallback<{}>) : Void;

	// Manipulating indexes

	public function createIndex(details : {}, cb : ArangoCallback<{}>) : Void;
	public function createCapConstraint(size : { }, cb : ArangoCallback<{}>) : Void;
	@:overload(function(fields : Array<String>, cb : ArangoCallback<{}>) : Void {})
	public function createHashIndex(fields : Array<String>, opts : {}, cb : ArangoCallback<{}>) : Void;
	@:overload(function(fields : Array<String>, cb : ArangoCallback<{}>) : Void {})
	public function createSkipList(fields : Array<String>, opts : {}, cb : ArangoCallback<{}>) : Void;
	@:overload(function(fields : Array<String>, cb : ArangoCallback<{}>) : Void {})
	public function createGeoIndex(fields : Array<String>, opts : {}, cb : ArangoCallback<{}>) : Void;
	@:overload(function(fields : Array<String>, cb : ArangoCallback<{}>) : Void {})
	public function createFulltextIndex(fields : Array<String>, minLength : Int, cb : ArangoCallback<{}>) : Void;
	public function index(indexHandle : String, cb : ArangoCallback<{}>) : Void;
	public function indexes(cb : ArangoCallback<Array<{}>>) : Void;
	public function dropIndex(indexHandle : String, cb : ArangoCallback<{}>) : Void;

	// Simple queries

	@:overload(function<T>(cb : ArangoCallback<Cursor<T>>) : Void {})
	public function all<T>(opts : {}, cb : ArangoCallback<Cursor<T>>) : Void;
	public function any<T>(cb : ArangoCallback<T>) : Void;
	@:overload(function<T>(cb : ArangoCallback<Array<T>>) : Void {})
	public function first<T>(opts : Either<{}, Int>, cb : ArangoCallback<Array<T>>) : Void;
	@:overload(function<T>(cb : ArangoCallback<Array<T>>) : Void {})
	public function last<T>(opts : Either<{}, Int>, cb : ArangoCallback<Array<T>>) : Void;
	@:overload(function<T>(example : {}, cb : ArangoCallback<Cursor<T>>) : Void {})
	public function byExample<T>(example : {}, opts : {}, cb : ArangoCallback<Cursor<T>>) : Void;
	public function firstExample<T>(example : {}, cb : ArangoCallback<T>) : Void;

	@:overload(function(example : {}, cb : ArangoCallback<{}>) : Void {})
	public function removeByExample(example : {}, opts : {}, cb : ArangoCallback<{}>) : Void;
	@:overload(function(example : {}, newValue : {}, cb : ArangoCallback<{}>) : Void {})
	public function replaceByExample(example : {}, newValue : {}, opts : {}, cb : ArangoCallback<{}>) : Void;
	@:overload(function(example : {}, newValue : {}, cb : ArangoCallback<{}>) : Void {})
	public function updateByExample(example : {}, newValue : {}, opts : {}, cb : ArangoCallback<{}>) : Void;
	public function lookupByKeys(keys : Array<String>, cb : ArangoCallback<{}>) : Void;
	@:overload(function(keys : Array<String>, cb : ArangoCallback<{}>) : Void {})
	public function removeByKeys(keys : Array<String>, opts : {}, cb : ArangoCallback<{}>) : Void;

	@:overload(function<T>(fieldName : String, query : String, cb : ArangoCallback<Cursor<T>>) : Void {})
	public function fulltext<T>(fieldName : String, query : String, opts : {}, cb : ArangoCallback<Cursor<T>>) : Void;

	// Bulk importing documents

	// Unfortunately import is a reserved word, so this method has to be static.
	@:overload(function<T>(collection : Collection, data : Array<T>, cb : ArangoCallback<CollectionImportResult>) : Void {})
	@:overload(function<T>(collection : Collection, data : Array<T>, opts : {}, cb : ArangoCallback<CollectionImportResult>) : Void {})
	@:overload(function<T>(collection : Collection, data : Array<Array<T>>, cb : ArangoCallback<CollectionImportResult>) : Void {})
	public static inline function importData<T>(collection : Collection, data : Array<Array<T>>, opts : {}, cb : ArangoCallback<CollectionImportResult>) : Void {
		untyped collection['import'](data, opts, cb);
	}
	
	// Manipulating documents

	@:overload(function(documentHandle : Either<String, {}>, newValue : {}, cb : ArangoCallback<CollectionMetadata>) : Void {})
	public function replace(documentHandle : Either<String, {}>, newValue : {}, opts : {}, cb : ArangoCallback<CollectionMetadata>) : Void;
	@:overload(function(documentHandle : Either<String, {}>, newValue : {}, cb : ArangoCallback<CollectionMetadata>) : Void {})
	public function update(documentHandle : Either<String, {}>, newValue : {}, opts : {}, cb : ArangoCallback<CollectionMetadata>) : Void;
	@:overload(function(documentHandle : Either<String, {}>, cb : ArangoCallback<CollectionMetadata>) : Void {})
	public function remove(documentHandle : Either<String, {}>, opts : {}, cb : ArangoCallback<CollectionMetadata>) : Void;
	@:overload(function(cb : ArangoCallback<Array<String>>) : Void {})
	public function list(type : CollectionListType, cb : ArangoCallback<Array<String>>) : Void;
}
