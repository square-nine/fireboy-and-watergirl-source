package FireBoyAndWaterGirl_fla
{
   import com.spilgames.bs.BrandingManager;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   [Embed(source="/_assets/assets.swf", symbol="FireBoyAndWaterGirl_fla.Result_239")]
   public dynamic class Result_239 extends MovieClip
   {
       
      
      public var F:MovieClip;
      
      public var txt:TextField;
      
      public var A:MovieClip;
      
      public var B:MovieClip;
      
      public var C:MovieClip;
      
      public var bm:BrandingManager;
      
      public var tf:TextFormat;
      
      public function Result_239()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         this.bm = BrandingManager.getInstance();
         if(this.bm.getCurrentLanguage().indexOf("ru-") >= 0)
         {
            this.tf = TextField(this.txt).getTextFormat();
            this.tf.font = "Cambria";
            this.tf.bold = false;
            TextField(this.txt).defaultTextFormat = this.tf;
         }
         this.txt.text = this.bm.getLocalizedString("score_rank") + ":";
      }
   }
}
