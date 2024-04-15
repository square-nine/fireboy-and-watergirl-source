package FireBoyAndWaterGirl_fla
{
   import com.spilgames.bs.BrandingManager;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   [Embed(source="/_assets/assets.swf", symbol="FireBoyAndWaterGirl_fla.RBoard_237")]
   public dynamic class RBoard_237 extends MovieClip
   {
       
      
      public var sponsorLogoHolder:SponsorLogoHolder;
      
      public var TimeTxt:TextField;
      
      public var GDcounter:MovieClip;
      
      public var RDcounter:MovieClip;
      
      public var BDcounter:MovieClip;
      
      public var Result:MovieClip;
      
      public var time:TextField;
      
      public var ToMenuBtn:MovieClip;
      
      public var bm:BrandingManager;
      
      public var tf:TextFormat;
      
      public function RBoard_237()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         this.bm = BrandingManager.getInstance();
         if(this.bm.getCurrentLanguage().indexOf("ru-") >= 0)
         {
            this.tf = new TextFormat();
            this.tf.font = "Cambria";
            this.tf.bold = false;
            TextField(this.TimeTxt).defaultTextFormat = this.tf;
         }
         this.TimeTxt.text = this.bm.getLocalizedString("score_time") + ":";
      }
   }
}
