package js.npm.nodemailer;

using js.support.Either;
using js.support.Either.Either4;
using js.node.Buffer;
using js.node.stream.Readable.IReadable;

typedef MailData = {
	?from : String,
	?sender : String,
	?to : Either<String, Array<String>>,
	?cc : Either<String, Array<String>>,
	?bcc : Either<String, Array<String>>,
	?replyTo : String,
	?inReplyTo : String,
	?references : Either<String, Array<String>>,
	?subject : String,
	?text : Either4<String, Buffer, IReadable, {path: String}>,
	?html : Either4<String, Buffer, IReadable, {path: String}>,
	?headers : Either<Dynamic<String>, Array<Dynamic<String>>>,
	?attachments : Array<Dynamic>,
	?alternatives : Array<Dynamic>,
	?envelope : Dynamic,
	?messageId : String,
	?date : Date,
	?encoding : String,
	?generateTextFromHtml : Bool	
}

typedef MailResult = {
	messageId : String, // most transports should return the final Message-Id value used with this property
	?envelope : String, // includes the envelope object for the message
	?accepted : Array<String>, // is an array returned by SMTP transports (includes recipient addresses that were accepted by the server)
	?rejected : Array<String>, // is an array returned by SMTP transports (includes recipient addresses that were rejected by the server)
	?pending : Array<String>, // is an array returned by Direct SMTP transport. Includes recipient addresses that were temporarily rejected together with the server response
	?response : String // is a string returned by SMTP transports and includes the last SMTP response from the server	
}

extern class Transporter
{
	@:overload(function(data : MailData) : Void {})
	@:overload(function(data : MailData, callback : Dynamic -> Void) : Void {})
	public function sendMail(data : MailData, callback : Dynamic -> MailResult -> Void) : Void;
}
