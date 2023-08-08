//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.story.model {
    import alecmce.async.*;

    public interface StoryLoader extends Async {

        function set url(_arg1:String):void;
        function get data():String;
        function dispose(_arg1:Boolean=true):void;

    }
}//package gaia.moga.story.model 
