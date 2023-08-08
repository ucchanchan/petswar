//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.feeds {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.view.components.app.panel.*;

    public class PublishCaptureFeedConfirm extends Panel {

        private var asset:Asset;
        private var _confirmed:Signal;
        private var _close:Signal;
        private var msg:String;
        private var icon:Asset;
        private var moga:MonsterModel;

        public function PublishCaptureFeedConfirm(_arg1:Asset, _arg2:String, _arg3:Asset, _arg4:MonsterModel){
            this.asset = _arg1;
            this.msg = _arg2;
            this.icon = _arg3;
            this.moga = _arg4;
            this._confirmed = new Signal(MonsterModel);
            this._close = new Signal();
            if (_arg1.isComplete){
                this.init();
            } else {
                _arg1.complete.add(this.init);
            };
        }
        private function init(_arg1:Asset=null):void{
            var _local2:MovieClip = (_arg1.content as MovieClip).main;
            _local2.confirm.addEventListener(MouseEvent.CLICK, this.onConfirm, false, 0, true);
            _local2.close.addEventListener(MouseEvent.CLICK, this.onClose, false, 0, true);
            _local2.msg.text = this.msg;
            _local2.icon.addChild(this.icon);
            addChild(this.asset.self);
        }
        private function onConfirm(_arg1:MouseEvent):void{
            this.removeListeners();
            this._confirmed.dispatch(this.moga);
        }
        private function onClose(_arg1:MouseEvent):void{
            this.removeListeners();
            this._close.dispatch();
        }
        private function removeListeners():void{
            var _local1:MovieClip = (this.asset.content as MovieClip).main;
            _local1.confirm.removeEventListener(MouseEvent.CLICK, this.onConfirm);
            _local1.close.removeEventListener(MouseEvent.CLICK, this.onClose);
        }
        public function get confirmed():Signal{
            return (this._confirmed);
        }
        public function get close():Signal{
            return (this._close);
        }

    }
}//package com.gaiaonline.monster.view.components.feeds 
