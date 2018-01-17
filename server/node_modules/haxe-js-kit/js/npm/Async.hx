package js.npm;

import haxe.Constraints;

typedef AsyncCallback<T> = T -> Void;
typedef AsyncOptionalCallback<T> = ?T -> Void;
typedef AsyncMapCallback<Err, T> = Err -> T -> Void;

typedef AsyncLoopCallback<Err> = AsyncCallback<Err> -> Void;

extern class Async
implements npm.Package.Require<"async", "^0.9.0">
{
	public static function each<T1, Err>(arr : Array<T1>, iterator : T1 -> AsyncOptionalCallback<Err> -> Void, ?callback : AsyncCallback<Err>) : Void;
	public static function eachSeries<T1, Err>(arr : Array<T1>, iterator : T1 -> AsyncOptionalCallback<Err> -> Void, ?callback : AsyncCallback<Err>) : Void;
	public static function eachLimit<T1, Err>(arr : Array<T1>, limit : Int, iterator : T1 -> AsyncOptionalCallback<Err> -> Void, ?callback : AsyncCallback<Err>) : Void;

	public static function map<T1, T2, Err>(arr : Array<T1>, iterator : T1 -> AsyncMapCallback<Err, T2> -> Void, ?callback : AsyncMapCallback<Err, Array<T2>>) : Void;
	public static function mapSeries<T1, T2, Err>(arr : Array<T1>, iterator : T1 -> AsyncMapCallback<Err, T2> -> Void, ?callback : AsyncMapCallback<Err, Array<T2>>) : Void;
	public static function mapLimit<T1, T2, Err>(arr : Array<T1>, limit : Int, iterator : T1 -> AsyncMapCallback<Err, T2> -> Void, ?callback : AsyncMapCallback<Err, Array<T2>>) : Void;

	public static function filter<T1, Err>(arr : Array<T1>, iterator : T1 -> AsyncCallback<Bool> -> Void, ?callback : AsyncCallback<Array<T1>>) : Void;
	public static function filterSeries<T1, Err>(arr : Array<T1>, iterator : T1 -> AsyncCallback<Bool> -> Void, ?callback : AsyncCallback<Array<T1>>) : Void;

	public static function reject<T1, Err>(arr : Array<T1>, iterator : T1 -> AsyncCallback<Bool> -> Void, ?callback : AsyncCallback<Array<T1>>) : Void;
	public static function rejectSeries<T1, Err>(arr : Array<T1>, iterator : T1 -> AsyncCallback<Bool> -> Void, ?callback : AsyncCallback<Array<T1>>) : Void;

	// reduce
	// reduceRight

	public static function detect<T1, Err>(arr : Array<T1>, iterator : T1 -> AsyncCallback<Bool> -> Void, ?callback : AsyncCallback<Null<T1>>) : Void;
	public static function detectSeries<T1, Err>(arr : Array<T1>, iterator : T1 -> AsyncCallback<Bool> -> Void, ?callback : AsyncCallback<Null<T1>>) : Void;

	public static function sortBy<T1, T2, Err>(arr : Array<T1>, iterator : T1 -> AsyncMapCallback<Err, T2> -> Void, ?callback : AsyncCallback<Array<T1>>) : Void;

	public static function some<T1>(arr : Array<T1>, iterator : T1 -> AsyncCallback<Bool> -> Void, ?callback : AsyncCallback<Bool>) : Void;
	public static function any<T1>(arr : Array<T1>, iterator : T1 -> AsyncCallback<Bool> -> Void, ?callback : AsyncCallback<Bool>) : Void;
	
	public static function every<T1>(arr : Array<T1>, iterator : T1 -> AsyncCallback<Bool> -> Void, ?callback : AsyncCallback<Bool>) : Void;
	public static function all<T1>(arr : Array<T1>, iterator : T1 -> AsyncCallback<Bool> -> Void, ?callback : AsyncCallback<Bool>) : Void;

	public static function concat<T1, T2, Err>(arr : Array<T1>, iterator : T1 -> AsyncMapCallback<Err, Array<T2>> -> Void, ?callback : AsyncMapCallback<Err, Array<T2>>) : Void;
	public static function concatSeries<T1, T2, Err>(arr : Array<T1>, iterator : T1 -> AsyncMapCallback<Err, Array<T2>> -> Void, ?callback : AsyncMapCallback<Err, Array<T2>>) : Void;

	@:overload(function(tasks : Array<Function>) : Void {})
	public static function series<T1, Err>(tasks : Array<Function>, callback : AsyncMapCallback<Err, Array<T1>>) : Void;

	@:overload(function(tasks : Array<Function>) : Void {})
	public static function parallel<T1, Err>(tasks : Array<Function>, callback : AsyncMapCallback<Err, Array<T1>>) : Void;

	@:overload(function(tasks : Array<Function>, limit : Int) : Void {})
	public static function parallelLimit<T1, Err>(tasks : Array<Function>, limit : Int, callback : AsyncMapCallback<Err, Array<T1>>) : Void;

	// The test function must be synchronous for whilst:
	public static function whilst<Err>(test : Void -> Bool, fn : AsyncLoopCallback<Err>, callback : AsyncCallback<Err>) : Void;
	public static function doWhilst<Err>(fn : AsyncLoopCallback<Err>, test : Void -> Bool, callback : AsyncCallback<Err>) : Void;
	
	// The test function must be synchronous for until:
	public static function until<Err>(test : Void -> Bool, fn : AsyncLoopCallback<Err>, callback : AsyncCallback<Err>) : Void;
	public static function doUntil<Err>(fn : AsyncLoopCallback<Err>, test : Void -> Bool, callback : AsyncCallback<Err>) : Void;
	
	public static function forever<Err>(fn : AsyncLoopCallback<Err>, ?errback : AsyncCallback<Err>) : Void;

	public static function waterfall<T1, Err>(arr : Array<Function>, ?callback : AsyncMapCallback<Err, T1>) : Void;

	// compose
	// seq

	@:overload(function(fns : Array<Function>) : Function {})
	@:overload(function<T, T2, T3, T4, Err>(fns : Array<Function>, arg1 : T, arg2 : T2, arg3 : T3, arg4 : T4, callback : AsyncCallback<Err>) : Void {})
	@:overload(function<T, T2, T3, Err>(fns : Array<Function>, arg1 : T, arg2 : T2, arg3 : T3, callback : AsyncCallback<Err>) : Void {})
	@:overload(function<T, T2, Err>(fns : Array<Function>, arg1 : T, arg2 : T2, callback : AsyncCallback<Err>) : Void {})
	public static function applyEach<T, Err>(fns : Array<Function>, arg1 : T, callback : AsyncCallback<Err>) : Void;

	@:overload(function(fns : Array<Function>) : Function {})
	@:overload(function<T, T2, T3, T4, Err>(fns : Array<Function>, arg1 : T, arg2 : T2, arg3 : T3, arg4 : T4, callback : AsyncCallback<Err>) : Void {})
	@:overload(function<T, T2, T3, Err>(fns : Array<Function>, arg1 : T, arg2 : T2, arg3 : T3, callback : AsyncCallback<Err>) : Void {})
	@:overload(function<T, T2, Err>(fns : Array<Function>, arg1 : T, arg2 : T2, callback : AsyncCallback<Err>) : Void {})
	public static function applyEachSeries<T, Err>(fns : Array<Function>, arg1 : T, callback : AsyncCallback<Err>) : Void;

	// queue
	// priorityQueue
	// cargo
	// auto

	@:overload(function<Err, T>(opts : {times: Int, interval: Int}, task : AsyncMapCallback<Err, T> -> Void, ?callback : AsyncMapCallback<Err, T>) : Void {})
	public static function retry<Err, T>(times : Int, task : AsyncMapCallback<Err, T> -> Void, ?callback : AsyncMapCallback<Err, T>) : Void;

	public static function iterator(tasks : Array<Void -> Void>) : Void -> (Void -> Void);

	// apply: Use Haxe's bind instead

	public static function nextTick(callback : Void -> Void) : Void;

	public static function times<T1, T2, Err>(times : Int, iterator : Int -> AsyncMapCallback<Err, T2> -> Void, ?callback : AsyncMapCallback<Err, Array<T2>>) : Void;
	public static function timesSeries<T1, T2, Err>(times : Int, iterator : Int -> AsyncMapCallback<Err, T2> -> Void, ?callback : AsyncMapCallback<Err, Array<T2>>) : Void;
	public static function timesLimit<T1, T2, Err>(times : Int, limit : Int, iterator : Int -> AsyncMapCallback<Err, T2> -> Void, ?callback : AsyncMapCallback<Err, Array<T2>>) : Void;

	// memoize
	// unmemoize
	// ensureAsync

	public static function constant<T>(value : T) : Void -> T;

	public static function asyncify(fn : Function) : Function;

	@:overload(function<T, T2, T3, T4, T5, Err>(fn : T2 -> T3 -> T4 -> T5 -> AsyncMapCallback<Err, T> -> Void, arg1 : T2, arg2 : T3, arg3 : T4, arg4 : T5) : Void {})
	@:overload(function<T, T2, T3, T4, Err>(fn : T2 -> T3 -> T4 -> AsyncMapCallback<Err, T> -> Void, arg1 : T2, arg2 : T3, arg3 : T4) : Void {})
	@:overload(function<T, T2, T3, Err>(fn : T2 -> T3 -> AsyncMapCallback<Err, T> -> Void, arg1 : T2, arg2 : T3) : Void {})
	public static function log<T, T2, Err>(fn : T2 -> AsyncMapCallback<Err, T> -> Void, arg1 : T2) : Void;

	@:overload(function<T, T2, T3, T4, T5, Err>(fn : T2 -> T3 -> T4 -> T5 -> AsyncMapCallback<Err, T> -> Void, arg1 : T2, arg2 : T3, arg3 : T4, arg4 : T5) : Void {})
	@:overload(function<T, T2, T3, T4, Err>(fn : T2 -> T3 -> T4 -> AsyncMapCallback<Err, T> -> Void, arg1 : T2, arg2 : T3, arg3 : T4) : Void {})
	@:overload(function<T, T2, T3, Err>(fn : T2 -> T3 -> AsyncMapCallback<Err, T> -> Void, arg1 : T2, arg2 : T3) : Void {})
	public static function dir<T, T2, Err>(fn : T2 -> AsyncMapCallback<Err, T> -> Void, arg1 : T2) : Void;

	public static function noConflict() : Class<Async>;
}
