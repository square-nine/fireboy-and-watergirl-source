package FireBoyAndWaterGirl_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="FireBoyAndWaterGirl_fla.Diamond4_190")]
   public dynamic class Diamond4_190 extends MovieClip
   {
       
      
      public var Now:MovieClip;
      
      public var Glower:MovieClip;
      
      public var Time:TextField;
      
      public function Diamond4_190()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,2,this.frame3,3,this.frame4);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         stop();
      }
      
      internal function frame3() : *
      {
         stop();
      }
      
      internal function frame4() : *
      {
         stop();
      }
   }
}
