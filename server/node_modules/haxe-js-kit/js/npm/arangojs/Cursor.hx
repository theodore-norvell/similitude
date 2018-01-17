package js.npm.arangojs;

extern class Cursor<T>
{
	public var count(default, never) : Null<Int>;
	
	public function all(cb : ArangoCallback<Array<T>>) : Void;
	public function next(cb : ArangoCallback<T>) : Void;
	public function hasNext() : Bool;

	@:overload(function( fn : T -> Void, ?cb : ArangoCallback<T>) : Void {})
	@:overload(function( fn : T -> Bool, ?cb : ArangoCallback<T>) : Void {})
	@:overload(function( fn : T -> Int -> Void, ?cb : ArangoCallback<T>) : Void {})
	@:overload(function( fn : T -> Int -> Bool, ?cb : ArangoCallback<T>) : Void {})
	@:overload(function( fn : T -> Int -> Cursor<T> -> Void, ?cb : ArangoCallback<T>) : Void {})
	public function each(fn : T -> Int -> Cursor<T> -> Bool, ?cb : ArangoCallback<T>) : Void;

	@:overload(function(  fn : T -> Void, cb : ArangoCallback<Bool>) : Void {})
	@:overload(function(  fn : T -> Bool, cb : ArangoCallback<Bool>) : Void {})
	@:overload(function(  fn : T -> Int -> Void, cb : ArangoCallback<Bool>) : Void {})
	@:overload(function(  fn : T -> Int -> Bool, cb : ArangoCallback<Bool>) : Void {})
	@:overload(function(  fn : T -> Int -> Cursor<T> -> Void, cb : ArangoCallback<Bool>) : Void {})
	public function every(fn : T -> Int -> Cursor<T> -> Bool, cb : ArangoCallback<Bool>) : Void;

	@:overload(function( fn : T -> Void, cb : ArangoCallback<Bool>) : Void {})
	@:overload(function( fn : T -> Bool, cb : ArangoCallback<Bool>) : Void {})
	@:overload(function( fn : T -> Int -> Void, cb : ArangoCallback<Bool>) : Void {})
	@:overload(function( fn : T -> Int -> Bool, cb : ArangoCallback<Bool>) : Void {})
	@:overload(function( fn : T -> Int -> Cursor<T> -> Void, cb : ArangoCallback<Bool>) : Void {})
	public function some(fn : T -> Int -> Cursor<T> -> Bool, cb : ArangoCallback<Bool>) : Void;

	@:overload(function<T2>(fn : T -> T2, cb : ArangoCallback<Array<T2>>) : Void {})
	@:overload(function<T2>(fn : T -> Int -> T2, cb : ArangoCallback<Array<T2>>) : Void {})
	public function map<T2>(fn : T -> Int -> Cursor<T> -> T2, cb : ArangoCallback<Array<T2>>) : Void;

	@:overload(function<T2>(   fn : T2 -> T -> T2, cb : ArangoCallback<Array<T2>>) : Void {})
	@:overload(function<T2>(   fn : T2 -> T -> Int -> T2, cb : ArangoCallback<Array<T2>>) : Void {})
	public function reduce<T2>(fn : T2 -> T -> Int -> Cursor<T> -> T2, cb : ArangoCallback<Array<T2>>) : Void;
}
