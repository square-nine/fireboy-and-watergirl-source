package Playtomic
{
   internal final class LogRequest
   {
      
      private static var Pool:Array = new Array();
       
      
      private var _data:String = "";
      
      private var _hasView:Boolean = false;
      
      private var _hasPlay:Boolean = false;
      
      internal var ready:Boolean = false;
      
      public function LogRequest()
      {
         super();
      }
      
      internal static function Create() : LogRequest
      {
         var _loc1_:LogRequest = Pool.length > 0 ? Pool.pop() as LogRequest : new LogRequest();
         _loc1_._data = "";
         _loc1_._hasView = false;
         _loc1_._hasPlay = false;
         _loc1_.ready = false;
         return _loc1_;
      }
      
      internal function MassQueue(param1:Array) : void
      {
         var _loc3_:LogRequest = null;
         var _loc2_:int = int(param1.length - 1);
         while(_loc2_ > -1)
         {
            this.Queue(param1[_loc2_]);
            param1.splice(_loc2_,1);
            if(this.ready)
            {
               this.Send();
               _loc3_ = Create();
               _loc3_.MassQueue(param1);
               return;
            }
            _loc2_--;
         }
         Log.LogQueue = this;
      }
      
      internal function Queue(param1:String) : void
      {
         this._data += (this._data == "" ? "" : "~") + param1;
         if(this._data.indexOf("v/") > -1)
         {
            this._hasView = true;
         }
         if(this._data.indexOf("p/") > -1)
         {
            this._hasPlay = true;
         }
         if(this._data.length > 300)
         {
            this.ready = true;
         }
      }
      
      public function Send() : void
      {
         if(this._data == "")
         {
            return;
         }
         PRequest.SendStatistics(this.Complete,"/tracker/q.aspx?q=" + this._data + "&url=" + (this._hasView ? Log.SourceUrl : Log.BaseUrl));
      }
      
      private function Complete(param1:Boolean) : void
      {
         if(param1)
         {
            if(this._hasView)
            {
               Log.IncreaseViews();
            }
            if(this._hasPlay)
            {
               Log.IncreasePlays();
            }
         }
         Pool.push(this);
      }
   }
}
