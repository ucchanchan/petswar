//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.list.scrollbar {
    import org.osflash.signals.*;

    public interface Scrollbar {

        function get reposition():ISignal;
        function setup(_arg1:uint, _arg2:uint):void;
        function get isVisible():Boolean;
        function set isVisible(_arg1:Boolean):void;

    }
}//package alecmce.list.scrollbar 
