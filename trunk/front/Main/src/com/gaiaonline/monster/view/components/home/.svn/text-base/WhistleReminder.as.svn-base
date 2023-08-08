//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.home {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.view.components.app.panel.*;

    public class WhistleReminder extends Panel {

        private var asset:Asset;
        private var content:MovieClip;
        private var _confirm:Signal;
        private var _cancel:Signal;
        private var _ready:Signal;

        public function WhistleReminder(_arg1:Asset){
            this.asset = _arg1;
            addChild(_arg1.self);
            this._ready = new Signal();
            this._confirm = new Signal();
            this._cancel = new Signal();
            if (_arg1.isComplete){
                this.init();
            } else {
                _arg1.complete.add(this.init);
            };
        }
        private function init(_arg1:Asset=null):void{
            this.content = MovieClip(this.asset.content);
            this.content.confirm.addEventListener(MouseEvent.MOUSE_DOWN, this.onConfirm);
            this.content.cancel.addEventListener(MouseEvent.MOUSE_DOWN, this.onCancel);
            this._ready.dispatch();
        }
        private function onConfirm(_arg1:MouseEvent):void{
            this._confirm.dispatch();
        }
        private function onCancel(_arg1:MouseEvent):void{
            this._cancel.dispatch();
        }
        public function setText(_arg1:String, _arg2:String):void{
            this.content.title.text = _arg1;
            this.content.msg.text = _arg2;
        }
        public function get confirm():Signal{
            return (this._confirm);
        }
        public function get cancel():Signal{
            return (this._cancel);
        }
        public function get ready():Signal{
            return (this._ready);
        }

    }
}//package com.gaiaonline.monster.view.components.home 
