//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.items.model {
    import flash.display.*;
    import alecmce.ui.*;
    import __AS3__.vec.*;
    import alecmce.async.*;
    import flash.geom.*;

    public class Item extends AsyncBase {

        public var id:uint;
        public var itemName:String;
        public var description:String;
        public var asset:Asset;
        public var icon:BitmapData;
        public var vector:String;
        public var isUseable:Boolean;
        public var inventory:Object;
        public var context:Vector.<String>;

        public function Item(_arg1:uint){
            this.id = _arg1;
            this.icon = new BitmapData(60, 60, true, 0);
        }
        public function isInContext(_arg1:String):Boolean{
            return ((((_arg1 == null)) || (!((this.context.indexOf(_arg1) == -1)))));
        }
        override protected function onInit():void{
            this.asset = new SingletonAssetLoader(this.vector);
            if (this.asset.isComplete){
                this.setup(this.asset);
            } else {
                if (this.asset.isError){
                    this.cancel(this.asset);
                } else {
                    this.asset.error.addOnce(this.cancel);
                    this.asset.complete.addOnce(this.setup);
                };
            };
            this.asset.init();
        }
        override public function dispose(_arg1:Boolean=true):void{
            super.dispose(_arg1);
            if (this.icon){
                this.icon.dispose();
            };
            this.icon = null;
        }
        private function setup(_arg1:Asset):void{
            _arg1.error.remove(this.cancel);
            var _local2:DisplayObject = _arg1.self;
            var _local3:Rectangle = _local2.getRect(_local2);
            this.icon = new BitmapData(_local3.width, _local3.height, true, 0);
            this.icon.draw(_local2, new Matrix(1, 0, 0, 1, -(_local3.left), -(_local3.top)), null, null, null, true);
            _arg1.dispose();
            asyncComplete();
        }
        private function cancel(_arg1:Asset, _arg2:String=""):void{
            _arg1.complete.remove(this.setup);
            this.icon.fillRect(this.icon.rect, 4294901760);
            asyncError(_arg2);
        }
        override public function get name():String{
            return (this.itemName);
        }

    }
}//package gaia.moga.items.model 
