//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.quests {
    import flash.display.*;
    import flash.events.*;
    import com.gskinner.motion.*;
    import com.gaiaonline.monster.model.vo.*;
    import org.osflash.signals.*;
    import __AS3__.vec.*;
    import flash.geom.*;
    import com.gaiaonline.monster.service.*;

    public class QuestList {

        private var _ui:MovieClip;
        private var _selected:Signal;
        private var _positions:Vector.<int>;
        private var _head:QuestListItem;
        private var _tail:QuestListItem;
        private var _offset:int;
        private var _height:Number;
        private var _top:Number;
        private var _items:Vector.<QuestVO>;
        private var _count:uint;
        private var _vector:int;
        private var _isTweening:Boolean;
        private var _emptyMessage:String;
        private var text:TextService;

        private static const QUEST:String = "quest";
        private static const DURATION:Number = 0.3;
        private static const COUNT:uint = 6;

        public function QuestList(_arg1:MovieClip, _arg2:Vector.<QuestVO>, _arg3:String, _arg4:TextService){
            this.text = _arg4;
            this._ui = _arg1;
            this._selected = new Signal(QuestVO);
            this._items = _arg2;
            this._count = this._items.length;
            this._emptyMessage = _arg3;
            this.init();
        }
        public function get ui():DisplayObject{
            return (this._ui);
        }
        public function get selected():Signal{
            return (this._selected);
        }
        private function init():void{
            var _local3:MovieClip;
            var _local4:QuestListItem;
            this._offset = 0;
            this._positions = new Vector.<int>(COUNT, true);
            this._ui.empty.visible = (this._count == 0);
            if (this._ui.empty.visible){
                this._ui.empty.text = this._emptyMessage;
            };
            var _local1:int;
            while (_local1 < COUNT) {
                _local3 = this._ui[(QUEST + _local1)];
                this._positions[_local1] = _local3.y;
                _local4 = new QuestListItem(_local3, this.text);
                _local4.selected.add(this.onQuestSelected);
                if (_local1 == 0){
                    this._head = (this._tail = _local4);
                } else {
                    _local4.prev = this._tail;
                    this._tail.next = _local4;
                    this._tail = _local4;
                    if (_local1 <= this._count){
                        _local4.quest = this._items[(_local1 - 1)];
                    };
                };
                _local1++;
            };
            this._head.ui.alpha = 0;
            this._tail.ui.alpha = 0;
            var _local2:Rectangle = this._head.ui.getRect(this._head.ui);
            this._height = _local2.height;
            this._top = (_local2.top + this._head.ui.y);
            this._ui.upButton.addEventListener(MouseEvent.MOUSE_DOWN, this.onUpMouseDown);
            this._ui.upButton.addEventListener(MouseEvent.MOUSE_UP, this.onCancel);
            this._ui.upButton.visible = (this._count > 0);
            this._ui.downButton.addEventListener(MouseEvent.MOUSE_UP, this.onDownMouseDown);
            this._ui.downButton.addEventListener(MouseEvent.MOUSE_UP, this.onCancel);
            this._ui.downButton.visible = (this._count > 0);
        }
        private function onQuestSelected(_arg1:QuestVO):void{
            this._selected.dispatch(_arg1);
        }
        private function onUpMouseDown(_arg1:MouseEvent):void{
            if (this._offset <= 0){
                return;
            };
            this._vector = -1;
            this.scrollUp();
            this._ui.upButton.addEventListener(MouseEvent.MOUSE_UP, this.onCancel);
        }
        private function onDownMouseDown(_arg1:MouseEvent):void{
            if ((this._offset + 4) >= this._count){
                return;
            };
            this._vector = 1;
            this.scrollDown();
        }
        private function onCancel(_arg1:MouseEvent):void{
            this._vector = 0;
        }
        private function scrollUp():void{
            var _local5:Object;
            var _local6:Object;
            if (this._isTweening){
                return;
            };
            this._isTweening = true;
            this._offset--;
            var _local1:QuestListItem = this._tail.prev;
            var _local2:QuestListItem = this._head;
            this._tail.next = this._head;
            this._head.prev = this._tail;
            this._head = this._tail;
            this._tail.prev.next = null;
            this._tail = this._tail.prev;
            this._head.prev = null;
            this._head.ui.y = (this._positions[0] - this._height);
            if (this._offset > 0){
                this._head.quest = this._items[(this._offset - 1)];
            };
            var _local3:QuestListItem = this._head;
            var _local4:int;
            while (_local3 != null) {
                var _temp1 = _local4;
                _local4 = (_local4 + 1);
                _local5 = {y:this._positions[_temp1]};
                if (_local3 == _local1){
                    _local5.alpha = 0;
                } else {
                    if (_local3 == _local2){
                        _local5.alpha = 1;
                    };
                };
                _local6 = {};
                if (_local3 == this._head){
                    _local6.onComplete = this.onComplete;
                };
                new GTween(_local3.ui, DURATION, _local5, _local6);
                _local3 = _local3.next;
            };
        }
        private function scrollDown():void{
            var _local5:Object;
            var _local6:Object;
            if (this._isTweening){
                return;
            };
            this._isTweening = true;
            this._offset++;
            var _local1:QuestListItem = this._head.next;
            var _local2:QuestListItem = this._tail;
            this._head.prev = this._tail;
            this._tail.next = this._head;
            this._tail = this._head;
            this._head.next.prev = null;
            this._head = this._head.next;
            this._tail.next = null;
            this._tail.ui.y = (this._positions[(COUNT - 1)] + this._height);
            if ((this._offset + 4) < this._count){
                this._tail.quest = this._items[(this._offset + 4)];
            };
            var _local3:QuestListItem = this._head;
            var _local4:int;
            while (_local3 != null) {
                var _temp1 = _local4;
                _local4 = (_local4 + 1);
                _local5 = {y:this._positions[_temp1]};
                if (_local3 == _local1){
                    _local5.alpha = 0;
                } else {
                    if (_local3 == _local2){
                        _local5.alpha = 1;
                    };
                };
                _local6 = {};
                if (_local3 == this._head){
                    _local6.onComplete = this.onComplete;
                };
                new GTween(_local3.ui, DURATION, _local5, _local6);
                _local3 = _local3.next;
            };
        }
        private function onComplete(_arg1:GTween):void{
            this._isTweening = false;
            if (this._vector == 1){
                this.scrollDown();
            } else {
                if (this._vector == -1){
                    this.scrollUp();
                };
            };
        }
        public function dispose(_arg1:Boolean=true):void{
            this._selected.removeAll();
            var _local2:QuestListItem = this._head;
            while (_local2) {
                this._head = _local2.next;
                _local2.dispose(_arg1);
                _local2 = this._head;
            };
            this._head = null;
            this._tail = null;
            this._ui.upButton.removeEventListener(MouseEvent.MOUSE_DOWN, this.onUpMouseDown);
            this._ui.upButton.removeEventListener(MouseEvent.MOUSE_UP, this.onCancel);
            this._ui.downButton.removeEventListener(MouseEvent.MOUSE_DOWN, this.onDownMouseDown);
            this._ui.downButton.removeEventListener(MouseEvent.MOUSE_UP, this.onCancel);
            this._ui = null;
        }

    }
}//package com.gaiaonline.monster.view.components.quests 
