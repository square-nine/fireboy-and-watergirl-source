package Box2D.Collision
{
   public class b2Proxy
   {
       
      
      public var lowerBounds:Array;
      
      public var upperBounds:Array;
      
      public var overlapCount:uint;
      
      public var timeStamp:uint;
      
      public var userData:* = null;
      
      public function b2Proxy()
      {
         this.lowerBounds = [uint(0),uint(0)];
         this.upperBounds = [uint(0),uint(0)];
         super();
      }
      
      public function GetNext() : uint
      {
         return this.lowerBounds[0];
      }
      
      public function SetNext(param1:uint) : void
      {
         this.lowerBounds[0] = param1 & 65535;
      }
      
      public function IsValid() : Boolean
      {
         return this.overlapCount != b2BroadPhase.b2_invalid;
      }
   }
}
