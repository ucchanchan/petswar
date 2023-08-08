//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.quests {
    import flash.display.*;
    import flash.events.*;
    import com.gaiaonline.monster.model.vo.*;
    import org.osflash.signals.natives.*;
    import com.gaiaonline.monster.view.components.questrewards.*;
    import com.gaiaonline.monster.service.*;

    public class QuestInspector {

        public var ui:MovieClip;
        private var _ok:NativeSignal;
        private var _requestHelp:NativeSignal;
        private var rewards:QuestRewards;
        private var _currentQuest:QuestVO;

        public function QuestInspector(_arg1:MovieClip){
            this.ui = _arg1;
            this._ok = new NativeSignal(_arg1.ok, MouseEvent.CLICK);
            this._requestHelp = new NativeSignal(_arg1.getHelpButton, MouseEvent.CLICK);
        }
        public function show(_arg1:QuestVO, _arg2:TextService):void{
            this._currentQuest = _arg1;
            this.ui.title.text = _arg2.getQuestText(String(_arg1.id), "name");
            this.ui.description.text = _arg2.getQuestText(String(_arg1.id), "description");
            this.removeCurrentRewards();
            this.rewards = new QuestRewards(_arg1.rewards, this.ui.rewards.spinny);
            this.ui.rewards.addChild(this.rewards);
        }
        public function get currentQuest():QuestVO{
            return (this._currentQuest);
        }
        public function get ok():NativeSignal{
            return (this._ok);
        }
        public function get requestHelp():NativeSignal{
            return (this._requestHelp);
        }
        public function dispose(_arg1:Boolean=true):void{
            this.removeCurrentRewards();
            this._ok.removeAll();
            this._ok = null;
            this.ui = null;
        }
        private function removeCurrentRewards():void{
            if (!this.rewards){
                return;
            };
            this.rewards.parent.removeChild(this.rewards);
            this.rewards = null;
        }

    }
}//package com.gaiaonline.monster.view.components.quests 
