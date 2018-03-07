package ;

import haxe.Json;
import js.html.DOMElement;
import js.Browser;
import js.jquery.JQuery;
import tjson.TJSON;

class Test {
    var registUsername:DOMElement;
    var registPassword:DOMElement;
    var registEmail:DOMElement;
    var b:DOMElement;
    public function new() {
        registUsername = Browser.document.getElementById("regist_username");
        registPassword = Browser.document.getElementById("regist_password");
        registEmail = Browser.document.getElementById("regist_email");
        b= Browser.document.getElementById("regist");
        b.addEventListener('click', regist, false);
    }

    public function regist(){
        var username:String = new JQuery("#regist_username").val();
        var password:String = new JQuery("#regist_password").val();
        var c_password:String = new JQuery("#confirm_password").val();
        var email:String = new JQuery("#regist_email").val() ;
        if(c_password != password){
            new JQuery('#confirm_passwordtag').html("*Confirm Password <br>
            <font color="+"red"+">password don't match</font>");
        }
        else{
        if(username!=""&&password!=""&&email!=""&&c_password!=''){
            var u:User = new User(username,password,email) ;
            //new JQuery("#regist_username").hide();
            var s = {
                username: username,
                password: password,
                email:email
            };
            var o = TJSON.encode(u);
            trace(o);
            //var db = new HaxeLow('db.json');
            //var user = db.col(User);
            //user.push(u);
            //db.save();

            JQuery.ajax( { type:"post",
                           url: "http://127.0.0.1:3000/regist",
                           contentType: "application/json",
                           data:o}
                          )
            .done( function( text : String ) {
                trace(text);
                new JQuery('#nametag').text("*Username");
                new JQuery('#emailtag').text("*Email");
                       if( text == "t" ) {
                            trace( "logged in") ;
                           new JQuery('#alert').css('opacity', 0.5).fadeIn();
                           new JQuery('#alert2').css('opacity', 1).fadeIn();
                           new JQuery('#text1').css('opacity', 1).fadeIn();
                           new JQuery('#text2').css('opacity', 1).fadeIn();
                           var yourTimer:haxe.Timer = new haxe.Timer(5000);
                           yourTimer.run = function():Void{
                               Browser.location.assign("http://127.0.0.1:3000/");
                           };
                       }
                if(text == "username"){
                    new JQuery('#nametag').html("*Username <font color="+"red"+">username already existed</font>");
                    //new JQuery('#nametag').text("*Username   username already existed");
                }
                if(text == "email"){
                    new JQuery('#emailtag').html("*Email <font color="+"red"+">email already existed</font>");
                    //new JQuery('#nametag').text("*Username   username already existed");
                }
                   })
            .fail( function( jqXHR, testStatus, errorThrown ) {} ) ;


        }
        }
    }

    static public function main()


    {
        var main = new Test();


    }
}
