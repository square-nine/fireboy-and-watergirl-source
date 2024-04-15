package Box2D.Collision.Shapes
{
   import Box2D.Common.Math.b2Vec2;
   
   public class b2CircleDef extends b2ShapeDef
   {
       
      
      public var localPosition:b2Vec2;
      
      public var radius:Number;
      
      public function b2CircleDef()
      {
         this.localPosition = new b2Vec2(0,0);
         super();
         type = b2Shape.e_circleShape;
         this.radius = 1;
      }
   }
}
