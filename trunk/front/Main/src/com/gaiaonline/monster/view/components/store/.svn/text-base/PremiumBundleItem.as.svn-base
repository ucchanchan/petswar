//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.store {
    import flash.display.*;
    import flash.events.*;
    import com.gaiaonline.monster.model.vo.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;

    public class PremiumBundleItem extends Sprite {

        private var content:MovieClip;
        private var data:StoreItemVO;
        private var _clicked:Signal;
        private var setSelected:Boolean;
        private var setSpecial:Boolean;

        public function PremiumBundleItem(_arg1:Asset, _arg2:StoreItemVO){
            this._clicked = new Signal();
            this.data = _arg2;
            if (_arg1.isComplete){
                this.init();
            } else {
                _arg1.complete.add(this.init);
            };
            this.addEventListener(MouseEvent.MOUSE_DOWN, this.onClick, false, 0, true);
            this.addEventListener(MouseEvent.ROLL_OUT, this.onRollOut, false, 0, true);
            this.addEventListener(MouseEvent.ROLL_OVER, this.onRollOver, false, 0, true);
            this.buttonMode = true;
        }
        private function init(_arg1:Asset=null):void{
            this.content = MovieClip(_arg1.content);
            addChild(this.content);
            this.content.coinAmount.text = ("x " + this.data.quantity);
            this.content.cost.text = (("$" + int((this.data.premium_cost / 10))) + " USD");
            this.update(this.setSelected);
            this.makeSpecial(this.setSpecial);
            this.content.hover.visible = false;
        }
        private function onClick(_arg1:MouseEvent):void{
            this.content.hover.visible = false;
            this.clicked.dispatch(this);
        }
        private function onRollOver(_arg1:MouseEvent):void{
            if (!this.content.selected.visible){
                this.content.hover.visible = true;
            };
        }
        private function onRollOut(_arg1:MouseEvent):void{
            this.content.hover.visible = false;
        }
        public function update(_arg1:Boolean):void{
            if (!this.content){
                this.setSelected = _arg1;
            } else {
                this.content.selected.visible = _arg1;
            };
        }
        public function makeSpecial(_arg1:Boolean):void{
            if (!this.content){
                this.setSpecial = _arg1;
            } else {
                this.content.bestValue.visible = _arg1;
            };
        }
        public function get clicked():Signal{
            return (this._clicked);
        }

    }
}//package com.gaiaonline.monster.view.components.store 
