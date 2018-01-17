package js.npm.passport;

import js.support.Callback;

typedef FacebookTokenStrategyConfig = {
	clientID : String,
	clientSecret : String
}

extern class FacebookTokenStrategy
implements js.npm.passport.Strategy
implements npm.Package.Require<"passport-facebook-token","*">
{
	public function new( config : FacebookTokenStrategyConfig , cb : String -> String -> Profile -> Callback<Dynamic> -> Void ) : Void;
}
