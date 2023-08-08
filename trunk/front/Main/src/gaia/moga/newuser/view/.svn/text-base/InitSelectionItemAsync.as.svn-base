//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.newuser.view {
    import alecmce.async.*;
    import gaia.moga.newuser.view.ui.*;

    public class InitSelectionItemAsync extends AsyncBase {

        private var _item:SelectionItem;

        public function InitSelectionItemAsync(_arg1:SelectionItem){
            this._item = _arg1;
        }
        override protected function onInit():void{
            this._item.setupComplete.add(this.onSetupComplete);
            this._item.init();
        }
        private function onSetupComplete():void{
            asyncComplete();
        }

    }
}//package gaia.moga.newuser.view 
