//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.geom3D {
    import __AS3__.vec.*;

    public class Point3D {

        public var x:Number;
        public var y:Number;
        public var z:Number;

        public function Point3D(_arg1:Number=0, _arg2:Number=0, _arg3:Number=0){
            this.x = _arg1;
            this.y = _arg2;
            this.z = _arg3;
        }
        public function clone():Point3D{
            return (new Point3D(this.x, this.y, this.z));
        }
        public function resolve(_arg1:Vector.<Vector3D>):Point3D{
            var _local4:Vector3D;
            var _local2:Point3D = this.clone();
            var _local3:int = _arg1.length;
            while (_local3--) {
                _local4 = _arg1[_local3];
                _local2.x = (_local2.x + _local4.i);
                _local2.y = (_local2.y + _local4.j);
                _local2.z = (_local2.z + _local4.k);
            };
            return (_local2);
        }
        public function get positionVector():Vector3D{
            return (new Vector3D(this.x, this.y, this.z));
        }

    }
}//package alecmce.geom3D 
