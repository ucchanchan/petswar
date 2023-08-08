//Created by Action Script Viewer - http://www.buraks.com/asv
package com.adobe.serialization.json {

    public class JSONDecoder {

        private var value;
        private var tokenizer:JSONTokenizer;
        private var token:JSONToken;

        public function JSONDecoder(_arg1:String){
            tokenizer = new JSONTokenizer(_arg1);
            nextToken();
            value = parseValue();
        }
        private function parseObject():Object{
            var _local2:String;
            var _local1:Object = new Object();
            nextToken();
            if (token.type == JSONTokenType.RIGHT_BRACE){
                return (_local1);
            };
            while (true) {
                if (token.type == JSONTokenType.STRING){
                    _local2 = String(token.value);
                    nextToken();
                    if (token.type == JSONTokenType.COLON){
                        nextToken();
                        _local1[_local2] = parseValue();
                        nextToken();
                        if (token.type == JSONTokenType.RIGHT_BRACE){
                            return (_local1);
                        };
                        if (token.type == JSONTokenType.COMMA){
                            nextToken();
                        } else {
                            tokenizer.parseError(("Expecting } or , but found " + token.value));
                        };
                    } else {
                        tokenizer.parseError(("Expecting : but found " + token.value));
                    };
                } else {
                    tokenizer.parseError(("Expecting string but found " + token.value));
                };
            };
            return (null);
        }
        private function parseValue():Object{
            if (token == null){
                tokenizer.parseError("Unexpected end of input");
            };
            switch (token.type){
                case JSONTokenType.LEFT_BRACE:
                    return (parseObject());
                case JSONTokenType.LEFT_BRACKET:
                    return (parseArray());
                case JSONTokenType.STRING:
                case JSONTokenType.NUMBER:
                case JSONTokenType.TRUE:
                case JSONTokenType.FALSE:
                case JSONTokenType.NULL:
                    return (token.value);
                default:
                    tokenizer.parseError(("Unexpected " + token.value));
            };
            return (null);
        }
        private function nextToken():JSONToken{
            return ((token = tokenizer.getNextToken()));
        }
        public function getValue(){
            return (value);
        }
        private function parseArray():Array{
            var _local1:Array = new Array();
            nextToken();
            if (token.type == JSONTokenType.RIGHT_BRACKET){
                return (_local1);
            };
            while (true) {
                _local1.push(parseValue());
                nextToken();
                if (token.type == JSONTokenType.RIGHT_BRACKET){
                    return (_local1);
                };
                if (token.type == JSONTokenType.COMMA){
                    nextToken();
                } else {
                    tokenizer.parseError(("Expecting ] or , but found " + token.value));
                };
            };
            return (null);
        }

    }
}//package com.adobe.serialization.json 
