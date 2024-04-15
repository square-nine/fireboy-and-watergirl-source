package Box2D.Collision
{
   import Box2D.Common.Math.b2Vec2;
   
   public class b2Segment
   {
       
      
      public var p1:b2Vec2;
      
      public var p2:b2Vec2;
      
      public function b2Segment()
      {
         p1 = new b2Vec2();
         p2 = new b2Vec2();
         super();
      }
      
      public function TestSegment(param1:Array, param2:b2Vec2, param3:b2Segment, param4:Number) : Boolean
      {
         var _loc5_:b2Vec2 = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         _loc5_ = param3.p1;
         _loc6_ = param3.p2.x - _loc5_.x;
         _loc7_ = param3.p2.y - _loc5_.y;
         _loc8_ = p2.x - p1.x;
         _loc10_ = _loc9_ = p2.y - p1.y;
         _loc11_ = -_loc8_;
         _loc12_ = 100 * Number.MIN_VALUE;
         if((_loc13_ = -(_loc6_ * _loc10_ + _loc7_ * _loc11_)) > _loc12_)
         {
            _loc14_ = _loc5_.x - p1.x;
            _loc15_ = _loc5_.y - p1.y;
            _loc16_ = _loc14_ * _loc10_ + _loc15_ * _loc11_;
            if(0 <= _loc16_ && _loc16_ <= param4 * _loc13_)
            {
               _loc17_ = -_loc6_ * _loc15_ + _loc7_ * _loc14_;
               if(-_loc12_ * _loc13_ <= _loc17_ && _loc17_ <= _loc13_ * (1 + _loc12_))
               {
                  _loc16_ /= _loc13_;
                  _loc18_ = Math.sqrt(_loc10_ * _loc10_ + _loc11_ * _loc11_);
                  _loc10_ /= _loc18_;
                  _loc11_ /= _loc18_;
                  param1[0] = _loc16_;
                  param2.Set(_loc10_,_loc11_);
                  return true;
               }
            }
         }
         return false;
      }
   }
}
