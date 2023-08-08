//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.quests {
    import flash.display.*;
    import flash.events.*;
    import com.gaiaonline.monster.model.vo.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import com.gaiaonline.monster.service.*;
    import gaia.lib.assets.*;

    public class Quests extends Panel implements IQuestView {

        private var asset:Asset;
        private var content:MovieClip;
        private var signaller:SignallingAsset;
        private var quests:Vector.<QuestVO>;
        private var emptyMessage:String;
        private var list:QuestList;
        private var inspector:QuestInspector;
        private var text:TextService;
        private var _closed:Signal;
        private var _helpRequested:Signal;

        public function Quests(_arg1:Asset, _arg2:Vector.<QuestVO>, _arg3:String, _arg4:TextService){
            this.emptyMessage = _arg3;
            this.asset = _arg1;
            this.quests = _arg2;
            this.text = _arg4;
            this._closed = new Signal();
            this._helpRequested = new Signal();
        }
        override public function setup():void{
            addChild(this.asset.self);
            this.content = MovieClip(this.asset.content);
            this.list = new QuestList(this.content.dialog.list, this.quests, this.emptyMessage, this.text);
            this.list.selected.addOnce(this.onQuestSelected);
            this.inspector = new QuestInspector(this.content.dialog.inspector);
            this.inspector.ui.visible = false;
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
                    this.activate();
                    break;
                case "inactive":
                    this._closed.dispatch();
                    break;
            };
        }
        private function activate():void{
            this.content.dialog.close.addEventListener(MouseEvent.CLICK, this.onClose);
        }
        private function onQuestSelected(_arg1:QuestVO):void{
            this.inspector.ok.addOnce(this.onInspectorOK);
            this.inspector.requestHelp.addOnce(this.onInspectorRequestHelp);
            this.inspector.show(_arg1, this.text);
            this.list.ui.visible = false;
            this.inspector.ui.visible = true;
        }
        private function onInspectorOK(_arg1:MouseEvent):void{
            this.list.selected.addOnce(this.onQuestSelected);
            this.list.ui.visible = true;
            this.inspector.ui.visible = false;
        }
        private function onInspectorRequestHelp(_arg1:MouseEvent):void{
            this._helpRequested.dispatch(this.inspector.currentQuest);
        }
        private function onClose(_arg1:MouseEvent):void{
            this.content.play();
        }
        override public function dispose(_arg1:Boolean=true):void{
            if (!this.asset){
                return;
            };
            removeChild(this.asset.self);
            this.signaller.signal.removeAll();
            this.signaller = null;
            this.list.dispose(_arg1);
            this.list = null;
            this.inspector.dispose(_arg1);
            this.inspector = null;
            this.content.dialog.close.removeEventListener(MouseEvent.CLICK, this.onClose);
            this.content = null;
            this.asset = null;
        }

    }
}//package com.gaiaonline.monster.view.components.quests 
