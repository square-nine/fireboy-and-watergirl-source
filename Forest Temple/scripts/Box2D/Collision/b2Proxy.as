package Box2D.Collision
{
   public class b2Proxy
   {
       
      
      public var overlapCount:uint;
      
      public var lowerBounds:Array;
      
      public var upperBounds:Array;
      
      public var userData:* = null;
      
      public var timeStamp:uint;
      
      public function b2Proxy()
      {
         lowerBounds = [uint(0),uint(0)];
         upperBounds = [uint(0),uint(0)];
         userData = null;
         super();
      }
      
      public function GetNext() : uint
      {
         return lowerBounds[0];
      }
      
      public function IsValid() : Boolean
      {
         return overlapCount != b2BroadPhase.b2_invalid;
      }
      
      public function SetNext(param1:uint) : void
      {
         lowerBounds[0] = param1 & 65535;
      }
   }
}
