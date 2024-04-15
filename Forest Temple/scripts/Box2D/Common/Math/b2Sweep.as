package Box2D.Common.Math
{
   public class b2Sweep
   {
       
      
      public var localCenter:b2Vec2;
      
      public var c:b2Vec2;
      
      public var a:Number;
      
      public var c0:b2Vec2;
      
      public var a0:Number;
      
      public var t0:Number;
      
      public function b2Sweep()
      {
         localCenter = new b2Vec2();
         c0 = new b2Vec2();
         c = new b2Vec2();
         super();
      }
      
      public function Advance(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         if(t0 < param1 && 1 - t0 > Number.MIN_VALUE)
         {
            _loc2_ = (param1 - t0) / (1 - t0);
            c0.x = (1 - _loc2_) * c0.x + _loc2_ * c.x;
            c0.y = (1 - _loc2_) * c0.y + _loc2_ * c.y;
            a0 = (1 - _loc2_) * a0 + _loc2_ * a;
            t0 = param1;
         }
      }
      
      public function GetXForm(param1:b2XForm, param2:Number) : void
      {
         var _loc3_:b2Mat22 = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(1 - t0 > Number.MIN_VALUE)
         {
            _loc4_ = (param2 - t0) / (1 - t0);
            param1.position.x = (1 - _loc4_) * c0.x + _loc4_ * c.x;
            param1.position.y = (1 - _loc4_) * c0.y + _loc4_ * c.y;
            _loc5_ = (1 - _loc4_) * a0 + _loc4_ * a;
            param1.R.Set(_loc5_);
         }
         else
         {
            param1.position.SetV(c);
            param1.R.Set(a);
         }
         _loc3_ = param1.R;
         param1.position.x -= _loc3_.col1.x * localCenter.x + _loc3_.col2.x * localCenter.y;
         param1.position.y -= _loc3_.col1.y * localCenter.x + _loc3_.col2.y * localCenter.y;
      }
   }
}
