//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.story.view.ui {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import __AS3__.vec.*;
    import flash.text.*;
    import com.gaiaonline.monster.*;

    public class SpeechBubble extends AssetWrapper {

        private var _name:String;
        private var _text:String;
        private var _colors:Vector.<ColorVO>;
        private var _index:int;
        private var _end:SpeechBubbleEnd;
        private var _isVisible:Boolean;
        private var _isSetup:Boolean;
        private var clip:MovieClip;
        private var _left:SpeechBubbleArrow;
        private var _right:SpeechBubbleArrow;
        private var _accept:SpeechBubbleButton;
        private var _speech:Speech;
        private var _storyComplete:Signal;
        private var forwards:Boolean;
        private var format:TextFormat;

        public function SpeechBubble(_arg1:Asset, _arg2:Speech){
            super(_arg1);
            this._isSetup = false;
            this._speech = _arg2;
            this._storyComplete = new Signal(SpeechBubble, Boolean);
            this._colors = new Vector.<ColorVO>();
        }
        override protected function onComplete(_arg1:Asset):void{
            this._isSetup = true;
            addChild(_asset.self);
            this.clip = (_asset.content as MovieClip);
            this._left = new SpeechBubbleArrow(this.clip.left);
            this._right = new SpeechBubbleArrow(this.clip.right);
            this._accept = new SpeechBubbleButton(this.clip.accept);
            if (this._text){
                this.apply(this._name, this._text, this._end);
            };
        }
        public function apply(_arg1:String, _arg2:String, _arg3:SpeechBubbleEnd):void{
            this._name = _arg1;
            this.processText(_arg2);
            this._index = 0;
            this._end = _arg3;
            if (!this._isSetup){
                return;
            };
            this.primeSpeech();
            if (this._isVisible){
                this.playStory();
            } else {
                this.playToVisible();
            };
        }
        public function cancel():void{
            this._speech.complete.remove(this.onSpeechComplete);
            this._speech.reset();
            removeEventListener(Event.ENTER_FRAME, this.rewind);
            removeEventListener(Event.ENTER_FRAME, this.play);
            this.clearUp();
            this.clip.gotoAndStop(1);
        }
        private function processText(_arg1:String):void{
            var _local3:String;
            var _local4:int;
            var _local5:Array;
            var _local6:uint;
            this._colors.length = 0;
            this._text = _arg1;
            var _local2:Array = _arg1.match(/(\{\$\S+\s+.+?\})/g);
            if (((!(_local2)) || ((_local2.length == 0)))){
                return;
            };
            for each (_local3 in _local2) {
                _local4 = _arg1.indexOf(_local3);
                _local5 = _local3.match(/\{\$(\S+)\s+(.+?)\}/);
                _local6 = Color.fromMessage(_local5[1]);
                _arg1 = _arg1.replace(_local3, _local5[2]);
                this._colors.push(new ColorVO(_local4, _local5[2].length, _local6));
            };
            this._text = _arg1;
        }
        private function primeSpeech():void{
            var _local1:MovieClip = this.clip.textfield;
            this.clip.textfield.visible = false;
            this.clip.bubble.label.text = this._name;
            this._right.isVisible = false;
            this._left.isVisible = false;
            this._accept.isVisible = false;
            if (this._speech.parent == this.clip){
                return;
            };
            this._speech.x = _local1.x;
            this._speech.y = _local1.y;
            this._speech.width = _local1.width;
            this.clip.addChildAt(this._speech, 1);
        }
        private function playToVisible():void{
            addEventListener(Event.ENTER_FRAME, this.play);
        }
        private function play(_arg1:Event):void{
            this.clip.nextFrame();
            if (this.clip.currentFrame < this.clip.totalFrames){
                return;
            };
            removeEventListener(Event.ENTER_FRAME, this.play);
            this.playStory();
        }
        private function playStory():void{
            var _local1:ColorVO;
            this.clip.addEventListener(MouseEvent.CLICK, this.onClick);
            this._speech.complete.addOnce(this.onSpeechComplete);
            this._speech.reset();
            this._speech.text = this._text;
            for each (_local1 in this._colors) {
                this.format = this._speech.defaultTextFormat;
                this.format = new TextFormat(this.format.font, this.format.size, _local1.color, this.format.bold, this.format.italic, this.format.underline);
                this._speech.setTextFormat(this.format, _local1.start, _local1.end);
            };
            this._speech.start();
        }
        private function onClick(_arg1:MouseEvent):void{
            this.clip.removeEventListener(MouseEvent.CLICK, this.onClick);
            this._speech.speed = 10;
        }
        private function onSpeechComplete(_arg1:Speech):void{
            this.clip.removeEventListener(MouseEvent.CLICK, this.onClick);
            if (this._end.leftArrow){
                this._left.click.addOnce(this.onLeftClick);
                this._left.isVisible = true;
            };
            if (this._end.rightArrow){
                this._right.click.addOnce(this.onRightClick);
                this._right.isVisible = true;
            };
            if (((this._end.ok) || (this._end.accept))){
                this._accept.click.addOnce(this.onRightClick);
                this._accept.isVisible = true;
                this._accept.label = (this._end.ok) ? "ok" : "accept";
            };
        }
        private function onLeftClick():void{
            this.clearUp();
            this.forwards = false;
            this._storyComplete.dispatch(this, this.forwards);
        }
        private function onRightClick():void{
            this.clearUp();
            this.forwards = true;
            addEventListener(Event.ENTER_FRAME, this.rewind);
        }
        private function rewind(_arg1:Event):void{
            this.clip.prevFrame();
            if (this.clip.currentFrame > 1){
                return;
            };
            removeEventListener(Event.ENTER_FRAME, this.rewind);
            this._isVisible = false;
            this._storyComplete.dispatch(this, this.forwards);
        }
        private function clearUp():void{
            this._speech.text = "";
            this._left.isVisible = false;
            this._left.click.removeAll();
            this._right.isVisible = false;
            this._right.click.removeAll();
            this._accept.isVisible = false;
            this._accept.click.removeAll();
        }
        override public function dispose(_arg1:Boolean=true):void{
        }
        public function get storyComplete():ISignal{
            return (this._storyComplete);
        }

    }
}//package gaia.moga.story.view.ui 

class ColorVO {

    public var start:int;
    public var end:int;
    public var color:uint;

    public function ColorVO(_arg1:int, _arg2:int, _arg3:uint){
        this.start = _arg1;
        this.end = (_arg1 + _arg2);
        this.color = _arg3;
    }
}
