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
   
   [Embed(source="/_assets/assets.swf", symbol="Recuento")]
   public dynamic class Recuento extends MovieClip
   {
       
      
      public var Rboard:MovieClip;
      
      public var Tapper:MovieClip;
      
      public var v:*;
      
      public var acc:*;
      
      public function Recuento()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function StartEase() : *
      {
         this.v = 0;
         this.acc = 0;
         this.Tapper.alpha = 0;
         this.Rboard.addEventListener(Event.ENTER_FRAME,this.Ease);
      }
      
      public function Ease(param1:Event) : *
      {
         if(param1.target.y < 235.7 - 100)
         {
            this.acc = -(param1.target.y - 235.7) / 20;
         }
         else
         {
            this.acc = -(param1.target.y - 235.7) / 10;
         }
         param1.target.y += this.v;
         this.v += this.acc;
         if(param1.target.y < 235.7 - 100)
         {
            this.v *= 0.8;
         }
         else
         {
            this.v *= 0.6;
         }
         if(Math.abs(235.7 - param1.target.y) < 0.2 && Math.abs(this.v) < 0.2)
         {
            param1.target.y = 235.7;
            this.Rboard.removeEventListener(Event.ENTER_FRAME,this.Ease);
         }
         this.Tapper.alpha = Math.abs((param1.target.y + 164) / 390);
      }
      
      internal function frame1() : *
      {
         stop();
         this.Rboard.addEventListener(Event.ENTER_FRAME,this.Ease);
         this.v = 0;
         this.acc = 0;
         this.Tapper.alpha = 0;
      }
   }
}
