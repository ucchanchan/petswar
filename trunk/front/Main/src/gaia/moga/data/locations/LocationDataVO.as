//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.data.locations {

    public class LocationDataVO {

        public var id:int;
        public var name:String;
        public var description:String;
        public var music:String;
        private var _storyMusic:String;

        public function LocationDataVO(_arg1:int){
            this.id = _arg1;
        }
        public function get storyMusic():String{
            return (((this._storyMusic) || (this.music)));
        }
        public function set storyMusic(_arg1:String):void{
            this._storyMusic = _arg1;
        }

    }
}//package gaia.moga.data.locations 
