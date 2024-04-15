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
       
      
      public var BlueCount:Number;
      
      public var RedCount:Number;
      
      public var GreenCount:Number;
      
      public var finish1:Number = 0;
      
      public var finish2:Number = 0;
      
      public var contactStack1:Array;
      
      public var contactStack2:Array;
      
      public var deadFire:Boolean = false;
      
      public var deadWater:Boolean = false;
      
      public function ContactListener()
      {
         this.contactStack1 = new Array();
         this.contactStack2 = new Array();
         super();
         this.BlueCount = 0;
         this.RedCount = 0;
         this.GreenCount = 0;
      }
      
      override public function Add(param1:b2ContactPoint) : void
      {
         if(param1.shape1.GetUserData() == "FinishGirl" && param1.shape2.GetUserData() == "waterlegs")
         {
            this.finish2 = 1;
         }
         if(param1.shape2.GetUserData() == "FinishGirl" && param1.shape1.GetUserData() == "waterlegs")
         {
            this.finish2 = 1;
         }
         if(param1.shape1.GetUserData() == "FinishBoy" && param1.shape2.GetUserData() == "firelegs")
         {
            this.finish1 = 1;
         }
         if(param1.shape2.GetUserData() == "FinishBoy" && param1.shape1.GetUserData() == "firelegs")
         {
            this.finish1 = 1;
         }
         if(param1.shape1.GetUserData() == "water" && param1.shape2.GetUserData() == "box")
         {
            param1.shape2.GetBody().GetUserData().waterCC = param1.shape1.GetBody().GetUserData().pnt;
         }
         if(param1.shape2.GetUserData() == "water" && param1.shape1.GetUserData() == "box")
         {
            param1.shape1.GetBody().GetUserData().waterCC = param1.shape2.GetBody().GetUserData().pnt;
         }
         if(param1.shape1.GetUserData() == "water" && param1.shape2.GetUserData() == "firelegs" && this.deadFire == false)
         {
            this.deadFire = true;
         }
         if(param1.shape2.GetUserData() == "water" && param1.shape1.GetUserData() == "firelegs" && this.deadFire == false)
         {
            this.deadFire = true;
         }
         if(param1.shape2.GetUserData() == "black" && param1.shape1.GetUserData() == "firelegs" && this.deadFire == false)
         {
            this.deadFire = true;
         }
         if(param1.shape1.GetUserData() == "black" && param1.shape2.GetUserData() == "firelegs" && this.deadFire == false)
         {
            this.deadFire = true;
         }
         if(param1.shape1.GetUserData() == "fire" && param1.shape2.GetUserData() == "waterlegs" && this.deadWater == false)
         {
            this.deadWater = true;
         }
         if(param1.shape2.GetUserData() == "fire" && param1.shape1.GetUserData() == "waterlegs" && this.deadWater == false)
         {
            this.deadWater = true;
         }
         if(param1.shape2.GetUserData() == "black" && param1.shape1.GetUserData() == "waterlegs" && this.deadWater == false)
         {
            this.deadWater = true;
         }
         if(param1.shape1.GetUserData() == "black" && param1.shape2.GetUserData() == "waterlegs" && this.deadWater == false)
         {
            this.deadWater = true;
         }
         if(param1.shape1.GetUserData() == "water" && param1.shape2.GetUserData() == "waterlegs")
         {
            param1.shape2.GetBody().GetUserData().isOnWater = true;
         }
         if(param1.shape2.GetUserData() == "water" && param1.shape1.GetUserData() == "waterlegs")
         {
            param1.shape1.GetBody().GetUserData().isOnWater = true;
         }
         if(param1.shape1.GetUserData() == "fire" && param1.shape2.GetUserData() == "firelegs")
         {
            param1.shape2.GetBody().GetUserData().isOnLava = true;
         }
         if(param1.shape2.GetUserData() == "fire" && param1.shape1.GetUserData() == "firelegs")
         {
            param1.shape1.GetBody().GetUserData().isOnLava = true;
         }
         if(param1.shape1.GetBody().GetUserData() && param1.shape2.GetBody().GetUserData())
         {
            if(param1.shape1.GetBody().GetUserData().name == "ice" && param1.shape2.GetUserData() == "waterlegs")
            {
               param1.shape2.GetBody().GetUserData().isOnIce = true;
            }
            if(param1.shape2.GetBody().GetUserData().name == "ice" && param1.shape1.GetUserData() == "waterlegs")
            {
               param1.shape1.GetBody().GetUserData().isOnIce = true;
            }
            if(param1.shape1.GetBody().GetUserData().name == "ice" && param1.shape2.GetUserData() == "firelegs")
            {
               param1.shape2.GetBody().GetUserData().isOnIce = true;
            }
            if(param1.shape2.GetBody().GetUserData().name == "ice" && param1.shape1.GetUserData() == "firelegs")
            {
               param1.shape1.GetBody().GetUserData().isOnIce = true;
            }
         }
         if(param1.shape1.GetBody().GetUserData().name != "bd" && param1.shape1.GetBody().GetUserData().name != "rd" && param1.shape1.GetBody().GetUserData().name != "FUCK" && param1.shape2.GetBody().GetUserData().name != "bd" && param1.shape2.GetBody().GetUserData().name != "rd" && param1.shape2.GetBody().GetUserData().name != "FUCK")
         {
            if(param1.shape1.GetUserData() == "firelegs" || param1.shape2.GetUserData() == "firelegs")
            {
               this.contactStack1.push(param1.normal.Copy());
            }
            if(param1.shape1.GetUserData() == "waterlegs" || param1.shape2.GetUserData() == "waterlegs")
            {
               this.contactStack2.push(param1.normal.Copy());
            }
         }
         if(param1.shape1.GetBody().GetUserData().name == "bd" && param1.shape2.GetBody().GetUserData().name == "pers2")
         {
            param1.shape1.GetBody().GetUserData().parent.parent.DiamondSound.play();
            param1.shape1.GetBody().GetUserData().parent.removeChild(param1.shape1.GetBody().GetUserData());
            param1.shape1.GetBody().DestroyShape(param1.shape1);
            param1.shape1.GetBody().GetUserData().name = "FUCK";
            ++this.BlueCount;
            trace("BLUE DIAMONDO");
         }
         if(param1.shape2.GetBody().GetUserData().name == "bd" && param1.shape1.GetBody().GetUserData().name == "pers2")
         {
            param1.shape2.GetBody().GetUserData().parent.parent.DiamondSound.play();
            param1.shape2.GetBody().GetUserData().parent.removeChild(param1.shape2.GetBody().GetUserData());
            param1.shape2.GetBody().DestroyShape(param1.shape2);
            param1.shape2.GetBody().GetUserData().name = "FUCK";
            ++this.BlueCount;
            trace("BLUE DIAMONDO");
         }
         if(param1.shape1.GetBody().GetUserData().name == "rd" && param1.shape2.GetBody().GetUserData().name == "pers1")
         {
            param1.shape1.GetBody().GetUserData().parent.parent.DiamondSound.play();
            param1.shape1.GetBody().GetUserData().parent.removeChild(param1.shape1.GetBody().GetUserData());
            param1.shape1.GetBody().DestroyShape(param1.shape1);
            param1.shape1.GetBody().GetUserData().name = "FUCK";
            ++this.RedCount;
            trace("RED DIAMONDO");
         }
         if(param1.shape2.GetBody().GetUserData().name == "rd" && param1.shape1.GetBody().GetUserData().name == "pers1")
         {
            param1.shape2.GetBody().GetUserData().parent.parent.DiamondSound.play();
            param1.shape2.GetBody().GetUserData().parent.removeChild(param1.shape2.GetBody().GetUserData());
            param1.shape2.GetBody().DestroyShape(param1.shape2);
            param1.shape2.GetBody().GetUserData().name = "FUCK";
            ++this.RedCount;
            trace("RED DIAMONDO");
         }
         if(param1.shape2.GetBody().GetUserData().name == "gr" && (param1.shape1.GetBody().GetUserData().name == "pers1" || param1.shape1.GetBody().GetUserData().name == "pers2"))
         {
            param1.shape2.GetBody().GetUserData().parent.parent.DiamondSound.play();
            param1.shape2.GetBody().GetUserData().parent.removeChild(param1.shape2.GetBody().GetUserData());
            param1.shape2.GetBody().DestroyShape(param1.shape2);
            param1.shape2.GetBody().GetUserData().name = "FUCK";
            ++this.GreenCount;
            trace("SILVER DIAMONDO");
         }
         if(param1.shape1.GetBody().GetUserData().name == "gr" && (param1.shape2.GetBody().GetUserData().name == "pers1" || param1.shape2.GetBody().GetUserData().name == "pers2"))
         {
            param1.shape1.GetBody().GetUserData().parent.parent.DiamondSound.play();
            param1.shape1.GetBody().GetUserData().parent.removeChild(param1.shape1.GetBody().GetUserData());
            param1.shape1.GetBody().DestroyShape(param1.shape1);
            param1.shape1.GetBody().GetUserData().name = "FUCK";
            ++this.GreenCount;
            trace("SILVER DIAMONDO");
         }
      }
      
      override public function Persist(param1:b2ContactPoint) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(param1.shape1.GetUserData() == "water" && param1.shape2.GetUserData() == "box")
         {
            param1.shape2.GetBody().GetUserData().waterCC = param1.shape1.GetBody().GetUserData().pnt;
         }
         if(param1.shape2.GetUserData() == "water" && param1.shape1.GetUserData() == "box")
         {
            param1.shape1.GetBody().GetUserData().waterCC = param1.shape2.GetBody().GetUserData().pnt;
         }
         if(param1.shape1.GetBody().GetUserData().name != "bd" && param1.shape1.GetBody().GetUserData().name != "rd" && param1.shape1.GetBody().GetUserData().name != "FUCK" && param1.shape2.GetBody().GetUserData().name != "bd" && param1.shape2.GetBody().GetUserData().name != "rd" && param1.shape2.GetBody().GetUserData().name != "FUCK")
         {
            if(param1.shape1.GetUserData() == "firelegs" || param1.shape2.GetUserData() == "firelegs")
            {
               _loc2_ = 0;
               _loc3_ = 0;
               while(_loc3_ < this.contactStack1.length)
               {
                  if(this.contactStack1[_loc3_].x == param1.normal.x && this.contactStack1[_loc3_].y == param1.normal.y)
                  {
                     _loc2_ = _loc3_;
                  }
                  _loc3_++;
               }
               this.contactStack1[_loc2_] = param1.normal.Copy();
            }
            if(param1.shape1.GetUserData() == "waterlegs" || param1.shape2.GetUserData() == "waterlegs")
            {
               _loc2_ = 0;
               _loc3_ = 0;
               while(_loc3_ < this.contactStack2.length)
               {
                  if(this.contactStack2[_loc3_].x == param1.normal.x && this.contactStack2[_loc3_].y == param1.normal.y)
                  {
                     _loc2_ = _loc3_;
                  }
                  _loc3_++;
               }
               this.contactStack2[_loc2_] = param1.normal.Copy();
            }
         }
         if(param1.shape1.GetUserData() == "FinishGirl" && param1.shape2.GetUserData() == "waterlegs")
         {
            this.finish2 = 1;
         }
         if(param1.shape2.GetUserData() == "FinishGirl" && param1.shape1.GetUserData() == "waterlegs")
         {
            this.finish2 = 1;
         }
         if(param1.shape1.GetUserData() == "FinishBoy" && param1.shape2.GetUserData() == "firelegs")
         {
            this.finish1 = 1;
         }
         if(param1.shape2.GetUserData() == "FinishBoy" && param1.shape1.GetUserData() == "firelegs")
         {
            this.finish1 = 1;
         }
         if(param1.shape1.GetUserData() == "water" && param1.shape2.GetUserData() == "waterlegs")
         {
            param1.shape2.GetBody().GetUserData().isOnWater = true;
         }
         if(param1.shape2.GetUserData() == "water" && param1.shape1.GetUserData() == "waterlegs")
         {
            param1.shape1.GetBody().GetUserData().isOnWater = true;
         }
         if(param1.shape1.GetUserData() == "fire" && param1.shape2.GetUserData() == "firelegs")
         {
            param1.shape2.GetBody().GetUserData().isOnLava = true;
         }
         if(param1.shape2.GetUserData() == "fire" && param1.shape1.GetUserData() == "firelegs")
         {
            param1.shape1.GetBody().GetUserData().isOnLava = true;
         }
         if(param1.shape1.GetBody().GetUserData() && param1.shape2.GetBody().GetUserData())
         {
            if(param1.shape1.GetBody().GetUserData().name == "ice" && param1.shape2.GetUserData() == "waterlegs")
            {
               param1.shape2.GetBody().GetUserData().isOnIce = true;
            }
            if(param1.shape2.GetBody().GetUserData().name == "ice" && param1.shape1.GetUserData() == "waterlegs")
            {
               param1.shape1.GetBody().GetUserData().isOnIce = true;
            }
            if(param1.shape1.GetBody().GetUserData().name == "ice" && param1.shape2.GetUserData() == "firelegs")
            {
               param1.shape2.GetBody().GetUserData().isOnIce = true;
            }
            if(param1.shape2.GetBody().GetUserData().name == "ice" && param1.shape1.GetUserData() == "firelegs")
            {
               param1.shape1.GetBody().GetUserData().isOnIce = true;
            }
         }
      }
      
      override public function Remove(param1:b2ContactPoint) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(param1.shape1.GetUserData() == "water" && param1.shape2.GetUserData() == "box")
         {
            param1.shape2.GetBody().GetUserData().waterCC = null;
         }
         if(param1.shape2.GetUserData() == "water" && param1.shape1.GetUserData() == "box")
         {
            param1.shape1.GetBody().GetUserData().waterCC = null;
         }
         if(param1.shape1.GetUserData() == "FinishGirl" && param1.shape2.GetUserData() == "waterlegs")
         {
            this.finish2 = 0;
         }
         if(param1.shape2.GetUserData() == "FinishGirl" && param1.shape1.GetUserData() == "waterlegs")
         {
            this.finish2 = 0;
         }
         if(param1.shape1.GetUserData() == "FinishBoy" && param1.shape2.GetUserData() == "firelegs")
         {
            this.finish1 = 0;
         }
         if(param1.shape2.GetUserData() == "FinishBoy" && param1.shape1.GetUserData() == "firelegs")
         {
            this.finish1 = 0;
         }
         if(param1.shape1.GetUserData() == "water" && param1.shape2.GetUserData() == "waterlegs")
         {
            param1.shape2.GetBody().GetUserData().isOnWater = false;
         }
         if(param1.shape2.GetUserData() == "water" && param1.shape1.GetUserData() == "waterlegs")
         {
            param1.shape1.GetBody().GetUserData().isOnWater = false;
         }
         if(param1.shape1.GetUserData() == "fire" && param1.shape2.GetUserData() == "firelegs")
         {
            param1.shape2.GetBody().GetUserData().isOnLava = false;
         }
         if(param1.shape2.GetUserData() == "fire" && param1.shape1.GetUserData() == "firelegs")
         {
            param1.shape1.GetBody().GetUserData().isOnLava = false;
         }
         if(param1.shape1.GetBody().GetUserData() && param1.shape2.GetBody().GetUserData())
         {
            if(param1.shape1.GetBody().GetUserData().name == "ice" && param1.shape2.GetUserData() == "waterlegs")
            {
               param1.shape2.GetBody().GetUserData().isOnIce = false;
            }
            if(param1.shape2.GetBody().GetUserData().name == "ice" && param1.shape1.GetUserData() == "waterlegs")
            {
               param1.shape1.GetBody().GetUserData().isOnIce = false;
            }
            if(param1.shape1.GetBody().GetUserData().name == "ice" && param1.shape2.GetUserData() == "firelegs")
            {
               param1.shape2.GetBody().GetUserData().isOnIce = false;
            }
            if(param1.shape2.GetBody().GetUserData().name == "ice" && param1.shape1.GetUserData() == "firelegs")
            {
               param1.shape1.GetBody().GetUserData().isOnIce = false;
            }
         }
         if(param1.shape1.GetUserData() == "firelegs" || param1.shape2.GetUserData() == "firelegs")
         {
            _loc2_ = 0;
            _loc3_ = 0;
            while(_loc3_ < this.contactStack1.length)
            {
               if(this.contactStack1[_loc3_].x == param1.normal.x && this.contactStack1[_loc3_].y == param1.normal.y)
               {
                  _loc2_ = _loc3_;
               }
               _loc3_++;
            }
            this.contactStack1.splice(_loc2_,1);
         }
         if(param1.shape1.GetUserData() == "waterlegs" || param1.shape2.GetUserData() == "waterlegs")
         {
            _loc2_ = 0;
            _loc3_ = 0;
            while(_loc3_ < this.contactStack2.length)
            {
               if(this.contactStack2[_loc3_].x == param1.normal.x && this.contactStack2[_loc3_].y == param1.normal.y)
               {
                  _loc2_ = _loc3_;
               }
               _loc3_++;
            }
            this.contactStack2.splice(_loc2_,1);
         }
      }
   }
}
