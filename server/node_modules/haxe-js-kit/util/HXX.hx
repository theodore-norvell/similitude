package util;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.ExprTools;
import haxe.macro.TypeTools;
#end

/**

	Rudimentary JSX-like compiler for Haxe

**/
class HXX {
	macro public static function compile( expr : Expr ) {
		return tr(expr);
	}
	
	#if macro
	static function tr( expr : Expr ): Expr {
		return switch(expr.expr){
			case EMeta({ name: 'el' },c) :
				createElement(c);
			default: 
				ExprTools.map(expr,tr);

		}
	}

	static function createElement(expr:Expr) {
		return switch( expr.expr ) {
			case ECall(call, args ):
				var children : Array<Expr> = [];
				var attributes : Array<{ field : String, expr: Expr}> = [];
				var spread : Array<Expr> = [ { expr : EObjectDecl( attributes ) , pos : expr.pos } ];

				for ( a in args ) switch ( a.expr ) {
					case EBinop(op,left,right) : // prop = "test", "data-prop" = 1, etc
						var field = switch( left.expr ) {
							case EConst(CIdent(i)) : i;
	 						case EConst(CString(i)) : i;
	 						default: Context.error("unsupported", left.pos ); 
						}
						attributes.push( { field : field , expr : right } );
					case EMeta({name:"spread"},e) : // @spread this.props
					 	spread.push( e );
					default: // all others are considered children
						children.push( tr( a ) );
				}

				var element = switch( call.expr ){
					case EConst(CIdent(el)) if (~/^[a-z]/.match(el)) : // simple, lower case element
						macro $v{el};
					default: // react component
						macro js.npm.react.support.Tools.createReactClass( $call );
				}

				var mergedAttributes : ExprDef = if( spread.length > 1 ) { // if several props objects, merge them using "spread"
					ECall( macro untyped js.npm.React.__spread , spread );
				} else { // otherwise just pass in the attributes object
					spread[0].expr;
				}

				var callArgs = [element, { expr : mergedAttributes , pos : expr.pos } ];
				callArgs = callArgs.concat( children );

				var o = {
					pos: expr.pos,
					expr: ECall( 
						macro untyped js.npm.React.createElement,
						callArgs
					)
				};

				o;

			case _ : 
				throw Context.error("unsupported", expr.pos);
		}
	}
	#end
}