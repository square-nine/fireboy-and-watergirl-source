package FireBoyAndWaterGirl_fla
{
   import com.spilgames.bs.BrandingManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   [Embed(source="/_assets/assets.swf", symbol="FireBoyAndWaterGirl_fla.ShowNumsBtn_192")]
   public dynamic class ShowNumsBtn_192 extends MovieClip
   {
       
      
      public var txt:TextField;
      
      public var txt2:TextField;
      
      public var bm:BrandingManager;
      
      public var tf:TextFormat;
      
      public var originalFilters:*;
      
      public function ShowNumsBtn_192()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function mouseDownHandler(param1:MouseEvent) : void
      {
         this.scaleX = 0.95;
         this.scaleY = 0.95;
      }
      
      public function mouseUpHandler(param1:MouseEvent) : void
      {
         this.scaleX = 1;
         this.scaleY = 1;
      }
      
      public function mouseOverHandler(param1:MouseEvent) : void
      {
         this.txt2.visible = true;
      }
      
      public function mouseOutHandler(param1:MouseEvent) : void
      {
         this.txt2.visible = false;
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
            TextField(this.txt2).defaultTextFormat = this.tf;
         }
         this.txt.text = this.bm.getLocalizedString("levelselect_showNumbers");
         this.txt2.text = this.txt.text;
         this.txt2.visible = false;
         this.originalFilters = this.txt.filters;
         this.addEventListener(MouseEvent.MOUSE_OVER,this.mouseOverHandler);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.mouseOutHandler);
      }
   }
}
