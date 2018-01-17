package js.npm;

import js.support.Callback;
import haxe.Constraints.Function;
import js.node.http.ClientRequest;
import js.node.http.ServerResponse;
import js.node.http.Agent;

@:enum abstract RestlerEvent(String) from String to String {
	var complete = "complete";
	var success = "success";
	var fail = "fail";
	var error = "error";
	var abort = "abort";
	var timeout = "timeout";
}

typedef RestlerParser<T> = String -> Callback<T> -> Void;

typedef RestlerOptions = {
	?method : String,
	?query : {},
	?data : Dynamic,
	?parser : RestlerParser<Dynamic>,
	?xml2js : {},
	?encoding : String,
	?decoding : String,
	?headers : {},
	?username : String,
	?password : String,
	?accessToken : String,
	?multipart : ClientRequest,
	?client : Dynamic,
	?followRedirects : Bool,
	?timeout : Int,
	?rejectUnauthorized : Bool,
	?agent : Agent
}

extern class RestlerRestRequest
{
	@:overload(function(event : RestlerEvent, callback : Void -> Void) : RestlerRestRequest {})
	@:overload(function<T>(event : RestlerEvent, callback : T -> Void) : RestlerRestRequest {})
	public function on<T>(event : RestlerEvent, callback : T -> ServerResponse -> Void) : RestlerRestRequest;

	@:overload(function() : RestlerRestRequest {})
	public function abort<T>(error : T) : RestlerRestRequest;

	@:overload(function() : RestlerRestRequest {})
	public function retry(timeoutMs : Int) : RestlerRestRequest;

	public var aborted(default, null) : Bool;
}

extern class Restler
implements npm.Package.Require<"restler", "^3.4.0">
{
	public static var parsers : {
		auto: RestlerParser<{}>,
		json: RestlerParser<{}>,
		xml : RestlerParser<{}>,
		yaml: RestlerParser<{}>
	};
	
	public static function request(url : String, ?options : RestlerOptions) : RestlerRestRequest;
	public static function get(url : String, ?options : RestlerOptions) : RestlerRestRequest;
	public static function post(url : String, ?options : RestlerOptions) : RestlerRestRequest;
	public static function put(url : String, ?options : RestlerOptions) : RestlerRestRequest;
	public static function del(url : String, ?options : RestlerOptions) : RestlerRestRequest;
	public static function head(url : String, ?options : RestlerOptions) : RestlerRestRequest;
	public static function patch(url : String, ?options : RestlerOptions) : RestlerRestRequest;

	public static function json(url : String, data : Dynamic, ?options : RestlerOptions) : RestlerRestRequest;
	public static function postJson(url : String, data : Dynamic, ?options : RestlerOptions) : RestlerRestRequest;
	public static function putJson(url : String, data : Dynamic, ?options : RestlerOptions) : RestlerRestRequest;
	public static function patchJson(url : String, data : Dynamic, ?options : RestlerOptions) : RestlerRestRequest;
}
