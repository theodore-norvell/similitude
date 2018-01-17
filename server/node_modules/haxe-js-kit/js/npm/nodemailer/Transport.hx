package js.npm.nodemailer;

import js.npm.nodemailer.Transporter.MailResult;

//extern class Transport
typedef Transport = {
	var name : String;
	var version : String;
	function send<T>(mail : T, callback : Dynamic -> MailResult -> Void) : Void;
}
