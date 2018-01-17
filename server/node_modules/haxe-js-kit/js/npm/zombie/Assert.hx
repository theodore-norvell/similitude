package js.npm.zombie;
import js.support.Either;

extern class Assert
{
	public function attribute(selection : String, name : String, expected : String, ?message : String) : Void;
	public function className(selection : String, className : String, ?message : String) : Void;
	public function cookie(identifier : String, expected : String, ?message : String) : Void;
	public function element(selection : String, ?message : String) : Void;
	public function elements(selection : String, count : Either<Int, {}>, ?message : String) : Void;
	public function evaluate(expression : String, expected : Dynamic, ?message : String) : Void;
	public function global(name : String, expected : String, ?message : String) : Void;
	public function hasClass(selection : String, className : String, ?message : String) : Void;
	public function hasFocus(selection : String, ?message : String) : Void;
	public function hasNoClass(selection : String, className : String, ?message : String) : Void;
	public function input(selection : String, expected : String, ?message : String) : Void;
	public function link(selection : String, text : String, url : Either<String, RegExp>, ?message : String) : Void;
	public function redirected(?message : String) : Void;
	public function success(?message : String) : Void;
	public function status(code : Int, ?message : String) : Void;
	public function style(selection : String, style : String, expected : String, ?message : String) : Void;
	public function text(selection : String, expected : String, ?message : String) : Void;
	public function url(url : Dynamic, ?message : String) : Void;
}
