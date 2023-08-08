//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.ui.button {
    import org.osflash.signals.*;
    import alecmce.ui.*;

    public interface Button extends UIElement {

        function get clicked():ISignal;
        function get over():ISignal;
        function get out():ISignal;
        function get isOver():Boolean;
        function get isDown():Boolean;

    }
}//package alecmce.ui.button 
