package ;

import tjson.TJSON;
import tjson.TJSON;
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
    isFolder:Bool,
    fileName:String,
    version:Array<{
        number:Int,
        contents:String,
        modified:Date
    }>,
    ?fileList:Array<{
    fileName:String,
    id:String,
    fileType:String
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
typedef AccountData={
    username:String,
    password:String,
    email:String
}
class Stuff extends Model<StuffData>{}
class Account extends Model<AccountData>{}
class StuffManager extends js.npm.mongoose.macro.Manager<StuffData,Stuff>{}
class AccountManager extends js.npm.mongoose.macro.Manager<AccountData,Account>{}
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
        var accountMan: AccountManager = AccountManager.build(database, "account");







//        stuffMan.find({ _id:"5a96105fd7b3122cccb603c0"},function (err : Null<Error>, stuff) : Void {
//            trace(stuff[0]);
//        });


//        stuffMan.remove( {_id:"5a9610fb28608225a0ed5181"},function (err : Null<Error>) : Void {
//            console.log("inside callback err is " + err);
//        } ) ;


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
            res.sendfile(Node.__dirname+'/login.html');
        });

        app.post('/', jsonParser,function (req : Request, res : Response) {
            var _req : Dynamic = req;
            var err,account = @async accountMan.find({"username":_req.body.username,"password":_req.body.password});
            if(err==null){
                if(account.length!=0){
                    console.log(_req.body.username+" login success");
                    res.send("y");
                }
                else{
                    console.log(_req.body.username+" login fail, wrong password");
                    res.send("n");
                }
            }
            else{
                console.log("login error:"+err);
                res.send("n");
            }
        });


        app.get('/regist', function (req : Request, res : Response) {
            res.sendfile(Node.__dirname+'/regist.html');
        });


        app.post('/regist', jsonParser,function (req : Request, res : Response) {
            var _req : Dynamic = req;
            if(_req.body.username!=""){
                var err0,namedata = @async accountMan.find({"username":_req.body.username});
                if(err0==null){
                    if(namedata.length==0){
                        var err1,emaildata = @async accountMan.find({"email":_req.body.email});
                        if(err1==null){
                            if(emaildata.length==0){
                                var ac : AccountData = {
                                    username:_req.body.username,
                                    password:_req.body.password,
                                    email:_req.body.email
                                }
                                var err3,newdata = @async accountMan.create( ac);
                                console.log("creating new account error is: " + err3 + " stuff is " + newdata);
                                if(err3==null){
                                    var d : StuffData = {
                                        isFolder:true,
                                        fileName:_req.body.username,
                                        version:[{
                                            number:0,
                                            contents:"",
                                            modified:Date.now()
                                        }],
                                        fileList:[],
                                        metainformation:{
                                            fileType:"Folder",
                                            owner:_req.body.username,
                                            permissions:[{
                                                group:"",
                                                permission:"read&write"
                                            }],
                                            created:Date.now()
                                        }
                                    }
                                    var err6,newfolder = @async stuffMan.create( d);
                                    console.log("creating new folder error is: " + err6 + " stuff is " + newfolder);
                                    var err4,root = @async stuffMan.find({"fileName":"","isFolder":true});
                                    if(err4==null){
                                        if(root.length!=0){
                                            root[0].fileList.push({fileName:_req.body.username,id:Std.string(newfolder._id),fileType:"Folder"});
                                            var err5, root1= @async stuffMan.update({"_id" : root[0]._id},{"fileList":root[0].fileList});
                                            if(err5==null){
                                                console.log("new account register: "+_req.body.username);
                                                res.send("t");
                                            }
                                            else{
                                                res.send("fail");
                                            }
                                        }
                                        else{
                                            res.send("fail");
                                        }
                                    }
                                    else{
                                        res.send("fail");
                                    }
                                }
                                else{
                                    res.send("fail");
                                }

                            }
                            else{
                                res.send("email");
                            }
                        }
                        else{
                            console.log("register error: "+err0);
                            res.send("email");
                        }
                    }
                    else{
                        res.send("username");
                    }
                }
                else{
                    console.log("register error: "+err0);
                    res.send("username");
                }
            }
            else{
                res.send("fail");
            }

        });


        app.get('/app/users', function (req : Request, res : Response,next ) {
            //console.log("Got a GET request for the homepage");
            //res.send(Node.__dirname);
            var _req : Dynamic = req;
            var username = req.param('username');
            res.sendfile((Node.__dirname).substring(0,(Node.__dirname).indexOf('server\\src'))+"\\client\\app.html");
        });

        app.post('/app/users', jsonParser, function (req : Request, res : Response,next ) {
            var _req : Dynamic = req;

            var d : StuffData = {
                isFolder:true,
                fileName:"root",
                version:[{
                    number:0,
                    contents:haxe.Json.stringify(_req.body),
                    modified:Date.now()
                }],
                fileList:[],
                metainformation:{
                    fileType:"folder",
                    owner:"test",
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

            stuffMan.find({"_id": "5a99837266a081105cc8b355"},function (err : Null<Error>, stuff) : Void {
//                trace(stuff[0].version[0].contents);
                res.send(stuff[0].version[0].contents);
            });

        });

        app.post('/app/users/folder',function (req : Request, res : Response,next ) {
            var _req : Dynamic = req;
            console.log(req.param('new')+req.param('username')+req.param('folder').split("/")[0]+req.param('fileName'));
            var stufftemp =stuffMan;
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
                    var err, stuff= @async stufftemp.find({_id:id});
                        if(stuff.length!=0){
                            var flag:Bool=true;
                            for(i in stuff[0].fileList){
                                if(path[path.length-1]==i.fileName){
                                    flag=false;
                                }
                            }
                            if(flag==true){
                                var d : StuffData = {
                                    isFolder:true,
                                    fileName:path[path.length-1],
                                    version:[{
                                        number:0,
                                        contents:"",
                                        modified:Date.now()
                                    }],
                                    fileList:[],
                                    metainformation:{
                                        fileType:"Folder",
                                        owner:req.param('username'),
                                        permissions:[{
                                            group:"a",
                                            permission:"read&write"
                                        }],
                                        created:Date.now()
                                    }
                                }

                                var err, NewData= @async stufftemp.create( d);
                                // TODO check for error
                                console.log(req.param('username')+" create new folder callback err is " + err + " stuff is " + NewData);

                                var err1, Folder= @async stufftemp.find({_id:id});
                                console.log("finding parent folder find error:"+err1);
                                Folder[0].fileList.push({fileName:path[path.length-1],id:Std.string(NewData._id),fileType:"Folder"});
                                var err2, id= @async stufftemp.update({"_id" : id},{"fileList":Folder[0].fileList});
                                console.log(err2);
                                res.send("success");
                            }
                            else{
                                res.send("existed");
                            }

                        }
                        else{
                            res.send("patherror");
                        }
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
                    var err1, parentFolder = @async stufftemp.find({_id:id});
                    trace(err1);
                    var fileId:String="";
                    if(parentFolder.length!=0){
                        for(i in  parentFolder[0].fileList){
                            if(i.fileName==req.param('fileName')){
                                fileId=i.id;
                            }
                        }
                        trace(fileId);
                        if(fileId==""){
                            var d : StuffData = {
                                isFolder:false,
                                fileName:req.param("fileName"),
                                version:[{
                                    number:0,
                                    contents:haxe.Json.stringify(_req.body),
                                    modified:Date.now()
                                }],
                                fileList:[],
                                metainformation:{
                                    fileType:"Circuit",
                                    owner:req.param("username"),
                                    permissions:[{
                                        group:"a",
                                        permission:"read&write"
                                    }],
                                    created:Date.now()
                                }
                            }

                            var err, NewData= @async stufftemp.create( d);
                            // TODO check for error
                            console.log("inside callback err is " + err + " stuff is " + NewData);

                            var err, Folder= @async stufftemp.find({_id:id});
                            trace(err);
                            Folder[0].fileList.push({fileName:req.param("fileName"),id:Std.string(NewData._id),fileType:"Circuit"});
                            var err, updated= @async stufftemp.update({"_id" : id},{"fileList":Folder[0].fileList});
                            trace(err);
                            res.send("success");
                        }
                        else{
                            var err, stuff = @async stufftemp.find({_id:fileId});
                            trace(err);
                            if(stuff.length!=0){
                                stuff[0].version.push({
                                    number:stuff[0].version.length,
                                    contents:haxe.Json.stringify(_req.body),
                                    modified:Date.now()
                                });
                                var err, id= @async stufftemp.update({"_id" : stuff[0]._id},{"version":stuff[0].version});
                                console.log("error is: "+err+"data is: "+id);
                                res.send("success");
                            }
                            else{
                                res.send("fail");
                            }
                        }
                    }
                    else{
                        res.send("fail");
                    }
                }
                else{
                    res.send("fail");
                }
            }
        });


        app.post('/app/users/delete',function(req:Request,res:Response,next){
            var path : Array<String> =req.param('folder').split("/");
            var err, id = @async findFileId(path,stuffMan);
            stuffMan.remove( {"parentid":id,"fileName":req.param("fileName")},function (err : Null<Error>) : Void {
            console.log("inside callback err is " + err);
            } ) ;
        });

        app.post('/app/users/download',function(req:Request,res:Response,next){
            var path : Array<String> =req.param('folder').split("/");
            var err, FolderId = @async findFileId(path,stuffMan);
            if(err!=null){
                console.log(err);
                res.send("fail");

            }
            else if(FolderId!=null){
                var err1, data = @async stuffMan.find({"parentid":FolderId,"fileName":req.param("fileName")});
                if(err!=null){
                    console.log(err);
                    res.send("fail");

                }
                var flag:Bool=false;
                if(data.length!=0){
                    for(i in data[0].version){
                        if(i.number==Std.parseInt(req.param("version"))){
                            flag=true;
                            res.send(i.contents);
                        }
                    }
                }
                if(flag==false){
                    res.send("fail");
                }
            }
            else{
                res.send("fail");
            }
        });

        app.post('/app/users/showfolder',function(req:Request,res:Response,next){
            var path : Array<String> =req.param('folder').split("/");
            var err, FolderId = @async findFileId(path,stuffMan);
            if(err!=null){
                console.log(err);
                res.send("fail");

            }
            else if(FolderId!=null){
                var err1, data = @async stuffMan.find({_id:FolderId});
                if(err!=null){
                    console.log(err);
                    res.send("fail");
                }
                if(data.length!=0){
                    res.send(haxe.Json.stringify(data[0].fileList));
                }
                else{
                    res.send("fail");
                }
            }
            else{
                res.send("fail");
            }
        });


        app.post('/app/users/showversion',function(req:Request,res:Response,next){
            var id:String=req.param("id");
            var err,data = @async stuffMan.find({_id:id});
            if(err==null){
                if(data.length!=0){
                    res.send(Std.string(data[0].version.length));
                }
                else{
                    res.send("fail");
                }
            }
            else{
                res.send("fail");
            }

        });

        app.get('/forgot', function (req : Request, res : Response) {
            res.sendfile(Node.__dirname+'/forgot.html');
        });

        app.post('/forgot/users', jsonParser, function (req : Request, res : Response,next ) {
            var _req : Dynamic = req;
            var username = req.param('username');

            var err,account = @async accountMan.find({"username": username});
            if(err==null){
                if(account.length!=0){
                    var options = {
                        from        : 'web.circuitdiagram@hotmail.com',
                        to          : account[0].email,
                        subject        : 'From web application',
                        text          : 'From web application',
                        html           : '<h1>Hello, your password is:  </h1>'+'<h1 style=\"color:red\">'+account[0].password+'</h1>',
                        attachments :[]
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
            }
            else{
                res.send("n");
            }
        });

        app.get('/changepassword', function (req : Request, res : Response) {
            res.sendfile(Node.__dirname+'/changepassword.html');
        });


        app.post('/initial', function (req : Request, res : Response) {
            var errpath,rootModel = @async stuffMan.find({ "fileName" : "", "isFolder" : true});
            if(errpath!=null){console.log(errpath);}
            else if(rootModel.length==0){
                var d : StuffData = {
                    isFolder:true,
                    fileName:"",
                    version:[{
                        number:0,
                        contents:"",
                        modified:Date.now()
                    }],
                    fileList:[],
                    metainformation:{
                        fileType:"folder",
                        owner:"",
                        permissions:[{
                            group:"",
                            permission:"read&write"
                        }],
                        created:Date.now()
                    }
                }

                stuffMan.create( d, function (err : Null<Error>, stuff : Stuff) : Void {
                    console.log("inside callback err is " + err + " stuff is " + stuff);
                });
            }

        });

        app.post('/changepassword/users', jsonParser, function (req : Request, res : Response,next ) {
            var _req : Dynamic = req;
            var username = req.param('username');

            var err,account = @async accountMan.find({"username": username,"password":_req.body.oldp});
            if(err==null){
                if(account.length!=0){
                    var err1, updated = @async accountMan.update({"username": username,"password":_req.body.oldp},{"password":_req.body.newp});
                    if(err1==null){
                        res.send("y");
                    }
                    else{
                        res.send("n");
                    }
                }
                else{
                    res.send("n");
                }
            }
            else{
                res.send("n");
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
        if(path[0]=="root"){
            var err,rootModel = @async manager.find({ "fileName" : "", "isFolder" : true});
            if( err != null ) { trace(err); callback(err, null) ; }
            else if(rootModel.length!=0){
                var idOfFolder =Std.string(rootModel[0]._id);
                trace("id of root is "+idOfFolder);
                findFileIdHelper(1,idOfFolder,path,manager, callback) ; }
            else{
                callback(err, null);
            }
        }
        else{
            callback(null, null);
        }
    }

    function findFileIdHelper(i:Int,
                              idOfCurrent:String,
                              path:Array<String>,
                              manager : StuffManager,
                              callback : Callback<String>):Void{
        if(i < path.length ){
            var err,results = @async manager.find({"_id":idOfCurrent} );
            if( err != null) {
                trace(err); callback(err, null) ; }
            else if(results.length!=0){
                var flag:Bool=true;
                for(t in results[0].fileList){
                    if(t.fileName == path[i]){
                        idOfCurrent=t.id;
                        flag=false;
                }
                }
                if(flag==false){
                    findFileIdHelper( i+1, idOfCurrent, path,manager, callback) ;
                }
                else{
                    callback(null,null);
                }
                 }
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