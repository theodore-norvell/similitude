package js.npm;

import js.node.stream.Readable;
import js.node.stream.Writable;

typedef YaCsvOptions = {
	?encoding : String,
	?separator : String,
	?quote : String,
	?escape : String,
	?comment : String,
	?columnNames : Array<String>,
	?columnsFromHeader : Bool,
	?nestedQuotes : Bool
}

extern class YaCsv
extends Readable<YaCsv>
implements npm.Package.Require<"ya-csv", "^0.9.4">
{
	// Read
	@:overload(function(fileName : String) : YaCsv {})
	public static function createCsvFileReader(fileName : String, options : YaCsvOptions) : YaCsv;

	@:overload(function(reader : IReadable) : YaCsv {})
	public static function createCsvStreamReader(reader : IReadable, options : YaCsvOptions) : YaCsv;

	// Write
	@:overload(function(writer : IWritable) : YaCsvWriter {})
	public static function createCsvFileWriter(fileName : String, options : {}) : YaCsvWriter;

	@:overload(function(writer : IWritable) : YaCsvWriter {})
	public static function createCsvStreamWriter(writer : IWritable, options : {}) : YaCsvWriter;

	public function setColumnNames(columns : Array<String>) : Void;
}

extern class YaCsvWriter
{
	public function writeRecord<T : Array<Dynamic>>(data : T) : Void;
}
