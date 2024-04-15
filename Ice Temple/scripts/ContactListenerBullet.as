package
{
   import Box2D.*;
   import Box2D.Collision.*;
   import Box2D.Collision.Shapes.*;
   import Box2D.Common.Math.*;
   import Box2D.Dynamics.*;
   import flash.events.*;
   import flash.ui.*;
   
   public class ContactListenerBullet extends b2ContactListener
   {
       
      
      internal var freezeColor:* = 11596281;
      
      internal var meltColor:* = 16677980;
      
      public function ContactListenerBullet()
      {
         super();
      }
      
      override public function Add(param1:b2ContactPoint) : void
      {
         if((param1.shape1.GetUserData() == "LightBall" || param1.shape2.GetUserData() == "LightBall") && (param1.shape1.GetBody().GetUserData().name == "LightPusher" || param1.shape2.GetBody().GetUserData().name == "LightPusher"))
         {
            if(param1.shape1.GetBody().GetUserData().color == param1.shape2.GetBody().GetUserData().color)
            {
               if(param1.shape1.GetBody().GetUserData().name == "LightPusher")
               {
                  param1.shape1.GetBody().GetUserData().activated = true;
               }
               if(param1.shape2.GetBody().GetUserData().name == "LightPusher")
               {
                  param1.shape2.GetBody().GetUserData().activated = true;
               }
            }
         }
         if((param1.shape1.GetBody().GetUserData() is Bullet || param1.shape2.GetBody().GetUserData() is Bullet) && (param1.shape1.GetBody().GetUserData().mirror == true || param1.shape2.GetBody().GetUserData().mirror == true))
         {
            if(param1.shape1.GetBody().GetUserData() is Bullet)
            {
               param1.shape1.GetBody().GetUserData().Path.push(new b2Vec2(param1.position.x,param1.position.y));
            }
            else if(param1.shape2.GetBody().GetUserData() is Bullet)
            {
               param1.shape2.GetBody().GetUserData().Path.push(new b2Vec2(param1.position.x,param1.position.y));
            }
         }
         if((param1.shape1.GetBody().GetUserData() is Bullet || param1.shape2.GetBody().GetUserData() is Bullet) && (param1.shape1.GetUserData() == "iceSensor" || param1.shape2.GetUserData() == "iceSensor"))
         {
            if(param1.shape1.GetBody().GetUserData() is Bullet)
            {
               if(param1.shape1.GetBody().GetUserData().color == this.freezeColor)
               {
                  param1.shape2.GetBody().GetUserData().freeze = true;
                  if(param1.shape2.GetBody().GetUserData().melt == false)
                  {
                     param1.shape2.GetBody().GetUserData().contactPoint = param1.position;
                  }
               }
               if(param1.shape1.GetBody().GetUserData().color == this.meltColor)
               {
                  param1.shape2.GetBody().GetUserData().melt = true;
                  param1.shape2.GetBody().GetUserData().contactPoint = param1.position;
               }
            }
            else if(param1.shape2.GetBody().GetUserData() is Bullet)
            {
               if(param1.shape2.GetBody().GetUserData().color == this.freezeColor)
               {
                  param1.shape1.GetBody().GetUserData().freeze = true;
                  if(param1.shape1.GetBody().GetUserData().melt == false)
                  {
                     param1.shape1.GetBody().GetUserData().contactPoint = param1.position;
                  }
               }
               if(param1.shape2.GetBody().GetUserData().color == this.meltColor)
               {
                  param1.shape1.GetBody().GetUserData().melt = true;
                  param1.shape1.GetBody().GetUserData().contactPoint = param1.position;
               }
            }
         }
      }
      
      override public function Persist(param1:b2ContactPoint) : void
      {
      }
      
      override public function Remove(param1:b2ContactPoint) : void
      {
      }
   }
}
