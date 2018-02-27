package ;

import Std;
import String;
import tjson.TJSON;
import tjson.TJSON;
import org.bsonspec.ObjectID;
import js.Node;
import js.node.Http;
import js.node.Path;
import js.Node.console;
import js.npm.Express;
import js.npm.Nodemailer;
import js.npm.express.*;
import js.npm.mongoose.*;
import js.npm.mongoose.macro.Manager;
import js.npm.mongoose.macro.Model;
import js.support.Error;
import js.support.Callback;
import com.mun.model.component.CircuitDiagram;

import tjson.TJSON;


@:schemaOptions({
    autoIndex: true
})
typedef StuffData = {
    parentid:String,
    isFolder:Bool,
    fileName:String,
    version:Array<{
        number:Int,
        contents:String,
        modified:Date
    }>,
    metainformation:{
        fileType:String,
        owner:String,
        permissions:Array<{
            group:String,
            permission:String
        }>,
        created:Date
    }
}
class Stuff extends Model<StuffData>{}
class StuffManager extends js.npm.mongoose.macro.Manager<StuffData,Stuff>{}
class Main implements util.Async
{



    private var server:Dynamic;
    function new()
    {
        var app :Express = new Express();


        /**
        * database connection test and build model
**/
        var database = new js.npm.mongoose.Mongoose();
        database.connect("mongodb://localhost/test_mongoose",
                         function( err : Null<Error>) : Void {
                             console.log("inside callback for connect err is " + err );
                         });
        var stuffMan : StuffManager = StuffManager.build(database, "test");



        var err,stuff = @async stuffMan.find({_id:"5a95aeebe2e0fe2aecf77a48"});
            trace(stuff[0].version);


//        console.log("about to remove");
//        stuffMan.remove( {},function (err : Null<Error>) : Void {
//            console.log("inside callback err is " + err);
//        } ) ;
//        console.log("inside callback, err is" + err );
//        console.log("back from remove");


//        var d : StuffData = {
//            folder : {
//                parentid : "",
//                currentFolderName : "NewFolder",
//                isFolder : false
//            },
//            version : {
//                fileName : "",
//                number : [1],
//                contents : [""],
//                modified : Date.now(),
//            },
//            metainformation : {
//                fileType : "circuit",
//                owner : "test",
//                permissions : {
//                    group : ["a"],
//                    permission : "true"
//                },
//                created : Date.now()
//            }
//        }


//            stuffMan.create( d, function (err : Null<Error>, stuff : Stuff) : Void {
//            console.log("inside callback err is " + err + " stuff is " + stuff);
//            });
//        console.log("back from create");


        var mailTransport = Nodemailer.createTransport({
            service: "Gmail",
            auth: {
                user: "web.circuitdiagram@gmail.com",
                pass: "Webapplication"
            }
        });






        /**
        mailTransport.sendMail(options, function(err, msg){
            if(err){
                console.log(err);
            }
            else {
                console.log(msg);
            }
        });**/





        app.set('port', 3000);
        app.use(new Static(Path.join((Node.__dirname).substring(0,(Node.__dirname).indexOf('server\\src')))));
        //app.use(new Static(Path.join(Node.__dirname)));
        app.use(BodyParser.json());
        var jsonParser = BodyParser.json();
        trace((Node.__dirname).substring(0,(Node.__dirname).indexOf('server\\src'))+"client\\src");
        //trace((Node.__dirname).substring(0,(Node.__dirname).indexOf('server\\src'))+"\\client");

        app.get('/', function (req : Request, res : Response) {
            //console.log("Got a GET request for the homepage");
            //res.send(Node.__dirname);
            res.sendfile(Node.__dirname+'/login.html');
        });

        app.post('/', jsonParser,function (req : Request, res : Response) {
            var _req : Dynamic = req;
            var db = new HaxeLow('db.json');
            var user = db.col(User);
            var flag:Bool = false;
            for(i in user){
                flag = i.check(_req.body.username,_req.body.password);
                if(flag == true){
                    break;
                }
            }
            if(flag == true){
                console.log("login");
                res.send("y");
            }
            else{
                console.log("login fail");
                res.send("n");
            }
        });


// This responds with "Hello World" on the homepage
        app.get('/regist', function (req : Request, res : Response) {
            //console.log("Got a GET request for the homepage");
            //res.send(Node.__dirname);
            res.sendfile(Node.__dirname+'/regist.html');
        });

// This responds a POST request for the homepage
        app.post('/regist', jsonParser,function (req : Request, res : Response) {
           //console.log("Got a POST request for the homepage");
           //trace( req.get('Content-Type') ) ;
           // trace( req.is('application/json') );
            var _req : Dynamic = req;
            var db = new HaxeLow('db.json');
            var user = db.col(User);
            var emailflag:Bool = true;
            var usernameflag:Bool = true;
            //for(i in user){
            //    if(i.getname() == _req.body.username || i.getmail() == _req.body.email){
            //        flag = false;
            //    }
            //}
            //if(flag==true){
            //    user.push(_req.body);
            //    db.save();
            //}
            for(i in user){
                if(i.getname() == _req.body.username ){
                           usernameflag = false;
                        }
                if( i.getmail() == _req.body.email){
                    emailflag = false;
                }
            }

            if(emailflag==true && usernameflag == true){
                user.push(_req.body);
                db.save();
                console.log("new client registered, username : "+_req.body.username);
                var stufftemp : StuffManager = StuffManager.build(database, _req.body.username);
                var d : StuffData = {
                    parentid:"",
                    isFolder:true,
                    fileName:"root",
                    version:[{
                        number:1,
                        contents:"",
                        modified:Date.now()
                    }],
                    metainformation:{
                        fileType:"folder",
                        owner:_req.body.username,
                        permissions:[{
                            group:"a",
                            permission:"read&write"
                        }],
                        created:Date.now()
                    }
                }

                stufftemp.create( d, function (err : Null<Error>, stuff : Stuff) : Void {
                    console.log("inside callback err is " + err + " stuff is " + stuff);
                });

                res.send("t");
            }
            else{
                if(usernameflag == false){
                    console.log("username");
                    res.send("username");
                }
                if(emailflag == false){
                    console.log("email");
                    res.send("email");
                }
            }

        });


        app.get('/app/users', function (req : Request, res : Response,next ) {
            //console.log("Got a GET request for the homepage");
            //res.send(Node.__dirname);
            var _req : Dynamic = req;
            var username = req.param('username');
            trace(username);
            res.sendfile((Node.__dirname).substring(0,(Node.__dirname).indexOf('server\\src'))+"\\client\\app.html");
        });

        app.post('/app/users', jsonParser, function (req : Request, res : Response,next ) {
            var _req : Dynamic = req;

            var d : StuffData = {
                parentid:"",
                isFolder:true,
                fileName:"root",
                version:[{
                    number:1,
                    contents:"",
                    modified:Date.now()
                }],
                metainformation:{
                    fileType:"folder",
                    owner:_req.body.username,
                    permissions:[{
                        group:"a",
                        permission:"read&write"
                    }],
                    created:Date.now()
                }
            }


//            stuffMan.create( d, function (err : Null<Error>, stuff : Stuff) : Void {
//            console.log("inside callback err is " + err + " stuff is " + stuff);
//            });

//            res.send(_req.body);

            stuffMan.find({"_id": "5a95aeebe2e0fe2aecf77a48"},function (err : Null<Error>, stuff) : Void {
                trace(stuff[0].version[0].contents);
                res.send(stuff[0].version[0].contents);
            });

        });

        app.post('/app/users/folder',function (req : Request, res : Response,next ) {
            var _req : Dynamic = req;
            console.log(req.param('new')+req.param('username')+req.param('folder').split("/")[0]+req.param('fileName'));
            var stufftemp : StuffManager = StuffManager.build(database, req.param('username'));
            /**
            *
            * create new folder
            *
**/
            if(req.param('new')=="true"){
                var path : Array<String> =req.param('folder').split("/");
                path.pop();
                var err, id = @async findFileId(path,stufftemp);
                path =req.param('folder').split("/");

                if(id != null){
                    stufftemp.find({"parentid" : id, "fileName" : path[path.length-1], "isFolder" : true},
                    function (err : Null<Error>, stuff) : Void {
                        if(stuff.length==0){
                            var d : StuffData = {
                                parentid:id,
                                isFolder:true,
                                fileName:path[path.length-1],
                                version:[{
                                    number:0,
                                    contents:"",
                                    modified:Date.now()
                                }],
                                metainformation:{
                                    fileType:"folder",
                                    owner:_req.body.username,
                                    permissions:[{
                                        group:"a",
                                        permission:"read&write"
                                    }],
                                    created:Date.now()
                                }
                            }

                            stufftemp.create( d, function (err : Null<Error>, stuff : Stuff) : Void {
                                console.log("inside callback err is " + err + " stuff is " + stuff);
                                res.send("success");
                            });
                        }
                        else{
                            id=null;
                        }
                    });

                }
                if(id==null){
                    res.send("patherror");
                }
            }
            else{
                var path : Array<String> =req.param("folder").split("/");

                var err, id = @async findFileId(path,stufftemp);
                // TODO Check for error

                trace("test2  err is "+err);
                trace("test2  id is "+id);

                if( id != null ){
                    stufftemp.find({"parentid" : id,
                        "isFolder" : false, "fileName" : req.param('fileName')},
                    function (err : Null<Error>, stuff) : Void {
                        if(stuff.length==0){
                            var d : StuffData = {
                                parentid:id,
                                isFolder:false,
                                fileName:req.param("fileName"),
                                version:[{
                                    number:0,
                                    contents:haxe.Json.stringify(_req.body),
                                    modified:Date.now()
                                }],
                                metainformation:{
                                    fileType:"CircuitDiagram",
                                    owner:req.param("username"),
                                    permissions:[{
                                        group:"a",
                                        permission:"read&write"
                                    }],
                                    created:Date.now()
                                }
                            }

                            stufftemp.create( d, function (err : Null<Error>, stuff : Stuff) : Void {
                                // TODO check for error
                                console.log("inside callback err is " + err + " stuff is " + stuff);
                                res.send("success");
                            });
                        }
                        else{
                            stuff[0].version.push({
                                number:stuff[0].version.length,
                                contents:haxe.Json.stringify(_req.body),
                                modified:Date.now()
                            });
                            var err, id= @async stufftemp.update({"_id" : stuff[0]._id},{"version":stuff[0].version});
                            trace("error is: "+err+"data is: "+id);
                        }
                    });

                }
            }
        });

        app.get('/forgot', function (req : Request, res : Response) {
            //console.log("Got a GET request for the homepage");
            //res.send(Node.__dirname);
            res.sendfile(Node.__dirname+'/forgot.html');
        });

        app.post('/forgot/users', jsonParser, function (req : Request, res : Response,next ) {
            var _req : Dynamic = req;
            var username = req.param('username');
            var db = new HaxeLow('db.json');
            var user = db.col(User);
            var flag:Bool =false;
            var temp:String='';
            var pass:String='';
            for(i  in user){
                if(i.getname() == username){
                    flag = true;
                    temp = i.getmail();
                    pass = i.getpassword();
                }
            }
            if(flag == true){
                var options = {
                    from        : 'web.circuitdiagram@hotmail.com',
                    to          : temp,
                    subject        : 'From web application',
                    text          : 'From web application',
                    html           : '<h1>Hello, your password is:  '+pass+'！</h1>',
                    attachments :
                    [

                    ]
                };
                mailTransport.sendMail(options, function(err, msg){
                    if(err){
                        console.log(err);
                    }
                    else {
                        console.log("email sent to user: "+username);
                    }
                });
                res.send("y");
            }
            else{
                res.send("n");
            }
        });

        app.get('/changepassword', function (req : Request, res : Response) {
            res.sendfile(Node.__dirname+'/changepassword.html');
        });


        app.post('/changepassword/users', jsonParser, function (req : Request, res : Response,next ) {
            var _req : Dynamic = req;
            var username = req.param('username');
            var db = new HaxeLow('db.json');
            var user = db.col(User);
            var flag:Bool = true;
            for(i in user){
                if(i.getname() == username){
                    flag = i.changepass(_req.body.oldp,_req.body.newp);
                    break;
                }
            }
            if(flag == true){
                db.save();
                res.send('y');
            }
            else{
                res.send('n');
            }

        });

        app.use(function(req, res, next) {
            res.status(404).send('404');
        });

        app.listen(app.get('port'), function(){
            trace('Express server listening on port ' + app.get('port'));
        });

    }


    function findFileId(path:Array<String>, manager : StuffManager, callback : Callback<String>):Void{
        var err,rootModel = @async manager.find({ "fileName" : path[0], "isFolder" : true});
        if( err != null ) { trace(err); callback(err, null) ; }
        else {
            var idOfFolder =Std.string(rootModel[0]._id);
            trace("id of root is "+idOfFolder);
            findFileIdHelper(1,idOfFolder,path,manager, callback) ; }
    }

    function findFileIdHelper(i:Int,
                              idOfCurrent:String,
                              path:Array<String>,
                              manager : StuffManager,
                              callback : Callback<String>):Void{
        if(i < path.length ){
            var err,results = @async manager.find({"parentid" : idOfCurrent, "fileName" : path[i]} );
            if( err != null) {
                trace(err); callback(err, null) ; }
            else if(results.length!=0){
                idOfCurrent=Std.string(results[0]._id);
                findFileIdHelper( i+1, idOfCurrent, path,manager, callback) ; }
            else{callback(null,null);}
        }
        else {
            callback( null, idOfCurrent ) ; }
    }

    static public function main()
    {
        var main = new Main();
    }
}