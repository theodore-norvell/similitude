package js.npm.passport;

import js.support.Callback;

extern class BasicStrategy
implements js.npm.passport.Strategy
implements npm.Package.RequireNamespace<"passport-http","*">
{
	public function new( cb : String -> String -> Callback<haxe.extern.Rest<Dynamic>> -> Void ) : Void;
}