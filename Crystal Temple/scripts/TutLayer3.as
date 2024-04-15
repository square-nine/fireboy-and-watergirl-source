package
{
   import com.spilgames.bs.BrandingManager;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   [Embed(source="/_assets/assets.swf", symbol="TutLayer3")]
   public dynamic class TutLayer3 extends MovieClip
   {
       
      
      public var tut_3_6:TextField;
      
      public var tut_3_1:TextField;
      
      public var tut_3_2:TextField;
      
      public var tut_3_3:TextField;
      
      public var tut_3_4:TextField;
      
      public var tut_3_5:TextField;
      
      public var bm:BrandingManager;
      
      public var tf:TextFormat;
      
      public function TutLayer3()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,2,this.frame3,3,this.frame4,4,this.frame5,5,this.frame6,6,this.frame7);
      }
      
      internal function frame1() : *
      {
         this.bm = BrandingManager.getInstance();
         if(this.bm.getCurrentLanguage().indexOf("ru-") >= 0)
         {
            this.tf = new TextFormat();
            this.tf.font = "Cambria";
            this.tf.bold = true;
            TextField(this.tut_3_1).defaultTextFormat = this.tf;
         }
         this.tut_3_1.text = this.bm.getLocalizedString("tut_3_1");
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
            TextField(this.tut_3_2).defaultTextFormat = this.tf;
         }
         this.tut_3_2.text = this.bm.getLocalizedString("tut_3_2");
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
            TextField(this.tut_3_3).defaultTextFormat = this.tf;
         }
         this.tut_3_3.text = this.bm.getLocalizedString("tut_3_3");
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
            TextField(this.tut_3_4).defaultTextFormat = this.tf;
         }
         this.tut_3_4.text = this.bm.getLocalizedString("tut_3_4");
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
            TextField(this.tut_3_5).defaultTextFormat = this.tf;
         }
         this.tut_3_5.text = this.bm.getLocalizedString("tut_3_5");
         stop();
      }
      
      internal function frame6() : *
      {
         this.bm = BrandingManager.getInstance();
         if(this.bm.getCurrentLanguage().indexOf("ru-") >= 0)
         {
            this.tf = new TextFormat();
            this.tf.font = "Cambria";
            this.tf.bold = true;
            TextField(this.tut_3_6).defaultTextFormat = this.tf;
         }
         this.tut_3_6.text = this.bm.getLocalizedString("tut_3_6");
         stop();
      }
      
      internal function frame7() : *
      {
         stop();
      }
   }
}
