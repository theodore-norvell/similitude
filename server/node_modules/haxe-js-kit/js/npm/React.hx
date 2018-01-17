package js.npm;

#if macro
import haxe.macro.Expr;
#end
import js.html.Element;
import js.html.Event;
import js.html.EventTarget;
import js.npm.ObjectAssign;
import js.npm.react.Component;

//@:native('React')
// TODO check that static work, since react provide its own way of generating statics
// http://facebook.github.io/react/docs/component-specs.html
extern class React 
implements npm.Package.Require<"react","0.12.2">
{
  static function render<P:Props,S>(component : Component<P,S>, container : Element, ?callback : Void -> Void) : Component<P,S>;
  // @:deprecated
  // static function renderComponent(component : ReactComponent, container : Element, ?callback : Void -> Void) : ReactComponent;
  static function unmountComponentAtNode(container : Element) : Bool;
  static function renderComponentToString<P:Props,S>(component : Component<P,S> ) : String;
  static function renderComponentToStaticMarkup<P:Props,S>(component : Component<P,S>) : String;
  
  static public function createElement<P:Props,S>( type : Dynamic, ?props : {} , ?childs : Fragment ) : Component<P,S>;
  public static function createClass(cl:Dynamic) : Dynamic;
  public static function initializeTouchEvents(flag:Bool): Void;
  
}