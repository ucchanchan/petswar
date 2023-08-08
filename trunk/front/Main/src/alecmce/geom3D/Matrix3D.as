//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.geom3D {
    import __AS3__.vec.*;

    public class Matrix3D {

        private var _matrix:Vector.<Number>;

        public function Matrix3D(){
            this._matrix = Vector.<Number>([1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1]);
        }
        public function transformPoint(_arg1):Point3D{
            var _local2:Point3D;
            _local2 = new Point3D();
            _local2.x = ((((this._matrix[0] * _arg1.x) + (this._matrix[4] * _arg1.y)) + (this._matrix[8] * _arg1.z)) + this._matrix[12]);
            _local2.y = ((((this._matrix[1] * _arg1.x) + (this._matrix[5] * _arg1.y)) + (this._matrix[9] * _arg1.z)) + this._matrix[13]);
            _local2.z = ((((this._matrix[2] * _arg1.x) + (this._matrix[6] * _arg1.y)) + (this._matrix[10] * _arg1.z)) + this._matrix[14]);
            return (_local2);
        }
        public function transformVector(_arg1):Vector3D{
            var _local2:Vector3D = new Vector3D();
            _local2.i = (((this._matrix[0] * _arg1.i) + (this._matrix[4] * _arg1.j)) + (this._matrix[8] * _arg1.k));
            _local2.j = (((this._matrix[1] * _arg1.i) + (this._matrix[5] * _arg1.j)) + (this._matrix[9] * _arg1.k));
            _local2.k = (((this._matrix[2] * _arg1.i) + (this._matrix[6] * _arg1.j)) + (this._matrix[10] * _arg1.k));
            return (_local2);
        }
        public function clone():Matrix3D{
            var _local1:Matrix3D = new Matrix3D();
            _local1._matrix = this._matrix.concat();
            return (_local1);
        }
        public function toString():String{
            var _local1:int;
            var _local2:int;
            var _local3:Vector.<String>;
            _local3 = Vector.<String>(["|", "|", "|", "|"]);
            _local1 = 0;
            while (_local1 < 4) {
                _local2 = 0;
                while (_local2 < 4) {
                    _local3[_local2] = (_local3[_local2] + ((" " + this._matrix[((_local1 << 2) | _local2)].toFixed(3)) + " |"));
                    _local2++;
                };
                _local1++;
            };
            return (_local3.join("\n"));
        }

        public static function multiply(_arg1:Matrix3D, _arg2:Matrix3D):Matrix3D{
            var _local3:int;
            var _local4:int;
            var _local5:int;
            var _local6:Matrix3D = new (Matrix3D);
            _local3 = 0;
            while (_local3 < 4) {
                _local4 = 0;
                while (_local4 < 4) {
                    _local5 = 0;
                    while (_local5 < 4) {
                        _local6._matrix[((_local3 << 2) | _local4)] = (_local6._matrix[((_local3 << 2) | _local4)] + (_arg1._matrix[((_local5 << 2) | _local4)] * _arg2._matrix[((_local3 << 2) | _local5)]));
                        _local5++;
                    };
                    _local4++;
                };
                _local3++;
            };
            return (_local6);
        }
        public static function viewpoint(_arg1:Point3D, _arg2:Vector3D):Matrix3D{
            var _local5:Matrix3D;
            var _local6:Matrix3D;
            var _local3:Number = -(Math.atan2(_arg2.i, _arg2.k));
            var _local4:Number = -(Math.atan2(_arg2.j, _arg2.k));
            _local5 = about(Vector3D.yAxis, _local3);
            _local6 = about(Vector3D.xAxis, _local4);
            _local6 = multiply(_local5, _local6);
            _local5 = translate(_arg1.positionVector);
            _local5 = multiply(_local5, _local6);
            return (_local5);
        }
        public static function euler(_arg1:Number, _arg2:Number, _arg3:Number):Matrix3D{
            var _local4:Matrix3D = new (Matrix3D);
            var _local5:Number = Math.sin(_arg1);
            var _local6:Number = Math.sin(_arg2);
            var _local7:Number = Math.sin(_arg3);
            var _local8:Number = Math.cos(_arg1);
            var _local9:Number = Math.cos(_arg2);
            var _local10:Number = Math.cos(_arg3);
            _local4._matrix[0] = ((_local8 * _local10) - ((_local9 * _local5) * _local7));
            _local4._matrix[1] = (((-(_local9) * _local10) * _local8) - (_local8 * _local7));
            _local4._matrix[2] = (_local5 * _local6);
            _local4._matrix[3] = 0;
            _local4._matrix[4] = ((_local10 * _local5) + ((_local8 * _local9) * _local7));
            _local4._matrix[5] = (((_local8 * _local9) * _local10) - (_local5 * _local7));
            _local4._matrix[6] = (-(_local8) * _local6);
            _local4._matrix[7] = 0;
            _local4._matrix[8] = (_local6 * _local7);
            _local4._matrix[9] = (_local10 * _local6);
            _local4._matrix[10] = _local9;
            _local4._matrix[11] = 0;
            return (_local4);
        }
        public static function about(_arg1:Vector3D, _arg2:Number):Matrix3D{
            var _local3:Matrix3D = new (Matrix3D);
            var _local4:Number = Math.sin(_arg2);
            var _local5:Number = Math.cos(_arg2);
            var _local6:Number = (1 / _arg1.magnitude);
            var _local7:Number = (_arg1.i * _local6);
            var _local8:Number = (_arg1.j * _local6);
            var _local9:Number = (_arg1.k * _local6);
            _local3._matrix[0] = (_local5 + (((1 - _local5) * _local7) * _local7));
            _local3._matrix[1] = ((((1 - _local5) * _local7) * _local8) - (_local4 * _local9));
            _local3._matrix[2] = ((((1 - _local5) * _local7) * _local9) + (_local4 * _local8));
            _local3._matrix[3] = 0;
            _local3._matrix[4] = ((((1 - _local5) * _local7) * _local8) + (_local4 * _local9));
            _local3._matrix[5] = (_local5 + (((1 - _local5) * _local8) * _local8));
            _local3._matrix[6] = ((((1 - _local5) * _local8) * _local9) - (_local4 * _local7));
            _local3._matrix[7] = 0;
            _local3._matrix[8] = ((((1 - _local5) * _local9) * _local7) - (_local4 * _local8));
            _local3._matrix[9] = ((((1 - _local5) * _local9) * _local8) + (_local4 * _local7));
            _local3._matrix[10] = (_local5 + (((1 - _local5) * _local9) * _local9));
            _local3._matrix[11] = 0;
            return (_local3);
        }
        public static function translate(_arg1:Vector3D):Matrix3D{
            var _local2:Matrix3D = new (Matrix3D);
            _local2._matrix[12] = _arg1.i;
            _local2._matrix[13] = _arg1.j;
            _local2._matrix[14] = _arg1.k;
            return (_local2);
        }

    }
}//package alecmce.geom3D 
