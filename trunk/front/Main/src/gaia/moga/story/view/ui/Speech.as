//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.story.view.ui {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import __AS3__.vec.*;
    import flash.geom.*;
    import flash.text.*;

    public class Speech extends Sprite {

        private var _textfield:TextField;
        private var _text:String;
        private var _speed:int;
        private var _pool:Vector.<Character>;
        private var _position:int;
        private var _max:int;
        private var _complete:Signal;
        private var defaultSpeed:int;
        private var _wait:int;

        public function Speech(_arg1:TextField, _arg2:int, _arg3:int){
            this._complete = new Signal(Speech);
            this._textfield = _arg1;
            this._textfield.height = 1000;
            this._textfield.selectable = false;
            this._speed = (this.defaultSpeed = _arg2);
            this._pool = this.generateCharacterPool(_arg3);
        }
        override public function set width(_arg1:Number):void{
            this._textfield.width = _arg1;
        }
        public function get text():String{
            return (this._text);
        }
        public function set text(_arg1:String):void{
            if (this._text == _arg1){
                return;
            };
            this._wait = 0;
            this._text = _arg1;
            this._textfield.text = _arg1;
            this.clearCharacters();
        }
        public function get defaultTextFormat():TextFormat{
            return (this._textfield.defaultTextFormat);
        }
        public function set defaultTextFormat(_arg1:TextFormat):void{
            this._textfield.defaultTextFormat = _arg1;
        }
        public function setTextFormat(_arg1:TextFormat, _arg2:int=-1, _arg3:int=-1):void{
            this._textfield.setTextFormat(_arg1, _arg2, _arg3);
        }
        public function start():void{
            this.setupCharacters();
            addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            var _local1:Character = this._pool[0];
            addChild(_local1);
            _local1.play();
        }
        private function onEnterFrame(_arg1:Event):void{
            var _local2:int = this._speed;
            var _local3:Boolean;
            while (((!(_local3)) && (_local2))) {
                if (this._wait){
                    this._wait--;
                } else {
                    _local3 = this.iterate();
                };
            };
        }
        private function iterate():Boolean{
            var _local1:Character = this._pool[this._position++];
            if (this._position > this._max){
                removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
                this._complete.dispatch(this);
                return (true);
            };
            addChild(_local1);
            this._wait = (this._wait + _local1.play());
            return (false);
        }
        private function generateCharacterPool(_arg1:int):Vector.<Character>{
            var _local2:Vector.<Character> = new Vector.<Character>(_arg1, true);
            var _local3:int = _arg1;
            while (_local3--) {
                _local2[_local3] = new Character(this.generateTextField());
            };
            return (_local2);
        }
        private function generateTextField():TextField{
            var _local1:TextField = new TextField();
            _local1.width = this._textfield.width;
            _local1.height = this._textfield.height;
            _local1.multiline = this._textfield.multiline;
            _local1.wordWrap = this._textfield.wordWrap;
            _local1.embedFonts = this._textfield.embedFonts;
            _local1.antiAliasType = this._textfield.antiAliasType;
            _local1.defaultTextFormat = this._textfield.defaultTextFormat;
            return (_local1);
        }
        private function setupCharacters():void{
            var _local2:String;
            var _local3:Rectangle;
            var _local4:TextFormat;
            this._max = this._textfield.length;
            var _local1:int;
            while (_local1 < this._max) {
                _local2 = this._text.charAt(_local1);
                _local3 = this._textfield.getCharBoundaries(_local1);
                _local4 = this._textfield.getTextFormat(_local1, (_local1 + 1));
                this._pool[_local1].setup(_local2, _local3, _local4);
                _local1++;
            };
            this._position = 0;
        }
        private function clearCharacters():void{
            var _local1:int;
            while (_local1 < this._max) {
                this._pool[_local1].clear();
                _local1++;
            };
        }
        public function get complete():ISignal{
            return (this._complete);
        }
        public function get speed():int{
            return (this._speed);
        }
        public function set speed(_arg1:int):void{
            this._speed = _arg1;
        }
        public function reset():void{
            removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            this.clearCharacters();
            this._speed = this.defaultSpeed;
            this._textfield.setTextFormat(this._textfield.defaultTextFormat);
        }

    }
}//package gaia.moga.story.view.ui 
