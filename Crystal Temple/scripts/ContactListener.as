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
         if(param1.shape1.GetBody().GetUserData().name == "Portal")
         {
            if(param1.shape1.GetUserData() == "MaskSensorR")
            {
               this.ApplyMask(param1.shape1.GetBody().GetUserData(),param1.shape2.GetBody().GetUserData(),"left");
               if(param1.shape1.GetBody().GetUserData().maskedByR.indexOf(param1.shape2.GetBody()) == -1)
               {
                  param1.shape1.GetBody().GetUserData().maskedByR.push(param1.shape2.GetBody().GetUserData());
               }
            }
            else if(param1.shape1.GetUserData() == "MaskSensorL")
            {
               this.ApplyMask(param1.shape1.GetBody().GetUserData(),param1.shape2.GetBody().GetUserData(),"right");
               if(param1.shape1.GetBody().GetUserData().maskedByL.indexOf(param1.shape2.GetBody()) == -1)
               {
                  param1.shape1.GetBody().GetUserData().maskedByL.push(param1.shape2.GetBody().GetUserData());
               }
            }
         }
         if(param1.shape2.GetBody().GetUserData().name == "Portal")
         {
            if(param1.shape2.GetUserData() == "MaskSensorR")
            {
               this.ApplyMask(param1.shape2.GetBody().GetUserData(),param1.shape1.GetBody().GetUserData(),"left");
               if(param1.shape2.GetBody().GetUserData().maskedByR.indexOf(param1.shape1.GetBody()) == -1)
               {
                  param1.shape2.GetBody().GetUserData().maskedByR.push(param1.shape1.GetBody().GetUserData());
               }
            }
            else if(param1.shape2.GetUserData() == "MaskSensorL")
            {
               this.ApplyMask(param1.shape2.GetBody().GetUserData(),param1.shape1.GetBody().GetUserData(),"right");
               if(param1.shape2.GetBody().GetUserData().maskedByL.indexOf(param1.shape1.GetBody()) == -1)
               {
                  param1.shape2.GetBody().GetUserData().maskedByL.push(param1.shape1.GetBody().GetUserData());
               }
            }
         }
         if(param1.shape1.GetUserData() == "TransportSensor" || param1.shape2.GetUserData() == "TransportSensor")
         {
            if(param1.shape1.GetUserData() == "TransportSensor")
            {
               if(param1.shape1.GetBody().GetUserData().receivingObject != param1.shape2.GetBody().GetUserData())
               {
                  param1.shape1.GetBody().GetUserData().activeObject = param1.shape2.GetBody().GetUserData();
                  param1.shape1.GetBody().GetUserData().activeBody = param1.shape2.GetBody();
                  param1.shape1.GetBody().GetUserData().enterSpeed = param1.shape2.GetBody().GetLinearVelocity().Copy();
                  param1.shape1.GetBody().GetUserData().other.receivingObject = param1.shape2.GetBody().GetUserData();
               }
            }
            if(param1.shape2.GetUserData() == "TransportSensor")
            {
               if(param1.shape2.GetBody().GetUserData().receivingObject != param1.shape1.GetBody().GetUserData())
               {
                  param1.shape2.GetBody().GetUserData().activeObject = param1.shape1.GetBody().GetUserData();
                  param1.shape2.GetBody().GetUserData().activeBody = param1.shape1.GetBody();
                  param1.shape2.GetBody().GetUserData().enterSpeed = param1.shape1.GetBody().GetLinearVelocity().Copy();
                  param1.shape2.GetBody().GetUserData().other.receivingObject = param1.shape1.GetBody().GetUserData();
               }
            }
         }
      }
      
      override public function Persist(param1:b2ContactPoint) : void
      {
         var _loc2_:b2Vec2 = null;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         if(param1.shape1.GetUserData() == "TransportSensor" || param1.shape2.GetUserData() == "TransportSensor")
         {
            if(param1.shape1.GetUserData() == "TransportSensor")
            {
               _loc2_ = param1.normal.Copy();
               _loc2_.Multiply(5);
               trace("PRESISTING " + _loc2_.x + " " + _loc2_.y);
               param1.shape2.GetBody().SetLinearVelocity(_loc2_);
            }
            if(param1.shape2.GetUserData() == "TransportSensor")
            {
               _loc2_ = param1.normal.Copy();
               _loc2_.Multiply(5);
               trace("PRESISTING " + _loc2_.x + " " + _loc2_.y);
               param1.shape1.GetBody().SetLinearVelocity(_loc2_);
            }
         }
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
               _loc3_ = 0;
               _loc4_ = 0;
               while(_loc4_ < this.contactStack1.length)
               {
                  if(this.contactStack1[_loc4_].x == param1.normal.x && this.contactStack1[_loc4_].y == param1.normal.y)
                  {
                     _loc3_ = _loc4_;
                  }
                  _loc4_++;
               }
               this.contactStack1[_loc3_] = param1.normal.Copy();
            }
            if(param1.shape1.GetUserData() == "waterlegs" || param1.shape2.GetUserData() == "waterlegs")
            {
               _loc3_ = 0;
               _loc4_ = 0;
               while(_loc4_ < this.contactStack2.length)
               {
                  if(this.contactStack2[_loc4_].x == param1.normal.x && this.contactStack2[_loc4_].y == param1.normal.y)
                  {
                     _loc3_ = _loc4_;
                  }
                  _loc4_++;
               }
               this.contactStack2[_loc3_] = param1.normal.Copy();
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
         var _loc4_:* = undefined;
         if(param1.shape1.GetBody().GetUserData().name == "Portal")
         {
            if(param1.shape1.GetUserData() == "MaskSensorR")
            {
               _loc2_ = param1.shape1.GetBody().GetUserData().maskedByR.indexOf(param1.shape2.GetBody().GetUserData());
               if(_loc2_ != -1)
               {
                  param1.shape1.GetBody().GetUserData().maskedByR.splice(_loc2_,1);
                  if(param1.shape1.GetBody().GetUserData().maskedByR.indexOf(param1.shape2.GetBody().GetUserData()) == -1)
                  {
                     this.UnapplyMask(param1.shape2.GetBody().GetUserData());
                  }
               }
            }
            else if(param1.shape1.GetUserData() == "MaskSensorL")
            {
               _loc2_ = param1.shape1.GetBody().GetUserData().maskedByL.indexOf(param1.shape2.GetBody().GetUserData());
               if(_loc2_ != -1)
               {
                  param1.shape1.GetBody().GetUserData().maskedByL.splice(_loc2_,1);
                  if(param1.shape1.GetBody().GetUserData().maskedByL.indexOf(param1.shape2.GetBody().GetUserData()) == -1)
                  {
                     this.UnapplyMask(param1.shape2.GetBody().GetUserData());
                  }
               }
            }
         }
         if(param1.shape2.GetBody().GetUserData().name == "Portal")
         {
            if(param1.shape2.GetUserData() == "MaskSensorR")
            {
               _loc2_ = param1.shape2.GetBody().GetUserData().maskedByR.indexOf(param1.shape1.GetBody().GetUserData());
               if(_loc2_ != -1)
               {
                  param1.shape2.GetBody().GetUserData().maskedByR.splice(_loc2_,1);
                  if(param1.shape2.GetBody().GetUserData().maskedByR.indexOf(param1.shape1.GetBody().GetUserData()) == -1)
                  {
                     this.UnapplyMask(param1.shape1.GetBody().GetUserData());
                  }
               }
            }
            else if(param1.shape2.GetUserData() == "MaskSensorL")
            {
               _loc2_ = param1.shape2.GetBody().GetUserData().maskedByL.indexOf(param1.shape1.GetBody().GetUserData());
               if(_loc2_ != -1)
               {
                  param1.shape2.GetBody().GetUserData().maskedByL.splice(_loc2_,1);
                  if(param1.shape2.GetBody().GetUserData().maskedByL.indexOf(param1.shape1.GetBody().GetUserData()) == -1)
                  {
                     this.UnapplyMask(param1.shape1.GetBody().GetUserData());
                  }
               }
            }
         }
         if(param1.shape1.GetUserData() == "TransportSensor" || param1.shape2.GetUserData() == "TransportSensor")
         {
            if(param1.shape1.GetUserData() == "TransportSensor" && param1.shape1.GetBody().GetUserData().activeObject == param1.shape2.GetBody().GetUserData())
            {
               param1.shape1.GetBody().GetUserData().activeObject = null;
               param1.shape1.GetBody().GetUserData().activeBody = null;
               param1.shape1.GetBody().GetUserData().enterSpeed = null;
            }
            if(param1.shape2.GetUserData() == "TransportSensor" && param1.shape2.GetBody().GetUserData().activeObject == param1.shape1.GetBody().GetUserData())
            {
               param1.shape2.GetBody().GetUserData().activeObject = null;
               param1.shape2.GetBody().GetUserData().activeBody = null;
               param1.shape2.GetBody().GetUserData().enterSpeed = null;
            }
            if(param1.shape1.GetUserData() == "TransportSensor" && param1.shape1.GetBody().GetUserData().receivingObject == param1.shape2.GetBody().GetUserData())
            {
               param1.shape1.GetBody().GetUserData().receivingObject = null;
            }
            if(param1.shape2.GetUserData() == "TransportSensor" && param1.shape2.GetBody().GetUserData().receivingObject == param1.shape1.GetBody().GetUserData())
            {
               param1.shape2.GetBody().GetUserData().receivingObject = null;
            }
         }
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
            _loc3_ = 0;
            _loc4_ = 0;
            while(_loc4_ < this.contactStack1.length)
            {
               if(this.contactStack1[_loc4_].x == param1.normal.x && this.contactStack1[_loc4_].y == param1.normal.y)
               {
                  _loc3_ = _loc4_;
               }
               _loc4_++;
            }
            this.contactStack1.splice(_loc3_,1);
         }
         if(param1.shape1.GetUserData() == "waterlegs" || param1.shape2.GetUserData() == "waterlegs")
         {
            _loc3_ = 0;
            _loc4_ = 0;
            while(_loc4_ < this.contactStack2.length)
            {
               if(this.contactStack2[_loc4_].x == param1.normal.x && this.contactStack2[_loc4_].y == param1.normal.y)
               {
                  _loc3_ = _loc4_;
               }
               _loc4_++;
            }
            this.contactStack2.splice(_loc3_,1);
         }
      }
      
      public function ApplyMask(param1:Object, param2:Object, param3:String) : void
      {
         if(param2.mask)
         {
            if(param2.mask.parent)
            {
               param2.mask.parent.removeChild(param2.mask);
            }
            param2.mask = null;
         }
         var _loc4_:* = new PortalMask();
         if(param3 == "left")
         {
            _loc4_.rotation = 180;
         }
         param1.addChild(_loc4_);
         param2.mask = _loc4_;
      }
      
      public function UnapplyMask(param1:Object) : void
      {
         if(param1.mask)
         {
            if(param1.mask.parent)
            {
               param1.mask.parent.removeChild(param1.mask);
            }
            param1.mask = null;
         }
      }
   }
}
