package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="MeltSmoke")]
   public dynamic class MeltSmoke extends MovieClip
   {
       
      
      public var meltsmoke:MovieClip;
      
      public function MeltSmoke()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}
