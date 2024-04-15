package Box2D.Collision
{
   import Box2D.Common.Math.b2Vec2;
   
   public class ClipVertex
   {
       
      
      public var v:b2Vec2;
      
      public var id:b2ContactID;
      
      public function ClipVertex()
      {
         this.v = new b2Vec2();
         this.id = new b2ContactID();
         super();
      }
   }
}
