package Box2D.Collision
{
   public class b2PairCallback
   {
       
      
      public function b2PairCallback()
      {
         super();
      }
      
      public function PairRemoved(param1:*, param2:*, param3:*) : void
      {
      }
      
      public function PairAdded(param1:*, param2:*) : *
      {
         return null;
      }
   }
}
