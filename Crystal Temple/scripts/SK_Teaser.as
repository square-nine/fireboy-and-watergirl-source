package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="SK_Teaser")]
   public dynamic class SK_Teaser extends MovieClip
   {
       
      
      public function SK_Teaser()
      {
         super();
         addFrameScript(149,this.frame150);
      }
      
      internal function frame150() : *
      {
         stop();
      }
   }
}
