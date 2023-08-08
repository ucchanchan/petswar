//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.quests {
    import flash.display.*;
    import flash.events.*;
    import com.gaiaonline.monster.model.vo.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import com.gaiaonline.monster.service.*;
    import gaia.lib.assets.*;

    public class NewQuests extends Panel implements IQuestView {

        private var asset:Asset;
        private var content:MovieClip;
        private var signaller:SignallingAsset;
        private var quest:QuestVO;
        private var text:TextService;
        private var inspector:QuestInspector;
        private var _closed:Signal;
        private var _helpRequested:Signal;

        public function NewQuests(_arg1:Asset, _arg2:QuestVO, _arg3:TextService){
            this.asset = _arg1;
            this.quest = _arg2;
            this.text = _arg3;
            this._closed = new Signal();
            this._helpRequested = new Signal();
        }
        override public function setup():void{
            addChild(this.asset.self);
            this.content = MovieClip(this.asset.content);
            this.content.dialog.close.visible = false;
            this.content.dialog.list.visible = false;
            if (this.quest){
                this.inspector = new QuestInspector(this.content.dialog.inspector);
                this.inspector.show(this.quest, this.text);
                this.inspector.requestHelp.addOnce(this.onInspectorRequestHelp);
            };
            this.signaller = SignallingAsset(this.content);
            this.signaller.signal.add(this.onSignal);
            this.content.play();
        }
        public function get closed():Signal{
            return (this._closed);
        }
        public function get helpRequested():Signal{
            return (this._helpRequested);
        }
        private function onSignal(_arg1:Object):void{
            switch (_arg1){
                case "active":
                    this.inspector.ok.addOnce(this.onInspectorOK);
                    break;
                case "inactive":
                    this._closed.dispatch();
                    break;
            };
        }
        private function onInspectorOK(_arg1:MouseEvent):void{
            this.content.play();
        }
        private function onInspectorRequestHelp(_arg1:MouseEvent):void{
            this._helpRequested.dispatch(this.inspector.currentQuest);
        }
        override public function dispose(_arg1:Boolean=true):void{
            if (!this.asset){
                return;
            };
            removeChild(this.asset.self);
            this.signaller.signal.removeAll();
            this.signaller = null;
            this.inspector.dispose(_arg1);
            this.inspector = null;
            this.asset = null;
        }

    }
}//package com.gaiaonline.monster.view.components.quests 
