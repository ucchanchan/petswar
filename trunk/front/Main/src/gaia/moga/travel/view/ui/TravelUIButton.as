//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.travel.view.ui {
    import flash.display.*;
    import com.gaiaonline.monster.model.world.*;
    import alecmce.ui.button.*;

    public class TravelUIButton extends MovieClipButton {

        private var _index:uint;
        private var _zone:Zone;

        private static const LOCKED:uint = 5;

        public function TravelUIButton(_arg1:MovieClip, _arg2:uint){
            super(_arg1);
            this._index = _arg2;
        }
        public function get zone():Zone{
            return (this._zone);
        }
        public function set zone(_arg1:Zone):void{
            this._zone = _arg1;
            this.update();
        }
        public function get isAvailable():Boolean{
            return (((this._zone) && (this._zone.isAvailable)));
        }
        override public function update():void{
            if (!this.isAvailable){
                ui.gotoAndStop(LOCKED);
            } else {
                super.update();
            };
        }
        public function get index():uint{
            return (this._index);
        }

    }
}//package gaia.moga.travel.view.ui 
