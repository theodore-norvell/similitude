package js.npm.react;

import js.npm.react.PropTypes;
import js.support.Callback;

@:remove
abstract Fragment(Dynamic) 
from Component<Dynamic,Dynamic> 
from Int
from String 
from Bool
{
  @:from inline static function fromString( str : String ) : Fragment {
    return untyped str;
  }

  @:from inline static function fromInt( i : Int ) : Fragment {
    return untyped i;
  }

  @:from inline static function fromComponent( c : Component<Dynamic,Dynamic> ) : Fragment {
    return untyped c;
  }

  @:from inline static function fromBool( b : Bool ) : Fragment {
    return untyped b;
  }
}

// FIXME : rename or something
@:native('{}')
extern class Component<P:Props,S> {
  var props : P;
  var state : S;
  var propTypes : Dynamic<PropTypes.PropType<Dynamic>>;
  function render() : Fragment;
  function setState(data:S, ?cb:Callback0 ) : Void;
  function getInitialState() : S;
  function shouldComponentUpdate() : Bool;
  function getDefaultProps() : P;
}

typedef Props = {
  var children : Dynamic;
}