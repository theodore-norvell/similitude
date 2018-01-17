package js.npm;

import js.support.Callback;

extern class Bcrypt
implements npm.Package.Require<"bcrypt","^0.8.5"> {

	public static function genSaltSync(rounds : Int) : String;

	public static function genSalt(rounds : Int, cb : Callback<String>) : Void;

	public static function hashSync(data : String, salt : String) : String;

	public static function hash(data : String, salt : String, cb : Callback<String>) : Void;

	public static function compareSync(data : String, encrypted : String) : Bool;

	public static function compare(data : String, encrypted : String, cb : Callback<Bool>) : Void;

	public static function getRounds(encrypted : String) : Int;
}
