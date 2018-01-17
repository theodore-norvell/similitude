package test;

import js.npm.express.Middleware;
import js.npm.express.Request;
import js.npm.express.Response;

using js.npm.express.Session;


class ExpressTest {
	static function main(){
		var PORT = 9000;
		var app : js.npm.express.Application = new js.npm.Express();
		var secret = 'mySecret';
		
		var store = js.npm.ConnectMongo.construct( Session ,{ db : 'localhost' } );

		app.set('test','toto');
		app.use( new js.npm.express.CookieParser( secret ) );
		app.use( new Session({ secret : secret , store : store }) );

		/** custom middleware **/
		app.use( function(req,_,next:MiddlewareNext){

			trace("got request",req.originalUrl);
			next();
		} );

		/** all verbs route on / **/
		app.all('/', function(req:Request,res:Response){
			var session = req.session();
			if( session.n == null ){
				session.n = 1;
			}
			res.send("HELLO " + session.n++ );
		});

		/** custom verb route **/
		app.head('/',function(req:Request,res:Response,next:MiddlewareNext){
			trace('HEAD REQUEST');
			next();
		});

		// FIXME: inline conversion to 'm-search' won't work on @:overloads
		app.mSearch('/',function(req,res){
			trace("M-SEARCH REQUEST");
			
		});

		/** otherwise, go static **/
		app.use( new js.npm.express.Static('.') );
		
		trace('listening to $PORT');
		app.listen(PORT);
	}
}