package
{
   import com.spilgames.bs.BrandingManager;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   [Embed(source="/_assets/assets.swf", symbol="TutLayer")]
   public dynamic class TutLayer extends MovieClip
   {
       
      
      public var tut_1_8:TextField;
      
      public var tut_1_9:TextField;
      
      public var tut_1_13:TextField;
      
      public var tut_1_12:TextField;
      
      public var tut_1_11:TextField;
      
      public var tut_1_10:TextField;
      
      public var tut_1_1:TextField;
      
      public var tut_1_2:TextField;
      
      public var tut_1_3:TextField;
      
      public var tut_1_4:TextField;
      
      public var tut_1_5:TextField;
      
      public var tut_1_6:TextField;
      
      public var tut_1_7:TextField;
      
      public var bm:BrandingManager;
      
      public var tf:TextFormat;
      
      public var tfw:TextFormat;
      
      public var tff:TextFormat;
      
      public var AWD:*;
      
      public var ARROW:*;
      
      public var WATER:*;
      
      public var FIRE:*;
      
      public function TutLayer()
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
            TextField(this.tut_1_1).defaultTextFormat = this.tf;
            TextField(this.tut_1_2).defaultTextFormat = this.tf;
            TextField(this.tut_1_3).defaultTextFormat = this.tf;
         }
         this.tfw = this.tut_1_1.getTextFormat();
         this.tfw.color = 6740479;
         this.tff = this.tut_1_1.getTextFormat();
         this.tff.color = 16711680;
         this.AWD = this.bm.getLocalizedString("word_1_1").toLowerCase();
         this.ARROW = this.bm.getLocalizedString("word_1_2").toLowerCase();
         this.WATER = this.bm.getLocalizedString("word_1_3").toLowerCase();
         this.FIRE = this.bm.getLocalizedString("word_1_4").toLowerCase();
         trace("wOOOOOOrds: " + this.AWD + " " + this.ARROW + " " + this.WATER + " " + this.FIRE);
         this.tut_1_1.text = this.bm.getLocalizedString("tut_1_1").toLowerCase();
         this.tut_1_2.text = this.bm.getLocalizedString("tut_1_2").toLowerCase();
         this.tut_1_3.text = this.bm.getLocalizedString("tut_1_3").toLowerCase();
         this.tut_1_1.setTextFormat(this.tfw,this.tut_1_1.text.indexOf(this.AWD),this.tut_1_1.text.indexOf(this.AWD) + String(this.AWD).length);
         this.tut_1_2.setTextFormat(this.tff,this.tut_1_2.text.indexOf(this.ARROW),this.tut_1_2.text.indexOf(this.ARROW) + String(this.ARROW).length);
         this.tut_1_3.setTextFormat(this.tfw,this.tut_1_3.text.indexOf(this.WATER),this.tut_1_3.text.indexOf(this.WATER) + String(this.WATER).length);
         this.tut_1_3.setTextFormat(this.tff,this.tut_1_3.text.indexOf(this.FIRE),this.tut_1_3.text.indexOf(this.FIRE) + String(this.FIRE).length);
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
            TextField(this.tut_1_4).defaultTextFormat = this.tf;
         }
         this.tut_1_4.text = this.bm.getLocalizedString("tut_1_4");
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
            TextField(this.tut_1_5).defaultTextFormat = this.tf;
            TextField(this.tut_1_6).defaultTextFormat = this.tf;
         }
         this.tut_1_5.text = this.bm.getLocalizedString("tut_1_5");
         this.tut_1_6.text = this.bm.getLocalizedString("tut_1_6");
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
            TextField(this.tut_1_7).defaultTextFormat = this.tf;
            TextField(this.tut_1_8).defaultTextFormat = this.tf;
         }
         this.tut_1_7.text = this.bm.getLocalizedString("tut_1_7");
         this.tut_1_8.text = this.bm.getLocalizedString("tut_1_8");
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
            TextField(this.tut_1_9).defaultTextFormat = this.tf;
            TextField(this.tut_1_10).defaultTextFormat = this.tf;
            TextField(this.tut_1_11).defaultTextFormat = this.tf;
         }
         this.tut_1_9.text = this.bm.getLocalizedString("tut_1_9");
         this.tut_1_10.text = this.bm.getLocalizedString("tut_1_10");
         this.tut_1_11.text = this.bm.getLocalizedString("tut_1_11");
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
            TextField(this.tut_1_12).defaultTextFormat = this.tf;
         }
         this.tut_1_12.text = this.bm.getLocalizedString("tut_1_12");
         stop();
      }
      
      internal function frame7() : *
      {
         this.bm = BrandingManager.getInstance();
         if(this.bm.getCurrentLanguage().indexOf("ru-") >= 0)
         {
            this.tf = new TextFormat();
            this.tf.font = "Cambria";
            this.tf.bold = true;
            TextField(this.tut_1_13).defaultTextFormat = this.tf;
         }
         this.tut_1_13.text = this.bm.getLocalizedString("tut_1_13");
         stop();
      }
   }
}
