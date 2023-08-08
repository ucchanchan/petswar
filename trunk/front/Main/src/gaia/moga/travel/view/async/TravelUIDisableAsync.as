//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.travel.view.async {
    import alecmce.async.*;
    import gaia.moga.travel.view.ui.*;

    public class TravelUIDisableAsync extends AsyncBase {

        private var view:TravelUI;

        public function TravelUIDisableAsync(_arg1:TravelUI){
            this.view = _arg1;
        }
        override protected function onInit():void{
            this.view.disabled.addOnce(this.onDisabled);
            this.view.disable();
        }
        private function onDisabled():void{
            asyncComplete();
        }

    }
}//package gaia.moga.travel.view.async 
