//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.quests {
    import flash.display.*;
    import flash.events.*;
    import com.gaiaonline.monster.model.vo.*;
    import org.osflash.signals.*;
    import com.gaiaonline.monster.service.*;

    public class QuestListItem {

        public var next:QuestListItem;
        public var prev:QuestListItem;
        private var _ui:MovieClip;
        private var _quest:QuestVO;
        private var text:TextService;
        private var _selected:Signal;

        public function QuestListItem(_arg1:MovieClip, _arg2:TextService){
            this._ui = _arg1;
            this._ui.visible = false;
            this._ui.button.addEventListener(MouseEvent.CLICK, this.onClick);
            this.text = _arg2;
            this._selected = new Signal(QuestVO);
        }
        public function get ui():MovieClip{
            return (this._ui);
        }
        public function get quest():QuestVO{
            return (this._quest);
        }
        public function set quest(_arg1:QuestVO):void{
            if (this._quest == _arg1){
                return;
            };
            this._quest = _arg1;
            this.update();
            this._ui.visible = !((this._quest == null));
        }
        public function dispose(_arg1:Boolean=true):void{
            this.next = null;
            this.prev = null;
            this._ui.button.removeEventListener(MouseEvent.CLICK, this.onClick);
            this._ui = null;
            this._quest = null;
        }
        public function get selected():Signal{
            return (this._selected);
        }
        private function update():void{
            this._ui.cat;
            this._ui.exclaim;
            this._ui.label.text = this.text.getQuestText(String(this.quest.id), "name");
            this._ui.progress.text = ((this.quest.progress.progressSummaryText + "/") + this.quest.goals.goalsSummaryText);
            this._ui.button;
        }
        private function onClick(_arg1:MouseEvent):void{
            this._selected.dispatch(this._quest);
        }

    }
}//package com.gaiaonline.monster.view.components.quests 
