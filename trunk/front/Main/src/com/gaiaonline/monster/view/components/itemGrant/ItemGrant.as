//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.itemGrant {
    import flash.display.*;
    import flash.events.*;
    import com.gaiaonline.monster.model.vo.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.view.components.app.panel.*;

    public class ItemGrant extends Panel {

        private var asset:Asset;
        private var msg:String;
        private var type:ItemGrantType;
        private var id:int;
        private var icon:Asset;
        private var _close:Signal;

        public function ItemGrant(_arg1:Asset, _arg2:String, _arg3:ItemGrantType, _arg4:int, _arg5:Asset){
            this._close = new Signal();
            this.asset = _arg1;
            this.msg = _arg2;
            this.type = _arg3;
            this.id = _arg4;
            this.icon = _arg5;
            if (_arg1.isComplete){
                this.init(_arg1);
            } else {
                _arg1.complete.add(this.init);
                _arg1.init();
            };
        }
        private function init(_arg1:Asset):void{
            var _local3:MovieClip;
            var _local2:MovieClip = (_arg1.content as MovieClip);
            _local2.rigItem.visible = false;
            _local2.basic.visible = false;
            _local3 = _local2.basic;
            switch (this.type){
                case ItemGrantType.RIG_ITEM:
                    _local3 = _local2.rigItem;
                    this.showItem(_local3.icon);
                    break;
                case ItemGrantType.BASIC_ITEM:
                    this.showItem(_local3.icon);
                    break;
                case ItemGrantType.MONSTER:
                    this.showMoga(_local3.icon);
                    break;
            };
            _local3.visible = true;
            _local3.confirm.addEventListener(MouseEvent.CLICK, this.onClose);
            _local3.msg.text = this.msg;
            this.addChild(_arg1.self);
        }
        private function showItem(_arg1:MovieClip):void{
            if (!this.icon){
                return;
            };
            this.icon.self.scaleX = 2;
            this.icon.self.scaleY = 2;
            this.icon.self.y = (this.icon.self.y - 85);
            this.icon.self.x = (this.icon.self.x - 40);
            _arg1.addChild(this.icon.self);
        }
        private function showMoga(_arg1:MovieClip):void{
            if (!this.icon){
                return;
            };
            this.icon.self.scaleX = 0.7;
            this.icon.self.scaleY = 0.7;
            _arg1.addChild(this.icon.self);
        }
        private function onClose(_arg1:MouseEvent):void{
            this._close.dispatch(this.id);
        }
        public function get close():Signal{
            return (this._close);
        }

    }
}//package com.gaiaonline.monster.view.components.itemGrant 
