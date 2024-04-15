package
{
   import Box2D.*;
   import Box2D.Collision.*;
   import Box2D.Collision.Shapes.*;
   import Box2D.Common.Math.*;
   import Box2D.Dynamics.*;
   import flash.events.*;
   import flash.ui.*;
   
   public class ContactListener extends b2ContactListener
   {
       
      
      public var deadWater:Boolean = false;
      
      public var RedCount:Number;
      
      public var contactStack1:Array;
      
      public var GreenCount:Number;
      
      public var contactStack2:Array;
      
      public var BlueCount:Number;
      
      public var deadFire:Boolean = false;
      
      public var finish1:Number = 0;
      
      public var finish2:Number = 0;
      
      public function ContactListener()
      {
         finish1 = 0;
         finish2 = 0;
         contactStack1 = new Array();
         contactStack2 = new Array();
         deadFire = false;
         deadWater = false;
         super();
         BlueCount = 0;
         RedCount = 0;
         GreenCount = 0;
      }
      
      override public function Add(param1:b2ContactPoint) : void
      {
         if(param1.shape1.GetUserData() == "FinishGirl" && param1.shape2.GetUserData() == "waterlegs")
         {
            finish2 = 1;
         }
         if(param1.shape2.GetUserData() == "FinishGirl" && param1.shape1.GetUserData() == "waterlegs")
         {
            finish2 = 1;
         }
         if(param1.shape1.GetUserData() == "FinishBoy" && param1.shape2.GetUserData() == "firelegs")
         {
            finish1 = 1;
         }
         if(param1.shape2.GetUserData() == "FinishBoy" && param1.shape1.GetUserData() == "firelegs")
         {
            finish1 = 1;
         }
         if(param1.shape1.GetUserData() == "water" && param1.shape2.GetUserData() == "firelegs" && deadFire == false)
         {
            deadFire = true;
         }
         if(param1.shape2.GetUserData() == "water" && param1.shape1.GetUserData() == "firelegs" && deadFire == false)
         {
            deadFire = true;
         }
         if(param1.shape2.GetUserData() == "black" && param1.shape1.GetUserData() == "firelegs" && deadFire == false)
         {
            deadFire = true;
         }
         if(param1.shape1.GetUserData() == "black" && param1.shape2.GetUserData() == "firelegs" && deadFire == false)
         {
            deadFire = true;
         }
         if(param1.shape1.GetUserData() == "fire" && param1.shape2.GetUserData() == "waterlegs" && deadWater == false)
         {
            deadWater = true;
         }
         if(param1.shape2.GetUserData() == "fire" && param1.shape1.GetUserData() == "waterlegs" && deadWater == false)
         {
            deadWater = true;
         }
         if(param1.shape2.GetUserData() == "black" && param1.shape1.GetUserData() == "waterlegs" && deadWater == false)
         {
            deadWater = true;
         }
         if(param1.shape1.GetUserData() == "black" && param1.shape2.GetUserData() == "waterlegs" && deadWater == false)
         {
            deadWater = true;
         }
         if(param1.shape1.GetBody().GetUserData().name != "bd" && param1.shape1.GetBody().GetUserData().name != "rd" && param1.shape1.GetBody().GetUserData().name != "FUCK" && param1.shape2.GetBody().GetUserData().name != "bd" && param1.shape2.GetBody().GetUserData().name != "rd" && param1.shape2.GetBody().GetUserData().name != "FUCK")
         {
            if(param1.shape1.GetUserData() == "firelegs" || param1.shape2.GetUserData() == "firelegs")
            {
               contactStack1.push(param1.normal.Copy());
            }
            if(param1.shape1.GetUserData() == "waterlegs" || param1.shape2.GetUserData() == "waterlegs")
            {
               contactStack2.push(param1.normal.Copy());
            }
         }
         if(param1.shape1.GetBody().GetUserData().name == "bd" && param1.shape2.GetBody().GetUserData().name == "pers2")
         {
            param1.shape1.GetBody().GetUserData().parent.parent.DiamondSound.play();
            param1.shape1.GetBody().GetUserData().parent.removeChild(param1.shape1.GetBody().GetUserData());
            param1.shape1.GetBody().DestroyShape(param1.shape1);
            param1.shape1.GetBody().GetUserData().name = "FUCK";
            ++BlueCount;
            trace("BLUE DIAMONDO");
         }
         if(param1.shape2.GetBody().GetUserData().name == "bd" && param1.shape1.GetBody().GetUserData().name == "pers2")
         {
            param1.shape2.GetBody().GetUserData().parent.parent.DiamondSound.play();
            param1.shape2.GetBody().GetUserData().parent.removeChild(param1.shape2.GetBody().GetUserData());
            param1.shape2.GetBody().DestroyShape(param1.shape2);
            param1.shape2.GetBody().GetUserData().name = "FUCK";
            ++BlueCount;
            trace("BLUE DIAMONDO");
         }
         if(param1.shape1.GetBody().GetUserData().name == "rd" && param1.shape2.GetBody().GetUserData().name == "pers1")
         {
            param1.shape1.GetBody().GetUserData().parent.parent.DiamondSound.play();
            param1.shape1.GetBody().GetUserData().parent.removeChild(param1.shape1.GetBody().GetUserData());
            param1.shape1.GetBody().DestroyShape(param1.shape1);
            param1.shape1.GetBody().GetUserData().name = "FUCK";
            ++RedCount;
            trace("RED DIAMONDO");
         }
         if(param1.shape2.GetBody().GetUserData().name == "rd" && param1.shape1.GetBody().GetUserData().name == "pers1")
         {
            param1.shape2.GetBody().GetUserData().parent.parent.DiamondSound.play();
            param1.shape2.GetBody().GetUserData().parent.removeChild(param1.shape2.GetBody().GetUserData());
            param1.shape2.GetBody().DestroyShape(param1.shape2);
            param1.shape2.GetBody().GetUserData().name = "FUCK";
            ++RedCount;
            trace("RED DIAMONDO");
         }
         if(param1.shape2.GetBody().GetUserData().name == "gr" && (param1.shape1.GetBody().GetUserData().name == "pers1" || param1.shape1.GetBody().GetUserData().name == "pers2"))
         {
            param1.shape2.GetBody().GetUserData().parent.parent.DiamondSound.play();
            param1.shape2.GetBody().GetUserData().parent.removeChild(param1.shape2.GetBody().GetUserData());
            param1.shape2.GetBody().DestroyShape(param1.shape2);
            param1.shape2.GetBody().GetUserData().name = "FUCK";
            ++GreenCount;
            trace("SILVER DIAMONDO");
         }
         if(param1.shape1.GetBody().GetUserData().name == "gr" && (param1.shape2.GetBody().GetUserData().name == "pers1" || param1.shape2.GetBody().GetUserData().name == "pers2"))
         {
            param1.shape1.GetBody().GetUserData().parent.parent.DiamondSound.play();
            param1.shape1.GetBody().GetUserData().parent.removeChild(param1.shape1.GetBody().GetUserData());
            param1.shape1.GetBody().DestroyShape(param1.shape1);
            param1.shape1.GetBody().GetUserData().name = "FUCK";
            ++GreenCount;
            trace("SILVER DIAMONDO");
         }
      }
      
      override public function Remove(param1:b2ContactPoint) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(param1.shape1.GetUserData() == "FinishGirl" && param1.shape2.GetUserData() == "waterlegs")
         {
            finish2 = 0;
         }
         if(param1.shape2.GetUserData() == "FinishGirl" && param1.shape1.GetUserData() == "waterlegs")
         {
            finish2 = 0;
         }
         if(param1.shape1.GetUserData() == "FinishBoy" && param1.shape2.GetUserData() == "firelegs")
         {
            finish1 = 0;
         }
         if(param1.shape2.GetUserData() == "FinishBoy" && param1.shape1.GetUserData() == "firelegs")
         {
            finish1 = 0;
         }
         if(param1.shape1.GetUserData() == "firelegs" || param1.shape2.GetUserData() == "firelegs")
         {
            _loc2_ = 0;
            _loc3_ = 0;
            while(_loc3_ < contactStack1.length)
            {
               if(contactStack1[_loc3_].x == param1.normal.x && contactStack1[_loc3_].y == param1.normal.y)
               {
                  _loc2_ = _loc3_;
               }
               _loc3_++;
            }
            contactStack1.splice(_loc2_,1);
         }
         if(param1.shape1.GetUserData() == "waterlegs" || param1.shape2.GetUserData() == "waterlegs")
         {
            _loc2_ = 0;
            _loc3_ = 0;
            while(_loc3_ < contactStack2.length)
            {
               if(contactStack2[_loc3_].x == param1.normal.x && contactStack2[_loc3_].y == param1.normal.y)
               {
                  _loc2_ = _loc3_;
               }
               _loc3_++;
            }
            contactStack2.splice(_loc2_,1);
         }
      }
      
      override public function Persist(param1:b2ContactPoint) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(param1.shape1.GetBody().GetUserData().name != "bd" && param1.shape1.GetBody().GetUserData().name != "rd" && param1.shape1.GetBody().GetUserData().name != "FUCK" && param1.shape2.GetBody().GetUserData().name != "bd" && param1.shape2.GetBody().GetUserData().name != "rd" && param1.shape2.GetBody().GetUserData().name != "FUCK")
         {
            if(param1.shape1.GetUserData() == "firelegs" || param1.shape2.GetUserData() == "firelegs")
            {
               _loc2_ = 0;
               _loc3_ = 0;
               while(_loc3_ < contactStack1.length)
               {
                  if(contactStack1[_loc3_].x == param1.normal.x && contactStack1[_loc3_].y == param1.normal.y)
                  {
                     _loc2_ = _loc3_;
                  }
                  _loc3_++;
               }
               contactStack1[_loc2_] = param1.normal.Copy();
            }
            if(param1.shape1.GetUserData() == "waterlegs" || param1.shape2.GetUserData() == "waterlegs")
            {
               _loc2_ = 0;
               _loc3_ = 0;
               while(_loc3_ < contactStack2.length)
               {
                  if(contactStack2[_loc3_].x == param1.normal.x && contactStack2[_loc3_].y == param1.normal.y)
                  {
                     _loc2_ = _loc3_;
                  }
                  _loc3_++;
               }
               contactStack2[_loc2_] = param1.normal.Copy();
            }
         }
      }
   }
}
