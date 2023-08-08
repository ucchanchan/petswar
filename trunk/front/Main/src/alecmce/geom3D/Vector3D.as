//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.geom3D {

    public class Vector3D {

        private var _i:Number;
        private var _j:Number;
        private var _k:Number;
        private var _magnitude:Number;

        public static const xAxis:Vector3D = new Vector3D(1, 0, 0);
;
        public static const yAxis:Vector3D = new Vector3D(0, 1, 0);
;
        public static const zAxis:Vector3D = new Vector3D(0, 0, 1);
;

        public function Vector3D(_arg1:Number=0, _arg2:Number=0, _arg3:Number=0){
            this._i = _arg1;
            this._j = _arg2;
            this._k = _arg3;
            this._magnitude = -1;
        }
        public function get i():Number{
            return (this._i);
        }
        public function set i(_arg1:Number):void{
            if (this._i == _arg1){
                return;
            };
            this._i = _arg1;
            this._magnitude = -1;
        }
        public function get j():Number{
            return (this._j);
        }
        public function set j(_arg1:Number):void{
            if (this._j == _arg1){
                return;
            };
            this._j = _arg1;
            this._magnitude = -1;
        }
        public function get k():Number{
            return (this._k);
        }
        public function set k(_arg1:Number):void{
            if (this._k == _arg1){
                return;
            };
            this._k = _arg1;
            this._magnitude = -1;
        }
        public function get magnitude():Number{
            if (this._magnitude == -1){
                this._magnitude = Math.sqrt((((this.i * this.i) + (this.j * this.j)) + (this.k * this.k)));
            };
            return (this._magnitude);
        }
        public function set magnitude(_arg1:Number):void{
            var _local2:Number = (_arg1 / this.magnitude);
            this._i = (this._i * _local2);
            this._j = (this._j * _local2);
            this._k = (this._k * _local2);
            this._magnitude = _arg1;
        }

    }
}//package alecmce.geom3D 
