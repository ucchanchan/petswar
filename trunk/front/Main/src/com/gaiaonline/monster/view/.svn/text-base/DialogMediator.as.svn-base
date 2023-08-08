//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.view.dialog.vo.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.view.dialog.*;

    public class DialogMediator extends Mediator {

		[Inject]
        public var view:Dialog;
		[Inject]
        public var text:TextService;
        private var vo:DialogVO;

        override public function onRegister():void{
            eventDispatcher.addEventListener(DialogEvent.SHOW_DIALOG, this.onShowDialog);
        }
        override public function onRemove():void{
            eventDispatcher.removeEventListener(DialogEvent.SHOW_DIALOG, this.onShowDialog);
        }
        private function onShowDialog(_arg1:DialogEvent):void{
            this.vo = _arg1.data;
            this.view.response.addOnce(this.onResponse);
            this.view.show(this.vo, this.text.dialogButtonsLanguage);
        }
        private function onResponse(_arg1:String):void{
            var _local2:Class;
            switch (_arg1){
                case Dialog.OK:
                    _local2 = this.vo.ok;
                    break;
                case Dialog.CANCEL:
                    _local2 = this.vo.cancel;
                    break;
                case Dialog.YES:
                    _local2 = this.vo.yes;
                    break;
                case Dialog.NO:
                    _local2 = this.vo.no;
                    break;
            };
            if (_local2){
                dispatch(new DialogInterimEvent(DialogInterimEvent.ACTION, _local2, this.vo.data));
            };
            this.view.hide();
        }

    }
}//package com.gaiaonline.monster.view 
