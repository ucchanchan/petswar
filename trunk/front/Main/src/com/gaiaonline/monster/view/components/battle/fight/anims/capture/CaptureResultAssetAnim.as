//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.capture {
    import flash.display.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import flash.text.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.view.components.team.*;
    import com.gaiaonline.monster.view.components.feeds.*;

    public class CaptureResultAssetAnim extends SignallingAssetAnim {

        private var monster:Asset;
        private var isMonsterReady:Boolean;
        private var text:String;
        private var fb:FBService;
        private var model:MonsterModel;
        private var nameWidget:NameMonster;
        private var captureConfirm:PublishCaptureFeedConfirm;
        private var captureConfirmContainer:DisplayObjectContainer;

        private static const MONSTER_CONTAINER:String = "monsterContainer";
        private static const MONSTER:String = "monster";
        private static const TEXT_CONTAINER:String = "monsterCapturedTextMC";
        private static const TEXT:String = "monsterCapturedText";

        public function CaptureResultAssetAnim(_arg1:DisplayObjectContainer, _arg2:Asset, _arg3:Asset, _arg4:String, _arg5:FBService, _arg6:MonsterModel, _arg7:NameMonster, _arg8:PublishCaptureFeedConfirm, _arg9:DisplayObjectContainer){
            super(_arg1, _arg2);
            this.monster = _arg3;
            this.text = _arg4;
            this.fb = _arg5;
            this.model = _arg6;
            this.nameWidget = _arg7;
            this.captureConfirm = _arg8;
            this.captureConfirmContainer = _arg9;
            _arg7.nameSubmitted.add(this.onNameSubmitted);
            _arg8.confirmed.add(this.onPublishConfirmed);
            _arg8.close.add(this.onPublishClosed);
            this.isMonsterReady = _arg3.isComplete;
            if (!this.isMonsterReady){
                _arg3.complete.addOnce(this.onMonsterReady);
            };
        }
        override public function play():void{
            super.play();
        }
        private function onMonsterReady(_arg1:Asset):void{
            this.isMonsterReady = true;
            if (isPlaying){
                this.play();
            };
        }
        override protected function actuallyPlay():void{
            var _local1:DisplayObjectContainer;
            _local1 = DisplayObjectContainer(content.getChildByName(MONSTER_CONTAINER));
            _local1 = DisplayObjectContainer(_local1.getChildByName(MONSTER));
            _local1.addChild(this.monster.self);
            _local1 = DisplayObjectContainer(content.getChildByName(TEXT_CONTAINER));
            var _local2:TextField = TextField(_local1.getChildByName(TEXT));
            _local2.text = this.text;
            container.addChild(asset.self);
            signaller.signal.add(this.onSignal);
            content.gotoAndPlay(1);
        }
        private function onNameSubmitted(_arg1:MonsterModel):void{
            container.removeChild(this.nameWidget);
            content.play();
        }
        private function onPublishConfirmed(_arg1:MonsterModel):void{
            this.removePublishConfirm();
        }
        private function onPublishClosed():void{
            this.removePublishConfirm();
        }
        private function removePublishConfirm():void{
            this.captureConfirmContainer.removeChild(this.captureConfirm);
            content.play();
        }
        private function onSignal(_arg1:Object=null):void{
            if (_arg1 == "nameMonster"){
                container.addChild(this.nameWidget);
            } else {
                if (_arg1 == "publishFeed"){
                    this.captureConfirmContainer.addChild(this.captureConfirm);
                } else {
                    this.monster.self.parent.removeChild(this.monster.self);
                    container.removeChild(asset.self);
                    _complete.dispatch(this);
                };
            };
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.capture 
