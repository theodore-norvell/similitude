package js.npm.mongoose;

import haxe.extern.Rest;
import js.support.Callback;

extern class Aggregate<M>
implements npm.Package.RequireNamespace<"mongoose", "^4.0.0">
{
    public var options : Dynamic;

    @:overload(function (commands : Rest<{}>) : Void {})
    @:overload(function (commands : Array<{}>) : Void {})
    public function new();

    public function model(model : M) : Aggregate<M>;

    @:overload(function (commands : Rest<{}>) : Aggregate<M> {})
    public function append(commands : Array<{}>) : Aggregate<M>;

    @:overload(function (selection : {}) : Aggregate<M> {})
    public function project(selection : String) : Aggregate<M>;

    public function near(args : {}) : Aggregate<M>;

    public function group(args : {}) : Aggregate<M>;

    public function match(args : {}) : Aggregate<M>;

    public function skip(args : {}) : Aggregate<M>;

    public function limit(args : {}) : Aggregate<M>;

    public function out(args : {}) : Aggregate<M>;

    public function unwind(args : Rest<String>) : Aggregate<M>;

    public function lookup(args : {}) : Aggregate<M>;

    public function sample(size : Int) : Aggregate<M>;

    @:overload(function (selection : {}) : Aggregate<M> {})
    public function sort(selection : String) : Aggregate<M>;

    public function read(pref : String, ?tags : Array<String>) : Aggregate<M>;

    public function explain(cb : Callback<{}>) : Promise;

    public function allowDiskUse(value : Bool) : Aggregate<M>;

    public function cursor(options : {}) : Aggregate<M>;

    public function exec(callback : Callback<Array<{}>>) : Promise;
}
