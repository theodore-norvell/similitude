package ;

import js.Node;
import js.node.Http;
import js.node.Path;
import js.Node.console;
import js.npm.Express;
import js.npm.Nodemailer;
import js.npm.express.*;

class Main
{

    private var server:Dynamic;
    function new()
    {
        var app :Express = new Express();

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
                /**
            var raw = i;
            var myInstance:User = new User("1","1","1");

            var structsFields:Array<String> = Reflect.fields(raw);
            var classFields:Array<String> = Type.getInstanceFields(Type.getClass(myInstance));

            for (field in structsFields)
            {
                if (classFields.indexOf(field) > -1)
                {
                    var value:Dynamic = Reflect.field(raw, field);
                    Reflect.setField(myInstance, field, value);
                }
            }
            trace(myInstance.getname());
            **/
                if(i.getname() == _req.body.username ){
                           usernameflag = false;
                        }
                if( i.getmail() == _req.body.email){
                    emailflag = false;
                }

                //trace(i.getname());
                //trace(_req.body.username);
            }

            if(emailflag==true && usernameflag == true){
                user.push(_req.body);
                db.save();
                console.log("t");
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




            //var _username = _req.body.name;
            //trace( _req.body );
            //trace(_req.body.name);

        });

// This responds a DELETE request for the /del_user page.

        app.get('/app/users', jsonParser, function (req : Request, res : Response,next ) {
            //console.log("Got a GET request for the homepage");
            //res.send(Node.__dirname);
            var _req : Dynamic = req;
            var username = req.param('username');
            trace(username);
            res.sendfile((Node.__dirname).substring(0,(Node.__dirname).indexOf('server\\src'))+"\\client\\app.html");
        });

        app.get('/forgot', function (req : Request, res : Response) {
            //console.log("Got a GET request for the homepage");
            //res.send(Node.__dirname);
            res.sendfile(Node.__dirname+'/forgot.html');
        });

        app.post('/forgot/users', jsonParser, function (req : Request, res : Response,next ) {
            //console.log("Got a GET request for the homepage");
            //res.send(Node.__dirname);
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
                    // cc         : ''  //抄送
                    // bcc      : ''    //密送
                    subject        : '一封来自Node Mailer的邮件',
                    text          : '一封来自Node Mailer的邮件',
                    html           : '<h1>Hello, your password is'+pass+'！</h1>',
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

    static public function main()
    {
        var main = new Main();
    }
}