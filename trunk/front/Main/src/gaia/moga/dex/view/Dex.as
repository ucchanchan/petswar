//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.view {
    import org.osflash.signals.*;
    import __AS3__.vec.*;
    import gaia.moga.dex.model.*;

    public interface Dex {

        function get data():DexModel;
        function set data(_arg1:DexModel):void;
        function get team():Vector.<DexMogaInstance>;
        function set team(_arg1:Vector.<DexMogaInstance>):void;
        function get limit():uint;
        function set limit(_arg1:uint):void;
        function set isLocked(_arg1:Boolean):void;
        function get isLocked():Boolean;
        function get sound():ISignal;
        function get openShop():ISignal;
        function get closed():ISignal;
        function dispose(_arg1:Boolean=true):void;

    }
}//package gaia.moga.dex.view 
