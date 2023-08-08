//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.story.view.anim {
    import alecmce.async.*;

    public interface StoryAnim extends Async {

        function get forwards():Boolean;
        function cancel():void;

    }
}//package gaia.moga.story.view.anim 
