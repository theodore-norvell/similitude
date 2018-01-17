package js.node.events;

typedef EventEmitterListener = Dynamic;
/* 
   emits: newListener
 */
extern interface IEventEmitter 
{

	function addListener(event:String,fn:EventEmitterListener):Dynamic;
	function on(event:String,fn:EventEmitterListener):Dynamic;
	function once(event:String,fn:EventEmitterListener):Void;
	function removeListener(event:String,listener:EventEmitterListener):Void;
	function removeAllListeners(event:String):Void;
	function listeners(event:String):Array<EventEmitterListener>;
	function setMaxListeners(m:Int):Void;
	function emit(event:String,?arg1:Dynamic,?arg2:Dynamic,?arg3:Dynamic):Void;

}