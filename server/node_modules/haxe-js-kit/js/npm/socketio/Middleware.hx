package js.npm.socketio;

typedef Next = ?js.Error -> Void

typedef Middleware = Socket -> Next -> Void;