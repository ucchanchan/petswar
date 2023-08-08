//Created by Action Script Viewer - http://www.buraks.com/asv
package {
    import flash.display.*;
    import flash.system.*;
    import com.gaiaonline.monster.*;
    import com.gskinner.motion.plugins.*;

    public class Main extends Sprite {

        private var context:ApplicationContext;

        public function Main(){
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
            ColorTransformPlugin.install();
            var _local1:Sprite = new Sprite();
            addChild(_local1);
           // var _local2:Sprite = new Sprite();
            //this.drawSides(_local2.graphics);
            //addChild(_local2);
            this.context = new ApplicationContext(_local1);
            Security.allowDomain("www.gaiaonline.com");
            Security.allowDomain("v.sometrics.com");
			//Security.allowDomain("*");
        }
        private function drawSides(_arg1:Graphics):void{
            _arg1.beginFill(0);
            _arg1.drawRect(-760, 0, 760, 660);
            _arg1.endFill();
            _arg1.beginFill(0);
            _arg1.drawRect(760, 0, 760, 660);
            _arg1.endFill();
        }

    }
}//package 
