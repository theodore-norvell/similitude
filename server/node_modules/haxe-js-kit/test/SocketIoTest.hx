package test;

class SocketIoTest {
	#if client
	static function main(){
		var socket = js.browser.SocketIo.connect('http://localhost');
		socket.on('news', function (data) {
		    trace(data);
		    socket.emit('my other event', { my: 'data' });
		});
	}
	#end
	#if server
	static function index(req : js.npm.express.Request, res : js.npm.express.Response){
		trace("index");
		  res.sendfile( js.Node.__dirname + '/test/index.socketio.html');
	}
	static function script(req : js.npm.express.Request, res : js.npm.express.Response){
		trace("script");
		  res.sendfile( js.Node.__dirname + '/test/test.socketio.client.js');
	}

	static function main(){
		var PORT = 9000;
		var app = new js.npm.Express();
		var server = js.node.Http.createServer( cast app );
		var io = new js.npm.socketio.Server(server);

		app.get('/',index);
		app.get('/test.socketio.js',script);

		io.on('connection',function(socket){
			socket.emit('news', {hello:'world'});
			socket.on('my other event',function(data){
				trace(data);
			});
		});

		trace('listening to $PORT');
		server.listen(PORT);
	}
	#end
}