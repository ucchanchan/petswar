//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.story.view.assets {
    import alecmce.ui.*;
    import gaia.moga.story.model.*;

    public interface StoryAssetFactory {

        function getNPCBubble():Asset;
        function getPlayerBubble():Asset;
        function getSkip():Asset;
        function createWrapper(_arg1:String):Asset;
        function createLoader(_arg1:String):StoryLoader;

    }
}//package gaia.moga.story.view.assets 
