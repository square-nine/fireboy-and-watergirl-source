package
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getTimer;
   
   public class FPSCounter extends Sprite
   {
       
      
      private var last:uint;
      
      private var ticks:uint = 0;
      
      private var tf:TextField;
      
      public function FPSCounter(param1:int = 0, param2:int = 0, param3:uint = 16777215, param4:Boolean = false, param5:uint = 0)
      {
         this.last = getTimer();
         super();
         x = param1;
         y = param2;
         this.tf = new TextField();
         this.tf.textColor = param3;
         this.tf.text = "----- fps";
         this.tf.selectable = false;
         this.tf.background = param4;
         this.tf.backgroundColor = param5;
         this.tf.autoSize = TextFieldAutoSize.LEFT;
         addChild(this.tf);
         width = this.tf.textWidth;
         height = this.tf.textHeight;
         addEventListener(Event.ENTER_FRAME,this.tick);
      }
      
      public function tick(param1:Event) : void
      {
         var _loc4_:Number = NaN;
         ++this.ticks;
         var _loc2_:uint = uint(getTimer());
         var _loc3_:uint = uint(_loc2_ - this.last);
         if(_loc3_ >= 1000)
         {
            _loc4_ = this.ticks / _loc3_ * 1000;
            this.tf.text = _loc4_.toFixed(1) + " fps";
            this.ticks = 0;
            this.last = _loc2_;
         }
      }
   }
}
