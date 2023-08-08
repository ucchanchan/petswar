//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.geom3D {
    import __AS3__.vec.*;

    public class Viewpoint3D {

        private var _position:Point3D;
        private var _look:Vector3D;
        private var _matrix:Matrix3D;
        private var _width:Number;
        private var _height:Number;
        private var _theta:Number;
        private var _distance:Number;
        private var halfWidth:Number;
        private var halfHeight:Number;

        public function Viewpoint3D(_arg1:int, _arg2:int){
            this._position = new Point3D(0, 0, -100);
            this._look = new Vector3D(0, 0, 1);
            this._width = _arg1;
            this.halfWidth = (_arg1 * 0.5);
            this._height = _arg2;
            this.halfHeight = (_arg2 * 0.5);
            this._theta = (Math.PI / 6);
        }
        public function get position():Point3D{
            return (this._position);
        }
        public function set position(_arg1:Point3D):void{
            this._position = _arg1;
            this._matrix = null;
        }
        public function get look():Vector3D{
            return (this._look);
        }
        public function set look(_arg1:Vector3D):void{
            this._look = _arg1;
            this._matrix = null;
        }
        public function get width():Number{
            return (this._width);
        }
        public function set width(_arg1:Number):void{
            if (this._width == _arg1){
                return;
            };
            this._width = _arg1;
            this.halfWidth = (_arg1 * 0.5);
            this._distance = Number.NaN;
        }
        public function get height():Number{
            return (this._height);
        }
        public function set height(_arg1:Number):void{
            if (this._height == _arg1){
                return;
            };
            this._height = _arg1;
            this.halfHeight = (_arg1 * 0.5);
            this._distance = Number.NaN;
        }
        public function get theta():Number{
            return (this._theta);
        }
        public function set theta(_arg1:Number):void{
            if (this._theta == _arg1){
                return;
            };
            this._theta = _arg1;
            this._distance = Number.NaN;
        }
        public function transformPoints(_arg1:Vector.<Point3D>):Vector.<ViewpointResolved>{
            var _local4:Point3D;
            var _local5:Number;
            var _local6:Number;
            var _local7:Number;
            var _local2:int = _arg1.length;
            var _local3:Vector.<ViewpointResolved> = new Vector.<ViewpointResolved>(_local2, true);
            if (this._matrix == null){
                this._matrix = Matrix3D.viewpoint(this._position, this._look);
            };
            if (isNaN(this._distance)){
                this._distance = (this._width / (2 * Math.tan(this._theta)));
            };
            while (_local2--) {
                _local4 = this._matrix.transformPoint(_arg1[_local2]);
                _local5 = (1 / _local4.z);
                _local6 = (this.halfWidth + ((this._distance * _local4.x) * _local5));
                _local7 = (this.halfHeight + ((this._distance * _local4.y) * _local5));
                _local3[_local2] = new ViewpointResolved(_local6, _local7, _local4.z);
            };
            return (_local3);
        }
        public function transformPoint(_arg1:Point3D):ViewpointResolved{
            if (this._matrix == null){
                this._matrix = Matrix3D.viewpoint(this._position, this._look);
            };
            if (isNaN(this._distance)){
                this._distance = (this._width / (2 * Math.tan(this._theta)));
            };
            _arg1 = this._matrix.transformPoint(_arg1);
            var _local2:Number = (1 / _arg1.z);
            var _local3:Number = ((this._width * 0.5) + ((this._distance * _arg1.x) * _local2));
            var _local4:Number = ((this._height * 0.5) + ((this._distance * _arg1.y) * _local2));
            return (new ViewpointResolved(_local3, _local4, _arg1.z));
        }

    }
}//package alecmce.geom3D 
