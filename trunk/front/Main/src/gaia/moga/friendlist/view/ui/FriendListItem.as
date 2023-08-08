//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.friendlist.view.ui {
    import flash.display.*;
    import org.osflash.signals.*;
    import gaia.moga.friendlist.view.ui.*;
    import gaia.moga.friendlist.model.*;
    import alecmce.ui.button.*;
    import flash.text.*;

    class FriendListItem extends MovieClipButton {

        private var _friend:Friend;
        private var _index:int;
        private var _isVisiting:Boolean;
        private var noFriendFrame:int;// = 4
        private var visitingFrame:int;// = 3
        public var next:FriendListItem;
        public var prev:FriendListItem;
        public var changed:Signal;

        function FriendListItem(_arg1:MovieClip){
            this._index = -2;
            super(_arg1, 1, 2, 3, 1);
            TextField(_ui.userName).gridFitType = GridFitType.NONE;
            TextField(_ui.mogaCount).gridFitType = GridFitType.NONE;
            TextField(_ui.index).gridFitType = GridFitType.NONE;
            this.changed = new Signal(FriendListItem);
        }
        public function setFriend(_arg1:Friend, _arg2:int):void{
            this._index = _arg2;
            _ui.visible = (_arg2 >= 0);
            if (this._friend == _arg1){
                return;
            };
            if (this._friend){
                this._friend.changed.remove(this.onChanged);
            };
            this._friend = _arg1;
            if (this._friend){
                this._friend.changed.add(this.onChanged);
            };
            this.populateWithFriendData();
            this.update();
        }
        private function onChanged(_arg1:Friend):void{
            _ui.mogaCount.text = _arg1.count.toString();
            this.changed.dispatch(this);
        }
        public function get friend():Friend{
            return (this._friend);
        }
        public function set isVisiting(_arg1:Boolean):void{
            if (this._isVisiting == _arg1){
                return;
            };
            this._isVisiting = _arg1;
            this.update();
        }
        public function get isVisiting():Boolean{
            return (this._isVisiting);
        }
        override public function update():void{
            var _local1 = !((this._friend == null));
            _ui.userName.visible = _local1;
            _ui.mogaCount.visible = _local1;
            _ui.index.visible = _local1;
            _ui.playerIconContainer.visible = _local1;
            if (((_local1) && ((_ui.playerIconContainer.numChildren == 0)))){
                _ui.playerIconContainer.addChild(this._friend.picture.self);
            };
            _ui.mouseChildren = !(_local1);
            if (this._isVisiting){
                _ui.gotoAndStop(this.visitingFrame);
            } else {
                if (_local1){
                    super.update();
                } else {
                    _ui.gotoAndStop(this.noFriendFrame);
                };
            };
        }
        private function populateWithFriendData():void{
            var _local1:MovieClip = _ui.playerIconContainer;
            while (_local1.numChildren > 0) {
                _local1.removeChildAt(0);
            };
            if (this._friend){
                _ui.userName.text = this._friend.firstName;
                _ui.mogaCount.text = this._friend.count.toString();
                _ui.index.text = (this._index + 1).toString();
                this._friend.picture.init();
                _ui.playerIconContainer.addChild(this._friend.picture.self);
            } else {
                _ui.userName.text = "";
                _ui.mogaCount.text = "";
                _ui.index.text = "";
            };
        }
        public function get index():int{
            return (this._index);
        }

    }
}//package gaia.moga.friendlist.view.ui 
