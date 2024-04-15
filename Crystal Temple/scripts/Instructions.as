package
{
   import com.spilgames.bs.BrandingManager;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   [Embed(source="/_assets/assets.swf", symbol="Instructions")]
   public dynamic class Instructions extends MovieClip
   {
       
      
      public var OKO:SimpleButton;
      
      public var txt1:TextField;
      
      public var txt2:TextField;
      
      public var txt3:TextField;
      
      public var txt4:TextField;
      
      public var bm:BrandingManager;
      
      public var tf:TextFormat;
      
      public function Instructions()
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
            TextField(this.txt1).defaultTextFormat = this.tf;
            TextField(this.txt2).defaultTextFormat = this.tf;
            TextField(this.txt3).defaultTextFormat = this.tf;
            TextField(this.txt4).defaultTextFormat = this.tf;
         }
         this.txt1.text = this.bm.getLocalizedString("instr_1") + " " + this.bm.getLocalizedString("instr_2");
         this.txt2.text = this.bm.getLocalizedString("instr_3");
         this.txt3.text = this.bm.getLocalizedString("instr_4");
         this.txt4.text = this.bm.getLocalizedString("instr_5");
      }
   }
}
