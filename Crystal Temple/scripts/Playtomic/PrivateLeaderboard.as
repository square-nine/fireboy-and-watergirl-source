package Playtomic
{
   public class PrivateLeaderboard
   {
       
      
      public var TableId:String;
      
      public var Name:String;
      
      public var Bitly:String;
      
      public var Permalink:String;
      
      public var Highest:Boolean = true;
      
      public var RealName:String;
      
      public function PrivateLeaderboard(param1:String = null, param2:String = null, param3:String = null, param4:String = null, param5:Boolean = false, param6:String = null)
      {
         super();
         this.TableId = param1;
         this.Name = param2;
         this.Bitly = param3;
         this.Permalink = param4;
         this.Highest = param5;
         this.RealName = param6;
      }
      
      public function toString() : String
      {
         return "Playtomic.PrivateLeaderboard:" + "\nTableId: " + this.TableId + "\nName: " + this.Name + "\nBitly: " + this.Bitly + "\nPermalink: " + this.Permalink + "\nHighest: " + this.Highest + "\nRealName: " + this.RealName;
      }
   }
}
