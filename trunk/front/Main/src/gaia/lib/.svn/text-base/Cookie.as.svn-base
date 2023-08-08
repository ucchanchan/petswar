//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.lib {
    import alecmce.services.*;
    import flash.net.*;

    public class Cookie {

        private var ticker:Ticker;
        private var frame:int;
        private var so:SharedObject;

        private static const FRAMES:int = 5;

        public function Cookie(_arg1:Ticker, _arg2:String){
            this.ticker = _arg1;
            this.so = SharedObject.getLocal(_arg2);
        }
        public function getValue(_arg1:String, _arg2=null){
            if (this.so.data[_arg1] == null){
                return (_arg2);
            };
            return (this.so.data[_arg1]);
        }
        public function setValue(_arg1:String, _arg2):void{
            this.so.data[_arg1] = _arg2;
            this.delaySave();
        }
        public function save():void{
            this.so.flush();
        }
        private function delaySave():void{
            this.frame = FRAMES;
            this.ticker.add(this.andSave);
        }
        private function andSave():void{
            if (this.frame--){
                return;
            };
            this.save();
        }

    }
}//package gaia.lib 
