//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.story.view.ui {
    import flash.display.*;
    import com.gskinner.motion.*;
    import org.osflash.signals.*;
    import flash.geom.*;
    import flash.text.*;

    public class Character extends Sprite {

        private var textfield:TextField;
        private var tween:GTween;
        private var _complete:Signal;
        private var pause:int;

        public function Character(_arg1:TextField){
            this.textfield = _arg1;
            _arg1.selectable = false;
            _arg1.autoSize = TextFieldAutoSize.CENTER;
            addChild(_arg1);
            this.tween = new GTween(this, 0.2, {}, {onComplete:this.onComplete});
            this._complete = new Signal(Character);
        }
        public function setup(_arg1:String, _arg2:Rectangle=null, _arg3:TextFormat=null):void{
            _arg3 = ((_arg3) || (this.textfield.defaultTextFormat));
            this.textfield.text = _arg1;
            this.textfield.y = (-(int(_arg3.size)) * 0.5);
            this.textfield.setTextFormat(_arg3);
            x = (_arg2) ? (_arg2.x - 2) : 0;
            y = (_arg2) ? (_arg2.y + 2) : 0;
            alpha = 0;
            scaleX = (scaleY = 2);
            this.pause = 0;
            if ((((((_arg1 == ".")) || ((_arg1 == "!")))) || ((_arg1 == ":")))){
                this.pause = 10;
            } else {
                if ((((_arg1 == ",")) || ((_arg1 == ";")))){
                    this.pause = 3;
                };
            };
        }
        public function play():int{
            this.tween.setValues({alpha:1, scaleX:1, scaleY:1});
            return (this.pause);
        }
        public function clear():void{
            this.tween.paused = true;
            if (parent){
                parent.removeChild(this);
            };
        }
        private function onComplete(_arg1:GTween):void{
            this._complete.dispatch(this);
        }
        public function get complete():ISignal{
            return (this._complete);
        }

    }
}//package gaia.moga.story.view.ui 
