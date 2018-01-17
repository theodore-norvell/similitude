package js.npm.gcm;

import js.support.Callback;

typedef Recipients = {
	? to : String,
	? topic : String,
	? notificationKey : String,
	? registrationIds : Array<String>,
	? registrationTokens : Array<String>
}

typedef RequestOptions = {
    proxy : String,
    timeout : Int
}

extern class Sender
implements npm.Package.RequireNamespace<"node-gcm","^0.14.0">
{
	public function new(apiKey : String, ? options : RequestOptions) : Void;

	@:overload(function(msg : Message, recipients : Recipients, retry : Int, cb : Callback<String>) : Void {})
	public function send(msg : Message, recipients : Recipients, cb : Callback<String>) : Void;

	public function sendNoRetry(msg : Message, recipients : Recipients, cb : Callback<String>) : Void;
}