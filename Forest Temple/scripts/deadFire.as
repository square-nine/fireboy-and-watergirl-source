package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="deadFire")]
   public dynamic class deadFire extends MovieClip
   {
       
      
      public function deadFire()
      {
         super();
         addFrameScript(31,frame32);
      }
      
      internal function frame32() : *
      {
         stop();
         (this.parent.parent as Game).GameOver();
      }
   }
}
