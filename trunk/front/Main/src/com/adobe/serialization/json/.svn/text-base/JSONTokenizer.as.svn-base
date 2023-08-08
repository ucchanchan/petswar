//Created by Action Script Viewer - http://www.buraks.com/asv
package com.adobe.serialization.json {

    public class JSONTokenizer {

        private var loc:int;
        private var ch:String;
        private var obj:Object;
        private var jsonString:String;

        public function JSONTokenizer(_arg1:String){
            jsonString = _arg1;
            loc = 0;
            nextChar();
        }
        private function skipComments():void{
            if (ch == "/"){
                nextChar();
                switch (ch){
                    case "/":
                        do  {
                            nextChar();
                        } while (((!((ch == "\n"))) && (!((ch == "")))));
                        nextChar();
                        break;
                    case "*":
                        nextChar();
                        while (true) {
                            if (ch == "*"){
                                nextChar();
                                if (ch == "/"){
                                    nextChar();
                                    break;
                                };
                            } else {
                                nextChar();
                            };
                            if (ch == ""){
                                parseError("Multi-line comment not closed");
                            };
                        };
                        break;
                    default:
                        parseError((("Unexpected " + ch) + " encountered (expecting '/' or '*' )"));
                };
            };
        }
        private function isDigit(_arg1:String):Boolean{
            return ((((_arg1 >= "0")) && ((_arg1 <= "9"))));
        }
        private function readString():JSONToken{
            var _local3:String;
            var _local4:int;
            var _local1:JSONToken = new JSONToken();
            _local1.type = JSONTokenType.STRING;
            var _local2 = "";
            nextChar();
            while (((!((ch == "\""))) && (!((ch == ""))))) {
                if (ch == "\\"){
                    nextChar();
                    switch (ch){
                        case "\"":
                            _local2 = (_local2 + "\"");
                            break;
                        case "/":
                            _local2 = (_local2 + "/");
                            break;
                        case "\\":
                            _local2 = (_local2 + "\\");
                            break;
                        case "b":
                            _local2 = (_local2 + "\b");
                            break;
                        case "f":
                            _local2 = (_local2 + "\f");
                            break;
                        case "n":
                            _local2 = (_local2 + "\n");
                            break;
                        case "r":
                            _local2 = (_local2 + "\r");
                            break;
                        case "t":
                            _local2 = (_local2 + "\t");
                            break;
                        case "u":
                            _local3 = "";
                            _local4 = 0;
                            while (_local4 < 4) {
                                if (!isHexDigit(nextChar())){
                                    parseError((" Excepted a hex digit, but found: " + ch));
                                };
                                _local3 = (_local3 + ch);
                                _local4++;
                            };
                            _local2 = (_local2 + String.fromCharCode(parseInt(_local3, 16)));
                            break;
                        default:
                            _local2 = (_local2 + ("\\" + ch));
                    };
                } else {
                    _local2 = (_local2 + ch);
                };
                nextChar();
            };
            if (ch == ""){
                parseError("Unterminated string literal");
            };
            nextChar();
            _local1.value = _local2;
            return (_local1);
        }
        private function nextChar():String{
            return ((ch = jsonString.charAt(loc++)));
        }
        public function getNextToken():JSONToken{
            var _local2:String;
            var _local3:String;
            var _local4:String;
            var _local1:JSONToken = new JSONToken();
            skipIgnored();
            switch (ch){
                case "{":
                    _local1.type = JSONTokenType.LEFT_BRACE;
                    _local1.value = "{";
                    nextChar();
                    break;
                case "}":
                    _local1.type = JSONTokenType.RIGHT_BRACE;
                    _local1.value = "}";
                    nextChar();
                    break;
                case "[":
                    _local1.type = JSONTokenType.LEFT_BRACKET;
                    _local1.value = "[";
                    nextChar();
                    break;
                case "]":
                    _local1.type = JSONTokenType.RIGHT_BRACKET;
                    _local1.value = "]";
                    nextChar();
                    break;
                case ",":
                    _local1.type = JSONTokenType.COMMA;
                    _local1.value = ",";
                    nextChar();
                    break;
                case ":":
                    _local1.type = JSONTokenType.COLON;
                    _local1.value = ":";
                    nextChar();
                    break;
                case "t":
                    _local2 = ((("t" + nextChar()) + nextChar()) + nextChar());
                    if (_local2 == "true"){
                        _local1.type = JSONTokenType.TRUE;
                        _local1.value = true;
                        nextChar();
                    } else {
                        parseError(("Expecting 'true' but found " + _local2));
                    };
                    break;
                case "f":
                    _local3 = (((("f" + nextChar()) + nextChar()) + nextChar()) + nextChar());
                    if (_local3 == "false"){
                        _local1.type = JSONTokenType.FALSE;
                        _local1.value = false;
                        nextChar();
                    } else {
                        parseError(("Expecting 'false' but found " + _local3));
                    };
                    break;
                case "n":
                    _local4 = ((("n" + nextChar()) + nextChar()) + nextChar());
                    if (_local4 == "null"){
                        _local1.type = JSONTokenType.NULL;
                        _local1.value = null;
                        nextChar();
                    } else {
                        parseError(("Expecting 'null' but found " + _local4));
                    };
                    break;
                case "\"":
                    _local1 = readString();
                    break;
                default:
                    if (((isDigit(ch)) || ((ch == "-")))){
                        _local1 = readNumber();
                    } else {
                        if (ch == ""){
                            return (null);
                        };
                        parseError((("Unexpected " + ch) + " encountered"));
                    };
            };
            return (_local1);
        }
        private function skipWhite():void{
            while (isWhiteSpace(ch)) {
                nextChar();
            };
        }
        public function parseError(_arg1:String):void{
            throw (new JSONParseError(_arg1, loc, jsonString));
        }
        private function isWhiteSpace(_arg1:String):Boolean{
            return ((((((((_arg1 == " ")) || ((_arg1 == "\t")))) || ((_arg1 == "\n")))) || ((_arg1 == "\r"))));
        }
        private function skipIgnored():void{
            var _local1:int;
            do  {
                _local1 = loc;
                skipWhite();
                skipComments();
            } while (_local1 != loc);
        }
        private function isHexDigit(_arg1:String):Boolean{
            var _local2:String = _arg1.toUpperCase();
            return (((isDigit(_arg1)) || ((((_local2 >= "A")) && ((_local2 <= "F"))))));
        }
        private function readNumber():JSONToken{
            var _local1:JSONToken = new JSONToken();
            _local1.type = JSONTokenType.NUMBER;
            var _local2 = "";
            if (ch == "-"){
                _local2 = (_local2 + "-");
                nextChar();
            };
            if (!isDigit(ch)){
                parseError("Expecting a digit");
            };
            if (ch == "0"){
                _local2 = (_local2 + ch);
                nextChar();
                if (isDigit(ch)){
                    parseError("A digit cannot immediately follow 0");
                };
            } else {
                while (isDigit(ch)) {
                    _local2 = (_local2 + ch);
                    nextChar();
                };
            };
            if (ch == "."){
                _local2 = (_local2 + ".");
                nextChar();
                if (!isDigit(ch)){
                    parseError("Expecting a digit");
                };
                while (isDigit(ch)) {
                    _local2 = (_local2 + ch);
                    nextChar();
                };
            };
            if ((((ch == "e")) || ((ch == "E")))){
                _local2 = (_local2 + "e");
                nextChar();
                if ((((ch == "+")) || ((ch == "-")))){
                    _local2 = (_local2 + ch);
                    nextChar();
                };
                if (!isDigit(ch)){
                    parseError("Scientific notation number needs exponent value");
                };
                while (isDigit(ch)) {
                    _local2 = (_local2 + ch);
                    nextChar();
                };
            };
            var _local3:Number = Number(_local2);
            if (((isFinite(_local3)) && (!(isNaN(_local3))))){
                _local1.value = _local3;
                return (_local1);
            };
            parseError((("Number " + _local3) + " is not valid!"));
            return (null);
        }

    }
}//package com.adobe.serialization.json 
