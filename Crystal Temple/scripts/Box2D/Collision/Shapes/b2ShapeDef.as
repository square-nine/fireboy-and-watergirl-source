package Box2D.Collision.Shapes
{
   public class b2ShapeDef
   {
       
      
      public var type:int;
      
      public var userData:* = null;
      
      public var friction:Number = 0.2;
      
      public var restitution:Number = 0;
      
      public var density:Number = 0;
      
      public var isSensor:Boolean = false;
      
      public var filter:b2FilterData;
      
      public function b2ShapeDef()
      {
         this.type = b2Shape.e_unknownShape;
         this.filter = new b2FilterData();
         super();
      }
   }
}
