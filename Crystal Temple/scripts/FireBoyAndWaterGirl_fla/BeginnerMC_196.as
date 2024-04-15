package FireBoyAndWaterGirl_fla
{
   import com.spilgames.bs.BrandingManager;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   [Embed(source="/_assets/assets.swf", symbol="FireBoyAndWaterGirl_fla.BeginnerMC_196")]
   public dynamic class BeginnerMC_196 extends MovieClip
   {
       
      
      public var txt:TextField;
      
      public var bm:BrandingManager;
      
      public var tf:TextFormat;
      
      public function BeginnerMC_196()
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
            this.tf.bold = true;
            TextField(this.txt).defaultTextFormat = this.tf;
         }
         this.txt.text = this.bm.getLocalizedString("levelselect_beginners");
      }
   }
}
