package
{
   import com.spilgames.bs.BrandingManager;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   [Embed(source="/_assets/assets.swf", symbol="TutLayer4")]
   public dynamic class TutLayer4 extends MovieClip
   {
       
      
      public var tut_4_1:TextField;
      
      public var tut_4_2:TextField;
      
      public var tut_4_3:TextField;
      
      public var tut_4_4:TextField;
      
      public var tut_4_5:TextField;
      
      public var bm:BrandingManager;
      
      public var tf:TextFormat;
      
      public var tfb:TextFormat;
      
      public var tfw:TextFormat;
      
      public var WHITE:*;
      
      public var BLACK:*;
      
      public var fst:Number;
      
      public function TutLayer4()
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
            TextField(this.tut_4_1).defaultTextFormat = this.tf;
         }
         this.tut_4_1.text = this.bm.getLocalizedString("tut_4_1");
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
            TextField(this.tut_4_2).defaultTextFormat = this.tf;
         }
         this.tut_4_2.text = this.bm.getLocalizedString("tut_4_2");
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
            TextField(this.tut_4_3).defaultTextFormat = this.tf;
         }
         this.tut_4_3.text = this.bm.getLocalizedString("tut_4_3");
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
            TextField(this.tut_4_4).defaultTextFormat = this.tf;
         }
         this.tut_4_4.text = this.bm.getLocalizedString("tut_4_4");
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
            TextField(this.tut_4_5).defaultTextFormat = this.tf;
         }
         this.tut_4_5.text = this.bm.getLocalizedString("tut_4_5").toLowerCase();
         this.tfb = new TextFormat(null,null,3355443);
         this.tfw = new TextFormat(null,null,16777215);
         this.WHITE = this.bm.getLocalizedString("word_4_5_1").toLowerCase();
         this.BLACK = this.bm.getLocalizedString("word_4_5_2").toLowerCase();
         trace("woooords: " + this.BLACK + " " + this.WHITE);
         this.fst = 0;
         this.fst = this.tut_4_5.text.indexOf(this.BLACK) + String(this.BLACK).length;
         this.tut_4_5.setTextFormat(this.tfb,this.tut_4_5.text.indexOf(this.BLACK),this.tut_4_5.text.indexOf(this.BLACK) + String(this.BLACK).length);
         this.tut_4_5.setTextFormat(this.tfb,this.tut_4_5.text.indexOf(this.BLACK,this.fst),this.tut_4_5.text.indexOf(this.BLACK,this.fst) + String(this.BLACK).length);
         this.fst = this.tut_4_5.text.indexOf(this.WHITE) + String(this.WHITE).length;
         this.tut_4_5.setTextFormat(this.tfw,this.tut_4_5.text.indexOf(this.WHITE),this.tut_4_5.text.indexOf(this.WHITE) + String(this.WHITE).length);
         this.tut_4_5.setTextFormat(this.tfw,this.tut_4_5.text.indexOf(this.WHITE,this.fst),this.tut_4_5.text.indexOf(this.WHITE,this.fst) + String(this.WHITE).length);
         stop();
      }
   }
}
