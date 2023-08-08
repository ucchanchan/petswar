//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.newuser.view.ui {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import gaia.moga.newuser.view.ui.*;

    class SelectionDialog {

        private var NEWLINE_CHARACTERS:Vector.<String>;
        private var TRIM:RegExp;

        private var ui:MovieClip;
        private var info:ZodiacMonsterModel;
        private var _response:Signal;
        private var tf;

        function SelectionDialog(_arg1:MovieClip, _arg2:ZodiacMonsterModel){
            this.NEWLINE_CHARACTERS = Vector.<String>(["\n", "\r", "\r\n", "\n\r"]);
            this.TRIM = /^[ \n\r]+|[ \n\r]+$/g;
            super();
            this.ui = _arg1;
            this.info = _arg2;
            _arg1.inputBox.monsterName.text = _arg2.name;
            this._response = new Signal(Boolean);
        }
        public function enable():void{
            this.tf = this.ui.inputBox.monsterName;
            this.ui.stage.focus = this.tf;
            var _local1:int = this.tf.text.length;
            this.tf.setSelection(_local1, _local1);
            this.tf.addEventListener(TextEvent.TEXT_INPUT, this.onTextInput);
            this.ui.yes.addEventListener(MouseEvent.CLICK, this.onYes, false, 0, true);
            this.ui.no.addEventListener(MouseEvent.CLICK, this.onNo, false, 0, true);
        }
        private function onTextInput(_arg1:TextEvent):void{
            if (this.NEWLINE_CHARACTERS.indexOf(_arg1.text) != -1){
                this.onYes(null);
            };
        }
        public function disable():void{
            this.tf.removeEventListener(TextEvent.TEXT_INPUT, this.onTextInput);
            this.ui.yes.removeEventListener(MouseEvent.CLICK, this.onYes);
            this.ui.no.removeEventListener(MouseEvent.CLICK, this.onNo);
        }
        private function onYes(_arg1:MouseEvent):void{
            var _local2:String = this.ui.inputBox.monsterName.text;
            if (_local2 == ""){
                return;
            };
            _local2 = _local2.replace(this.TRIM, "");
            this.disable();
            this.info.name = _local2;
            this._response.dispatch(true);
        }
        private function onNo(_arg1:MouseEvent):void{
            this.disable();
            this._response.dispatch(false);
        }
        public function get name():String{
            return (this.ui.inputBox.monsterName.text);
        }
        public function get response():ISignal{
            return (this._response);
        }

    }
}//package gaia.moga.newuser.view.ui 
