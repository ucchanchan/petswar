//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.travel.view.async {
    import alecmce.async.*;
    import gaia.moga.travel.view.ui.*;

    public class TravelUIRemoveAsync extends AsyncBase {

        private var view:TravelUI;

        public function TravelUIRemoveAsync(_arg1:TravelUI){
            this.view = _arg1;
        }
        override protected function onInit():void{
            if (this.view.parent){
                this.view.parent.removeChild(this.view);
            };
            asyncComplete();
        }

    }
}//package gaia.moga.travel.view.async 
