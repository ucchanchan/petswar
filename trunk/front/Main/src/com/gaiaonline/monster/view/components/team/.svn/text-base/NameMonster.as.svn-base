//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.team {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import flash.text.*;

    public class NameMonster extends Panel {

        private var NEWLINE_CHARACTERS:Vector.<String>;
        private var TRIM:RegExp;

        private var asset:Asset;
        private var moga:MonsterModel;
        private var content:MovieClip;
        private var _nameSubmitted:Signal;
        private var _focusOnInit:Boolean;// = false
        private var tf:TextField;

        public function NameMonster(_arg1:Asset, _arg2:MonsterModel){
            this.NEWLINE_CHARACTERS = Vector.<String>(["\n", "\r", "\r\n", "\n\r"]);
            this.TRIM = /^[ \n\r]+|[ \n\r]+$/g;
            super();
            this.asset = _arg1;
            this.moga = _arg2;
            this._nameSubmitted = new Signal(MonsterModel);
            if (_arg1.isComplete){
                this.init();
            } else {
                _arg1.complete.addOnce(this.init);
            };
        }
        public function get nameSubmitted():Signal{
            return (this._nameSubmitted);
        }
        private function init(_arg1:Asset=null):void{
            var _local2:String = this.moga.defaultName;
            var _local3:int = _local2.length;
            this.content = MovieClip(_arg1.content);
            this.content.header.text = ("Name your " + _local2);
            this.content.continueButton.addEventListener(MouseEvent.CLICK, this.onNameSubmitted, false, 0, true);
            this.tf = this.content.monsterName;
            this.tf.text = _local2;
            this.tf.setSelection(_local3, _local3);
            this.tf.addEventListener(TextEvent.TEXT_INPUT, this.onTextInput);
            addChild(_arg1.self);
            if (this._focusOnInit){
                this.setFocus();
            };
        }
        private function onTextInput(_arg1:TextEvent):void{
            if (this.NEWLINE_CHARACTERS.indexOf(_arg1.text) != -1){
                this.onNameSubmitted(null);
            };
        }
        public function setFocus():void{
            if (this.content){
                stage.focus = this.content.monsterName;
            } else {
                this._focusOnInit = true;
            };
        }
        private function onNameSubmitted(_arg1:MouseEvent):void{
            var _local2:String = this.content.monsterName.text;
            if (_local2 == ""){
                return;
            };
            this.tf.removeEventListener(TextEvent.TEXT_INPUT, this.onTextInput);
            this.content.continueButton.removeEventListener(MouseEvent.CLICK, this.onNameSubmitted);
            this.moga.name = _local2.replace(this.TRIM, "");
            this._nameSubmitted.dispatch(this.moga);
        }

    }
}//package com.gaiaonline.monster.view.components.team 
