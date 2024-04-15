package
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getTimer;
   
   public class FPSCounter extends Sprite
   {
       
      
      private var ticks:uint = 0;
      
      private var tf:TextField;
      
      private var last:uint;
      
      public function FPSCounter(param1:int = 0, param2:int = 0, param3:uint = 16777215, param4:Boolean = false, param5:uint = 0)
      {
         last = getTimer();
         ticks = 0;
         super();
         x = param1;
         y = param2;
         tf = new TextField();
         tf.textColor = param3;
         tf.text = "----- fps";
         tf.selectable = false;
         tf.background = param4;
         tf.backgroundColor = param5;
         tf.autoSize = TextFieldAutoSize.LEFT;
         addChild(tf);
         width = tf.textWidth;
         height = tf.textHeight;
         addEventListener(Event.ENTER_FRAME,tick);
      }
      
      public function tick(param1:Event) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Number = NaN;
         ++ticks;
         _loc2_ = uint(getTimer());
         _loc3_ = uint(_loc2_ - last);
         if(_loc3_ >= 1000)
         {
            _loc4_ = ticks / _loc3_ * 1000;
            tf.text = _loc4_.toFixed(1) + " fps";
            ticks = 0;
            last = _loc2_;
         }
      }
   }
}
