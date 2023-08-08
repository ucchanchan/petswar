//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.ugc.model {
    import __AS3__.vec.*;

    public class UGCGrants {

        private var _grants:Vector.<GrantVO>;

        public function UGCGrants(){
            this._grants = new Vector.<GrantVO>();
        }
        public function add(_arg1:GrantVO):void{
            this._grants.push(_arg1);
        }
        public function get(_arg1:uint):GrantVO{
            return (this._grants[_arg1]);
        }
        public function get count():uint{
            return (this._grants.length);
        }

    }
}//package gaia.moga.ugc.model 
