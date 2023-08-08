//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.travel.view.async {
    import alecmce.async.*;
    import gaia.moga.travel.view.ui.*;

    public class TravelUIEnableAsync extends AsyncBase {

        private var view:TravelUI;

        public function TravelUIEnableAsync(_arg1:TravelUI){
            this.view = _arg1;
        }
        override protected function onInit():void{
            this.view.enabled.addOnce(this.onEnabled);
            this.view.enable();
        }
        private function onEnabled():void{
            asyncComplete();
        }

    }
}//package gaia.moga.travel.view.async 
