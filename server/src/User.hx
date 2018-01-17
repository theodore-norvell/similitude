package ;
class User {

    var username:String;
    var password:String;
    var email:String;

    public function new(u:String,p:String,e:String) {
        username=u;
        password=p;
        email=e;
    }

    public function getname():String{
        return username;
    }

    public function getmail():String{
        return email;
    }

    public function check(name:String, pass:String):Bool{
        if(name == username && pass == password){
            return true;
        }
        else {
            return false;
        }
    }

    public function getpassword():String{
        return password;
    }


}
