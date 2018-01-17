package js.npm;

import js.node.http.ServerResponse;
import js.node.stream.Readable;
import js.support.Either;
import js.support.Either.Either3;

/*
extern class RestlerResponse
{
	@:overload(function(event : String, callback : Void -> Void) : RestlerResponse {})
	@:overload(function(event : String, callback : Dynamic -> Void) : RestlerResponse {})
	public function on(event : String, callback : Dynamic -> ServerResponse -> Void) : RestlerResponse;
}
*/

typedef RequestCallback2 = Null<Dynamic> -> Void;
typedef RequestCallback1 = Null<Dynamic> -> ServerResponse -> Void;
typedef RequestCallback = Null<Dynamic> -> ServerResponse -> String -> Void;

typedef EitherCallback = Either3<RequestCallback, RequestCallback1, RequestCallback2>;

extern class Request extends Readable<Request>
implements npm.Package.Require<"request", "^2.55.0">
{
	public static inline function construct() : Request {
		untyped return require('request');
	}

	public static function defaults(options : {}) : Request;

	public function put(options : Either<{}, String>, ?callback : EitherCallback) : Request;
	public function patch(options : Either<{}, String>, ?callback : EitherCallback) : Request;
	public function post(options : Either<{}, String>, ?callback : EitherCallback) : Request;
	public function head(options : Either<{}, String>, ?callback : EitherCallback) : Request;
	public function del(options : Either<{}, String>, ?callback : EitherCallback) : Request;
	public function get(options : Either<{}, String>, ?callback : EitherCallback) : Request;

	public function cookie(keyValue : String) : Dynamic;
	public static function jar() : Dynamic;

	public function form(formValues : {}) : Request;

	public static var debug : Bool;
}
