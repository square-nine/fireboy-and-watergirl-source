package system
{
   public class Configurator implements Serializable
   {
       
      
      protected var _config:Object;
      
      public function Configurator(param1:Object)
      {
         super();
         _config = {};
         load(param1);
      }
      
      public function load(param1:Object) : void
      {
         var _loc2_:String = null;
         for(_loc2_ in param1)
         {
            _config[_loc2_] = param1[_loc2_];
         }
      }
      
      public function toSource(param1:int = 0) : String
      {
         config.serializer.prettyIndent = param1;
         return config.serializer.serialize(_config);
      }
      
      public function toString() : String
      {
         return toSource();
      }
   }
}
