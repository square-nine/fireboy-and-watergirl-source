package
{
   import adobe.utils.*;
   import fl.transitions.Tween;
   import fl.transitions.TweenEvent;
   import fl.transitions.easing.Bounce;
   import fl.transitions.easing.Strong;
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
   
   [Embed(source="/_assets/assets.swf", symbol="AG_Teaser")]
   public dynamic class AG_Teaser extends MovieClip
   {
       
      
      public var smash:Smash;
      
      public var timer:Timer;
      
      public var p_in:*;
      
      public var AGpresented_mc:MovieClip;
      
      public var AGskip_btn:SimpleButton;
      
      public var AGclick_btn:SimpleButton;
      
      public var AGlogo_mc:MovieClip;
      
      public function AG_Teaser()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         stop();
         smash = new Smash();
         AGpresented_mc.alpha = 0;
         AGclick_btn.visible = false;
         AGlogo_mc.y = -70;
         timer = new Timer(4000);
         timer.addEventListener(TimerEvent.TIMER,done);
         timer.start();
         p_in = new Tween(AGpresented_mc,"alpha",Strong.easeIn,0,100,12,false);
         p_in.addEventListener(TweenEvent.MOTION_FINISH,logo);
         AGskip_btn.addEventListener(MouseEvent.CLICK,done);
         AGclick_btn.addEventListener(MouseEvent.CLICK,loadAG);
      }
      
      public function done(param1:Event) : *
      {
         timer.stop();
         (this.parent as Game).TeaserOut();
         this.parent.removeChild(this);
      }
      
      public function loadAG(param1:MouseEvent) : void
      {
         var _loc2_:URLRequest = null;
         _loc2_ = new URLRequest("http://www.addictinggames.com");
         navigateToURL(_loc2_,"_blank");
      }
      
      public function logo(param1:TweenEvent) : *
      {
         var logo_in:* = undefined;
         var crunch:Function = null;
         var event:TweenEvent = param1;
         crunch = function(param1:TweenEvent):*
         {
            smash.play();
            AGclick_btn.visible = true;
            new Tween(AGlogo_mc,"y",Bounce.easeOut,60,85,6,false);
            new Tween(AGlogo_mc,"x",Bounce.easeOut,30,50,6,false);
            new Tween(AGpresented_mc,"y",Bounce.easeOut,15,25,6,false);
            new Tween(AGpresented_mc,"x",Bounce.easeOut,110,100,6,false);
         };
         logo_in = new Tween(AGlogo_mc,"y",Strong.easeIn,-75,85,12,false);
         logo_in.addEventListener(TweenEvent.MOTION_FINISH,crunch);
      }
   }
}
