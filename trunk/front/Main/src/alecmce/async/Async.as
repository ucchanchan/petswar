//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.async {
    import org.osflash.signals.*;

    public interface Async {

        function init():void;
        function get isComplete():Boolean;
        function get complete():Signal;
        function get isError():Boolean;
        function get error():Signal;
        function get name():String;

    }
}//package alecmce.async 
