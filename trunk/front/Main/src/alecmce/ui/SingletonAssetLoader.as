//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.ui {
    import flash.display.*;

    public class SingletonAssetLoader extends MovieClipAssetLoader {

        public function SingletonAssetLoader(_arg1:String, _arg2:Sprite=null, _arg3:int=3){
            super(_arg1, _arg2, _arg3);
        }
        override public function dispose(_arg1:Boolean=true):void{
            if (parent){
                parent.removeChild(this);
            };
        }

    }
}//package alecmce.ui 
