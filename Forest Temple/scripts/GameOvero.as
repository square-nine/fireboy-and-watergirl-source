package
{
   import adobe.utils.*;
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="GameOvero")]
   public dynamic class GameOvero extends MovieClip
   {
       
      
      public var GOboard:MovieClip;
      
      public var v:*;
      
      public var acc:*;
      
      public var Tapper:MovieClip;
      
      public function GameOvero()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function Ease(param1:Event) : *
      {
         var _loc2_:* = undefined;
         _loc2_ = 235.7;
         if(param1.target.y < _loc2_ - 100)
         {
            acc = -(param1.target.y - _loc2_) / 20;
         }
         else
         {
            acc = -(param1.target.y - _loc2_) / 10;
         }
         param1.target.y += v;
         v += acc;
         if(param1.target.y < _loc2_ - 100)
         {
            v *= 0.8;
         }
         else
         {
            v *= 0.6;
         }
         if(Math.abs(_loc2_ - param1.target.y) < 0.2 && Math.abs(v) < 0.2)
         {
            param1.target.y = _loc2_;
         }
         Tapper.alpha = Math.abs((param1.target.y + 164) / 390);
      }
      
      internal function frame1() : *
      {
         stop();
         GOboard.addEventListener(Event.ENTER_FRAME,Ease);
         v = 0;
         acc = 0;
         Tapper.alpha = 0;
      }
   }
}
