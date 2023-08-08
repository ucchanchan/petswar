//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.story.model {
    import gaia.moga.story.model.*;

    class StoryBackground implements StoryAsset {

        private var _id:String;
        private var _asset:String;

        public static const BACKGROUND:uint = 1;

        function StoryBackground(_arg1:String, _arg2:String){
            this._id = _arg1;
            this._asset = _arg2;
        }
        public function get id():String{
            return (this._id);
        }
        public function get asset():String{
            return (this._asset);
        }
        public function get type():uint{
            return (BACKGROUND);
        }

    }
}//package gaia.moga.story.model 
