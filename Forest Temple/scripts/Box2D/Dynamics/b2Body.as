package Box2D.Dynamics
{
   import Box2D.Collision.Shapes.b2MassData;
   import Box2D.Collision.Shapes.b2Shape;
   import Box2D.Collision.Shapes.b2ShapeDef;
   import Box2D.Common.Math.b2Mat22;
   import Box2D.Common.Math.b2Math;
   import Box2D.Common.Math.b2Sweep;
   import Box2D.Common.Math.b2Vec2;
   import Box2D.Common.Math.b2XForm;
   import Box2D.Dynamics.Contacts.b2ContactEdge;
   import Box2D.Dynamics.Joints.b2JointEdge;
   
   public class b2Body
   {
      
      public static var e_fixedRotationFlag:uint = 64;
      
      public static var e_frozenFlag:uint = 2;
      
      public static var e_maxTypes:uint = 3;
      
      public static var e_sleepFlag:uint = 8;
      
      private static var s_massData:b2MassData = new b2MassData();
      
      public static var e_bulletFlag:uint = 32;
      
      public static var e_staticType:uint = 1;
      
      public static var e_islandFlag:uint = 4;
      
      public static var e_allowSleepFlag:uint = 16;
      
      private static var s_xf1:b2XForm = new b2XForm();
      
      public static var e_dynamicType:uint = 2;
       
      
      public var m_next:b2Body;
      
      public var m_contactList:b2ContactEdge;
      
      public var m_angularVelocity:Number;
      
      public var m_shapeList:b2Shape;
      
      public var m_force:b2Vec2;
      
      public var m_mass:Number;
      
      public var m_sweep:b2Sweep;
      
      public var m_xf:b2XForm;
      
      public var m_torque:Number;
      
      public var m_userData:*;
      
      public var m_flags:uint;
      
      public var m_world:b2World;
      
      public var m_prev:b2Body;
      
      public var m_invMass:Number;
      
      public var m_type:int;
      
      public var m_linearDamping:Number;
      
      public var m_angularDamping:Number;
      
      public var m_invI:Number;
      
      public var m_linearVelocity:b2Vec2;
      
      public var m_sleepTime:Number;
      
      public var m_shapeCount:int;
      
      public var m_jointList:b2JointEdge;
      
      public var m_I:Number;
      
      public function b2Body(param1:b2BodyDef, param2:b2World)
      {
         var _loc3_:b2Mat22 = null;
         var _loc4_:b2Vec2 = null;
         m_xf = new b2XForm();
         m_sweep = new b2Sweep();
         m_linearVelocity = new b2Vec2();
         m_force = new b2Vec2();
         super();
         m_flags = 0;
         if(param1.isBullet)
         {
            m_flags |= e_bulletFlag;
         }
         if(param1.fixedRotation)
         {
            m_flags |= e_fixedRotationFlag;
         }
         if(param1.allowSleep)
         {
            m_flags |= e_allowSleepFlag;
         }
         if(param1.isSleeping)
         {
            m_flags |= e_sleepFlag;
         }
         m_world = param2;
         m_xf.position.SetV(param1.position);
         m_xf.R.Set(param1.angle);
         m_sweep.localCenter.SetV(param1.massData.center);
         m_sweep.t0 = 1;
         m_sweep.a0 = m_sweep.a = param1.angle;
         _loc3_ = m_xf.R;
         _loc4_ = m_sweep.localCenter;
         m_sweep.c.x = _loc3_.col1.x * _loc4_.x + _loc3_.col2.x * _loc4_.y;
         m_sweep.c.y = _loc3_.col1.y * _loc4_.x + _loc3_.col2.y * _loc4_.y;
         m_sweep.c.x += m_xf.position.x;
         m_sweep.c.y += m_xf.position.y;
         m_sweep.c0.SetV(m_sweep.c);
         m_jointList = null;
         m_contactList = null;
         m_prev = null;
         m_next = null;
         m_linearDamping = param1.linearDamping;
         m_angularDamping = param1.angularDamping;
         m_force.Set(0,0);
         m_torque = 0;
         m_linearVelocity.SetZero();
         m_angularVelocity = 0;
         m_sleepTime = 0;
         m_invMass = 0;
         m_I = 0;
         m_invI = 0;
         m_mass = param1.massData.mass;
         if(m_mass > 0)
         {
            m_invMass = 1 / m_mass;
         }
         if((m_flags & b2Body.e_fixedRotationFlag) == 0)
         {
            m_I = param1.massData.I;
         }
         if(m_I > 0)
         {
            m_invI = 1 / m_I;
         }
         if(m_invMass == 0 && m_invI == 0)
         {
            m_type = e_staticType;
         }
         else
         {
            m_type = e_dynamicType;
         }
         m_userData = param1.userData;
         m_shapeList = null;
         m_shapeCount = 0;
      }
      
      public function GetLinearVelocityFromWorldPoint(param1:b2Vec2) : b2Vec2
      {
         return new b2Vec2(m_linearVelocity.x - m_angularVelocity * (param1.y - m_sweep.c.y),m_linearVelocity.y + m_angularVelocity * (param1.x - m_sweep.c.x));
      }
      
      public function SetLinearVelocity(param1:b2Vec2) : void
      {
         m_linearVelocity.SetV(param1);
      }
      
      public function WakeUp() : void
      {
         m_flags &= ~e_sleepFlag;
         m_sleepTime = 0;
      }
      
      public function GetLocalCenter() : b2Vec2
      {
         return m_sweep.localCenter;
      }
      
      public function ApplyTorque(param1:Number) : void
      {
         if(IsSleeping())
         {
            WakeUp();
         }
         m_torque += param1;
      }
      
      public function IsFrozen() : Boolean
      {
         return (m_flags & e_frozenFlag) == e_frozenFlag;
      }
      
      public function IsDynamic() : Boolean
      {
         return m_type == e_dynamicType;
      }
      
      public function GetLinearVelocity() : b2Vec2
      {
         return m_linearVelocity;
      }
      
      public function SynchronizeTransform() : void
      {
         var _loc1_:b2Mat22 = null;
         var _loc2_:b2Vec2 = null;
         m_xf.R.Set(m_sweep.a);
         _loc1_ = m_xf.R;
         _loc2_ = m_sweep.localCenter;
         m_xf.position.x = m_sweep.c.x - (_loc1_.col1.x * _loc2_.x + _loc1_.col2.x * _loc2_.y);
         m_xf.position.y = m_sweep.c.y - (_loc1_.col1.y * _loc2_.x + _loc1_.col2.y * _loc2_.y);
      }
      
      public function GetInertia() : Number
      {
         return m_I;
      }
      
      public function IsSleeping() : Boolean
      {
         return (m_flags & e_sleepFlag) == e_sleepFlag;
      }
      
      public function SetMassFromShapes() : void
      {
         var _loc1_:b2Shape = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:b2MassData = null;
         var _loc5_:b2Mat22 = null;
         var _loc6_:b2Vec2 = null;
         var _loc7_:int = 0;
         if(m_world.m_lock == true)
         {
            return;
         }
         m_mass = 0;
         m_invMass = 0;
         m_I = 0;
         m_invI = 0;
         _loc2_ = 0;
         _loc3_ = 0;
         _loc4_ = s_massData;
         _loc1_ = m_shapeList;
         while(_loc1_)
         {
            _loc1_.ComputeMass(_loc4_);
            m_mass += _loc4_.mass;
            _loc2_ += _loc4_.mass * _loc4_.center.x;
            _loc3_ += _loc4_.mass * _loc4_.center.y;
            m_I += _loc4_.I;
            _loc1_ = _loc1_.m_next;
         }
         if(m_mass > 0)
         {
            m_invMass = 1 / m_mass;
            _loc2_ *= m_invMass;
            _loc3_ *= m_invMass;
         }
         if(m_I > 0 && (m_flags & e_fixedRotationFlag) == 0)
         {
            m_I -= m_mass * (_loc2_ * _loc2_ + _loc3_ * _loc3_);
            m_invI = 1 / m_I;
         }
         else
         {
            m_I = 0;
            m_invI = 0;
         }
         m_sweep.localCenter.Set(_loc2_,_loc3_);
         _loc5_ = m_xf.R;
         _loc6_ = m_sweep.localCenter;
         m_sweep.c.x = _loc5_.col1.x * _loc6_.x + _loc5_.col2.x * _loc6_.y;
         m_sweep.c.y = _loc5_.col1.y * _loc6_.x + _loc5_.col2.y * _loc6_.y;
         m_sweep.c.x += m_xf.position.x;
         m_sweep.c.y += m_xf.position.y;
         m_sweep.c0.SetV(m_sweep.c);
         _loc1_ = m_shapeList;
         while(_loc1_)
         {
            _loc1_.UpdateSweepRadius(m_sweep.localCenter);
            _loc1_ = _loc1_.m_next;
         }
         _loc7_ = m_type;
         if(m_invMass == 0 && m_invI == 0)
         {
            m_type = e_staticType;
         }
         else
         {
            m_type = e_dynamicType;
         }
         if(_loc7_ != m_type)
         {
            _loc1_ = m_shapeList;
            while(_loc1_)
            {
               _loc1_.RefilterProxy(m_world.m_broadPhase,m_xf);
               _loc1_ = _loc1_.m_next;
            }
         }
      }
      
      public function PutToSleep() : void
      {
         m_flags |= e_sleepFlag;
         m_sleepTime = 0;
         m_linearVelocity.SetZero();
         m_angularVelocity = 0;
         m_force.SetZero();
         m_torque = 0;
      }
      
      public function GetJointList() : b2JointEdge
      {
         return m_jointList;
      }
      
      public function SetXForm(param1:b2Vec2, param2:Number) : Boolean
      {
         var _loc3_:b2Shape = null;
         var _loc4_:b2Mat22 = null;
         var _loc5_:b2Vec2 = null;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         if(m_world.m_lock == true)
         {
            return true;
         }
         if(IsFrozen())
         {
            return false;
         }
         m_xf.R.Set(param2);
         m_xf.position.SetV(param1);
         _loc4_ = m_xf.R;
         _loc5_ = m_sweep.localCenter;
         m_sweep.c.x = _loc4_.col1.x * _loc5_.x + _loc4_.col2.x * _loc5_.y;
         m_sweep.c.y = _loc4_.col1.y * _loc5_.x + _loc4_.col2.y * _loc5_.y;
         m_sweep.c.x += m_xf.position.x;
         m_sweep.c.y += m_xf.position.y;
         m_sweep.c0.SetV(m_sweep.c);
         m_sweep.a0 = m_sweep.a = param2;
         _loc6_ = false;
         _loc3_ = m_shapeList;
         while(_loc3_)
         {
            if((_loc7_ = _loc3_.Synchronize(m_world.m_broadPhase,m_xf,m_xf)) == false)
            {
               _loc6_ = true;
               break;
            }
            _loc3_ = _loc3_.m_next;
         }
         if(_loc6_ == true)
         {
            m_flags |= e_frozenFlag;
            m_linearVelocity.SetZero();
            m_angularVelocity = 0;
            _loc3_ = m_shapeList;
            while(_loc3_)
            {
               _loc3_.DestroyProxy(m_world.m_broadPhase);
               _loc3_ = _loc3_.m_next;
            }
            return false;
         }
         m_world.m_broadPhase.Commit();
         return true;
      }
      
      public function GetLocalPoint(param1:b2Vec2) : b2Vec2
      {
         return b2Math.b2MulXT(m_xf,param1);
      }
      
      public function ApplyForce(param1:b2Vec2, param2:b2Vec2) : void
      {
         if(IsSleeping())
         {
            WakeUp();
         }
         m_force.x += param1.x;
         m_force.y += param1.y;
         m_torque += (param2.x - m_sweep.c.x) * param1.y - (param2.y - m_sweep.c.y) * param1.x;
      }
      
      public function SynchronizeShapes() : Boolean
      {
         var _loc1_:b2XForm = null;
         var _loc2_:b2Mat22 = null;
         var _loc3_:b2Vec2 = null;
         var _loc4_:b2Shape = null;
         var _loc5_:Boolean = false;
         _loc1_ = s_xf1;
         _loc1_.R.Set(m_sweep.a0);
         _loc2_ = _loc1_.R;
         _loc3_ = m_sweep.localCenter;
         _loc1_.position.x = m_sweep.c0.x - (_loc2_.col1.x * _loc3_.x + _loc2_.col2.x * _loc3_.y);
         _loc1_.position.y = m_sweep.c0.y - (_loc2_.col1.y * _loc3_.x + _loc2_.col2.y * _loc3_.y);
         _loc5_ = true;
         _loc4_ = m_shapeList;
         while(_loc4_)
         {
            if((_loc5_ = _loc4_.Synchronize(m_world.m_broadPhase,_loc1_,m_xf)) == false)
            {
               break;
            }
            _loc4_ = _loc4_.m_next;
         }
         if(_loc5_ == false)
         {
            m_flags |= e_frozenFlag;
            m_linearVelocity.SetZero();
            m_angularVelocity = 0;
            _loc4_ = m_shapeList;
            while(_loc4_)
            {
               _loc4_.DestroyProxy(m_world.m_broadPhase);
               _loc4_ = _loc4_.m_next;
            }
            return false;
         }
         return true;
      }
      
      public function GetAngle() : Number
      {
         return m_sweep.a;
      }
      
      public function GetXForm() : b2XForm
      {
         return m_xf;
      }
      
      public function ApplyImpulse(param1:b2Vec2, param2:b2Vec2) : void
      {
         if(IsSleeping())
         {
            WakeUp();
         }
         m_linearVelocity.x += m_invMass * param1.x;
         m_linearVelocity.y += m_invMass * param1.y;
         m_angularVelocity += m_invI * ((param2.x - m_sweep.c.x) * param1.y - (param2.y - m_sweep.c.y) * param1.x);
      }
      
      public function GetNext() : b2Body
      {
         return m_next;
      }
      
      public function GetMass() : Number
      {
         return m_mass;
      }
      
      public function GetLinearVelocityFromLocalPoint(param1:b2Vec2) : b2Vec2
      {
         var _loc2_:b2Mat22 = null;
         var _loc3_:b2Vec2 = null;
         _loc2_ = m_xf.R;
         _loc3_ = new b2Vec2(_loc2_.col1.x * param1.x + _loc2_.col2.x * param1.y,_loc2_.col1.y * param1.x + _loc2_.col2.y * param1.y);
         _loc3_.x += m_xf.position.x;
         _loc3_.y += m_xf.position.y;
         return new b2Vec2(m_linearVelocity.x + m_angularVelocity * (_loc3_.y - m_sweep.c.y),m_linearVelocity.x - m_angularVelocity * (_loc3_.x - m_sweep.c.x));
      }
      
      public function GetAngularVelocity() : Number
      {
         return m_angularVelocity;
      }
      
      public function SetAngularVelocity(param1:Number) : void
      {
         m_angularVelocity = param1;
      }
      
      public function SetMass(param1:b2MassData) : void
      {
         var _loc2_:b2Shape = null;
         var _loc3_:b2Mat22 = null;
         var _loc4_:b2Vec2 = null;
         var _loc5_:int = 0;
         if(m_world.m_lock == true)
         {
            return;
         }
         m_invMass = 0;
         m_I = 0;
         m_invI = 0;
         m_mass = param1.mass;
         if(m_mass > 0)
         {
            m_invMass = 1 / m_mass;
         }
         if((m_flags & b2Body.e_fixedRotationFlag) == 0)
         {
            m_I = param1.I;
         }
         if(m_I > 0)
         {
            m_invI = 1 / m_I;
         }
         m_sweep.localCenter.SetV(param1.center);
         _loc3_ = m_xf.R;
         _loc4_ = m_sweep.localCenter;
         m_sweep.c.x = _loc3_.col1.x * _loc4_.x + _loc3_.col2.x * _loc4_.y;
         m_sweep.c.y = _loc3_.col1.y * _loc4_.x + _loc3_.col2.y * _loc4_.y;
         m_sweep.c.x += m_xf.position.x;
         m_sweep.c.y += m_xf.position.y;
         m_sweep.c0.SetV(m_sweep.c);
         _loc2_ = m_shapeList;
         while(_loc2_)
         {
            _loc2_.UpdateSweepRadius(m_sweep.localCenter);
            _loc2_ = _loc2_.m_next;
         }
         _loc5_ = m_type;
         if(m_invMass == 0 && m_invI == 0)
         {
            m_type = e_staticType;
         }
         else
         {
            m_type = e_dynamicType;
         }
         if(_loc5_ != m_type)
         {
            _loc2_ = m_shapeList;
            while(_loc2_)
            {
               _loc2_.RefilterProxy(m_world.m_broadPhase,m_xf);
               _loc2_ = _loc2_.m_next;
            }
         }
      }
      
      public function IsStatic() : Boolean
      {
         return m_type == e_staticType;
      }
      
      public function GetWorldVector(param1:b2Vec2) : b2Vec2
      {
         return b2Math.b2MulMV(m_xf.R,param1);
      }
      
      public function GetShapeList() : b2Shape
      {
         return m_shapeList;
      }
      
      public function Advance(param1:Number) : void
      {
         m_sweep.Advance(param1);
         m_sweep.c.SetV(m_sweep.c0);
         m_sweep.a = m_sweep.a0;
         SynchronizeTransform();
      }
      
      public function SetBullet(param1:Boolean) : void
      {
         if(param1)
         {
            m_flags |= e_bulletFlag;
         }
         else
         {
            m_flags &= ~e_bulletFlag;
         }
      }
      
      public function CreateShape(param1:b2ShapeDef) : b2Shape
      {
         var _loc2_:b2Shape = null;
         if(m_world.m_lock == true)
         {
            return null;
         }
         _loc2_ = b2Shape.Create(param1,m_world.m_blockAllocator);
         _loc2_.m_next = m_shapeList;
         m_shapeList = _loc2_;
         ++m_shapeCount;
         _loc2_.m_body = this;
         _loc2_.CreateProxy(m_world.m_broadPhase,m_xf);
         _loc2_.UpdateSweepRadius(m_sweep.localCenter);
         return _loc2_;
      }
      
      public function IsConnected(param1:b2Body) : Boolean
      {
         var _loc2_:b2JointEdge = null;
         _loc2_ = m_jointList;
         while(_loc2_)
         {
            if(_loc2_.other == param1)
            {
               return _loc2_.joint.m_collideConnected == false;
            }
            _loc2_ = _loc2_.next;
         }
         return false;
      }
      
      public function DestroyShape(param1:b2Shape) : void
      {
         var _loc2_:b2Shape = null;
         var _loc3_:b2Shape = null;
         var _loc4_:Boolean = false;
         if(m_world.m_lock == true)
         {
            return;
         }
         param1.DestroyProxy(m_world.m_broadPhase);
         _loc2_ = m_shapeList;
         _loc3_ = null;
         _loc4_ = false;
         while(_loc2_ != null)
         {
            if(_loc2_ == param1)
            {
               if(_loc3_)
               {
                  _loc3_.m_next = param1.m_next;
               }
               else
               {
                  m_shapeList = param1.m_next;
               }
               _loc4_ = true;
               break;
            }
            _loc3_ = _loc2_;
            _loc2_ = _loc2_.m_next;
         }
         param1.m_body = null;
         param1.m_next = null;
         --m_shapeCount;
         b2Shape.Destroy(param1,m_world.m_blockAllocator);
      }
      
      public function GetUserData() : *
      {
         return m_userData;
      }
      
      public function IsBullet() : Boolean
      {
         return (m_flags & e_bulletFlag) == e_bulletFlag;
      }
      
      public function GetWorldCenter() : b2Vec2
      {
         return m_sweep.c;
      }
      
      public function AllowSleeping(param1:Boolean) : void
      {
         if(param1)
         {
            m_flags |= e_allowSleepFlag;
         }
         else
         {
            m_flags &= ~e_allowSleepFlag;
            WakeUp();
         }
      }
      
      public function SetUserData(param1:*) : void
      {
         m_userData = param1;
      }
      
      public function GetLocalVector(param1:b2Vec2) : b2Vec2
      {
         return b2Math.b2MulTMV(m_xf.R,param1);
      }
      
      public function GetWorldPoint(param1:b2Vec2) : b2Vec2
      {
         var _loc2_:b2Mat22 = null;
         var _loc3_:b2Vec2 = null;
         _loc2_ = m_xf.R;
         _loc3_ = new b2Vec2(_loc2_.col1.x * param1.x + _loc2_.col2.x * param1.y,_loc2_.col1.y * param1.x + _loc2_.col2.y * param1.y);
         _loc3_.x += m_xf.position.x;
         _loc3_.y += m_xf.position.y;
         return _loc3_;
      }
      
      public function GetWorld() : b2World
      {
         return m_world;
      }
      
      public function GetPosition() : b2Vec2
      {
         return m_xf.position;
      }
   }
}
