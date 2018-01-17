package js.npm.react;

// TODO more on events here: http://facebook.github.io/react/docs/events.html

extern class SyntheticEvent {
  var bubbles(default, null) : Bool;
  var cancelable(default, null) : Bool;
  var currentTarget(default, null) : EventTarget;
  var defaultPrevented(default, null) : Bool;
  var eventPhase(default, null) : Int;
  var isTrusted(default, null) : Bool;
  var nativeEvent(default, null) : Event;
  function preventDefault() : Void;
  function stopPropagation() : Void;
  var target(default, null) : EventTarget;
  var timeStamp(default, null) : Date;
  var type(default, null) : String;
}