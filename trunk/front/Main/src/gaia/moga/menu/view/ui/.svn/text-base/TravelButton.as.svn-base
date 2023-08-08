//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.menu.view.ui {
    import flash.display.*;

    public class TravelButton extends MenuButton {

        private var _type:String;

        public function TravelButton(_arg1:MovieClip, _arg2:String){
            super(_arg1, _arg2);
            this.type = Menu.TRAVEL;
        }
        public function get type():String{
            return (this._type);
        }
        public function set type(_arg1:String):void{
            this._type = _arg1;
            asset.slider.world.visible = (_arg1 == Menu.TRAVEL);
            asset.slider.home.visible = (_arg1 == Menu.HOME);
        }

    }
}//package gaia.moga.menu.view.ui 
