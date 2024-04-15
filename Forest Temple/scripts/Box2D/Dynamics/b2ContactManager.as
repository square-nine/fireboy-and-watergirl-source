package Box2D.Dynamics
{
   import Box2D.Collision.Shapes.b2Shape;
   import Box2D.Collision.b2ContactPoint;
   import Box2D.Collision.b2Manifold;
   import Box2D.Collision.b2ManifoldPoint;
   import Box2D.Collision.b2PairCallback;
   import Box2D.Common.Math.b2Vec2;
   import Box2D.Dynamics.Contacts.b2Contact;
   import Box2D.Dynamics.Contacts.b2NullContact;
   
   public class b2ContactManager extends b2PairCallback
   {
      
      private static const s_evalCP:b2ContactPoint = new b2ContactPoint();
       
      
      public var m_world:b2World;
      
      public var m_destroyImmediate:Boolean;
      
      public var m_nullContact:b2NullContact;
      
      public function b2ContactManager()
      {
         m_nullContact = new b2NullContact();
         super();
         m_world = null;
         m_destroyImmediate = false;
      }
      
      override public function PairAdded(param1:*, param2:*) : *
      {
         var _loc3_:b2Shape = null;
         var _loc4_:b2Shape = null;
         var _loc5_:b2Body = null;
         var _loc6_:b2Body = null;
         var _loc7_:b2Contact = null;
         _loc3_ = param1 as b2Shape;
         _loc4_ = param2 as b2Shape;
         _loc5_ = _loc3_.m_body;
         _loc6_ = _loc4_.m_body;
         if(_loc5_.IsStatic() && _loc6_.IsStatic())
         {
            return m_nullContact;
         }
         if(_loc3_.m_body == _loc4_.m_body)
         {
            return m_nullContact;
         }
         if(_loc6_.IsConnected(_loc5_))
         {
            return m_nullContact;
         }
         if(m_world.m_contactFilter != null && m_world.m_contactFilter.ShouldCollide(_loc3_,_loc4_) == false)
         {
            return m_nullContact;
         }
         if((_loc7_ = b2Contact.Create(_loc3_,_loc4_,m_world.m_blockAllocator)) == null)
         {
            return m_nullContact;
         }
         _loc3_ = _loc7_.m_shape1;
         _loc4_ = _loc7_.m_shape2;
         _loc5_ = _loc3_.m_body;
         _loc6_ = _loc4_.m_body;
         _loc7_.m_prev = null;
         _loc7_.m_next = m_world.m_contactList;
         if(m_world.m_contactList != null)
         {
            m_world.m_contactList.m_prev = _loc7_;
         }
         m_world.m_contactList = _loc7_;
         _loc7_.m_node1.contact = _loc7_;
         _loc7_.m_node1.other = _loc6_;
         _loc7_.m_node1.prev = null;
         _loc7_.m_node1.next = _loc5_.m_contactList;
         if(_loc5_.m_contactList != null)
         {
            _loc5_.m_contactList.prev = _loc7_.m_node1;
         }
         _loc5_.m_contactList = _loc7_.m_node1;
         _loc7_.m_node2.contact = _loc7_;
         _loc7_.m_node2.other = _loc5_;
         _loc7_.m_node2.prev = null;
         _loc7_.m_node2.next = _loc6_.m_contactList;
         if(_loc6_.m_contactList != null)
         {
            _loc6_.m_contactList.prev = _loc7_.m_node2;
         }
         _loc6_.m_contactList = _loc7_.m_node2;
         ++m_world.m_contactCount;
         return _loc7_;
      }
      
      override public function PairRemoved(param1:*, param2:*, param3:*) : void
      {
         var _loc4_:b2Contact = null;
         if(param3 == null)
         {
            return;
         }
         if((_loc4_ = param3 as b2Contact) == m_nullContact)
         {
            return;
         }
         Destroy(_loc4_);
      }
      
      public function Destroy(param1:b2Contact) : void
      {
         var _loc2_:b2Shape = null;
         var _loc3_:b2Shape = null;
         var _loc4_:int = 0;
         var _loc5_:b2Body = null;
         var _loc6_:b2Body = null;
         var _loc7_:b2Body = null;
         var _loc8_:b2Body = null;
         var _loc9_:Array = null;
         var _loc10_:b2ContactPoint = null;
         var _loc11_:int = 0;
         var _loc12_:b2Manifold = null;
         var _loc13_:int = 0;
         var _loc14_:b2ManifoldPoint = null;
         var _loc15_:b2Vec2 = null;
         var _loc16_:b2Vec2 = null;
         _loc2_ = param1.m_shape1;
         _loc3_ = param1.m_shape2;
         if((_loc4_ = param1.m_manifoldCount) > 0 && Boolean(m_world.m_contactListener))
         {
            _loc7_ = _loc2_.m_body;
            _loc8_ = _loc3_.m_body;
            _loc9_ = param1.GetManifolds();
            (_loc10_ = s_evalCP).shape1 = param1.m_shape1;
            _loc10_.shape2 = param1.m_shape2;
            _loc10_.friction = param1.m_friction;
            _loc10_.restitution = param1.m_restitution;
            _loc11_ = 0;
            while(_loc11_ < _loc4_)
            {
               _loc12_ = _loc9_[_loc11_];
               _loc10_.normal.SetV(_loc12_.normal);
               _loc13_ = 0;
               while(_loc13_ < _loc12_.pointCount)
               {
                  _loc14_ = _loc12_.points[_loc13_];
                  _loc10_.position = _loc7_.GetWorldPoint(_loc14_.localPoint1);
                  _loc15_ = _loc7_.GetLinearVelocityFromLocalPoint(_loc14_.localPoint1);
                  _loc16_ = _loc8_.GetLinearVelocityFromLocalPoint(_loc14_.localPoint2);
                  _loc10_.velocity.Set(_loc16_.x - _loc15_.x,_loc16_.y - _loc15_.y);
                  _loc10_.separation = _loc14_.separation;
                  _loc10_.id.key = _loc14_.id._key;
                  m_world.m_contactListener.Remove(_loc10_);
                  _loc13_++;
               }
               _loc11_++;
            }
         }
         if(param1.m_prev)
         {
            param1.m_prev.m_next = param1.m_next;
         }
         if(param1.m_next)
         {
            param1.m_next.m_prev = param1.m_prev;
         }
         if(param1 == m_world.m_contactList)
         {
            m_world.m_contactList = param1.m_next;
         }
         _loc5_ = _loc2_.m_body;
         _loc6_ = _loc3_.m_body;
         if(param1.m_node1.prev)
         {
            param1.m_node1.prev.next = param1.m_node1.next;
         }
         if(param1.m_node1.next)
         {
            param1.m_node1.next.prev = param1.m_node1.prev;
         }
         if(param1.m_node1 == _loc5_.m_contactList)
         {
            _loc5_.m_contactList = param1.m_node1.next;
         }
         if(param1.m_node2.prev)
         {
            param1.m_node2.prev.next = param1.m_node2.next;
         }
         if(param1.m_node2.next)
         {
            param1.m_node2.next.prev = param1.m_node2.prev;
         }
         if(param1.m_node2 == _loc6_.m_contactList)
         {
            _loc6_.m_contactList = param1.m_node2.next;
         }
         b2Contact.Destroy(param1,m_world.m_blockAllocator);
         --m_world.m_contactCount;
      }
      
      public function Collide() : void
      {
         var _loc1_:b2Contact = null;
         var _loc2_:b2Body = null;
         var _loc3_:b2Body = null;
         _loc1_ = m_world.m_contactList;
         while(_loc1_)
         {
            _loc2_ = _loc1_.m_shape1.m_body;
            _loc3_ = _loc1_.m_shape2.m_body;
            if(!(_loc2_.IsSleeping() && _loc3_.IsSleeping()))
            {
               _loc1_.Update(m_world.m_contactListener);
            }
            _loc1_ = _loc1_.m_next;
         }
      }
   }
}
