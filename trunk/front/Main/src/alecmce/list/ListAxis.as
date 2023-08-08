//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.list {

    public class ListAxis {

        public var property:String;

        public static const X_AXIS:ListAxis = new ListAxis("x");
;
        public static const Y_AXIS:ListAxis = new ListAxis("y");
;

        public function ListAxis(_arg1:String){
            this.property = _arg1;
        }
    }
}//package alecmce.list 
