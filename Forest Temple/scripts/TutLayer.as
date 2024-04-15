package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="TutLayer")]
   public dynamic class TutLayer extends MovieClip
   {
       
      
      public function TutLayer()
      {
         super();
         addFrameScript(0,frame1,1,frame2,2,frame3,3,frame4,4,frame5,5,frame6,6,frame7);
      }
      
      internal function frame3() : *
      {
         stop();
      }
      
      internal function frame6() : *
      {
         stop();
      }
      
      internal function frame7() : *
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
      
      internal function frame5() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         stop();
      }
   }
}
