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
       
      
      public var m_level:level;
      
      public function ContactListenerBullet()
      {
         super();
      }
      
      override public function Add(param1:b2ContactPoint) : void
      {
         if((param1.shape1.GetUserData() == "LightBall" || param1.shape2.GetUserData() == "LightBall") && (param1.shape1.GetUserData() == "TransportSensorLight" || param1.shape2.GetUserData() == "TransportSensorLight"))
         {
            if(param1.shape1.GetUserData() == "TransportSensorLight")
            {
               if(param1.shape1.GetBody().GetUserData().receivingObject != param1.shape2.GetBody().GetUserData())
               {
                  if(param1.shape1.GetBody().GetUserData().activeObject == null)
                  {
                     param1.shape1.GetBody().GetUserData().activeObject = param1.shape2.GetBody().GetUserData();
                     param1.shape1.GetBody().GetUserData().activeBody = param1.shape2.GetBody();
                     param1.shape1.GetBody().GetUserData().enterSpeed = param1.shape2.GetBody().GetLinearVelocity().Copy();
                     param1.shape1.GetBody().GetUserData().other.receivingObject = param1.shape2.GetBody().GetUserData();
                  }
               }
            }
            if(param1.shape2.GetUserData() == "TransportSensorLight")
            {
               if(param1.shape2.GetBody().GetUserData().receivingObject != param1.shape1.GetBody().GetUserData())
               {
                  if(param1.shape2.GetBody().GetUserData().activeObject == null)
                  {
                     param1.shape2.GetBody().GetUserData().activeObject = param1.shape1.GetBody().GetUserData();
                     param1.shape2.GetBody().GetUserData().activeBody = param1.shape1.GetBody();
                     param1.shape2.GetBody().GetUserData().enterSpeed = param1.shape1.GetBody().GetLinearVelocity().Copy();
                     param1.shape2.GetBody().GetUserData().other.receivingObject = param1.shape1.GetBody().GetUserData();
                  }
               }
            }
         }
         if(param1.shape1.GetBody().GetUserData().name == "Portal")
         {
            if(param1.shape1.GetUserData() == "MaskSensorR")
            {
               param1.shape1.GetBody().GetUserData().maskedLightR = true;
            }
            else if(param1.shape1.GetUserData() == "MaskSensorL")
            {
               param1.shape1.GetBody().GetUserData().maskedLightL = true;
            }
         }
         if(param1.shape2.GetBody().GetUserData().name == "Portal")
         {
            if(param1.shape2.GetUserData() == "MaskSensorR")
            {
               param1.shape2.GetBody().GetUserData().maskedLightR = true;
            }
            else if(param1.shape2.GetUserData() == "MaskSensorL")
            {
               param1.shape2.GetBody().GetUserData().maskedLightL = true;
            }
         }
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
            trace("FREESING");
            if(param1.shape1.GetBody().GetUserData() is Bullet)
            {
               trace("color " + param1.shape1.GetBody().GetUserData().color);
               if(param1.shape1.GetBody().GetUserData().color == 5)
               {
                  trace("FREEZE");
                  param1.shape2.GetBody().GetUserData().freeze = true;
                  if(param1.shape2.GetBody().GetUserData().melt == false)
                  {
                     param1.shape2.GetBody().GetUserData().contactPoint = param1.position;
                  }
               }
               if(param1.shape1.GetBody().GetUserData().color == 4)
               {
                  trace("MELT");
                  param1.shape2.GetBody().GetUserData().melt = true;
                  param1.shape2.GetBody().GetUserData().contactPoint = param1.position;
               }
            }
            else if(param1.shape2.GetBody().GetUserData() is Bullet)
            {
               trace("color " + param1.shape2.GetBody().GetUserData().color);
               if(param1.shape2.GetBody().GetUserData().color == 5)
               {
                  trace("FREEZE");
                  param1.shape1.GetBody().GetUserData().freeze = true;
                  if(param1.shape1.GetBody().GetUserData().melt == false)
                  {
                     param1.shape1.GetBody().GetUserData().contactPoint = param1.position;
                  }
               }
               if(param1.shape2.GetBody().GetUserData().color == 4)
               {
                  trace("MELT");
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
         if(param1.shape1.GetBody().GetUserData().name == "Portal" || param1.shape2.GetBody().GetUserData().name == "Portal")
         {
            if(param1.shape1.GetBody().GetUserData().name == "Portal" && param1.shape1.GetBody().GetUserData().activeObject == param1.shape2.GetBody().GetUserData())
            {
               param1.shape1.GetBody().GetUserData().activeObject = null;
               param1.shape1.GetBody().GetUserData().activeBody = null;
               param1.shape1.GetBody().GetUserData().enterSpeed = null;
            }
            if(param1.shape2.GetBody().GetUserData().name == "Portal" && param1.shape2.GetBody().GetUserData().activeObject == param1.shape1.GetBody().GetUserData())
            {
               param1.shape2.GetBody().GetUserData().activeObject = null;
               param1.shape2.GetBody().GetUserData().activeBody = null;
               param1.shape2.GetBody().GetUserData().enterSpeed = null;
            }
            if(param1.shape1.GetBody().GetUserData().name == "Portal" && param1.shape1.GetBody().GetUserData().receivingObject == param1.shape2.GetBody().GetUserData())
            {
               param1.shape1.GetBody().GetUserData().receivingObject = null;
            }
            if(param1.shape2.GetBody().GetUserData().name == "Portal" && param1.shape2.GetBody().GetUserData().receivingObject == param1.shape1.GetBody().GetUserData())
            {
               param1.shape2.GetBody().GetUserData().receivingObject = null;
            }
         }
      }
   }
}
