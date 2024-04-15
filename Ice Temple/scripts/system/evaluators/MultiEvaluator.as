package system.evaluators
{
   public class MultiEvaluator implements Evaluable
   {
       
      
      public var autoClear:Boolean;
      
      private var _evaluators:Array;
      
      public function MultiEvaluator(... rest)
      {
         super();
         _evaluators = [];
         add.apply(this,rest);
      }
      
      public function add(... rest) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         if(autoClear)
         {
            clear();
         }
         var _loc2_:int = int(rest.length);
         if(_loc2_ > 0)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               if((_loc6_ = rest[_loc4_]) is Evaluable)
               {
                  _evaluators.push(_loc6_);
               }
               else if(_loc6_ is Array)
               {
                  _loc3_ = int((_loc6_ as Array).length);
                  _loc5_ = 0;
                  while(_loc5_ < _loc3_)
                  {
                     if(_loc6_[_loc5_] is Evaluable)
                     {
                        _evaluators.push(_loc6_[_loc5_]);
                     }
                     _loc5_++;
                  }
               }
               _loc4_++;
            }
         }
      }
      
      public function clear() : void
      {
         _evaluators = [];
      }
      
      public function eval(param1:*) : *
      {
         var _loc2_:uint = 0;
         var _loc3_:int = int(_evaluators.length);
         if(_loc3_ > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               param1 = _evaluators[_loc2_].eval(param1);
               _loc2_++;
            }
         }
         return param1;
      }
      
      public function remove(param1:Evaluable) : Boolean
      {
         var _loc2_:int = _evaluators.indexOf(param1);
         if(_loc2_ > -1)
         {
            _evaluators.splice(_loc2_,1);
            return true;
         }
         return false;
      }
      
      public function size() : Number
      {
         return _evaluators.length;
      }
   }
}
