package js.npm.gcm;

import js.support.DynamicObject;

typedef MessageOptions = {
	? collapseKey : String,
    ? priority : String,
    ? contentAvailable : Bool,
    ? delayWhileIdle : Bool,
    ? timeToLive : Int,
    ? restrictedPackageName : String,
    ? dryRun : Bool,
    ? data : DynamicObject<String>,
    ? notification : NotificationPayload
}

typedef NotificationPayload = {
	title : String,
	body : String,
	icon : String,
	? sound : String,
	? badge : String,
	? tag : String,
	? color : String,
	? click_action : String,
	? body_loc_key : String,
	? body_loc_args : Array<String>,
	? title_loc_args : Array<String>,
	? title_loc_key : String,
}

extern class Message
implements npm.Package.RequireNamespace<"node-gcm","^0.14.0">
{
	public function new(? options : MessageOptions) : Void;

	@:overload(function(data : DynamicObject<String>) : Void {})
	public function addData(key : String, value : String) : Void;

	@:overload(function(data : NotificationPayload) : Void {})
	public function addNotification(key : String, value : String) : Void;
}