package
{
   import adobe.utils.*;
   import flash.accessibility.*;
   import flash.desktop.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.globalization.*;
   import flash.media.*;
   import flash.net.*;
   import flash.net.drm.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.sampler.*;
   import flash.sensors.*;
   import flash.system.*;
   import flash.text.*;
   import flash.text.engine.*;
   import flash.text.ime.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="GameOvero")]
   public dynamic class GameOvero extends MovieClip
   {
       
      
      public var GOboard:MovieClip;
      
      public var Tapper:MovieClip;
      
      public var v:*;
      
      public var acc:*;
      
      public function GameOvero()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function StartEase() : *
      {
         this.v = 0;
         this.acc = 0;
         this.GOboard.addEventListener(Event.ENTER_FRAME,this.Ease);
         this.Tapper.alpha = 0;
      }
      
      public function Ease(param1:Event) : *
      {
         trace("EVENTINT1 " + param1.target.y);
         var _loc2_:* = 235.7;
         if(param1.target.y < _loc2_ - 100)
         {
            this.acc = -(param1.target.y - _loc2_) / 20;
         }
         else
         {
            this.acc = -(param1.target.y - _loc2_) / 10;
         }
         param1.target.y += this.v;
         this.v += this.acc;
         if(param1.target.y < _loc2_ - 100)
         {
            this.v *= 0.8;
         }
         else
         {
            this.v *= 0.6;
         }
         if(Math.abs(_loc2_ - param1.target.y) < 0.2 && Math.abs(this.v) < 0.2)
         {
            param1.target.y = _loc2_;
            this.GOboard.removeEventListener(Event.ENTER_FRAME,this.Ease);
         }
         this.Tapper.alpha = Math.abs((param1.target.y + 164) / 390);
         trace("EVENTINT2 " + param1.target.y);
         trace("EVENTINT3 " + this.Tapper.alpha);
      }
      
      internal function frame1() : *
      {
         stop();
         this.v = 0;
         this.acc = 0;
      }
   }
}
