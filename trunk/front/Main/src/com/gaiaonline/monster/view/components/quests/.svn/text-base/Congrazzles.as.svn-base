//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.quests {
    import flash.display.*;
    import flash.events.*;
    import com.gaiaonline.monster.model.vo.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import com.gaiaonline.monster.view.components.questrewards.*;
    import com.gaiaonline.monster.service.*;
    import gaia.lib.assets.*;

    public class Congrazzles extends Panel {

        private var asset:Asset;
        private var content:MovieClip;
        private var signaller:SignallingAsset;
        private var text:TextService;
        private var quest:QuestVO;
        private var rewards:QuestRewards;
        private var _closed:Signal;
        private var _shareClick:Signal;

        public function Congrazzles(_arg1:Asset, _arg2:QuestVO, _arg3:TextService){
            this.asset = _arg1;
            this.quest = _arg2;
            this.text = _arg3;
            this._closed = new Signal();
            this._shareClick = new Signal();
        }
        override public function setup():void{
            addChild(this.asset.self);
            this.content = MovieClip(this.asset.content);
            this.content.dialog.description.text = this.text.getQuestText(String(this.quest.id), "completeDescription");
            this.content.dialog.ok.addEventListener(MouseEvent.CLICK, this.onDialogOk, false, 0, true);
            this.content.dialog.shareButton.addEventListener(MouseEvent.CLICK, this.onShareButtonClick, false, 0, true);
            this.rewards = new QuestRewards(this.quest.rewards, this.content.dialog.rewards.spinny);
            this.content.dialog.rewards.addChild(this.rewards);
            this.signaller = SignallingAsset(this.content);
            this.signaller.signal.add(this.onSignal);
            this.content.play();
        }
        private function onShareButtonClick(_arg1:MouseEvent):void{
            this._shareClick.dispatch(this.quest);
        }
        private function onDialogOk(_arg1:MouseEvent):void{
            this.content.gotoAndPlay("close");
        }
        private function onSignal(_arg1:Object):void{
            if (_arg1 == "active"){
                return;
            };
            this._closed.dispatch();
        }
        private function onInspectorOK(_arg1:MouseEvent):void{
            this.content.play();
        }
        override public function dispose(_arg1:Boolean=true):void{
            if (!this.asset){
                return;
            };
            if (this.rewards){
                this.rewards.parent.removeChild(this.rewards);
                this.rewards = null;
            };
            removeChild(this.asset.self);
            this.signaller.signal.removeAll();
            this.signaller = null;
            this.asset = null;
            this._closed.removeAll();
            this._closed = null;
            this._shareClick.removeAll();
            this._shareClick = null;
        }
        public function get closed():Signal{
            return (this._closed);
        }
        public function get shareClick():Signal{
            return (this._shareClick);
        }

    }
}//package com.gaiaonline.monster.view.components.quests 
