package
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="A10Teaser")]
   public dynamic class A10Teaser extends MovieClip
   {
       
      
      public function A10Teaser()
      {
         super();
         addFrameScript(0,this.frame1,149,this.frame150);
      }
      
      internal function frame1() : *
      {
         trace("INSIDE TEASER");
         stop();
      }
      
      internal function frame150() : *
      {
         dispatchEvent(new Event("teaserOut"));
      }
   }
}
