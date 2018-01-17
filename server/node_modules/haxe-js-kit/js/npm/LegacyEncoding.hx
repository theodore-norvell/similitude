package js.npm;

import js.node.Buffer;

@:enum abstract Mode(String) from String to String {
	var replacement = "replacement";
	var fatal = "fatal";
	var html = "html";
}

extern class LegacyEncoding implements Dynamic
implements npm.Package.Require<"legacy-encoding","^3.0.0"> {
	public static function encode(input : String, encoding : Encodings, ?options : {mode: Mode}) : Buffer;
	public static function decode(input : Buffer, encoding : Encodings, ?options : {mode: Mode}) : String;
}

@:enum abstract Encodings(String) from String to String {
	// 10000
	// 10006
	// 10007
	// 10029
	// 10079
	// 10081
	// 1046
	// 1124
	// 1125
	// 1129
	// 1133
	// 1161
	// 1162
	// 1163
	// 1250
	// 1251
	// 1252
	// 1253
	// 1254
	// 1255
	// 1256
	// 1257
	// 1258
	// 20866
	// 21866
	// 28591
	// 28592
	// 28593
	// 28594
	// 28595
	// 28596
	// 28597
	// 28598
	// 28599
	// 28600
	// 28601
	// 28603
	// 28604
	// 28605
	// 28606
	// 437
	// 737
	// 775
	// 808
	// 850
	// 852
	// 855
	// 856
	// 857
	// 858
	// 860
	// 861
	// 862
	// 863
	// 864
	// 865
	// 866
	// 869
	// 874
	// 922
	// 932
	// 936
	// 949
	// 950
	// ansi_x3.4-1968
	// ansix3.4
	// ansix3.41968
	// ansix3.41986
	var arabic = "arabic";
	var arabic8 = "arabic8";
	var armscii8 = "armscii8";
	var ascii = "ascii";
	var ascii8bit = "ascii8bit";
	// asmo-708
	var asmo708 = "asmo708";
	var base64 = "base64";
	var big5 = "big5";
	var big5hkscs = "big5hkscs";
	var binary = "binary";
	var celtic = "celtic";
	var celtic8 = "celtic8";
	var cesu8 = "cesu8";
	var chinese = "chinese";
	var cn = "cn";
	var cnbig5 = "cnbig5";
	var cp1046 = "cp1046";
	var cp1124 = "cp1124";
	var cp1125 = "cp1125";
	var cp1129 = "cp1129";
	var cp1133 = "cp1133";
	var cp1161 = "cp1161";
	var cp1162 = "cp1162";
	var cp1163 = "cp1163";
	var cp1250 = "cp1250";
	var cp1251 = "cp1251";
	var cp1252 = "cp1252";
	var cp1253 = "cp1253";
	var cp1254 = "cp1254";
	var cp1255 = "cp1255";
	var cp1256 = "cp1256";
	var cp1257 = "cp1257";
	var cp1258 = "cp1258";
	var cp20866 = "cp20866";
	var cp21866 = "cp21866";
	var cp28591 = "cp28591";
	var cp28592 = "cp28592";
	var cp28593 = "cp28593";
	var cp28594 = "cp28594";
	var cp28595 = "cp28595";
	var cp28596 = "cp28596";
	var cp28597 = "cp28597";
	var cp28598 = "cp28598";
	var cp28599 = "cp28599";
	var cp28600 = "cp28600";
	var cp28601 = "cp28601";
	var cp28603 = "cp28603";
	var cp28604 = "cp28604";
	var cp28605 = "cp28605";
	var cp28606 = "cp28606";
	var cp367 = "cp367";
	var cp437 = "cp437";
	var cp737 = "cp737";
	var cp775 = "cp775";
	var cp808 = "cp808";
	var cp819 = "cp819";
	var cp850 = "cp850";
	var cp852 = "cp852";
	var cp855 = "cp855";
	var cp856 = "cp856";
	var cp857 = "cp857";
	var cp858 = "cp858";
	var cp860 = "cp860";
	var cp861 = "cp861";
	var cp862 = "cp862";
	var cp863 = "cp863";
	var cp864 = "cp864";
	var cp865 = "cp865";
	var cp866 = "cp866";
	var cp869 = "cp869";
	var cp874 = "cp874";
	var cp922 = "cp922";
	var cp932 = "cp932";
	var cp936 = "cp936";
	var cp949 = "cp949";
	var cp950 = "cp950";
	var cpgr = "cpgr";
	var csascii = "csascii";
	var csbig5 = "csbig5";
	var cseuckr = "cseuckr";
	var csgb2312 = "csgb2312";
	var cshproman8 = "cshproman8";
	var csibm1046 = "csibm1046";
	var csibm1124 = "csibm1124";
	var csibm1125 = "csibm1125";
	var csibm1129 = "csibm1129";
	var csibm1133 = "csibm1133";
	var csibm1161 = "csibm1161";
	var csibm1162 = "csibm1162";
	var csibm1163 = "csibm1163";
	var csibm437 = "csibm437";
	var csibm737 = "csibm737";
	var csibm775 = "csibm775";
	var csibm850 = "csibm850";
	var csibm852 = "csibm852";
	var csibm855 = "csibm855";
	var csibm856 = "csibm856";
	var csibm857 = "csibm857";
	var csibm858 = "csibm858";
	var csibm860 = "csibm860";
	var csibm861 = "csibm861";
	var csibm862 = "csibm862";
	var csibm863 = "csibm863";
	var csibm864 = "csibm864";
	var csibm865 = "csibm865";
	var csibm866 = "csibm866";
	var csibm869 = "csibm869";
	var csibm922 = "csibm922";
	var csiso14jisc6220ro = "csiso14jisc6220ro";
	var csiso58gb231280 = "csiso58gb231280";
	var csiso88596e = "csiso88596e";
	var csiso88596i = "csiso88596i";
	var csiso88598e = "csiso88598e";
	var csiso88598i = "csiso88598i";
	var csisolatin1 = "csisolatin1";
	var csisolatin2 = "csisolatin2";
	var csisolatin3 = "csisolatin3";
	var csisolatin4 = "csisolatin4";
	var csisolatin5 = "csisolatin5";
	var csisolatin6 = "csisolatin6";
	var csisolatin9 = "csisolatin9";
	var csisolatinarabic = "csisolatinarabic";
	var csisolatincyrillic = "csisolatincyrillic";
	var csisolatingreek = "csisolatingreek";
	var csisolatinhebrew = "csisolatinhebrew";
	var cskoi8r = "cskoi8r";
	var csksc56011987 = "csksc56011987";
	var csmacintosh = "csmacintosh";
	var cspc775baltic = "cspc775baltic";
	var cspc850multilingual = "cspc850multilingual";
	var cspc862latinhebrew = "cspc862latinhebrew";
	var cspc8codepage437 = "cspc8codepage437";
	var cspcp852 = "cspcp852";
	var csshiftjis = "csshiftjis";
	var cyrillic = "cyrillic";
	// dos-874
	// ecma-114
	// ecma-118
	var ecma114 = "ecma114";
	var ecma118 = "ecma118";
	var elot928 = "elot928";
	var elot_928 = "elot_928";
	// euc-jp
	var euccn = "euccn";
	var eucjp = "eucjp";
	var euckr = "euckr";
	var gb18030 = "gb18030";
	var gb198880 = "gb198880";
	var gb2312 = "gb2312";
	var gb23121980 = "gb23121980";
	var gb231280 = "gb231280";
	var gbk = "gbk";
	var georgianacademy = "georgianacademy";
	var georgianps = "georgianps";
	var greek = "greek";
	var greek8 = "greek8";
	var hebrew = "hebrew";
	var hebrew8 = "hebrew8";
	var hex = "hex";
	var hproman8 = "hproman8";
	var ibm1046 = "ibm1046";
	var ibm1051 = "ibm1051";
	var ibm1124 = "ibm1124";
	var ibm1125 = "ibm1125";
	var ibm1129 = "ibm1129";
	var ibm1133 = "ibm1133";
	var ibm1161 = "ibm1161";
	var ibm1162 = "ibm1162";
	var ibm1163 = "ibm1163";
	var ibm1168 = "ibm1168";
	var ibm367 = "ibm367";
	var ibm437 = "ibm437";
	var ibm737 = "ibm737";
	var ibm775 = "ibm775";
	var ibm808 = "ibm808";
	var ibm819 = "ibm819";
	var ibm850 = "ibm850";
	var ibm852 = "ibm852";
	var ibm855 = "ibm855";
	var ibm856 = "ibm856";
	var ibm857 = "ibm857";
	var ibm858 = "ibm858";
	var ibm860 = "ibm860";
	var ibm861 = "ibm861";
	var ibm862 = "ibm862";
	var ibm863 = "ibm863";
	var ibm864 = "ibm864";
	var ibm865 = "ibm865";
	var ibm866 = "ibm866";
	var ibm869 = "ibm869";
	var ibm878 = "ibm878";
	var ibm922 = "ibm922";
	// iso-2022-jp
	// iso-2022-jp-1
	// iso-8859-1
	// iso-8859-11
	// iso-8859-15
	// iso-8859-2
	// iso-8859-3
	// iso-8859-4
	// iso-8859-5
	// iso-8859-6
	// iso-8859-6-e
	// iso-8859-6-i
	// iso-8859-7
	// iso-8859-8
	// iso-8859-8-e
	// iso-8859-8-i
	// iso-8859-9
	// iso-ir-100
	// iso-ir-101
	// iso-ir-109
	// iso-ir-110
	// iso-ir-126
	// iso-ir-127
	// iso-ir-138
	// iso-ir-144
	// iso-ir-148
	// iso8859-1
	// iso8859-11
	// iso8859-15
	// iso8859-2
	// iso8859-3
	// iso8859-4
	// iso8859-5
	// iso8859-6
	// iso8859-7
	// iso8859-8
	// iso8859-9
	var iso2022jp = "iso2022jp";
	// iso646.irv
	var iso646cn = "iso646cn";
	var iso646jp = "iso646jp";
	var iso646us = "iso646us";
	var iso88591 = "iso88591";
	var iso885910 = "iso885910";
	var iso885911 = "iso885911";
	var iso885913 = "iso885913";
	var iso885914 = "iso885914";
	var iso885915 = "iso885915";
	var iso885916 = "iso885916";
	var iso88592 = "iso88592";
	var iso88593 = "iso88593";
	var iso88594 = "iso88594";
	var iso88595 = "iso88595";
	var iso88596 = "iso88596";
	var iso88597 = "iso88597";
	var iso88598 = "iso88598";
	var iso88599 = "iso88599";
	// iso_8859-1
	// iso_8859-15
	// iso_8859-1:1987
	// iso_8859-2
	// iso_8859-2:1987
	// iso_8859-3
	// iso_8859-3:1988
	// iso_8859-4
	// iso_8859-4:1988
	// iso_8859-5
	// iso_8859-5:1988
	// iso_8859-6
	// iso_8859-6:1987
	// iso_8859-7
	// iso_8859-7:1987
	// iso_8859-8
	// iso_8859-8:1988
	// iso_8859-9
	// iso_8859-9:1989
	var isoceltic = "isoceltic";
	var isoir100 = "isoir100";
	var isoir101 = "isoir101";
	var isoir109 = "isoir109";
	var isoir110 = "isoir110";
	var isoir126 = "isoir126";
	var isoir127 = "isoir127";
	var isoir138 = "isoir138";
	var isoir14 = "isoir14";
	var isoir144 = "isoir144";
	var isoir148 = "isoir148";
	var isoir149 = "isoir149";
	var isoir157 = "isoir157";
	var isoir166 = "isoir166";
	var isoir179 = "isoir179";
	var isoir199 = "isoir199";
	var isoir203 = "isoir203";
	var isoir226 = "isoir226";
	var isoir57 = "isoir57";
	var isoir58 = "isoir58";
	var isoir6 = "isoir6";
	var jis = "jis";
	var jisc62201969ro = "jisc62201969ro";
	var jp = "jp";
	var koi = "koi";
	var koi8 = "koi8";
	// koi8-r
	var koi8_r = "koi8_r";
	var koi8r = "koi8r";
	var koi8ru = "koi8ru";
	var koi8t = "koi8t";
	var koi8u = "koi8u";
	var korean = "korean";
	var ksc5601 = "ksc5601";
	var ksc56011987 = "ksc56011987";
	var ksc56011989 = "ksc56011989";
	var l1 = "l1";
	var l10 = "l10";
	var l2 = "l2";
	var l3 = "l3";
	var l4 = "l4";
	var l5 = "l5";
	var l6 = "l6";
	var l7 = "l7";
	var l8 = "l8";
	var l9 = "l9";
	var latin1 = "latin1";
	var latin10 = "latin10";
	var latin2 = "latin2";
	var latin3 = "latin3";
	var latin4 = "latin4";
	var latin5 = "latin5";
	var latin6 = "latin6";
	var latin7 = "latin7";
	var latin8 = "latin8";
	var latin9 = "latin9";
	var logical = "logical";
	var mac = "mac";
	var maccenteuro = "maccenteuro";
	var maccroatian = "maccroatian";
	var maccyrillic = "maccyrillic";
	var macgreek = "macgreek";
	var maciceland = "maciceland";
	var macintosh = "macintosh";
	var macroman = "macroman";
	var macromania = "macromania";
	var macthai = "macthai";
	var macturkish = "macturkish";
	var macukraine = "macukraine";
	var msansi = "msansi";
	var msarab = "msarab";
	var mscyrl = "mscyrl";
	var msee = "msee";
	var msgreek = "msgreek";
	var mshebr = "mshebr";
	var mskanji = "mskanji";
	var msturk = "msturk";
	var pt154 = "pt154";
	var r8 = "r8";
	var rk1048 = "rk1048";
	var roman8 = "roman8";
	var shift_jis = "shift_jis";
	var shiftjis = "shiftjis";
	var sjis = "sjis";
	var strk10482002 = "strk10482002";
	var sun_eu_greek = "sun_eu_greek";
	var tcvn = "tcvn";
	var tcvn5712 = "tcvn5712";
	var tcvn57121 = "tcvn57121";
	var thai = "thai";
	var thai8 = "thai8";
	// tis-620
	var tis620 = "tis620";
	// tis620.25291
	// tis620.25330
	var tis6200 = "tis6200";
	var turkish = "turkish";
	var turkish8 = "turkish8";
	// ucs-2
	var ucs2 = "ucs2";
	var unicode = "unicode";
	var unicode11utf8 = "unicode11utf8";
	var us = "us";
	// us-ascii
	var usascii = "usascii";
	// utf-16le
	var utf16 = "utf16";
	var utf16be = "utf16be";
	var utf16le = "utf16le";
	var utf7 = "utf7";
	var utf7imap = "utf7imap";
	var utf8 = "utf8";
	var viscii = "viscii";
	var visual = "visual";
	var win1250 = "win1250";
	var win1251 = "win1251";
	var win1252 = "win1252";
	var win1253 = "win1253";
	var win1254 = "win1254";
	var win1255 = "win1255";
	var win1256 = "win1256";
	var win1257 = "win1257";
	var win1258 = "win1258";
	var win874 = "win874";
	var winbaltrim = "winbaltrim";
	// windows-1250
	// windows-1251
	// windows-1252
	// windows-1253
	// windows-1254
	// windows-1255
	// windows-1256
	// windows-1257
	// windows-1258
	// windows-31j
	// windows-874
	var windows1250 = "windows1250";
	var windows1251 = "windows1251";
	var windows1252 = "windows1252";
	var windows1253 = "windows1253";
	var windows1254 = "windows1254";
	var windows1255 = "windows1255";
	var windows1256 = "windows1256";
	var windows1257 = "windows1257";
	var windows1258 = "windows1258";
	var windows874 = "windows874";
	var windows932 = "windows932";
	var windows936 = "windows936";
	var windows949 = "windows949";
	var windows950 = "windows950";
	// x-cp1250
	// x-cp1251
	// x-cp1252
	// x-cp1253
	// x-cp1254
	// x-cp1255
	// x-cp1256
	// x-cp1257
	// x-cp1258
	// x-mac-cyrillic
	// x-mac-roman
	// x-mac-ukrainian
	// x-sjis
	var xgbk = "xgbk";
	var xroman8 = "xroman8";
	var xxbig5 = "xxbig5";
}
