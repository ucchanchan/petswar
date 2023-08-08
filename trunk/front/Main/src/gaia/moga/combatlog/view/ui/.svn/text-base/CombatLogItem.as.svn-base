//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.combatlog.view.ui {
    import flash.display.*;
    import com.gskinner.motion.*;
    import flash.text.*;

    class CombatLogItem extends Sprite {

        private var shape:Shape;
        private var tf:TextField;

        public static const WIDTH:uint = 312;
        public static const HEIGHT:uint = 15;

        function CombatLogItem(_arg1:TextFormat){
            this.init(_arg1);
        }
        private function init(_arg1:TextFormat):void{
            this.shape = new Shape();
            this.tf = new TextField();
            this.tf.width = WIDTH;
            this.tf.multiline = true;
            this.tf.wordWrap = true;
            this.tf.defaultTextFormat = _arg1;
            this.tf.selectable = false;
            addChild(this.shape);
            addChild(this.tf);
        }
        public function define(_arg1:String):void{
            this.tf.htmlText = _arg1;
            this.tf.height = (HEIGHT * this.tf.numLines);
            this.shape.graphics.beginFill(3355460);
            this.shape.graphics.drawRect(0, 0, WIDTH, (HEIGHT * this.tf.numLines));
            this.shape.graphics.endFill();
            this.shape.alpha = 1;
            this.shape.visible = true;
        }
        public function clearHighlight():void{
            new GTween(this.shape, 1, {alpha:0}, {onComplete:this.onComplete});
        }
        private function onComplete(_arg1:GTween):void{
            this.shape.visible = false;
        }

    }
}//package gaia.moga.combatlog.view.ui 
