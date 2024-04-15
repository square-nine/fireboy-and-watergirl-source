package system
{
   public class Arrays
   {
       
      
      public function Arrays()
      {
         super();
      }
      
      public static function contains(param1:Array, param2:Object) : Boolean
      {
         return param1.indexOf(param2) > -1;
      }
      
      public static function copy(param1:Array, param2:Boolean = false) : Array
      {
         var _loc3_:uint = 0;
         var _loc4_:Array = null;
         if(param2)
         {
            _loc4_ = [];
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               _loc4_[_loc3_] = param1[_loc3_];
               _loc3_++;
            }
            return _loc4_;
         }
         return Objects.copy(param1) as Array;
      }
      
      public static function initialize(param1:uint = 0, param2:* = null) : Array
      {
         var _loc4_:int = 0;
         var _loc3_:Array = [];
         while(_loc4_ < param1)
         {
            _loc3_.push(param2);
            _loc4_++;
         }
         return _loc3_;
      }
      
      public static function reduce(param1:Array, param2:Function, param3:* = undefined) : *
      {
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         var _loc4_:int = int(param1.length);
         if(param2 == null)
         {
            throw new ArgumentError("Arrays.reduce failed, the callback method not must be \'null\' or \'undefined\'.");
         }
         if(_loc4_ == 0)
         {
            throw new Error("Arrays.reduce failed, the array contains no values.");
         }
         if(param3 != undefined)
         {
            _loc6_ = param3;
         }
         else
         {
            while(!(_loc5_ in param1))
            {
               if(++_loc5_ > _loc4_)
               {
                  throw new Error("Array.reduce failed, if array contains no values, no initial value to return.");
               }
            }
            _loc6_ = param1[_loc5_++];
         }
         while(_loc5_ < _loc4_)
         {
            if(_loc5_ in param1)
            {
               _loc6_ = param2.call(null,_loc6_,param1[_loc5_],_loc5_,param1);
            }
            _loc5_++;
         }
         return _loc6_;
      }
      
      public static function reduceRight(param1:Array, param2:Function, param3:* = undefined) : *
      {
         var _loc6_:* = undefined;
         var _loc4_:int = int(param1.length);
         if(param2 == null)
         {
            throw new ArgumentError("Arrays.reduceRight failed, the callback method not must be \'null\' or \'undefined\'.");
         }
         if(_loc4_ == 0)
         {
            throw new Error("Arrays.reduceRight failed, the array contains no values.");
         }
         var _loc5_:int = _loc4_ - 1;
         if(param3 != undefined)
         {
            _loc6_ = param3;
         }
         else
         {
            while(!(_loc5_ in param1))
            {
               if(--_loc5_ < 0)
               {
                  throw new Error("Array.reduce failed, if array contains no values, no initial value to return.");
               }
            }
            _loc6_ = param1[_loc5_--];
         }
         while(_loc5_ >= 0)
         {
            if(_loc5_ in param1)
            {
               _loc6_ = param2.call(null,_loc6_,param1[_loc5_],_loc5_,param1);
            }
            _loc5_--;
         }
         return _loc6_;
      }
      
      public static function repeat(param1:Array, param2:uint = 0) : Array
      {
         var _loc4_:int = 0;
         var _loc3_:Array = [];
         if(param2 > 0)
         {
            while(_loc4_ < param2)
            {
               _loc3_ = _loc3_.concat(param1);
               _loc4_++;
            }
         }
         else
         {
            _loc3_ = [].concat(param1);
         }
         return _loc3_;
      }
      
      public static function spliceInto(param1:Array, param2:Array, param3:Number = 0, param4:Number = 0) : void
      {
         var inserted:Array = param1;
         var container:Array = param2;
         var containerPosition:Number = param3;
         var countReplaced:Number = param4;
         inserted.unshift(containerPosition,isNaN(countReplaced) ? 0 : countReplaced);
         try
         {
            container.splice.apply(container,inserted);
         }
         finally
         {
            inserted.splice(0,2);
         }
      }
   }
}
