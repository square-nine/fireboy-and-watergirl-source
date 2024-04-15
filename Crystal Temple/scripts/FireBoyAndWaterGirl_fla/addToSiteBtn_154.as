package FireBoyAndWaterGirl_fla
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="FireBoyAndWaterGirl_fla.addToSiteBtn_154")]
   public dynamic class addToSiteBtn_154 extends MovieClip
   {
       
      
      public var txt:TextField;
      
      public var txt2:TextField;
      
      public var originalFilters:*;
      
      public function addToSiteBtn_154()
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
         this.txt.text = "Add to your site";
         this.txt2.text = this.txt.text;
         this.txt2.visible = false;
         this.originalFilters = this.txt.filters;
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
         this.addEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
         this.addEventListener(MouseEvent.MOUSE_OVER,this.mouseOverHandler);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.mouseOutHandler);
      }
   }
}
