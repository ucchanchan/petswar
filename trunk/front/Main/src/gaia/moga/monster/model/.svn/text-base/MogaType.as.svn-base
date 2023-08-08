//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.monster.model {
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;

    public class MogaType {

        public var id:uint;
        private var map:Object;
        private var list:Vector.<MonsterModel>;

        public function MogaType(){
            this.map = {};
            this.list = new Vector.<MonsterModel>();
        }
        public function add(_arg1:MonsterModel):void{
            var _local2:int = this.list.indexOf(_arg1);
            if (_local2 != -1){
                return;
            };
            this.list.push(_arg1);
            this.map[_arg1.id] = _arg1;
        }
        public function remove(_arg1:MonsterModel):void{
            var _local2:int = this.list.indexOf(_arg1);
            if (_local2 == -1){
                return;
            };
            this.list.splice(_local2, 1);
            delete this.map[_arg1.id];
        }
        public function get count():uint{
            return (this.list.length);
        }
        public function getMoga(_arg1:uint):MonsterModel{
            return (this.list[_arg1]);
        }
        public function getMogaByID(_arg1:String):MonsterModel{
            return (this.map[_arg1]);
        }

    }
}//package gaia.moga.monster.model 
