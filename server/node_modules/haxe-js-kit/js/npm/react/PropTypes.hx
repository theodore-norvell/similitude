package js.npm.react;

import js.npm.react.Component.Props;

typedef PropType<T> = {
	isRequired : Bool
}

typedef PropName = String;
typedef ComponentName = String;

typedef PropTypeCustom = Props -> PropName -> ComponentName -> Bool;

extern class PropTypes 
implements npm.Package.RequireNamespace<"react","0.12.2"> 
{
	public static var array : PropType<Array<Dynamic>>;
	public static var bool : PropType<Bool>;
	public static var func : PropType<haxe.Constraints.Function>;
	public static var number : PropType<Float>;
	public static var object : PropType<{}>;
	public static var string : PropType<String>;

	public static var node : PropType<js.html.Node>;
	public static var element : PropType<js.html.Element>;

	public static var any : PropType<Dynamic>;

	public static function instanceOf<T>( t : Class<T> ) : PropType<T>;

	public static function oneOf<T>( values : Array<T> ) : PropType<Array<T>>;

	public static function oneOfType( types : Array<Class<Dynamic>> ) : PropType<Dynamic>;

	public static function arrayOf<T>( t : Class<T> ) : PropType<Array<T>>;

	public static function objectOf<T>( t : Class<T> ) : PropType<Dynamic<T>>;

	public static function shape<T:{}>( t : Class<T> ) : PropType<T>;

	public static function custom<T>( cb : PropTypeCustom ) : PropType<T>;
}