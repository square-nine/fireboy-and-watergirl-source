package
{
   import adobe.utils.*;
   import com.spilgames.bs.BrandingManager;
   import com.spilgames.bs.comps.Logo;
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
   
   [Embed(source="/_assets/assets.swf", symbol="SponsorLogoHolder")]
   public dynamic class SponsorLogoHolder extends MovieClip
   {
       
      
      public var embededLogo:MovieClip;
      
      public var marker:MovieClip;
      
      public var logoMC:*;
      
      public var brandingManager:BrandingManager;
      
      public function SponsorLogoHolder()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function waitForServices(param1:Event) : void
      {
         if(this.brandingManager.isReady())
         {
            this.removeEventListener(Event.ENTER_FRAME,this.waitForServices);
            this.logoMC = new Logo();
            this.addChild(this.logoMC);
            this.logoMC.filters = [new DropShadowFilter()];
            this.setUpLeft();
            trace("BRANDING IS HERE ALREADY");
            this.embededLogo.visible = false;
         }
         else
         {
            trace("NOT YET");
         }
      }
      
      public function setUpLeft() : void
      {
         if(this.logoMC)
         {
            trace("SETTING UPLEFT");
            this.logoMC.x = -this.logoMC.width / 2;
            this.logoMC.y = -this.logoMC.height / 2;
         }
      }
      
      public function setCenter() : void
      {
         if(this.logoMC)
         {
            trace("SETTING CENTER");
            this.logoMC.x = -this.logoMC.width / 2;
            this.logoMC.y = -this.logoMC.height / 2;
         }
      }
      
      internal function frame1() : *
      {
         this.marker.visible = false;
         trace("INIT LOGO HOLDER");
         this.brandingManager = BrandingManager.getInstance();
         this.addEventListener(Event.ENTER_FRAME,this.waitForServices);
      }
   }
}
