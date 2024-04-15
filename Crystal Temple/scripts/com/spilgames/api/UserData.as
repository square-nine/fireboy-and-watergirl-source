package com.spilgames.api
{
   public class UserData
   {
       
      
      private var _id:uint;
      
      private var _username:String = "";
      
      private var _avatar:int;
      
      private var _ratings:uint;
      
      private var _average_rating:Number;
      
      private var _title:String = "";
      
      private var _description:String = "";
      
      private var _created:uint;
      
      private var _hasData:Boolean;
      
      private var _hasPreview:Boolean;
      
      private var _hasRendering:Boolean;
      
      public function UserData(param1:XML)
      {
         super();
         this.readXML(param1);
      }
      
      public function get id() : uint
      {
         return this._id;
      }
      
      public function get username() : String
      {
         return this._username;
      }
      
      public function get avatar() : int
      {
         return this._avatar;
      }
      
      public function get ratings() : uint
      {
         return this._ratings;
      }
      
      public function get average_rating() : Number
      {
         return this._average_rating;
      }
      
      public function get title() : String
      {
         return this._title;
      }
      
      public function get description() : String
      {
         return this._description;
      }
      
      public function get created() : uint
      {
         return this._created;
      }
      
      public function get hasData() : Boolean
      {
         return this._hasData;
      }
      
      public function get hasPreview() : Boolean
      {
         return this._hasPreview;
      }
      
      public function get hasRendering() : Boolean
      {
         return this._hasRendering;
      }
      
      private function readXML(param1:XML) : void
      {
         this._id = int((param1.id || "").toString());
         this._username = (param1.username || "").toString();
         this._avatar = int((param1.avatar || "").toString()) || -1;
         this._ratings = int((param1.ratings || "").toString());
         this._average_rating = Number((param1.average_rating || "").toString());
         this._title = (param1.title || "").toString();
         this._description = (param1.description || "").toString();
         this._created = int((param1.created || "").toString());
         this._hasData = uint((param1.data || "").toString()) > 0;
         this._hasPreview = uint((param1.preview || "").toString()) > 0;
         this._hasRendering = uint((param1.rendering || "").toString()) > 0;
      }
   }
}
