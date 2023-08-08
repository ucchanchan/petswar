//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.data.attacks {

    public class AttackDataVO {

        private var category:AttackCategoryDataVO;
        private var level:uint;

        public function AttackDataVO(_arg1:AttackCategoryDataVO, _arg2:uint){
            this.category = _arg1;
            this.level = _arg2;
        }
        public function get name():String{
            return (((this.category.name + " ") + this.level));
        }
        public function get chargeAnim():String{
            return (this.category.chargeAnim);
        }
        public function get attackAnim():String{
            return (this.category.attackAnim);
        }
        public function get hitAnim():String{
            return (this.category.hitAnim);
        }
        public function get description():String{
            return (this.category.description);
        }
        public function get hitText():String{
            return (this.category.hitText);
        }
        public function get criticalText():String{
            return (this.category.criticalText);
        }
        public function get missText():String{
            return (this.category.missText);
        }
        public function get castAnim():String{
            return (this.category.castAnim);
        }
        public function get castText():String{
            return (this.category.castText);
        }

    }
}//package gaia.moga.data.attacks 
