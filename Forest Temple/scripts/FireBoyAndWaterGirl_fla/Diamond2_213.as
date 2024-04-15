package FireBoyAndWaterGirl_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="FireBoyAndWaterGirl_fla.Diamond2_213")]
   public dynamic class Diamond2_213 extends MovieClip
   {
       
      
      public var Glower:MovieClip;
      
      public var Now:MovieClip;
      
      public var Time:TextField;
      
      public function Diamond2_213()
      {
         super();
         addFrameScript(0,frame1,1,frame2,2,frame3,3,frame4);
      }
      
      internal function frame3() : *
      {
         stop();
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame4() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         stop();
      }
   }
}
