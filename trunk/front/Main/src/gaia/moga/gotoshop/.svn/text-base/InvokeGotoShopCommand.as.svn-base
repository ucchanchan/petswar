//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.gotoshop {
    import alecmce.ui.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.controller.*;

    public class InvokeGotoShopCommand extends AsyncCommand {

		[Inject]
        public var event:GotoShopEvent;
		[Inject]
        public var assets:AssetService;
		[Inject]
        public var text:TextService;
        private var asset:Asset;
        private var dialog:GotoShopDialog;

        override public function execute():void{
            this.asset = this.assets.createWrapper("assets/ui/gotoShop.swf");
            hook(this.asset, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:Async):void{
            var _local2:String;
            var _local3:String;
            switch (this.event.type){
                case GotoShopEvent.OUT_OF_SEEDS:
                    _local2 = this.text.getText("NO_SEEDS_DIALOG_TITLE");
                    _local3 = this.text.getText("NO_SEEDS_DIALOG_MAIN");
                    break;
                case GotoShopEvent.OUT_OF_COFFEE:
                    _local2 = this.text.getText("NO_COFFEE_DIALOG_TITLE");
                    _local3 = this.text.getText("NO_COFFEE_DIALOG_MAIN");
                    break;
            };
            this.dialog = new GotoShopDialog(this.asset, _local2, _local3);
            this.dialog.complete.addOnce(this.onDialogComplete);
            dispatch(new PanelsEvent(PanelsEvent.ADD_OVERLAY, this.dialog));
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
        }
        private function onDialogComplete():void{
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, this.dialog));
        }

    }
}//package gaia.moga.gotoshop 
