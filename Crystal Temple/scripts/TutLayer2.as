package
{
   import com.spilgames.bs.BrandingManager;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   [Embed(source="/_assets/assets.swf", symbol="TutLayer2")]
   public dynamic class TutLayer2 extends MovieClip
   {
       
      
      public var tut_2_5:TextField;
      
      public var tut_2_1:TextField;
      
      public var tut_2_2:TextField;
      
      public var tut_2_3:TextField;
      
      public var tut_2_4:TextField;
      
      public var bm:BrandingManager;
      
      public var tf:TextFormat;
      
      public function TutLayer2()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,2,this.frame3,3,this.frame4,4,this.frame5);
      }
      
      internal function frame1() : *
      {
         this.bm = BrandingManager.getInstance();
         if(this.bm.getCurrentLanguage().indexOf("ru-") >= 0)
         {
            this.tf = new TextFormat();
            this.tf.font = "Cambria";
            this.tf.bold = true;
            TextField(this.tut_2_1).defaultTextFormat = this.tf;
         }
         this.tut_2_1.text = this.bm.getLocalizedString("tut_2_1");
         stop();
      }
      
      internal function frame2() : *
      {
         this.bm = BrandingManager.getInstance();
         if(this.bm.getCurrentLanguage().indexOf("ru-") >= 0)
         {
            this.tf = new TextFormat();
            this.tf.font = "Cambria";
            this.tf.bold = true;
            TextField(this.tut_2_2).defaultTextFormat = this.tf;
         }
         this.tut_2_2.text = this.bm.getLocalizedString("tut_2_2");
         stop();
      }
      
      internal function frame3() : *
      {
         this.bm = BrandingManager.getInstance();
         if(this.bm.getCurrentLanguage().indexOf("ru-") >= 0)
         {
            this.tf = new TextFormat();
            this.tf.font = "Cambria";
            this.tf.bold = true;
            TextField(this.tut_2_3).defaultTextFormat = this.tf;
         }
         this.tut_2_3.text = this.bm.getLocalizedString("tut_2_3");
         stop();
      }
      
      internal function frame4() : *
      {
         this.bm = BrandingManager.getInstance();
         if(this.bm.getCurrentLanguage().indexOf("ru-") >= 0)
         {
            this.tf = new TextFormat();
            this.tf.font = "Cambria";
            this.tf.bold = true;
            TextField(this.tut_2_4).defaultTextFormat = this.tf;
         }
         this.tut_2_4.text = this.bm.getLocalizedString("tut_2_4");
         stop();
      }
      
      internal function frame5() : *
      {
         this.bm = BrandingManager.getInstance();
         if(this.bm.getCurrentLanguage().indexOf("ru-") >= 0)
         {
            this.tf = new TextFormat();
            this.tf.font = "Cambria";
            this.tf.bold = true;
            TextField(this.tut_2_5).defaultTextFormat = this.tf;
         }
         this.tut_2_5.text = this.bm.getLocalizedString("tut_2_5");
         stop();
      }
   }
}
