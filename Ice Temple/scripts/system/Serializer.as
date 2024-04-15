package system
{
   public interface Serializer
   {
       
      
      function get prettyIndent() : int;
      
      function set prettyIndent(param1:int) : void;
      
      function get prettyPrinting() : Boolean;
      
      function set prettyPrinting(param1:Boolean) : void;
      
      function get indentor() : String;
      
      function set indentor(param1:String) : void;
      
      function serialize(param1:*) : String;
      
      function deserialize(param1:String) : *;
   }
}
