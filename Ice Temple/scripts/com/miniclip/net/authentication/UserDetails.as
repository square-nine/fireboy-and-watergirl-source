package com.miniclip.net.authentication
{
   public class UserDetails
   {
       
      
      protected var _id:uint;
      
      protected var _sessionid:String;
      
      protected var _email:String;
      
      protected var _nickname:String;
      
      protected var _location:String;
      
      protected var _avatar:Boolean;
      
      protected var _worldRank:Number;
      
      protected var _starRank:Number;
      
      protected var _challenges:Number;
      
      protected var _friends:Number;
      
      protected var _playerPageURL:String;
      
      protected var _playerAvatarURL:String;
      
      public function UserDetails(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            _id = uint(param1.id);
            _sessionid = param1.sid;
            _email = param1.email;
            _nickname = param1.nickname;
            _location = param1.location;
            _worldRank = param1.worldRank;
            _starRank = param1.starRank;
            _challenges = param1.challenges;
            _friends = param1.friends;
            _playerPageURL = param1.playerPageURL;
            _playerAvatarURL = param1.playerAvatarURL;
            if(param1.avatar)
            {
               _avatar = param1.avatar;
            }
            if(param1.avatarCode)
            {
               _avatar = param1.avatarCode > 0;
            }
         }
      }
      
      public function serialize() : Object
      {
         var _loc1_:Object = new Object();
         _loc1_.id = _id;
         _loc1_.sessionid = _sessionid;
         _loc1_.email = _email;
         _loc1_.nickname = _nickname;
         _loc1_.location = _location;
         _loc1_.avatar = _avatar;
         _loc1_.worldRank = _worldRank;
         _loc1_.starRank = _starRank;
         _loc1_.challenges = _challenges;
         _loc1_.friends = _friends;
         _loc1_.playerPageURL = _playerPageURL;
         _loc1_.playerAvatarURL = _playerAvatarURL;
         return _loc1_;
      }
      
      public function get id() : uint
      {
         return _id;
      }
      
      public function get sessionid() : String
      {
         return _sessionid;
      }
      
      public function get email() : String
      {
         return _email;
      }
      
      public function get nickname() : String
      {
         return _nickname;
      }
      
      public function get location() : String
      {
         return _location;
      }
      
      public function get avatar() : Boolean
      {
         return _avatar;
      }
      
      public function get worldRank() : Number
      {
         return _worldRank;
      }
      
      public function get starRank() : Number
      {
         return _starRank;
      }
      
      public function get challenges() : Number
      {
         return _challenges;
      }
      
      public function get friends() : Number
      {
         return _friends;
      }
      
      public function get playerPageURL() : String
      {
         return _playerPageURL;
      }
      
      public function get playerAvatarURL() : String
      {
         return _playerAvatarURL;
      }
      
      public function set avatar(param1:Boolean) : void
      {
         _avatar = param1;
      }
      
      public function toString() : String
      {
         return "[ UserDetails: " + "    nickname: " + _nickname + " ]";
      }
   }
}
