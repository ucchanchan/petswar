//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.friendlist.view.ui {
    import flash.display.*;
    import flash.events.*;
    import com.gskinner.motion.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import __AS3__.vec.*;
    import gaia.moga.friendlist.model.*;
    import alecmce.ui.button.*;
    import com.gskinner.motion.easing.*;

    public class FriendList extends AssetWrapper {

        private var _ui:Asset;
        private var _slots:MovieClip;
        private var _friends:Vector.<Friend>;
        private var _friendMap:Object;
        private var _count:uint;
        private var _max:uint;
        private var _selected:Signal;
        private var _invite:Signal;
        private var _home:Signal;
        private var _head:FriendListItem;
        private var _tail:FriendListItem;
        private var _scrolling:int;
        private var _scrollingStack:int;
        private var _tween:GTween;
        private var _offset:int;
        private var _projected:int;
        private var _left:MovieClipButton;
        private var _right:MovieClipButton;
        private var _inviteFriends:SimpleButton;
        private var _goHome:SimpleButton;
        private var _isSelected:String;
        private var _areAnimsPlaying:Boolean;
        private var _isAtHome:Boolean;

        private static const COUNT:uint = 13;
        private static const OFFSET:uint = 5;
        private static const WIDTH:uint = 6;
        private static const DURATION:Number = 1;

        public function FriendList(_arg1:Asset, _arg2:Vector.<Friend>){
            super(_arg1);
            this._ui = _arg1;
            this._friends = _arg2.sort(this.compareFunction);
            this._friendMap = {};
            this._count = this._friends.length;
            this._max = (Math.ceil((this._count / OFFSET)) * OFFSET);
            if (this._max < OFFSET){
                this._max = OFFSET;
            };
            this._selected = new Signal(Friend);
            this._invite = new Signal();
            this._home = new Signal();
            this._scrolling = 0;
            this._scrollingStack = 0;
            this._offset = 0;
            this._projected = 0;
        }
        override protected function onComplete(_arg1:Asset):void{
            this.setup(this._ui);
            addChild(this._ui.self);
        }
        public function set isSelected(_arg1:String):void{
            if (this._isSelected == _arg1){
                return;
            };
            if (((this._isSelected) && (this._friendMap[this._isSelected]))){
                this._friendMap[this._isSelected].isVisiting = false;
            };
            this._isSelected = _arg1;
            if (((this._isSelected) && (this._friendMap[this._isSelected]))){
                this._friendMap[this._isSelected].isVisiting = true;
            };
        }
        public function get isSelected():String{
            return (this._isSelected);
        }
        public function get isAtHome():Boolean{
            return (this._isAtHome);
        }
        public function set isAtHome(_arg1:Boolean):void{
            this._isAtHome = _arg1;
            this._inviteFriends.visible = this._isAtHome;
            this._goHome.visible = !(this._isAtHome);
        }
        public function get ui():Asset{
            return (this._ui);
        }
        public function get selected():ISignal{
            return (this._selected);
        }
        public function get invite():ISignal{
            return (this._invite);
        }
        private function setup(_arg1:Asset):void{
            var _local4:MovieClip;
            var _local5:FriendListItem;
            var _local6:Friend;
            var _local2:MovieClip = (_arg1.content as MovieClip);
            this._slots = _local2.slots.slots;
            this._offset = 0;
            var _local3:int;
            while (_local3 < COUNT) {
                _local4 = this._slots[("slot" + _local3)];
                _local5 = new FriendListItem(_local4);
                _local5.clicked.add(this.onFriendClicked);
                if (_local3 == 0){
                    this._head = (this._tail = _local5);
                } else {
                    _local5.prev = this._tail;
                    this._tail.next = _local5;
                    this._tail = _local5;
                };
                if ((((_local3 > 0)) && ((_local3 <= this._count)))){
                    _local6 = this._friends[(_local3 - 1)];
                    _local5.setFriend(_local6, (_local3 - 1));
                    _local5.isVisiting = ((_local6) && ((_local6.id == this._isSelected)));
                    this._friendMap[_local6.id] = _local5;
                } else {
                    _local5.setFriend(null, (_local3 - 1));
                };
                _local3++;
            };
            this._left = new MovieClipButton(_local2.leftArrow);
            this._left.clicked.add(this.onLeftClicked);
            this._right = new MovieClipButton(_local2.rightArrow);
            this._right.clicked.add(this.onRightClicked);
            this._inviteFriends = _local2.inviteFriend;
            this._inviteFriends.addEventListener(MouseEvent.CLICK, this.onInviteFriendsClick);
            this._goHome = _local2.goHome;
            this._goHome.addEventListener(MouseEvent.CLICK, this.onGoHomeClick);
            this.repositionElementsAfterScroll();
            this.updateArrowAvailability();
            this.updateEnabled();
        }
        private function onFriendClicked(_arg1:FriendListItem):void{
            if (_arg1.friend){
                this._selected.dispatch(_arg1.friend);
            } else {
                this._invite.dispatch();
            };
        }
        private function onLeftClicked(_arg1:MovieClipButton):void{
            if (this._projected <= 0){
                return;
            };
            if (this._scrolling == 0){
                this._projected = (this._projected - OFFSET);
                this._scrolling = -1;
                this.scroll();
            } else {
                if (this._scrollingStack >= 0){
                    this._projected = (this._offset - OFFSET);
                    this._scrollingStack = -1;
                } else {
                    this._projected = (this._projected - OFFSET);
                    this._scrollingStack--;
                };
            };
            if (this._projected < 0){
                this._projected = 0;
            };
            this.updateArrowAvailability();
        }
        private function onRightClicked(_arg1:MovieClipButton):void{
            if ((this._projected + OFFSET) > this._count){
                return;
            };
            if (this._scrolling == 0){
                this._scrolling = 1;
                this._projected = (this._projected + OFFSET);
                this.scroll();
            } else {
                if (this._scrollingStack <= 0){
                    this._projected = (this._offset + OFFSET);
                    this._scrollingStack = 1;
                } else {
                    this._projected = (this._projected + OFFSET);
                    this._scrollingStack++;
                };
            };
            this.updateArrowAvailability();
        }
        private function scroll():void{
            this.updateEnabled(false);
            this._offset = (this._offset + (OFFSET * this._scrolling));
            if (this._offset < 0){
                this._offset = 0;
            };
            if (this._scrolling == -1){
                this.moveElementsFromTailToHead();
                this.repositionElementsBeforeScroll();
            };
            this._slots.x = 116;
            var _local1:Number = (116 - (440 * this._scrolling));
            this._tween = new GTween(this._slots, DURATION, {x:_local1}, {onComplete:this.onTweenComplete, ease:Quadratic.easeInOut});
        }
        private function onTweenComplete(_arg1:GTween):void{
            if (this._scrolling == 1){
                this.moveElementsFromHeadToTail();
            };
            this.repositionElementsAfterScroll();
            this.updateEnabled();
            this._scrolling = 0;
            if (this._scrollingStack < 0){
                this._scrolling = -1;
                this._scrollingStack++;
                this.scroll();
            } else {
                if (this._scrollingStack > 0){
                    this._scrolling = 1;
                    this._scrollingStack--;
                    this.scroll();
                };
            };
        }
        private function updateEnabled(_arg1:Boolean=true):void{
            var _local2:FriendListItem = this._head;
            while (_local2) {
                _local2.isEnabled = (((_local2.index >= this._offset)) && ((_local2.index < (this._offset + WIDTH))));
                _local2.isVisible = (((_local2.index >= 0)) && ((_local2.index <= this._max)));
                _local2 = _local2.next;
            };
        }
        private function moveElementsFromHeadToTail():void{
            var _local2:int;
            var _local3:Friend;
            var _local1 = 5;
            while (_local1--) {
                _local2 = this._tail.index;
                ++_local2;
                _local3 = ((_local2 < this._friends.length)) ? this._friends[_local2] : null;
                this._head.setFriend(_local3, _local2);
                this._head.isVisiting = ((_local3) && ((_local3.id == this._isSelected)));
                if (_local3){
                    this._friendMap[_local3.id] = this._head;
                };
                this._head.prev = this._tail;
                this._tail.next = this._head;
                this._tail = this._head;
                this._head = this._tail.next;
                this._head.prev = null;
                this._tail.next = null;
            };
        }
        private function moveElementsFromTailToHead():void{
            var _local2:int;
            var _local3:Friend;
            var _local1 = 5;
            while (_local1--) {
                _local2 = this._head.index;
                --_local2;
                _local3 = ((_local2 > -1)) ? this._friends[_local2] : null;
                this._tail.setFriend(_local3, _local2);
                this._tail.isVisiting = ((_local3) && ((_local3.id == this._isSelected)));
                if (_local3){
                    this._friendMap[_local3.id] = this._tail;
                };
                this._tail.next = this._head;
                this._head.prev = this._tail;
                this._head = this._tail;
                this._tail = this._head.prev;
                this._tail.next = null;
                this._head.prev = null;
            };
        }
        private function repositionElementsBeforeScroll():void{
            var _local1:FriendListItem = this._head;
            while (_local1) {
                _local1.ui.x = ((-440 + 88) + ((_local1.index - this._offset) * 88));
                _local1 = _local1.next;
            };
            this._slots.x = 116;
        }
        private function repositionElementsAfterScroll():void{
            var _local1:FriendListItem = this._head;
            while (_local1) {
                _local1.ui.x = (88 + ((_local1.index - this._offset) * 88));
                _local1 = _local1.next;
            };
            this._slots.x = 116;
        }
        private function updateArrowAvailability():void{
            this._left.isEnabled = ((!(this._areAnimsPlaying)) && ((this._projected > 0)));
            this._right.isEnabled = ((!(this._areAnimsPlaying)) && (((this._projected + OFFSET) < this._count)));
        }
        private function compareFunction(_arg1:Friend, _arg2:Friend):int{
            var _local3:uint = _arg1.count;
            var _local4:uint = _arg2.count;
            return (((_local3 > _local4)) ? -1 : ((_local3 < _local4)) ? 1 : 0);
        }
        private function onInviteFriendsClick(_arg1:MouseEvent):void{
            this._invite.dispatch();
        }
        private function onGoHomeClick(_arg1:MouseEvent):void{
            this._home.dispatch();
        }
        public function get offset():int{
            return (this._offset);
        }
        public function set offset(_arg1:int):void{
            if (_arg1 < 0){
                _arg1 = 0;
            } else {
                if (_arg1 >= this._count){
                    _arg1 = (this._count - 1);
                };
            };
            var _local2:int = ((_arg1 - this._offset) / OFFSET);
            if (_local2 > 0){
                while (_local2--) {
                    this.onRightClicked(null);
                };
            } else {
                while (_local2++) {
                    this.onLeftClicked(null);
                };
            };
        }
        public function get home():ISignal{
            return (this._home);
        }
        override public function dispose(_arg1:Boolean=true):void{
        }

    }
}//package gaia.moga.friendlist.view.ui 
