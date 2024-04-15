package system
{
   public class SystemConfigurator extends Configurator
   {
       
      
      public function SystemConfigurator(param1:Object)
      {
         super(param1);
      }
      
      public function get verbose() : Boolean
      {
         return _config.verbose;
      }
      
      public function set verbose(param1:Boolean) : void
      {
         _config.verbose = param1;
      }
      
      public function get serializer() : Serializer
      {
         return _config.serializer;
      }
      
      public function set serializer(param1:Serializer) : void
      {
         _config.serializer = param1;
      }
   }
}
