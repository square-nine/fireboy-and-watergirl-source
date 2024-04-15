package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="FireBoystairs")]
   public dynamic class FireBoystairs extends MovieClip
   {
       
      
      public var mc_1:MovieClip;
      
      public var mc_5:MovieClip;
      
      public function FireBoystairs()
      {
         super();
         addFrameScript(24,this.frame25);
      }
      
      internal function frame25() : *
      {
         stop();
      }
   }
}
