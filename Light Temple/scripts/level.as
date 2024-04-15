package
{
   import Box2D.*;
   import Box2D.Collision.*;
   import Box2D.Collision.Shapes.*;
   import Box2D.Common.*;
   import Box2D.Common.Math.*;
   import Box2D.Dynamics.*;
   import Box2D.Dynamics.Contacts.*;
   import Box2D.Dynamics.Joints.*;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.*;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.geom.*;
   import flash.media.SoundChannel;
   import flash.ui.*;
   
   [Embed(source="/_assets/assets.swf", symbol="level")]
   public class level extends Sprite
   {
       
      
      internal var Tuting1:Boolean;
      
      internal var Tuting2:Boolean;
      
      internal var tutlayer:*;
      
      public var pause:Boolean;
      
      public var ended:Boolean;
      
      internal var teta:Number;
      
      internal var r_pressed:Boolean;
      
      internal var l_pressed:Boolean;
      
      internal var u_pressed:Boolean;
      
      internal var r_pressed2:Boolean;
      
      internal var l_pressed2:Boolean;
      
      internal var u_pressed2:Boolean;
      
      internal var currentpers:Number;
      
      internal var allowjump1:Boolean;
      
      internal var allowjump2:Boolean;
      
      internal var prohibjump1:Boolean;
      
      internal var prohibjump2:Boolean;
      
      public var m_world:b2World;
      
      public var m_lworld:b2World;
      
      public var m_iterations:int = 50;
      
      public var m_timeStep:Number = 0.038461538461538464;
      
      public var world_aa:Number = 5;
      
      public var world_bb:Number = 40;
      
      public var LightSpeed:* = 190;
      
      internal var myActuateds:*;
      
      internal var myActuateds2:*;
      
      internal var myActuateds3:*;
      
      internal var myActuateds4:*;
      
      internal var myJumpers:*;
      
      internal var mySliders:*;
      
      internal var myLevers:*;
      
      internal var myPushers:*;
      
      internal var myMirrorSliders:*;
      
      internal var myLightPushers:*;
      
      internal var myWinds:*;
      
      internal var timecount:* = 0;
      
      internal var myContactListener:ContactListener;
      
      internal var myContactListenerBullet:ContactListenerBullet;
      
      internal var m_physScale:Number = 1;
      
      internal var pers1:b2Body;
      
      internal var pers2:b2Body;
      
      internal var LevelArray:Array;
      
      internal var FiresandWaters:Sprite;
      
      internal var DiamondsandRopes:Sprite;
      
      internal var CharsLayer:Sprite;
      
      internal var SlidersAndRots:Sprite;
      
      internal var GroundLayer:*;
      
      internal var MaskLayer:*;
      
      internal var BkgLayer:*;
      
      internal var LightBoard:*;
      
      internal var CurrentLevel:Number;
      
      internal var CurrentMode:String;
      
      internal var StartPosFire:b2Vec2;
      
      internal var StartPosWater:b2Vec2;
      
      internal var J1:Jump1_Sound;
      
      internal var J2:Jump2_Sound;
      
      internal var LeverSound:Lever_Sound;
      
      internal var PusherSound:Pusher_Sound;
      
      internal var LPusherSound:LPusher_Sound;
      
      internal var PlatformSound:Platform_Sound;
      
      internal var DoorSound:Door_Sound;
      
      internal var WindSound:Wind_Sound;
      
      internal var ClickSound:Click_Sound;
      
      internal var clickPlaying:Boolean = false;
      
      internal var InfiniteChannel:SoundChannel;
      
      internal var myChannels:Array;
      
      internal var myChannels2:Array;
      
      internal var myChannels3:Array;
      
      internal var windChannels:Array;
      
      internal var DoorChannel:SoundChannel;
      
      internal var DoorChannel2:SoundChannel;
      
      internal var DiamondSound:Diamond_Sound;
      
      internal var BDcount:Number;
      
      internal var RDcount:Number;
      
      public function level(param1:String, param2:Number)
      {
         this.myActuateds = new Array();
         this.myActuateds2 = new Array();
         this.myActuateds3 = new Array();
         this.myActuateds4 = new Array();
         this.myJumpers = new Array();
         this.mySliders = new Array();
         this.myLevers = new Array();
         this.myPushers = new Array();
         this.myMirrorSliders = new Array();
         this.myLightPushers = new Array();
         this.myWinds = new Array();
         super();
         this.RDcount = 0;
         this.BDcount = 0;
         this.CurrentLevel = param2;
         this.CurrentMode = param1;
         this.teta = 0;
         this.pause = false;
         this.ended = false;
         this.r_pressed = false;
         this.l_pressed = false;
         this.u_pressed = false;
         this.r_pressed2 = false;
         this.l_pressed2 = false;
         this.u_pressed2 = false;
         this.currentpers = 1;
         this.J1 = new Jump1_Sound();
         this.J2 = new Jump2_Sound();
         this.LeverSound = new Lever_Sound();
         this.PusherSound = new Pusher_Sound();
         this.LPusherSound = new LPusher_Sound();
         this.PlatformSound = new Platform_Sound();
         this.WindSound = new Wind_Sound();
         this.DoorSound = new Door_Sound();
         this.DiamondSound = new Diamond_Sound();
         this.ClickSound = new Click_Sound();
         this.DoorChannel = new SoundChannel();
         this.DoorChannel2 = new SoundChannel();
         this.InfiniteChannel = new SoundChannel();
         this.myChannels = new Array();
         this.myChannels2 = new Array();
         this.myChannels3 = new Array();
         this.windChannels = new Array();
         var _loc3_:b2AABB = new b2AABB();
         _loc3_.lowerBound.Set(-this.world_aa,-this.world_aa);
         _loc3_.upperBound.Set(this.world_bb,this.world_bb);
         var _loc4_:b2Vec2 = new b2Vec2(0,26);
         this.m_world = new b2World(_loc3_,_loc4_,true);
         _loc4_ = new b2Vec2(0,0);
         this.m_lworld = new b2World(_loc3_,_loc4_,true);
         this.myContactListener = new ContactListener();
         this.myContactListener.finish1 = -1;
         this.myContactListener.finish2 = -1;
         this.m_world.SetContactListener(this.myContactListener);
         this.myContactListenerBullet = new ContactListenerBullet();
         this.m_lworld.SetContactListener(this.myContactListenerBullet);
         this.BkgLayer = new BackGround();
         this.BkgLayer.scaleX /= 0.8;
         this.BkgLayer.scaleY /= 0.8;
         this.BkgLayer.x -= 16;
         this.BkgLayer.y -= 16;
         this.SlidersAndRots = new Sprite();
         this.LightBoard = new Sprite();
         this.CharsLayer = new Sprite();
         addChild(this.BkgLayer);
         this.GroundLayer = new Sprite();
         if(param1 == "puzzle")
         {
            if(param2 == 7)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,1,-1,0,0,0,0,0,-2,1,-1,0,0,0,0,-3,1,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,-2,1,1,1,-1,0,0,0,0,-3,-1,0,0,0,0,0,0,-3,1,1,1,-1,0,-3,0,0,-2,1,1,-1,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,-3,1,1,1,-1,0,-3,1,1,1,1,1,-1,0,0,0,0,1,-1,0,-1,0,-3,1,1,1,1,1,-1,0,1),new Array(1,0,0,0,0,0,0,0,0,1,1,1,1,-1,0,0,0,0,-3,1,1,1,1,-4,0,1,1,0,1,-1,0,0,0,0,-3,1,1,0,1),new Array(1,-1,0,0,-2,0,0,0,0,0,0,0,-3,1,1,1,1,-1,0,1,0,1,-4,0,0,1,1,0,1,-3,1,1,1,-1,0,1,1,0,1),new Array(1,0,0,0,1,0,0,0,0,0,0,0,0,1,-4,0,-3,1,0,-3,1,-4,0,0,-2,1,1,0,1,0,0,0,0,1,0,1,1,0,1),new Array(1,0,0,0,1,0,0,0,0,0,"gr",0,0,1,0,0,0,-3,-1,0,-3,0,0,-2,-4,0,1,0,-3,-1,0,0,-2,-4,0,1,1,0,1),new Array(1,0,0,-2,1,1,-1,0,0,0,0,0,0,1,0,0,0,0,1,-1,0,0,-2,1,0,0,-3,-1,0,-3,1,1,-4,0,-2,1,-4,0,1),new Array(1,0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,-2,1,-4,0,0,-3,1,0,0,0,1,-1,0,0,0,0,-2,1,-4,0,0,1),new Array(1,0,0,0,-3,1,1,1,-4,0,0,0,0,1,0,0,-2,1,-4,0,0,0,0,-3,1,1,1,1,1,-1,0,0,-2,1,-4,0,0,-2,1),new Array(1,-1,0,0,0,0,0,0,0,0,0,0,0,1,0,-2,1,-4,0,0,-2,-1,0,0,0,-3,1,1,1,-4,0,0,-3,-4,0,0,-2,-4,1),new Array(1,1,0,0,0,0,0,0,0,0,0,0,0,1,0,1,-4,0,0,-2,-4,-3,-1,0,0,0,0,-3,1,0,0,0,0,0,0,-2,-4,0,1),new Array(1,1,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,-2,1,1,0,0,1,0,0,-1,0,0,1,0,-2,-1,0,0,-2,-4,0,0,1),new Array(1,1,61,6,6,6,6,62,1,1,1,1,1,1,0,1,0,1,0,0,0,-2,-4,0,0,1,0,0,-4,0,1,-4,0,0,1,0,0,0,1),new Array(1,-4,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,-3,0,0,0,1,0,0,0,1,1,-4,0,-2,-4,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,0,0,0,0,1,0,1,1,1,-1,0,0,0,0,0,0,0,0,1,-4,0,-2,-4,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,1),new Array(1,0,0,0,0,0,1,0,0,0,0,1,1,-4,0,0,0,0,0,0,0,1,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,0,0,0,1,-1,0,0,1,-4,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,-2,-4,0,0,1,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,-2,1,1,1,0,0,0,0,1,1,-4,0,0,0,1,0,0,-2,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,0,0,0,0,0,0,0,1,-4,0,0,0,0,-3,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,1,0,0,0,-2,1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,1,0,0,-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(7,4);
               this.StartPosWater = new b2Vec2(12,3);
               this.CreateFinish(new b2Vec2(26.2,26.5),new b2Vec2(32,26.5));
               this.CreateSlidePlatform(new b2Vec2(4,7),1.5,0.5,new b2Vec2(1,0),-3,0,0,"pusher",6);
               this.CreatePusher(new b2Vec2(26.5,17),2,6,true);
               this.CreateSlidePlatform(new b2Vec2(22.5,8),0.5,2,new b2Vec2(-1,0),-4,0,0,"lever",2);
               this.CreateLever(new b2Vec2(10,16),2,"l","r",true);
               this.CreateSlidePlatform(new b2Vec2(28.5,10),0.5,2,new b2Vec2(1,0),-4,0,0,"lever",2);
               this.CreateLever(new b2Vec2(10,16),2,"l","r",false);
               this.CreateSlidePlatform(new b2Vec2(19,17),0.5,1.5,new b2Vec2(0,1),-4,0,0,"pusher",4);
               this.CreatePusher(new b2Vec2(18.5,24),2,4,true);
               this.CreateSlidePlatform(new b2Vec2(34,19),1.5,0.5,new b2Vec2(0,1),-2,0,0,"pusher",4);
               this.CreatePusher(new b2Vec2(18.5,24),2,4,false);
               this.CreateSlidePlatform(new b2Vec2(26.5,21),0.5,2,new b2Vec2(-1,0),-3,0,0,"pusher",5);
               this.CreatePusher(new b2Vec2(23.5,22),2,5,true);
               this.CreateSlidePlatform(new b2Vec2(20,16),0.5,1.5,new b2Vec2(1,0),-3,0,0,"pusher",3);
               this.CreatePusher(new b2Vec2(1.5,24),2,3,true);
               this.CreateSlidePlatform(new b2Vec2(8.5,19),0.5,2,new b2Vec2(0,1),-5,0,0,"pusher",1);
               this.CreatePusher(new b2Vec2(4.5,27),2,1,true);
               this.CreateBall(new b2Vec2(10,5));
               this.CreateBall(new b2Vec2(17,5));
               this.CreateBall(new b2Vec2(23,4));
               this.CreateBall(new b2Vec2(27,3));
               this.CreateBall(new b2Vec2(34,5));
            }
            if(param2 == 4)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-4,0,0,0,0,0,0,0,0,0,0,0,-3,1,1),new Array(1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1),new Array(1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,1,-1,0,0,0,0,0,0,0,1),new Array(1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,0,0,0,0,0,-2,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,0,-2,1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,1,1,-1,0,0,0,0,0,1),new Array(1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,1,1,1,1,1,0,-2,-4,0,0,0,0,0,0,0,0,0,1),new Array(1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,-3,1,-4,0,0,1,-2,-4,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,0,0,0,0,0,-2,1,1,1,1,0,0,0,0,0,1,-1,0,0,0,0,0,-2,1,-4,0,0,0,0,0,0,-2,1,1,1,1,1),new Array(1,1,0,-2,1,1,1,1,1,1,1,1,0,0,0,0,0,1,-4,0,0,0,0,0,-3,1,0,0,0,0,0,0,-2,-4,0,0,0,0,1),new Array(1,1,0,1,1,1,1,1,1,1,1,1,0,0,0,0,0,1,0,0,-2,1,-1,0,0,1,0,0,0,0,0,-2,1,0,0,0,0,0,1),new Array(1,1,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,1,1,1,1,1,1,1,1,-4,0,0,0,0,-2,1,1,0,0,0,0,0,1),new Array(1,1,0,1,0,0,0,0,0,0,0,1,1,1,-1,0,-2,1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,0,-3,0,0,0,1,0,0,0,1,-4,0,-3,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,-1,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,-2,1,1,51,5,5,5,5,5,52,0,0,1),new Array(1,-4,-3,-1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,1,1,0,0,0,0,0,-2,-4,0,-3,1,1,1,1,1,1,-4,0,0,1),new Array(1,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,-3,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,0,0,-2,1),new Array(1,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1),new Array(1,0,0,1,0,0,0,1,0,0,0,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1),new Array(1,-1,-2,1,0,0,0,1,0,0,0,0,0,-3,-1,0,0,51,5,5,5,5,52,1,1,0,0,0,0,-2,0,0,0,-2,1,-1,0,0,1),new Array(1,1,1,1,0,0,0,1,0,0,0,0,0,0,-3,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,-2,1,1,0,0,0,1),new Array(1,-4,0,-3,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,1,1,0,0,0,1),new Array(1,0,0,0,0,0,0,-3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,-4,0,0,0,-2,1),new Array(1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,1,1),new Array(1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,"gr",0,-2,1,1),new Array(1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,-1,0,0,0,1,-1,0,-2,1,0,0,0,0,0,0,0,1,-1,0,0,1,1,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(27.5,14);
               this.StartPosWater = new b2Vec2(17,23);
               this.CreateFinish(new b2Vec2(26.2,26.5),new b2Vec2(29.8,26.5));
               this.CreateSlidePlatform(new b2Vec2(14,4),0.5,1.5,new b2Vec2(1,0),-3,0,0,"pusher",3);
               this.CreatePusher(new b2Vec2(35,8),2,3,true);
               this.CreateSlidePlatform(new b2Vec2(13.5,11),0.5,2,new b2Vec2(0,-1),-3,0,0,"pusher",3);
               this.CreatePusher(new b2Vec2(35,8),2,3,false);
               this.CreateSlidePlatform(new b2Vec2(31,21),0.5,1.5,new b2Vec2(-1,0),-3,0,0,"pusher",4);
               this.CreatePusher(new b2Vec2(5,21),2,4,true);
               this.CreateSlidePlatform(new b2Vec2(36,23),0.5,1.5,new b2Vec2(-1,0),-3,0,0,"pusher",2);
               this.CreatePusher(new b2Vec2(22,27),2,2,true);
               this.CreateBall(new b2Vec2(26,2));
               this.CreateBall(new b2Vec2(26,5));
               this.CreateBall(new b2Vec2(4,26));
               this.CreatePulley(new b2Vec2(5,13),new b2Vec2(9,13),new b2Vec2(0.2,1.3),new b2Vec2(0.2,1.3),new b2Vec2(5,17),new b2Vec2(9,27.3));
            }
            if(param2 == 8)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,-1,0,0,1,0,0,0,-2,1,1,1,1,1,1,1,1,0,0,0,0,0,-3,1,1,1,1,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,0,0,-2,-4,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,-4,0,0,0,0,1,1,1,0,0,0,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,-3,1,1,1,1,51,5,5,5,52,-1,0,0,0,0,1,0,0,0,0,-2,1,1,-4,0,-3,1,1,-1,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,-3,1,-1,0,0,0,1,0,0,0,-2,1,1,-4,0,0,0,1,1,1,-1,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,0,0,0,0,1),new Array(1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,-1,0,0,1),new Array(1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,0,0,1),new Array(1,1,1,1,1,1,61,6,6,6,6,62,1,1,0,0,0,1,1,1,1,1,0,0,0,0,0,-2,1,1,1,0,0,0,-3,1,-1,0,1),new Array(1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,-3,1,1,1,-1,0,0,0,0,0,0,1),new Array(1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,1,1,1,-1,0,0,0,0,1,1,1,0,0,0,0,0,0,1),new Array(1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,0,0,0,1,1,1,-1,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,-2,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,1,1),new Array(1,0,0,0,0,-2,1,1,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,0,0,0,0,0,0,1,1),new Array(1,0,0,0,-2,-4,0,0,0,0,0,-3,1,1,1,1,1,1,1,-1,0,0,0,-2,1,1,1,1,1,1,-4,0,0,0,0,0,0,1,1),new Array(1,0,0,0,-4,0,0,0,0,0,0,0,-3,1,1,0,0,0,0,0,0,0,-2,-4,0,0,-3,1,1,1,0,0,0,0,0,-2,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,0,0,0,0,0,0,-2,-4,0,0,0,0,-3,1,1,0,0,0,0,0,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,-2,-4,0,0,0,0,0,0,-3,1,0,0,0,0,0,1,1,1,1),new Array(1,1,61,6,6,6,62,1,-1,0,0,0,0,0,1,0,0,0,0,-2,-4,0,0,0,0,"gr",0,0,0,-3,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,-3,-1,0,0,0,0,1,0,0,0,-2,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,0,0,0,0,0,0,0,-2,51,5,5,5,52,-1,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,-1,0,0,0,0,0,-2,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(23,13);
               this.StartPosWater = new b2Vec2(17,18);
               this.CreateFinish(new b2Vec2(33,4.5),new b2Vec2(36,4.5));
               this.CreateSlidePlatform(new b2Vec2(16,9),0.5,1.5,new b2Vec2(1,0),-4,0,0,"pusher",1);
               this.CreatePusher(new b2Vec2(1.5,3),2,1,true);
               this.CreateSlidePlatform(new b2Vec2(13,11),1.5,0.5,new b2Vec2(0,1),-4,0,0,"pusher",3);
               this.CreatePusher(new b2Vec2(25.5,3),2,3,true);
               this.CreateSlidePlatform(new b2Vec2(21,20),0.5,1.5,new b2Vec2(-1,0),-3,0,0,"lever",2);
               this.CreateLever(new b2Vec2(14,3),2,"l","r",true);
               this.CreateSlidePlatform(new b2Vec2(29,11),1.5,0.5,new b2Vec2(0,1),-3,0,0,"lever",4);
               this.CreateLever(new b2Vec2(3,27),4,"l","r",true);
               this.CreateSlidePlatform(new b2Vec2(36,17),0.5,1.5,new b2Vec2(0,-1),-3,0,0,"lever",5);
               this.CreateLever(new b2Vec2(34,27),5,"l","r",true);
               this.CreateSlidePlatform(new b2Vec2(30,6),0.5,1.5,new b2Vec2(1,0),-5,0,0,"lever",6);
               this.CreateLever(new b2Vec2(32,22),6,"l","r",true);
            }
            if(param2 == 10)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,1,1,1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,1,1,-4,0,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,1,-4,0,-2,-4,0,0,0,0,-2,1,1,1,1,0,0,-2,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,-4,0,-2,-4,0,0,0,0,-2,-4,0,0,0,1,0,0,0,0,-3,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,0,-2,-4,0,0,0,-2,1,-4,0,0,0,0,1,0,0,0,0,0,-3,1,-1,0,0,0,-2,1,1,1,1,1,1,1,1,1,0,0,1),new Array(1,0,1,0,0,0,-2,-4,0,0,0,0,0,0,-3,-1,0,0,0,0,0,0,-3,61,6,62,1,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,0,1,0,0,-2,-4,0,0,0,0,0,0,0,0,-3,1,1,1,-1,0,0,0,1,1,-4,0,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,0,0,1,-4,0,0,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-4,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,0,1,51,5,5,5,5,52,1,1,-1,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,-2,1,1,1,1,1,1,1,1,0,0,1),new Array(1,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,-2,-4,0,0,-2,-4,0,0,0,0,0,0,0,1,0,0,1),new Array(1,0,-3,1,1,1,1,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,-2,-4,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,-1,0,0,-3,1,1,0,0,0,-2,-4,0,0,-2,1,-4,0,0,-3,-1,0,0,0,-2,-4,0,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,1,1,-1,0,1,1,0,0,-2,-4,0,0,0,0,0,0,0,0,0,-3,1,1,1,-4,0,0,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,1,1,-4,0,1,1,0,-2,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,1),new Array(1,-4,0,0,-2,1,1,1,-4,0,0,0,-2,1,61,6,6,62,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,0,0,-2,1,0,0,0,0,0,0,-2,-4,0,0,0,1,1,1,1,1,0,0,0,1,1,-1,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,-1,0,-3,1,0,0,0,0,0,-2,-4,0,0,0,0,1,0,0,0,0,0,0,0,0,0,-3,-1,0,0,0,0,0,0,0,1,0,0,1),new Array(1,1,-1,0,1,0,0,0,0,-2,-4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,1,-4,0,1,0,0,0,-2,-4,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,-4,0,-2,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,-2,1,1,1,1,1,1,1,1,1,1,1,0,0,1),new Array(1,0,-2,1,1,-1,0,0,0,0,0,0,0,0,0,0,-3,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,0,0,-3,1,1,1,1,-1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,-1,0,0,1,0,0,0,-3,1,1,1,1,1,0,0,0,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,1,0,0,1,0,0,0,0,-3,1,1,1,1,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,1,0,0,1,0,"gr",0,0,0,0,0,0,0,0,0,-2,-4,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,-2,-4,0,0,0,1,1,1,51,5,5,52,-1,0,0,0,0,0,0,0,1,0,0,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(10,23);
               this.StartPosWater = new b2Vec2(13,23);
               this.CreateFinish(new b2Vec2(29.5,26.5),new b2Vec2(32.5,26.5));
               this.CreateSlidePlatform(new b2Vec2(36,5),0.5,1.5,new b2Vec2(-1,0),-3,0,0,"pusher",1);
               this.CreatePusher(new b2Vec2(29.5,4),2,1,true);
               this.CreateSlidePlatform(new b2Vec2(36,10),0.5,1.5,new b2Vec2(-1,0),-3,0,0,"pusher",2);
               this.CreatePusher(new b2Vec2(29.5,9),2,2,true);
               this.CreateSlidePlatform(new b2Vec2(36,15),0.5,1.5,new b2Vec2(-1,0),-3,0,0,"pusher",3);
               this.CreatePusher(new b2Vec2(29.5,14),2,3,true);
               this.CreateSlidePlatform(new b2Vec2(36,21),0.5,1.5,new b2Vec2(-1,0),-3,0,0,"pusher",4);
               this.CreatePusher(new b2Vec2(29.5,20),2,4,true);
               this.CreateSlidePlatform(new b2Vec2(4,2),0.5,1.5,new b2Vec2(-1,0),-3,0,0,"pusher",5);
               this.CreatePusher(new b2Vec2(36.5,27),2,5,true);
               this.CreateSlidePlatform(new b2Vec2(15,24),0.5,1.5,new b2Vec2(-1,0),-3,0,0,"pusher",5);
               this.CreatePusher(new b2Vec2(36.5,27),2,5,false);
               this.CreateSlidePlatform(new b2Vec2(22,17),0.5,1.5,new b2Vec2(-1,0),-3,0,0,"pusher",5);
               this.CreatePusher(new b2Vec2(36.5,27),2,5,false);
               this.CreateSlidePlatform(new b2Vec2(18,25),0.5,1.5,new b2Vec2(-1,0),-3,0,0,"pusher",6);
               this.CreatePusher(new b2Vec2(2.5,26),2,6,true);
               this.CreateMovingBox(new b2Vec2(35.5,4),new b2Vec2(0.95,0.95));
               this.CreateBall(new b2Vec2(4,1));
            }
            if(param2 == 2)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,-3,1,1,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,-3,1,1),new Array(1,0,0,0,0,0,1,0,0,-2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,0,0,0,0,0,0,0,-3,1),new Array(1,0,0,0,0,0,1,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,0,0,1,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,0,0,1,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,0,0,1,0,1,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,-4,0,0,1),new Array(1,0,0,0,0,0,1,0,0,1,0,1,0,0,1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,-4,0,0,0,1),new Array(1,0,0,0,0,0,1,0,0,1,0,1,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,-2,1),new Array(1,0,0,0,0,0,1,0,0,1,0,1,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,-2,1,1),new Array(1,0,0,0,0,0,1,0,0,1,0,1,0,0,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,1,1),new Array(1,1,1,1,1,1,1,0,0,1,1,1,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,0,0,1,-4,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,-2,1,1,1,1,1,1,1,1,1,-1,0,0,0,0,-1,0,0,0,1,1,1,1,1,1,1,0,0,0,1,1,1,1,-1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,-1,0,0,0,1,-1,0,0,1,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,"gr",0,0,1),new Array(1,-1,0,-2,1,1,1,1,1,1,1,-1,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,1,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,-3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1),new Array(1,0,0,0,0,1,0,1,0,0,0,1,0,0,0,0,0,0,1,-1,0,0,0,0,0,0,0,-2,1,1,1,1,1,1,-1,0,0,0,1),new Array(1,0,0,0,0,1,0,1,0,0,0,1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,-3,-1,0,0,1),new Array(1,1,1,1,0,1,0,1,0,0,0,1,1,1,1,0,0,0,-3,1,0,0,0,1,1,1,1,-4,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,1,0,1,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,1,1,1,0,1,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,1,0,1,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,1,1,1,1,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(32,6);
               this.StartPosWater = new b2Vec2(27,13);
               this.CreateFinish(new b2Vec2(5,18.5),new b2Vec2(8,18.5));
               this.CreateLightBeamer(new b2Vec2(37,13.5),Math.PI,16777113);
               this.CreateSlidePlatform(new b2Vec2(36,7),0.5,1.5,new b2Vec2(-1,0),-3,0,0,"lpusher",6);
               this.CreateLightPusher(new b2Vec2(1,13.5),Math.PI / 2,16777113,true);
               this.CreateSlidePlatform(new b2Vec2(31,15),0.5,1.5,new b2Vec2(-1,0),-3,0,0,"lpusher",6);
               this.CreateLightPusher(new b2Vec2(12.5,5),Math.PI,16777113,true);
               this.CreateSlidePlatform(new b2Vec2(21,24),0.5,1.5,new b2Vec2(1,0),-3,0,0,"lpusher",6);
               this.CreateLightPusher(new b2Vec2(27.5,6),0,16777113,true);
               this.CreateRotMirror(new b2Vec2(7.5,1.5),0,0,1);
               this.CreateLever(new b2Vec2(29,21),1,"r","l",true);
               this.CreateRotMirror(new b2Vec2(27.5,1.5),Math.PI / 4,0,2);
               this.CreateLever(new b2Vec2(25,23),2,"r","l",true);
               this.CreateSlidePlatform(new b2Vec2(12.5,11),0.5,1,new b2Vec2(1,0),-2,0,0,"lever",3);
               this.CreateLever(new b2Vec2(23,11),3,"l","r",true);
               this.CreateMovingMirror(new b2Vec2(12.5,8),new b2Vec2(0.95,0.95),0);
               this.CreateSlidePlatform(new b2Vec2(31,12),0.5,1.5,new b2Vec2(-1,0),-3,0,0,"pusher",4);
               this.CreatePusher(new b2Vec2(17,16),2,4,true);
               this.CreateSlidePlatform(new b2Vec2(13,20),0.5,1.5,new b2Vec2(0,1),-3,0,0,"lever",5);
               this.CreateLever(new b2Vec2(26,27),5,"l","r",true);
            }
            if(param2 == 1)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,-2,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,1,1,1,1,1,-1,0,0,0,-2,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,"gr",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1),new Array(1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1),new Array(1,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,-3,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,1),new Array(1,0,0,0,0,1,-4,0,-3,1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,-3,-1,0,-2,-4,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,-2,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,-2,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,1,0,1,0,0,0,1,1,1,1,1,1),new Array(1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,-3,1,1,1,1,1),new Array(1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,-1,0,0,0,-3,1,1,1,1),new Array(1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,-3,1,1,1,-1,0,0,0,1,1),new Array(1,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,-3,1,1,0,0,0,1,1),new Array(1,1,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,0,0,-2,1,1,-1,0,0,1,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(12,16);
               this.StartPosWater = new b2Vec2(7,24);
               this.CreateFinish(new b2Vec2(2,4.5),new b2Vec2(5,4.5));
               this.CreateLightBeamer(new b2Vec2(25.5,18),Math.PI / 2,16777113);
               this.CreateSlidePlatform(new b2Vec2(7,3),1.5,0.5,new b2Vec2(0,-1),-3,0,0,"pusher",4);
               this.CreatePusher(new b2Vec2(35.5,27),2,4,true);
               this.CreateSlidePlatform(new b2Vec2(9,8),1.5,0.5,new b2Vec2(0,-1),-3,0,0,"lever",1);
               this.CreateLever(new b2Vec2(14,5),1,"l","r",true);
               this.CreateWind(new b2Vec2(1,14),new b2Vec2(3,23),1,1,"lever",true);
               this.CreateLever(new b2Vec2(14,5),1,"l","r",true);
               this.CreateSlidePlatform(new b2Vec2(36,6),0.5,1.5,new b2Vec2(-1,0),-3,0,0,"lpusher",6);
               this.CreateLightPusher(new b2Vec2(15.5,18),Math.PI,16777113,true);
               this.CreateSlidePlatform(new b2Vec2(31,22),0.5,1.5,new b2Vec2(1,0),-3,0,0,"pusher",5);
               this.CreatePusher(new b2Vec2(7,19),2,5,true);
               this.CreateBall(new b2Vec2(22,5));
               this.CreateBall(new b2Vec2(25,5));
               this.CreateMovingMirror(new b2Vec2(12,26),new b2Vec2(0.95,0.95),0);
               this.CreateMovingMirror(new b2Vec2(18.5,26),new b2Vec2(0.95,0.95),90);
               this.CreatRoman(new b2Vec2(22,17),3,14,"r");
            }
            if(param2 == 6)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,-4,0,0,0,0,0,0,0,0,-3,1,-4,0,0,0,0,0,0,0,-3,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,"gr",0,0,0,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1),new Array(1,0,0,0,-2,51,5,5,52,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,1,1,-4,0,0,0,1),new Array(1,0,0,0,1,1,1,-4,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,1,0,1,0,0,0,0,1),new Array(1,0,0,-2,-4,0,0,0,0,0,0,0,0,0,1,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,1,0,0,1,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,-3,1,-4,0,0,-2,1,1,1,0,1,1,0,0,0,0,1),new Array(1,0,0,0,0,0,-2,1,1,1,0,0,0,0,1,1,-1,0,0,0,0,0,0,0,0,0,-2,1,1,1,0,0,1,-4,0,0,0,0,1),new Array(1,-1,0,0,0,-2,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,0,1,-4,0,0,0,0,0,1),new Array(1,1,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,1,0,1,0,0,0,0,0,0,1),new Array(1,1,0,0,0,0,0,0,0,0,0,0,1,-1,0,0,0,0,0,-2,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,1),new Array(1,1,-1,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(17,27);
               this.StartPosWater = new b2Vec2(24,27);
               this.CreateFinish(new b2Vec2(19,5.5),new b2Vec2(22,5.5));
               this.CreateSlidePlatform(new b2Vec2(16,7),0.5,1.5,new b2Vec2(1,0),-3,0,0,"lever",1);
               this.CreateLever(new b2Vec2(11,4),1,"l","r",true);
               this.CreateSlidePlatform(new b2Vec2(36,10),0.5,1.5,new b2Vec2(-1,0),-3,0,0,"lever",1);
               this.CreateLever(new b2Vec2(11,4),1,"l","r",false);
               this.CreateSlidePlatform(new b2Vec2(26,8),0.5,1.5,new b2Vec2(1,0),-3,0,0,"lpusher",6);
               this.CreateLightPusher(new b2Vec2(36,5),Math.PI,16777113,true);
               this.CreateSlidePlatform(new b2Vec2(36,8),0.5,1.5,new b2Vec2(-1,0),-3,0,0,"pusher",4);
               this.CreatePusher(new b2Vec2(20.5,11),2,4,true);
               this.CreateSlidePlatform(new b2Vec2(2,6),0.5,1.5,new b2Vec2(1,0),-3,0,0,"lpusher",6);
               this.CreateLightPusher(new b2Vec2(20.5,27),0,16777113,true);
               this.CreateInfiniteMirror(new b2Vec2(10.5,15),0,0,2);
               this.CreateMirrorSlider(new b2Vec2(10,26.5),10,0,2,true);
               this.CreateInfiniteMirror(new b2Vec2(35,23),0,0,3);
               this.CreateMirrorSlider(new b2Vec2(30,26.5),10,Math.PI / 2,3,true);
               this.CreateLightBeamer(new b2Vec2(10.5,6),Math.PI / 2,16777113);
            }
            if(param2 == 5)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"gr",0,0,0,0,0,1),new Array(1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,-1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,1,1,1,0,0,0,0,0,0,0,1,0,0,0,1,1,0,0,0,0,0,0,0,-2,1,1,1,1,1,-1,0,0,0,0,1),new Array(1,0,0,0,1,1,1,0,0,0,0,0,0,0,1,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,1,1,1,0,0,0,0,0,0,0,1,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,1,1,1,0,0,0,1,-4,0,-3,1,0,0,0,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,1,1,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,1,1,-1,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,1,1,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,-1,0,0,0,0,1),new Array(1,0,0,0,1,1,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,1,1,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,1,1,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1),new Array(1,0,0,0,1,1,1,0,0,0,1,0,0,0,1,0,0,0,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,1,1,1,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,-1,0,0,0,0,1),new Array(1,0,0,0,1,1,1,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,1,1,1,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,-2,1,1,-1,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,0,0,0,0,0,0,0,-3,1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,-3,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,71,7,7,7,7,7,7,72,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,71,7,7,7,7,72,1,-4,0,0,-3,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,-2,61,6,6,6,6,62,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,-4,0,0,0,0,1,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,-2,1,1,-4,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,-2,1,0,0,0,1),new Array(1,0,0,1,1,1,1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,-4,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(11,26);
               this.StartPosWater = new b2Vec2(14,26);
               this.CreateFinish(new b2Vec2(25,26.5),new b2Vec2(31,23.5));
               this.CreatePulley(new b2Vec2(8,6),new b2Vec2(12,6),new b2Vec2(0.2,1.3),new b2Vec2(0.2,1.3),new b2Vec2(8,8),new b2Vec2(12,15));
               this.CreateMovingBox(new b2Vec2(8,6),new b2Vec2(0.95,0.95));
               this.CreateSlidePlatform(new b2Vec2(7,8.5),0.5,1,new b2Vec2(-1,0),-2,0,0,"lever",3);
               this.CreateLever(new b2Vec2(9,22),3,"l","r",true);
               this.CreatePulley(new b2Vec2(2,2),new b2Vec2(16,2),new b2Vec2(0.2,1.3),new b2Vec2(0.2,1.3),new b2Vec2(2,4),new b2Vec2(16,19));
               this.CreateMovingBox(new b2Vec2(2,3),new b2Vec2(0.95,0.95));
               this.CreateSlidePlatform(new b2Vec2(3,5),0.5,1,new b2Vec2(1,0),-2,0,0,"pusher",4);
               this.CreatePusher(new b2Vec2(8,14),2,4,true);
               this.CreateSlidePlatform(new b2Vec2(26,5),0.5,1.5,new b2Vec2(1,0),-3,0,0,"pusher",4);
               this.CreatePusher(new b2Vec2(8,14),2,4,false);
               this.CreateSlidePlatform(new b2Vec2(24,6),1.5,0.5,new b2Vec2(-1,0),-4,0,0,"pusher",4);
               this.CreatePusher(new b2Vec2(8,14),2,4,false);
               this.CreateSlidePlatform(new b2Vec2(20,26),1.5,0.5,new b2Vec2(0,-1),-3,0,0,"pusher",4);
               this.CreatePusher(new b2Vec2(8,14),2,4,false);
               this.CreateMovingBox2(new b2Vec2(18.5,2),new b2Vec2(0.95,0.95));
               this.CreateSlidePlatform(new b2Vec2(22,4),0.5,1.5,new b2Vec2(1,0),-4,0,0,"pusher",5);
               this.CreatePusher(new b2Vec2(2,18),2,5,true);
               this.CreateSlidePlatform(new b2Vec2(30,2.5),2,0.5,new b2Vec2(1,0),-6,0,0,"pusher",5);
               this.CreatePusher(new b2Vec2(2,18),2,5,false);
               this.CreateSlidePlatform(new b2Vec2(36,21),0.5,1.5,new b2Vec2(0,1),-3,0,0,"pusher",5);
               this.CreatePusher(new b2Vec2(2,18),2,5,false);
               this.CreateSlidePlatform(new b2Vec2(36,24),0.5,1.5,new b2Vec2(0,1),-3,0,0,"pusher",5);
               this.CreatePusher(new b2Vec2(2,18),2,5,false);
            }
            if(param2 == 0)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,-3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1),new Array(1,1,1,1,1,1,-1,0,0,0,1,1,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,1,1,-1,0,0,0,-2,-4,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,-1,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,-2,1,1,1,1,1,1,-4,0,0,0,0,1,0,0,0,0,0,-2,1,-4,0,0,-3,1,-1,0,0,0,1),new Array(1,0,0,-2,51,5,5,52,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,-4,0,0,0,0,-3,1,-1,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,-4,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,51,5,52,1,-4,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-4,0,0,0,0,0,0,0,0,0,-2,1,-1,0,0,0,0,-2,1),new Array(1,1,1,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,1,-1,0,0,0,0,0,0,-2,1,0,0,0,0,0,0,0,0,-2,1,1,1,1,1,-4,0,-3,1,1),new Array(1,0,0,0,0,0,0,0,0,0,1,-3,-1,0,0,0,0,-2,1,-4,0,0,0,0,0,0,-2,1,1,1,-4,0,0,1,0,0,0,1,1),new Array(1,0,0,0,0,0,0,0,0,0,1,0,-3,71,7,7,72,-4,0,0,0,0,0,0,0,0,1,0,-3,1,0,0,0,1,0,0,0,1,1),new Array(1,0,0,0,0,0,0,0,0,-2,1,0,0,-3,1,1,-4,0,0,0,0,0,0,0,0,0,1,0,0,1,0,"gr",0,0,0,0,0,-3,1),new Array(1,0,0,0,0,-2,1,1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,0,0,1,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,-2,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,0,0,0,0,0,0,0,1),new Array(1,0,0,-2,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,-1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1),new Array(1,51,5,52,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,1,61,6,62,1,1,51,5,5,52,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1),new Array(1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,-2,1,51,5,5,5,52,1,1,1,1,1),new Array(1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,71,7,7,7,7,7,7,72,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.LightSpeed = 50;
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(34,10);
               this.StartPosWater = new b2Vec2(30,4);
               this.CreateFinish(new b2Vec2(2,26.5),new b2Vec2(5,26.5));
               this.CreateSlidePlatform(new b2Vec2(33,16),1.5,0.5,new b2Vec2(0,1),-3,0,0,"pusher",6);
               this.CreatePusher(new b2Vec2(14,5),2,6,true);
               this.CreateSlidePlatform(new b2Vec2(17,2),1.5,0.5,new b2Vec2(-1,0),-6,0,0,"lever",4);
               this.CreateLever(new b2Vec2(7,15),4,"l","r",true);
               this.CreateSlidePlatform(new b2Vec2(5,23),0.5,1.5,new b2Vec2(-1,0),-3,0,0,"lever",4);
               this.CreateLever(new b2Vec2(7,15),4,"l","r",false);
               this.CreateWind(new b2Vec2(35,16),new b2Vec2(37,25),1,2,"lever",true);
               this.CreateLever(new b2Vec2(3.5,3),2,"l","r",true);
               this.CreateHangingPlatform(new b2Vec2(23,11),new b2Vec2(3,0.2),12,"down");
            }
            if(param2 == 3)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,-1,0,0,0,0,0,0,0,1,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,1,-1,0,0,-2,1,1,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,1,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,-3,-1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,0,0,0,-2,1,1,0,"gr",0,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,1,0,0,-2,-4,0,0,0,1),new Array(1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,0,0,0,0,0,1,0,0,1,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,-1,0,0,0,0,0,1,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1),new Array(1,0,0,0,0,0,0,-2,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,1),new Array(1,0,0,0,0,0,-2,-4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,-2,-4,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,-4,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(13,21);
               this.StartPosWater = new b2Vec2(19,21);
               this.CreateFinish(new b2Vec2(7,26.5),new b2Vec2(10,26.5));
               this.CreateSlidePlatform(new b2Vec2(10,22),0.5,1.5,new b2Vec2(1,0),-3,0,0,"lpusher",6);
               this.CreateLightPusher(new b2Vec2(32,10),0,16777113,true);
               this.CreateSlidePlatform(new b2Vec2(23,25.5),1,0.5,new b2Vec2(0,1),-2,0,0,"pusher",1);
               this.CreatePusher(new b2Vec2(17.5,12),2,1,true);
               this.CreateSlidePlatform(new b2Vec2(26,25.5),1,0.5,new b2Vec2(0,-1),-2,0,0,"pusher",1);
               this.CreatePusher(new b2Vec2(17.5,12),2,1,false);
               this.CreateSlidePlatform(new b2Vec2(30,20),1.5,0.5,new b2Vec2(0,-1),-3,0,0,"pusher",4);
               this.CreatePusher(new b2Vec2(27,21),2,4,true);
               this.CreateSlidePlatform(new b2Vec2(10.5,13),0.5,1.5,new b2Vec2(1,0),-3.5,0,0,"pusher",3);
               this.CreatePusher(new b2Vec2(15.5,21),2,3,true);
               this.CreateRotMirror(new b2Vec2(3.5,3.5),0,0,2);
               this.CreateLever(new b2Vec2(21,21),2,"l","r",true);
               this.CreateMirrorSlider(new b2Vec2(15,15.5),10,3,5,true);
               this.CreateInfiniteMirror(new b2Vec2(35,3.5),0,0,5);
               this.CreateSlidePlatform(new b2Vec2(30,13),1.5,0.5,new b2Vec2(0,-1),-3,0,0,"lpusher",6);
               this.CreateLightPusher(new b2Vec2(14,25.5),Math.PI / 2,16777113,true);
               this.CreateLightBeamer(new b2Vec2(3.5,24),-Math.PI / 2,16777113);
               this.CreateRotMirror(new b2Vec2(35,25.5),Math.PI / 2,0,4,true);
            }
            if(param2 == 9)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,1,1,1,-4,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1),new Array(1,1,1,-4,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,-1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,-4,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,-4,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,-4,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,-3,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,1),new Array(1,1,-4,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1),new Array(1,-4,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,-3,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,-2,1,1,-4,0,0,0,0,0,0,-3,-1,0,0,0,0,0,0,1,1,1,1,1,1,-1,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,-2,1,1,-4,0,0,0,0,0,0,0,0,-3,-1,0,0,0,0,-2,-4,0,0,0,0,0,1,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,-1,"gr",0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,0,0,0,0,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,0,0,0,-2,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,-1,0,0,0,0,-3,-1,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,0,0,0,0,0,0,0,0,0,1),new Array(1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,-1,0,0,0,0,0,-3,-1,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,0,0,0,0,0,-3,1,1,1,1,1,1,1,1,1),new Array(1,1,1,1,1,1,0,0,0,-3,-1,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,0,0,0,0,0,1,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,-4,0,0,0,0,-3,-1,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,0,0,0,0,1,0,0,0,0,0,0,-2,1),new Array(1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,0,0,0,1,0,0,0,0,0,-2,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,-2,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,-2,1,1,1,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(7,26);
               this.StartPosWater = new b2Vec2(20,26);
               this.CreateFinish(new b2Vec2(14,10.5),new b2Vec2(17,10.5));
               this.CreateLightBeamer(new b2Vec2(1,3.5),0,16777113);
               this.CreateMirrorSlider(new b2Vec2(19,2.5),10.3,3,2,true);
               this.CreateInfiniteMirror(new b2Vec2(9,3.5),0,0,2);
               this.CreateMirrorSlider(new b2Vec2(26,6.5),9,3,1,true);
               this.CreateInfiniteMirror(new b2Vec2(16,15),0,0,1);
               this.CreateSlidePlatform(new b2Vec2(32,15),1.5,0.5,new b2Vec2(0,-1),-3,0,0,"lpusher",6);
               this.CreateLightPusher(new b2Vec2(1,26.5),Math.PI / 2,16777113,true);
               this.CreateSlidePlatform(new b2Vec2(20,10),1.5,0.5,new b2Vec2(0,-1),-3,0,0,"lpusher",6);
               this.CreateLightPusher(new b2Vec2(29,26.5),-Math.PI / 2,16777113,true);
               this.CreateMovingMirror(new b2Vec2(4.5,20),new b2Vec2(0.95,0.95),0);
               this.CreateMovingMirror(new b2Vec2(11.5,26),new b2Vec2(0.95,0.95),0);
               this.CreateMovingMirror(new b2Vec2(9.5,26),new b2Vec2(0.95,0.95),90);
            }
         }
         else if(param1 == "speed")
         {
            if(param2 == 3)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,-1,0,"bd",0,0,0,0,0,0,0,0,0,0,-2,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,"rd",0,-2,1,1,1,1),new Array(1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,-3,-4,0,-3,-4,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,1),new Array(1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,1,1),new Array(1,-4,0,0,0,-3,1,-1,0,"bd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"rd",0,-2,1,-4,0,0,0,-3,1),new Array(1,0,0,0,0,0,-3,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,-4,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,-3,1,1,1,71,7,7,7,7,72,1,-1,0,-2,1,71,7,7,7,7,72,1,1,1,-4,0,0,0,0,0,0,1),new Array(1,0,0,"rd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"bd",0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,-2,1,-1,0,0,"rd",0,0,0,0,0,0,0,"rd",0,-2,1,-1,0,"bd",0,0,0,0,0,0,0,"bd",0,0,-2,1,-1,0,0,1),new Array(1,0,0,-3,1,1,-1,0,0,0,0,-2,1,1,-1,0,0,-2,1,1,1,-1,0,0,-2,1,1,-1,0,0,0,0,-2,1,1,-4,0,0,1),new Array(1,0,0,0,-3,1,1,1,1,1,1,1,1,1,1,1,1,-4,0,0,0,-3,1,1,1,1,1,1,1,1,1,1,1,1,-4,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"bd",0,"rd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1),new Array(1,1,-1,0,0,"rd",0,0,0,0,0,-2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,0,0,0,"bd",0,0,-2,1,1),new Array(1,1,1,-1,0,0,0,0,"bd",0,-2,1,1,1,-4,0,0,0,0,0,0,0,0,0,-3,1,1,1,-1,0,"rd",0,0,0,0,-2,1,1,1),new Array(1,1,1,1,1,1,1,0,0,-2,1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,-1,0,0,1,1,1,1,1,1,1),new Array(1,1,1,1,1,1,1,0,0,1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,0,0,1,1,1,1,1,1,1),new Array(1,-4,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,-1,0,0,0,-2,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,-3,1),new Array(1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,-1,0,-2,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1),new Array(1,0,0,"bd",0,0,0,0,-2,-4,0,0,0,0,0,0,0,-3,1,1,1,-4,0,0,0,0,0,0,0,-3,-1,0,0,0,0,"rd",0,0,1),new Array(1,0,0,0,-2,1,1,1,-4,0,0,0,0,0,0,0,0,0,-3,1,-4,0,0,0,0,0,0,0,0,0,-3,1,1,1,-1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,"bd",0,0,0,0,0,0,1,0,0,0,0,0,0,"rd",0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,-1,0,0,0,0,"bd",0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,"rd",0,0,0,0,-2,1),new Array(1,1,1,-1,0,0,0,0,0,-2,1,1,1,1,-1,0,0,0,0,1,0,0,0,0,-2,1,1,1,1,-1,0,0,0,0,0,-2,1,1,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(36,3);
               this.StartPosWater = new b2Vec2(2,3);
               this.CreateFinish(new b2Vec2(21.5,26.5),new b2Vec2(16.5,26.5));
            }
            if(param2 == 2)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,"rd",0,0,0,0,0,0,0,0,0,"rd",0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,"rd",0,-2,1,-1,0,"rd",0,1,0,0,0,0,0,0,0,-2,1,-1,0,0,0,-2,-1,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,-2,-4,0,0,0,0,0,1,0,0,0,-2,1,1,1,1,1,1,1,1,1,1,-4,0,0,1),new Array(1,1,1,1,-1,0,0,"rd",0,0,0,0,-2,1,0,0,0,0,0,-2,-4,0,0,0,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,-3,-1,0,0,0,0,0,-2,1,1,0,0,-3,1,1,-4,0,0,0,-2,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,-3,-1,0,0,0,-2,-4,0,-3,-1,0,0,0,0,0,0,-2,1,1,0,0,0,-2,1,1,1,-1,0,-2,1,1,-1,0,1),new Array(1,0,0,0,0,0,-3,71,7,72,-4,0,0,0,-3,-1,0,0,0,0,-2,-4,-3,1,0,0,0,0,0,0,0,-3,1,1,-4,0,-3,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,"rd",0,0,-3,1,1,1,1,-4,0,0,-3,-1,0,0,0,0,0,0,0,0,-3,-1,0,0,-3,1),new Array(1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,1,-1,0,0,0,1,0,0,0,1),new Array(1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1),new Array(1,0,0,-3,-1,0,0,"rd",0,0,0,0,0,0,0,0,0,"rd",0,0,0,0,0,0,0,0,"rd",0,0,0,0,0,0,-2,-4,0,0,0,1),new Array(1,0,0,0,1,-1,0,0,0,-2,71,7,7,7,72,-1,0,0,0,-2,71,7,7,72,-1,0,0,-2,-1,0,-2,1,1,1,-1,0,0,-2,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,"bd",0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,"bd",0,-2,1,-1,0,"bd",0,1,0,"bd",0,0,0,0,0,-2,1,-1,0,0,0,-2,-1,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,-2,-4,0,0,0,0,0,1,0,0,0,-2,1,1,1,1,1,1,1,1,1,1,-4,0,0,1),new Array(1,1,1,1,-1,0,0,"bd",0,0,0,0,-2,1,0,0,0,0,0,-2,-4,0,0,0,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,-3,-1,0,0,0,0,0,-2,1,1,0,0,-3,1,1,-4,0,0,0,-2,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,-3,-1,0,0,0,-2,1,1,1,-1,0,0,0,0,0,0,-2,1,1,0,0,0,-2,1,1,1,-1,0,-2,1,1,-1,0,1),new Array(1,0,0,0,0,0,-3,71,7,72,-4,0,0,0,-3,-1,0,0,0,0,-2,-4,-3,1,0,0,0,0,0,0,0,-3,1,1,-4,0,-3,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,"bd",0,0,-3,1,1,1,1,-4,0,0,-3,-1,0,0,0,0,0,0,0,0,-3,-1,0,0,-3,1),new Array(1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,1,-1,0,0,0,1,0,0,0,1),new Array(1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1),new Array(1,0,0,-3,-1,0,0,"bd",0,0,0,0,0,0,0,0,0,"bd",0,0,0,0,0,0,0,0,"bd",0,0,0,0,0,0,-2,-4,0,0,0,1),new Array(1,0,0,0,1,-1,0,0,0,-2,71,7,7,7,72,-1,0,0,0,-2,71,7,7,72,-1,0,0,-2,-1,0,-2,1,1,-4,0,0,0,-2,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(2,4);
               this.StartPosWater = new b2Vec2(2,18);
               this.CreateFinish(new b2Vec2(2,8.5),new b2Vec2(2,22.5));
            }
            if(param2 == 4)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,1,1,1,1,-4,0,0,0,-3,-1,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"rd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,1),new Array(1,-1,0,0,0,0,0,0,"rd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,-3,1),new Array(1,1,1,1,1,-1,0,0,0,0,0,0,-2,1,1,1,1,-1,0,0,0,0,"rd",0,0,0,0,0,"rd",0,0,0,0,1,-1,0,0,0,1),new Array(1,0,0,0,0,-3,-1,0,0,0,0,-2,-4,0,0,0,0,-3,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,-1,0,0,1),new Array(1,0,0,0,0,0,-3,71,7,7,72,-4,0,0,0,0,0,0,-3,-1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,1),new Array(1,-1,0,0,0,0,0,-3,1,1,-4,0,0,0,0,0,0,0,0,-3,-1,0,0,0,0,0,0,0,0,0,0,-2,-4,0,0,0,0,0,1),new Array(1,1,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,71,7,7,7,7,7,7,7,7,72,-4,0,0,0,0,0,0,1),new Array(1,-4,0,0,-3,-1,0,0,0,0,0,"rd",0,-2,1,1,-1,0,"rd",0,0,-3,1,1,1,1,1,1,1,1,-4,0,0,0,0,0,0,-2,1),new Array(1,0,0,0,0,-3,-1,0,0,0,0,0,0,1,-4,-3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"rd",0,-2,1,1,1,1),new Array(1,0,0,0,0,0,1,-1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-4,0,0,1),new Array(1,-1,0,0,0,-2,-4,-3,-1,0,-2,71,72,1,0,0,1,71,72,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,0,0,0,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1),new Array(1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,1,1,1,1,-4,0,0,0,-3,-1,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"bd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,1),new Array(1,-1,0,0,0,0,0,0,"bd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,-3,1),new Array(1,1,1,1,1,-1,0,0,0,0,0,0,-2,1,1,1,1,-1,0,0,0,0,"bd",0,0,0,0,0,"bd",0,0,0,0,1,-1,0,0,0,1),new Array(1,0,0,0,0,-3,-1,0,0,0,0,-2,-4,0,0,0,0,-3,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,-1,0,0,1),new Array(1,0,0,0,0,0,-3,71,7,7,72,-4,0,0,0,0,0,0,-3,-1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,1),new Array(1,-1,0,0,0,0,0,-3,1,1,-4,0,0,0,0,0,0,0,0,-3,-1,0,0,0,0,0,0,0,0,0,0,-2,-4,0,0,0,0,0,1),new Array(1,1,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,71,7,7,7,7,7,7,7,7,72,-4,0,0,0,0,0,0,1),new Array(1,-4,0,0,-3,-1,0,0,0,0,0,"bd",0,-2,1,1,-1,0,"bd",0,0,-3,1,1,1,1,1,1,1,1,-4,0,0,0,0,0,0,-2,1),new Array(1,0,0,0,0,-3,-1,0,0,0,0,0,0,1,-4,-3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"bd",0,-2,1,1,-4,1),new Array(1,0,0,0,0,0,1,-1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1),new Array(1,-1,0,0,0,-2,-4,-3,-1,0,-2,71,72,1,0,0,1,71,72,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,-2,-4,0,0,0,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(3,4);
               this.StartPosWater = new b2Vec2(3,18);
               this.CreateFinish(new b2Vec2(2.5,12.5),new b2Vec2(2.5,26.5));
               this.CreateHangingPlatform(new b2Vec2(26.5,2),new b2Vec2(3,0.2),5,"down");
               this.CreateHangingPlatform(new b2Vec2(26.5,16),new b2Vec2(3,0.2),5,"down");
            }
            if(param2 == 1)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,-3,1,1,1,1,1,1,1,1,-4,0,-3,1,-4,0,-3,1,1,1,1,1,1,1,1,-4,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1),new Array(1,-4,0,-3,-1,0,0,"bd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"rd",0,0,-2,-4,0,-3,1),new Array(1,0,0,0,-3,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-4,0,0,0,1),new Array(1,0,0,0,0,-3,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-4,0,0,0,0,1),new Array(1,0,0,0,0,0,-3,0,0,0,0,0,0,0,0,"bd",0,0,0,0,0,0,0,"rd",0,0,0,0,0,0,0,0,-4,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,61,6,6,62,1,1,1,1,0,0,0,0,0,1,1,1,1,51,5,5,52,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1),new Array(1,0,0,-3,61,6,6,6,62,1,1,1,-4,0,-3,1,1,0,0,0,0,0,1,1,-4,0,-3,1,1,1,51,5,5,5,52,-4,0,0,1),new Array(1,0,0,0,-3,1,1,1,1,1,1,-4,0,0,0,-3,1,71,7,7,7,72,1,-4,0,0,0,-3,1,1,1,1,1,1,-4,0,0,0,1),new Array(1,-1,0,"rd",0,-3,1,1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,-4,0,"bd",0,-2,1),new Array(1,-3,-1,0,0,0,-3,1,1,-4,0,0,0,0,0,0,0,"bd",0,0,0,"rd",0,0,0,0,0,0,0,-3,1,1,-4,0,0,0,-2,-4,1),new Array(1,0,-3,-1,0,0,0,-3,1,0,0,0,"rd",0,0,0,0,0,0,0,0,0,0,0,0,0,"bd",0,0,0,1,-4,0,0,0,-2,-4,0,1),new Array(1,0,0,1,-1,0,"rd",0,1,0,0,0,0,0,0,0,0,0,-3,1,-4,0,0,0,0,0,0,0,0,0,1,0,"bd",0,-2,1,0,0,1),new Array(1,0,0,1,-4,0,0,0,1,1,1,1,-1,0,0,0,0,0,0,1,0,0,0,0,0,0,-2,1,1,1,1,0,0,0,-3,1,0,0,1),new Array(1,0,-2,-4,0,0,0,-2,-4,0,0,0,-3,-4,0,0,0,0,0,1,0,0,0,0,0,-3,-4,0,0,0,-3,-1,0,0,0,-3,-1,0,1),new Array(1,-2,-4,0,0,0,-2,-4,0,0,0,0,0,0,0,0,0,"bd",0,1,0,"rd",0,0,0,0,0,0,0,0,0,-3,-1,0,0,0,-3,-1,1),new Array(1,-4,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,-3,1),new Array(1,-1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,1,-4,0,0,0,0,0,0,0,0,0,1,0,0,0,0,-2,1),new Array(1,1,-1,0,0,0,-3,0,0,0,0,0,"bd",0,0,0,0,0,0,0,0,0,0,0,0,0,"rd",0,0,0,0,0,-4,0,0,0,-2,1,1),new Array(1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1),new Array(1,1,1,0,0,0,0,0,0,0,0,-3,1,-4,0,0,0,0,0,0,0,0,0,0,0,-3,1,-4,0,0,0,0,0,0,0,0,1,1,1),new Array(1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1),new Array(1,1,1,1,1,1,1,1,1,71,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,72,1,1,1,1,1,1,1,1,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(36.5,3);
               this.StartPosWater = new b2Vec2(1.5,3);
               this.CreateFinish(new b2Vec2(33.5,25.5),new b2Vec2(4.5,25.5));
            }
            if(param2 == 5)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,-4,0,0,0,0,0,0,-3,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"bd",0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,0,0,0,0,0,0,"rd",0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,-4,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,"rd",0,0,0,0,1,1,0,0,0,0,0,0,1,-1,0,0,0,0,0,0,1,0,0,0,0,1),new Array(1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,0,0,0,0,0,0,0,0,0,71,7,7,7,72,-4,0,0,0,0,1),new Array(1,1,1,1,1,1,-4,0,0,0,0,0,0,0,"bd",0,0,0,1,0,0,0,0,0,71,7,7,72,1,-4,0,0,1,0,0,0,0,0,1),new Array(1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,71,7,72,1,1,1,-4,0,0,0,0,1,0,0,1,1,1,1),new Array(1,1,1,1,1,1,71,7,7,7,7,7,72,0,0,71,7,72,1,0,0,1,1,-4,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1),new Array(1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1),new Array(1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1),new Array(1,-4,0,0,0,0,0,0,"bd",0,0,0,0,0,-2,1,1,0,0,0,0,0,-2,1,-1,0,0,0,0,0,0,0,1,0,0,0,0,0,1),new Array(1,0,0,0,"rd",0,0,0,0,0,0,0,0,-2,1,1,1,-1,0,0,0,-2,1,1,1,0,0,0,0,0,0,0,1,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,-2,1,1,-4,0,0,0,0,0,0,0,0,-3,1,1,1,1,1,1,1,1,1,1,1,1,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,-4,0,0,0,0,1),new Array(1,0,0,71,7,7,7,7,7,7,72,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,0,0,0,"rd",0,1),new Array(1,0,0,1,1,1,1,1,1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1),new Array(1,0,0,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1),new Array(1,0,0,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,"bd",0,1),new Array(1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"bd",0,0,0,"rd",0,0,0,"bd",0,0,0,"rd",0,-3,0,0,0,0,0,1),new Array(1,0,0,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,-2,1,-1,0,0,0,-2,0,0,0,-2,0,0,0,-2,0,0,0,-2,0,0,0,-2,0,0,0,-2,1,1,1,1),new Array(1,0,0,0,0,0,0,0,1,1,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,-2,1,1,1,1,1),new Array(1,-1,0,0,0,0,0,-2,1,1,1,-1,0,0,1,71,7,72,1,71,7,72,1,71,7,72,1,71,7,72,1,0,-2,1,1,1,1,1,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(2,8);
               this.StartPosWater = new b2Vec2(5,8);
               this.CreateFinish(new b2Vec2(27,14.5),new b2Vec2(30,14.5));
               this.CreateWind(new b2Vec2(35,3),new b2Vec2(37,10),1,5,"normal",true);
               this.CreateWind(new b2Vec2(33,6),new b2Vec2(35,17),1,5,"normal",true);
               this.CreateWind(new b2Vec2(35,12),new b2Vec2(37,25),1,5,"normal",true);
            }
            if(param2 == 6)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,-2,-4,0,0,0,0,0,0,0,0,0,0,-3,-1,-2,-1,-2,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,0,1),new Array(1,-2,-4,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,1),new Array(1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1),new Array(1,0,0,0,0,0,0,0,0,-2,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,"bd",0,"rd",0,0,-2,-1,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,-2,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,-1,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,-2,-4,-3,-4,-3,-1,0,0,"rd",0,0,"bd",0,0,-2,-1,0,0,0,0,-2,1,1,1,1,-1,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,-4,0,0,0,0,-3,-1,0,0,0,0,0,0,-2,1,1,-1,-2,-1,-2,-4,-3,1,1,-4,-3,-1,0,0,0,0,1),new Array(1,1,-4,0,0,0,0,0,0,0,0,0,0,-3,-1,0,0,0,0,-2,-4,0,0,-3,1,1,-4,0,0,-3,-4,0,0,-3,-1,0,0,0,1),new Array(1,-4,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,-2,-1,-2,-4,0,0,0,0,-3,-4,0,0,0,0,0,0,0,0,-3,-1,0,0,1),new Array(1,0,0,0,0,0,0,"rd",0,0,0,"bd",0,0,0,-3,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,0,0,1),new Array(1,0,0,0,0,0,0,0,-2,-1,0,0,0,0,0,0,-3,-4,0,0,0,0,0,0,0,0,0,"bd",0,0,0,0,"rd",0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,-2,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-1,0,0,0,0,0,0,-2,1),new Array(1,0,0,0,0,0,-2,-4,-3,-4,-3,-1,0,0,0,0,0,0,0,0,0,0,0,0,-2,-1,0,0,-2,1,1,-1,0,0,0,0,-2,-4,1),new Array(1,0,0,0,0,-2,-4,0,0,0,0,-3,-1,0,0,0,"rd",0,0,0,"bd",0,0,-2,1,1,-1,-2,-4,0,0,-3,-1,0,0,-2,-4,0,1),new Array(1,0,0,0,-2,-4,0,0,0,0,0,0,-3,-1,0,0,0,0,0,0,0,0,-2,1,1,1,1,-4,0,0,0,0,-3,-1,-2,-4,0,0,1),new Array(1,0,0,-2,-4,0,0,0,0,0,0,0,0,-3,-1,0,0,-2,-1,0,0,-2,-4,-3,1,1,-4,0,0,0,0,0,0,-3,-4,0,0,0,1),new Array(1,0,0,-4,0,0,0,0,"bd",0,0,"rd",0,0,-3,-1,-2,1,1,-1,-2,-4,0,0,-3,-4,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,-4,0,0,0,0,0,0,0,"bd",0,0,"rd",0,0,0,0,0,0,1),new Array(1,-1,0,0,0,0,0,0,0,-2,-1,0,0,0,0,0,-3,1,1,-4,0,0,0,0,0,0,0,0,0,-2,-1,0,0,0,0,0,0,0,1),new Array(1,-3,-1,0,-2,-1,-2,-1,-2,1,1,-1,0,0,0,0,0,-3,-4,0,0,0,0,0,0,0,0,0,-2,1,1,-1,0,0,0,0,0,0,1),new Array(1,0,-3,1,-4,-3,1,1,-4,0,0,-3,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-4,0,0,-3,-1,-2,-1,0,0,0,1),new Array(1,0,0,0,0,0,-3,-4,0,0,0,0,-3,-1,0,0,0,0,0,"bd",0,0,0,0,"rd",0,-2,-4,0,0,0,0,-3,1,1,-1,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,0,0,0,0,0,0,-2,-1,0,0,-2,-4,0,0,0,0,0,0,-3,-4,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,0,0,0,0,-2,1,1,-1,-2,-4,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,-2,-1,-2,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,-2,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,-2,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(2,6);
               this.StartPosWater = new b2Vec2(28,26);
               this.CreateFinish(new b2Vec2(31,25.5),new b2Vec2(5,5.5));
            }
            if(param2 == 7)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,"rd",0,0,0,0,0,0,0,0,0,"bd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1),new Array(1,0,0,0,0,0,0,0,0,0,0,-2,-1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1),new Array(1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1),new Array(1,-4,0,-3,1,1,0,0,0,0,0,0,0,0,0,0,1,-1,0,0,0,0,0,0,0,"bd",0,0,0,"rd",0,0,0,0,1,1,0,1,1),new Array(1,0,0,0,-3,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,0,0,0,1),new Array(1,0,0,0,0,0,-3,71,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,72,1,1,61,6,6,62,1,0,0,0,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-4,0,0,0,0,1,0,0,0,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,"rd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,"bd",0,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,"bd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1),new Array(1,1,1,1,1,1,1,1,-1,0,0,0,0,-2,1,1,1,-1,0,0,0,0,0,"bd",0,0,0,0,0,0,1,0,0,0,1,0,0,0,1),new Array(1,-4,0,0,0,0,0,0,-3,51,5,5,52,-4,0,0,0,-3,-1,0,0,0,0,0,0,0,0,0,0,0,1,0,"rd",0,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,0,0,0,0,"rd",0,0,0,0,0,1,0,0,0,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"rd",0,0,0,-3,-1,0,0,0,0,0,0,-2,0,0,1,0,0,0,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,61,6,6,62,1,-4,0,0,1,0,0,0,1,0,0,0,1),new Array(1,0,0,0,-2,1,-1,0,0,0,"bd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-4,0,"bd",0,1,0,0,0,1),new Array(1,0,0,-2,1,1,1,-1,0,0,0,0,0,0,0,0,-2,1,-1,0,0,0,0,0,0,0,0,0,-2,-4,0,0,0,0,1,0,0,0,1),new Array(1,0,0,0,0,-3,1,1,1,1,1,71,7,7,7,72,1,1,1,-1,0,0,0,0,0,0,0,-2,-4,0,0,0,0,0,1,0,0,0,1),new Array(1,0,0,0,0,0,-3,-4,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,1,1,1,-4,0,0,0,0,"rd",0,1,0,0,0,1),new Array(1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,0,0,0,0,0,0,0,-2,-1,0,0,0,0,0,0,0,0,0,0,"rd",0,0,0,"bd",0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,-1,0,0,-2,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,71,7,7,7,72,1,1,1,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,51,5,5,5,52,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(2,5);
               this.StartPosWater = new b2Vec2(4,5);
               this.CreateFinish(new b2Vec2(2,13.5),new b2Vec2(5,13.5));
               this.CreatePulley(new b2Vec2(32,4.5),new b2Vec2(36,4.5),new b2Vec2(0.2,1.3),new b2Vec2(0.2,1.3),new b2Vec2(32,12),new b2Vec2(36,22.5));
               this.CreateBall(new b2Vec2(36.5,22));
            }
         }
         else if(param1 == "dark")
         {
            if(param2 == 4)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,1,1,1,1,1,1,-1,0,0,0,0,0,1),new Array(1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-4,0,0,0,0,0,0,0,0,0,0,-3,-1,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,-2,1,1,71,7,72,1,1,71,7,72,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1),new Array(1,0,0,0,0,0,0,-2,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,0,0,0,1),new Array(1,0,0,0,0,0,-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,-1,0,0,0,0,1,0,0,0,1),new Array(1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,0,0,0,-3,-4,0,0,1),new Array(1,0,0,0,0,0,0,-3,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,-3,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,0,0,0,0,-2,1),new Array(1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,0,0,-2,1,1),new Array(1,0,0,0,-2,1,-1,0,0,-3,0,0,0,0,-2,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,1),new Array(1,0,0,-2,1,1,1,0,0,0,0,0,0,-2,1,-4,0,-3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,-2,1,-4,0,0,0,1,51,5,52,1,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1),new Array(1,0,0,0,0,0,1,0,0,0,0,1,1,-4,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1),new Array(1,0,0,0,0,0,1,0,0,0,0,1,1,0,0,0,0,0,1,0,0,-3,1,51,5,52,1,0,0,0,0,0,0,0,0,0,0,-3,1),new Array(1,1,1,-1,0,0,1,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,1,1,1,1,1,1,-1,0,0,0,0,1,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,1,1,1,1,-4,0,0,0,0,0,-2,1,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,1,-4,0,0,0,0,0,0,0,-2,-4,1,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,-3,1,1,1,-4,0,0,0,0,0,0,1,1,-4,0,1,0,0,-2,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,-3,1,1,0,0,0,0,0,0,0,1,1,0,0,1,0,-2,-4,0,0,0,-3,1,1,-4,0,0,0,0,0,0,0,0,0,1),new Array(1,-1,0,0,0,-3,-4,0,0,0,1,1,0,0,0,0,0,0,1,-2,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,-1,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,-1,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,1,51,5,5,5,5,5,5,5,5,5,5,52,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(7.5,18);
               this.StartPosWater = new b2Vec2(9.5,18);
               this.CreateFinish(new b2Vec2(2,7.5),new b2Vec2(2,3.5));
               this.CreateSlidePlatform(new b2Vec2(22,8),0.5,1.5,new b2Vec2(0,1),-3,0,0,"lever",5);
               this.CreateLever(new b2Vec2(22,27),5,"l","r",true);
            }
            if(param2 == 2)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1),new Array(1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,-4,0,0,-3,1),new Array(1,0,0,0,-2,1,1,61,6,6,6,62,1,1,1,1,51,5,5,5,52,1,1,1,1,1,1,1,61,6,6,62,1,-4,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,51,5,5,5,52,1,1,1,1,1,61,6,6,6,62,1,1,1,1,1,51,5,5,5,52,1,1,1,-1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,-2,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,-2,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1),new Array(1,0,0,0,0,-2,1,-4,-3,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1),new Array(1,0,0,0,-2,1,-4,0,0,-3,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,71,7,7,72,1,1,1,1,1,1),new Array(1,0,0,0,1,-4,0,0,0,0,-3,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,-3,1,71,7,7,7,7,7,7,7,7,7,7,7,72,1,1,-4,0,0,0,0,0,0,0,0,-3,1),new Array(1,0,0,0,0,0,0,-2,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,-2,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,-2,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,-1,0,0,-2,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(33,4);
               this.StartPosWater = new b2Vec2(35,4);
               this.CreateFinish(new b2Vec2(30,26.5),new b2Vec2(34,26.5));
               this.CreateHangingPlatform(new b2Vec2(18,16),new b2Vec2(3,0.2),5,"down");
            }
            if(param2 == 3)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,-4,0,0,-3,1,1,-4,0,0,-3,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,-3,-4,0,0,0,0,-3,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,-2,-1,0,0,0,0,-2,-1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1),new Array(1,-1,0,0,0,0,0,-2,1,1,-1,0,0,-2,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,-1,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,-1,0,0,0,-3,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,-2,-4,0,-3,-1,0,0,0,-3,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1),new Array(1,0,0,0,0,0,0,0,0,0,0,1,1,-4,0,0,0,-3,-1,0,0,0,-3,-1,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1),new Array(1,0,0,-2,0,0,0,0,0,0,0,1,-4,0,0,0,0,0,-3,-1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,-3,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,-2,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,1,0,0,0,0,0,0,0,1,0,0,-2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,1),new Array(1,0,0,1,0,0,0,0,0,0,0,-4,0,0,-3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1),new Array(1,0,0,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,-1,0,0,0,1),new Array(1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,-1,0,0,0,0,0,0,0,1,0,0,0,1),new Array(1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,-1,0,0,0,0,0,0,-4,0,0,0,1),new Array(1,1,1,1,1,1,1,-4,0,0,0,-2,1,1,1,-1,0,0,0,0,0,0,0,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,-4,0,0,0,0,0,0,0,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,1),new Array(1,71,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,72,1,1,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(2,4);
               this.StartPosWater = new b2Vec2(5,4);
               this.CreateFinish(new b2Vec2(2,21.5),new b2Vec2(5,21.5));
               this.CreateWind(new b2Vec2(12,15),new b2Vec2(14,23),1,2,"lever",true);
               this.CreateLever(new b2Vec2(31,4),2,"l","r",true);
               this.CreateWind(new b2Vec2(20,10),new b2Vec2(22,16),1,2,"lever",false);
               this.CreateLever(new b2Vec2(31,4),2,"l","r",false);
               this.CreateSlidePlatform(new b2Vec2(32,9),0.5,1.5,new b2Vec2(0,1),-4,0,0,"pusher",3);
               this.CreatePusher(new b2Vec2(28.5,16),2,3,true);
            }
            if(param2 == 1)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,-4,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,1),new Array(1,0,0,-2,1,1,1,1,1,1,1,1,-1,0,0,1,0,0,-2,1,1,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,1,1,-1,0,0,-2,1,1,-1,0,0,1,0,-2,1,-1,0,1,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,1,0,0,1,0,0,0,0,0,1,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,-2,1,-1,0,1,0,0,0,0,0,1,0,0,1,0,0,1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,-1,0,0,1),new Array(1,0,0,1,0,0,1,0,0,-2,1,1,1,-1,0,1,0,-2,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,1,0,0,1),new Array(1,0,0,1,0,0,1,-1,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,-1,0,1,0,-2,1,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,-1,0,0,1,0,-2,1),new Array(1,0,0,1,0,0,1,0,0,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,1,0,0,1),new Array(1,0,0,1,0,0,1,0,-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-4,0,0,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,0,-2,1,-1,0,1,0,0,-3,1,1,-1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,1,1,1,1,-1,0,1),new Array(1,0,0,1,0,0,1,0,0,0,0,0,0,-3,1,1,1,1,1,1,-1,0,0,1,0,0,-2,1,1,1,1,1,0,0,0,0,0,0,1),new Array(1,0,0,1,0,0,1,-1,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,-1,0,1,0,-2,1,1,1,1,1,1,-1,0,0,0,1,0,0,0,1,0,0,1,0,0,1,0,0,0,0,0,0,1,1,1,1,1,1),new Array(1,0,0,1,0,0,0,0,0,0,0,0,0,-3,-1,0,0,0,1,1,1,-1,0,1,-1,0,1,0,0,-2,1,1,1,1,0,0,0,-3,1),new Array(1,0,0,1,0,0,0,0,0,0,0,0,0,0,-3,-1,0,0,1,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,-2,1,1,1,1,1,1,1,1,1,-1,0,0,-3,1,1,1,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,-1,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,-2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,1,1,0,0,0,0,1,0,0,0,1,0,0,0,1,0,-2,1),new Array(1,1,1,1,1,1,1,1,1,-1,0,0,-3,1,1,1,0,0,1,0,0,1,1,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,1),new Array(1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,1,-1,0,-3,1,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,1),new Array(1,0,0,0,0,0,0,0,0,1,-1,0,0,0,0,0,0,0,1,0,0,0,-3,0,0,1,0,0,0,1,0,0,0,1,0,1,-1,0,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,1,1,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,1,1,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(35,4);
               this.StartPosWater = new b2Vec2(3,27);
               this.CreateFinish(new b2Vec2(3,26.5),new b2Vec2(35,3.5));
            }
            if(param2 == 5)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,1),new Array(1,1,1,-1,0,0,1,1,1,1,1,1,1,-1,0,0,-2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,-2,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,-2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,-2,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,1,-1,0,0,-2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,-2,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,-2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1),new Array(1,1,-1,0,0,-2,1,0,0,-2,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,-2,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,-2,1,1,1,1,-1,0,0,-2,1,1,1,1,0,0,-2,1,1,1,1,1,1,1,1,-1,0,0,-2,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(27,3);
               this.StartPosWater = new b2Vec2(2,3);
               this.CreateFinish(new b2Vec2(13,22.5),new b2Vec2(35,22.5));
            }
            if(param2 == 6)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,-3,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,-1,0,0,1),new Array(1,0,0,0,0,-3,1,1,51,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,52,1,1,1,51,5,52,-4,0,0,0,-3,0,0,1),new Array(1,0,0,0,0,0,0,-3,1,-4,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,1,1,1,-4,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,1),new Array(1,1,1,1,-1,0,0,-2,1,-1,0,0,-2,1,-1,0,0,-2,1,51,5,5,5,5,5,52,-1,0,0,0,0,0,0,1,-4,0,0,-3,1),new Array(1,1,1,1,1,0,0,1,1,1,0,0,1,1,1,0,0,1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1),new Array(1,1,1,1,1,0,0,1,1,1,0,0,1,1,1,0,0,1,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1,-4,0,0,0,0,1),new Array(1,1,1,1,1,0,0,1,1,1,0,0,1,1,1,0,0,1,1,1,0,0,0,0,0,0,0,0,0,1,-4,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,0,0,1,1,1,0,0,1,1,1,0,0,1,1,1,0,0,0,0,-2,61,6,6,62,-4,0,0,0,0,0,-2,0,0,1),new Array(1,1,1,1,1,0,0,1,1,1,0,0,1,1,1,0,0,1,1,1,0,0,0,0,1,-4,0,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,1,1,1,-4,0,0,-3,1,-4,0,0,-3,1,-4,0,0,-3,1,-4,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,-2,0,0,1,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,-2,1,1,1,1,0,0,1,0,0,1),new Array(1,0,0,-2,1,1,1,61,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,62,1,0,0,0,1,1,1,1,0,0,0,1,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,0,0,0,1,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,1,0,0,1),new Array(1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-4,0,0,0,-3,1,1,1,-4,0,0,1),new Array(1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,51,5,52,1,1,1,61,6,62,1,1,71,7,72,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,-2,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(2,5);
               this.StartPosWater = new b2Vec2(3,5);
               this.CreateFinish(new b2Vec2(33,23.5),new b2Vec2(29,26.5));
               this.CreateSlidePlatform(new b2Vec2(10,1),0.5,1.5,new b2Vec2(0,1),-4,0,0,"pusher",3);
               this.CreatePusher(new b2Vec2(26,7),2,3,true);
            }
            if(param2 == 7)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,-3,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1,1,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,-1,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,-2,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1),new Array(1,1,-1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,-2,1,1,1,71,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,72,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,71,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,72,1,1,1,1,-1,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1),new Array(1,1,1,1,1,61,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,62,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(2,27);
               this.StartPosWater = new b2Vec2(3,27);
               this.CreateFinish(new b2Vec2(35,2.5),new b2Vec2(35,9.5));
               this.CreateSlidePlatform(new b2Vec2(9,28.5),0.5,1.5,new b2Vec2(0,-1),-1.5,0,0,"pusher",3);
               this.CreatePusher(new b2Vec2(31,27),2,3,true);
               this.CreateSlidePlatform(new b2Vec2(16,28.5),0.5,1.5,new b2Vec2(0,-1),-1.5,0,0,"pusher",3);
               this.CreatePusher(new b2Vec2(31,27),2,3,false);
               this.CreateSlidePlatform(new b2Vec2(22,28.5),0.5,1.5,new b2Vec2(0,-1),-1.5,0,0,"pusher",3);
               this.CreatePusher(new b2Vec2(31,27),2,3,false);
               this.CreateSlidePlatform(new b2Vec2(8,21),0.5,1.5,new b2Vec2(0,1),-1,0,0,"pusher",2);
               this.CreatePusher(new b2Vec2(30,21),2,2,true);
               this.CreateSlidePlatform(new b2Vec2(16,21),0.5,1.5,new b2Vec2(0,1),-1,0,0,"pusher",2);
               this.CreatePusher(new b2Vec2(30,21),2,2,false);
               this.CreateSlidePlatform(new b2Vec2(24,21),0.5,1.5,new b2Vec2(0,1),-1,0,0,"pusher",2);
               this.CreatePusher(new b2Vec2(30,21),2,2,false);
               this.CreateSlidePlatform(new b2Vec2(16,9),0.5,1.5,new b2Vec2(0,-1),-3,0,0,"pusher",4);
               this.CreatePusher(new b2Vec2(5,3),2,4,true);
               this.CreateSlidePlatform(new b2Vec2(19,14),0.5,1.5,new b2Vec2(-1,0),-3,0,0,"pusher",4);
               this.CreatePusher(new b2Vec2(5,3),2,4,false);
               this.CreateSlidePlatform(new b2Vec2(26,12),0.5,1.5,new b2Vec2(0,-1),-3,0,0,"pusher",4);
               this.CreatePusher(new b2Vec2(5,3),2,4,false);
               this.CreateSlidePlatform(new b2Vec2(29,9),0.5,1.5,new b2Vec2(0,-1),-3,0,0,"pusher",4);
               this.CreatePusher(new b2Vec2(5,3),2,4,false);
            }
         }
         else if(param1 == "adventure")
         {
            if(param2 == 2)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,0,0,1,1,1,1,1,-4,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,0,0,1,1,1,1,-4,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,0,0,1,1,1,-4,0,0,0,"rd",0,0,1),new Array(1,0,0,0,0,0,0,"bd",0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,0,0,1,1,1,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,0,0,1,1,1,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,-2,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,-1,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,-2,1,1,1,1,-4,0,0,0,1,0,0,0,1,1,1,1,0,0,0,1,0,0,0,0,-3,1,1,1,1,-1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,-1,0,0,"bd",0,0,0,0,0,0,1,0,0,0,0,1,1,0,0,0,0,1,0,0,0,0,0,0,0,"rd",0,0,-2,1,1,1),new Array(1,0,0,0,0,0,0,0,0,-2,-4,0,0,-3,1,1,1,1,1,1,1,1,1,1,1,-4,0,0,-3,-1,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,-2,1,1,1,1,1,-1,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,-2,1,1,1,1,1,-1,0,0,0,1),new Array(1,0,"rd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"bd",0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"bd",0,"rd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1),new Array(1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1),new Array(1,0,0,0,-3,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,-4,0,0,0,1),new Array(1,0,"bd",0,0,0,0,0,0,-2,-4,0,0,-3,-1,0,0,0,0,0,0,0,0,0,-2,-4,0,0,-3,-1,0,0,0,0,0,0,"rd",0,1),new Array(1,0,0,0,0,0,0,0,-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,-2,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,-1,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,-2,1,1,1,-1,0,0,-2,1,1,-1,0,0,0,0,0,-2,1,1,-1,0,0,-2,1,1,1,-1,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(34,20);
               this.StartPosWater = new b2Vec2(5,21);
               this.CreateFinish(new b2Vec2(15.5,13.5),new b2Vec2(21.5,13.5));
               this.CreateLightBeamer(new b2Vec2(1,16.5),0,16777113);
               this.CreateLightBeamer(new b2Vec2(26.5,1),Math.PI / 2,6671615);
               this.CreateSlidePlatform(new b2Vec2(15,10),0.5,1.5,new b2Vec2(0,-1),-3,0,0,"lpusher",6);
               this.CreateLightPusher(new b2Vec2(37,16.5),-Math.PI / 2,16777113,true);
               this.CreateSlidePlatform(new b2Vec2(22,10),0.5,1.5,new b2Vec2(0,-1),-3,0,0,"lpusher",5);
               this.CreateLightPusher(new b2Vec2(11.5,1),Math.PI,6671615,true);
               this.CreateRotMirror(new b2Vec2(11.5,16.5),Math.PI / 2,0,1);
               this.CreateLever(new b2Vec2(6,9),1,"r","l",true);
               this.CreateRotMirror(new b2Vec2(26.5,16.5),0,0,3);
               this.CreateLever(new b2Vec2(32,9),3,"l","r",true);
               this.CreateRotMirror(new b2Vec2(11.5,25.5),Math.PI / 2,0,2);
               this.CreateLever(new b2Vec2(3,27),2,"r","l",true);
               this.CreateRotMirror(new b2Vec2(26.5,25.5),Math.PI / 2,0,4);
               this.CreateLever(new b2Vec2(35,27),4,"r","l",true);
            }
            if(param2 == 5)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,"bd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,-2,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,-1,0,0,0,0,0,0,"rd",0,1),new Array(1,0,0,0,-2,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,-2,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,-1,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,-1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,1,1,1,1,1),new Array(1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"bd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,1,0,0,0,1,1,1,1,1,0,0,1,1,-1,0,-2,1,1,0,0,1,1,1,1,1,1,1,0,0,1),new Array(1,0,0,0,0,0,0,1,1,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,1,1,1,1,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,1,1,1,1,1,1,0,0,0,1,0,0,0,1,0,0,-1,0,-2,1,-1,0,-2,0,0,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,"rd",0,1,0,0,0,1,0,0,1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,1),new Array(1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,"rd",0,0,1,0,0,1,0,0,0,0,0,0,0,0,1),new Array(1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,1),new Array(1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,0,0,1,1,1,1,1,1,1,0,0,1,0,0,0,0,0,0,0,0,1),new Array(1,-4,0,-3,-1,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1),new Array(1,0,"bd",0,-3,-1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,"bd",0,0,0,0,0,1),new Array(1,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,-1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"rd",0,0,0,0,0,-2,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(15,11);
               this.StartPosWater = new b2Vec2(15,22);
               this.CreateFinish(new b2Vec2(7,3.5),new b2Vec2(10,3.5));
               this.CreateRotMirror(new b2Vec2(11,10.5),0,0,4);
               this.CreateLever(new b2Vec2(7,21),4,"r","l",true);
               this.CreateRotMirror(new b2Vec2(18.5,10.5),0,0,3,true);
               this.CreateRotMirror(new b2Vec2(36.5,10.5),0,0,3,true);
               this.CreateRotMirror(new b2Vec2(36.5,13.5),Math.PI / 2,0,3,true);
               this.CreateRotMirror(new b2Vec2(27.5,13.5),0,0,1);
               this.CreateLever(new b2Vec2(36,8),1,"r","l",true);
               this.CreateLightBeamer(new b2Vec2(1,26.5),0,16777113);
               this.CreateSlidePlatform(new b2Vec2(2,6),0.5,1.5,new b2Vec2(0,1),-4,0,0,"lpusher",6);
               this.CreateLightPusher(new b2Vec2(18.5,3),Math.PI,16777113,true);
               this.CreateMovingMirror(new b2Vec2(21.5,23),new b2Vec2(0.95,0.95),0);
               this.CreateMovingMirror(new b2Vec2(24.5,23),new b2Vec2(0.95,0.95),90);
               this.CreateMovingMirror(new b2Vec2(13.5,25),new b2Vec2(0.95,0.95),90);
            }
            if(param2 == 3)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,"rd",0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,-2,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,"bd",0,0,1,1,1,-4,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,-2,1,1,-4,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,0,0,0,0,0,0,0,0,-2,1,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,-1,0,0,0,0,0,0,-2,1,-4,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,-1,0,0,0,0,-2,1,1,0,0,0,"bd",0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-4,0,0,0,0,0,0,0,0,-3,1,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,-1,0,0,0,0,0,0,0,0,"rd",0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,-3,1,1,1,1,-1,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,0,0,0,0,0,0,0,0,-3,1,-1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,-1,0,0,0,0,0,0,0,0,0,-3,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,-4,0,-3,-1,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-4,0,0,0,-3,-1,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,"bd",0,0,0,1,0,0,0,0,1,1,1,-1,0,1),new Array(1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,-4,0,0,-2,0,0,1,71,7,7,72,1,1,-4,0,0,1),new Array(1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,0,0,-2,1,0,0,-3,1,1,1,1,1,-4,0,0,0,1),new Array(1,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,1,1,-1,0,0,0,-3,1,-4,0,0,0,0,-2,1),new Array(1,0,0,0,1,0,1,0,0,0,0,"rd",0,0,"bd",0,0,0,0,1,0,1,0,0,1,1,1,0,0,0,0,1,0,0,0,0,0,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,0,0,0,-2,1,-1,0,"rd",0,0,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,-1,0,0,0,0,0,0,0,0,-2,1,1),new Array(1,0,0,0,-2,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,-1,0,1,1,1,1,1,0,0,0,0,0,0,0,-2,1,1,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(8,27);
               this.StartPosWater = new b2Vec2(29,27);
               this.CreateFinish(new b2Vec2(35,2.5),new b2Vec2(2,26.5));
               this.CreateSlidePlatform(new b2Vec2(5,26),1.5,0.5,new b2Vec2(0,-1),-3,0,0,"lever",3);
               this.CreateLever(new b2Vec2(28,4),3,"l","r",true);
               this.CreateSlidePlatform(new b2Vec2(20,26),1.5,0.5,new b2Vec2(0,-1),-3,0,0,"lever",3);
               this.CreateLever(new b2Vec2(28,4),3,"l","r",false);
               this.CreateMirrorSlider(new b2Vec2(12.5,26.5),10,-Math.PI / 4,2,true);
               this.CreateInfiniteMirror(new b2Vec2(11,16.6),0,0,2);
               this.CreateLightBeamer(new b2Vec2(2.5,20),-Math.PI / 2,6671615);
               this.CreateLightBeamer(new b2Vec2(19.5,20),-Math.PI / 2,16777113);
               this.CreateRotMirror(new b2Vec2(2.5,3.5),Math.PI / 2 + 0.5,0,3,true);
               this.CreateRotMirror(new b2Vec2(19.5,3.5),-0.5,0,3,true);
               this.CreateSlidePlatform(new b2Vec2(36,7),0.5,1.5,new b2Vec2(0,1),-4,0,0,"lpusher",6);
               this.CreateLightPusher(new b2Vec2(1,12.5),Math.PI / 2,16777113,true);
               this.CreateSlidePlatform(new b2Vec2(36,15),0.5,1.5,new b2Vec2(0,-1),-4,0,0,"lpusher",5);
               this.CreateLightPusher(new b2Vec2(14,1),Math.PI,6671615,true);
               this.CreateSlidePlatform(new b2Vec2(25,15),1.5,0.5,new b2Vec2(0,-1),-3,0,0,"lpusher",5);
               this.CreateLightPusher(new b2Vec2(21,10.5),-Math.PI / 2,6671615,true);
            }
            if(param2 == 1)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,-4,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,-1,0,0,0,0,0,0,0,0,-2,0,1,1,1,-4,0,0,0,0,0,0,1),new Array(1,0,0,0,1,0,0,0,0,0,1,0,0,0,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,-4,0,0,0,0,0,0,0,1),new Array(1,0,0,0,1,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,-2,1,1,1,1),new Array(1,0,0,0,1,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,"bd",0,0,1,0,0,0,1),new Array(1,0,0,0,1,0,0,0,0,0,1,0,0,0,1,0,0,0,-2,0,0,0,"rd",0,0,1,0,0,0,1,0,0,0,0,1,0,0,0,1),new Array(1,0,0,0,1,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,1,0,0,0,1),new Array(1,0,0,0,1,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,1,0,0,0,1),new Array(1,0,0,0,1,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,-3,1,1,1,1,1,1,1,0,0,0,1,0,0,0,1,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,1,0,0,0,-4,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,"rd",0,0,0,1,0,0,0,1,0,0,0,1,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,1,0,"rd",0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,1,0,0,0,1,0,"bd",0,1,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,0,0,0,1),new Array(1,1,1,1,1,0,0,0,0,0,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,-4,0,0,0,1,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,-4,0,0,0,1,0,0,0,0,0,0,0,0,1,0,"bd",0,0,0,0,0,0,0,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,-4,0,0,-3,1),new Array(1,1,1,1,-1,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,-2,0,0,0,1,0,0,0,0,1),new Array(1,1,1,1,1,-1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,-2,1,1,1,1,1,0,0,0,0,1),new Array(1,1,1,1,1,1,-1,0,0,0,-2,0,0,0,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,1,1,1,1,1,1,-1,0,0,-2,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(8,27);
               this.StartPosWater = new b2Vec2(17,24);
               this.CreateFinish(new b2Vec2(22,10.5),new b2Vec2(36,2.5));
               this.CreatePulley(new b2Vec2(2,1.5),new b2Vec2(12,1.5),new b2Vec2(0.2,1.3),new b2Vec2(0.2,1.3),new b2Vec2(2,5),new b2Vec2(12,27.5));
               this.CreatePulley(new b2Vec2(16,1.5),new b2Vec2(27,1.5),new b2Vec2(0.2,1.3),new b2Vec2(0.2,1.3),new b2Vec2(16,17.5),new b2Vec2(27,6));
               this.CreatePulley(new b2Vec2(31,9.5),new b2Vec2(36,9.5),new b2Vec2(0.2,1.3),new b2Vec2(0.2,1.3),new b2Vec2(31,25.5),new b2Vec2(36,12));
               this.CreateSlidePlatform(new b2Vec2(2,6),0.5,1.5,new b2Vec2(1,0),-3,0,0,"lever",1);
               this.CreateLever(new b2Vec2(2,24),1,"l","r",true);
               this.CreateMovingBox2(new b2Vec2(2,5),new b2Vec2(0.95,0.95));
               this.CreateSlidePlatform(new b2Vec2(27,7),0.5,1.5,new b2Vec2(1,0),-3,0,0,"lever",2);
               this.CreateLever(new b2Vec2(22,17),2,"l","r",true);
               this.CreateSlidePlatform(new b2Vec2(19,23),1.5,0.5,new b2Vec2(1,0),-3,0,0,"lever",2);
               this.CreateLever(new b2Vec2(22,17),2,"l","r",false);
               this.CreateMovingBox2(new b2Vec2(27,6),new b2Vec2(0.95,0.95));
               this.CreateSlidePlatform(new b2Vec2(34.5,13),0.5,0.75,new b2Vec2(-1,0),-2,0,0,"pusher",3);
               this.CreatePusher(new b2Vec2(27.5,17),2,3,true);
               this.CreateMovingBox2(new b2Vec2(36,12),new b2Vec2(0.95,0.95));
            }
            if(param2 == 9)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,-4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1),new Array(1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,"rd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,-3,0,0,0,0,0,0,0,-2,1,1,1,1,1,1,1,1,1,61,6,6,6,6,62,-1,0,0,0,0,0,0,1),new Array(1,1,1,1,-1,0,0,0,0,"rd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1),new Array(1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"bd",0,0,0,-2,1,1,1,1,1),new Array(1,1,1,1,1,1,51,5,52,1,0,0,0,0,0,0,0,0,0,0,"bd",0,0,0,0,0,0,0,0,0,0,0,-2,-4,0,0,0,-3,1),new Array(1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,51,5,5,5,52,-4,0,0,0,0,0,1),new Array(1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,1,-4,0,0,0,0,0,0,1),new Array(1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,-2,-4,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,71,7,7,7,7,72,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,-4,0,0,0,0,0,0,0,0,0,0,0,"bd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"rd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,-4,0,0,-3,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,-3,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,-1,0,0,1),new Array(1,0,0,0,0,0,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,61,6,6,62,1,1,1,1,1,0,0,1),new Array(1,0,0,0,0,0,1,1,51,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,52,1,1,1,1,1,1,1,1,1,1,-4,0,0,1),new Array(1,0,0,0,0,0,1,0,-3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,-2,1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"bd",0,0,0,0,0,0,-2,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"rd",0,0,0,"bd",0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1),new Array(1,-1,0,0,0,0,0,0,0,0,0,-2,1,1,1,-1,0,0,0,0,0,0,0,-2,1,1,-1,0,0,0,"rd",0,0,0,-2,1,1,1,1),new Array(1,1,1,1,1,1,1,51,5,5,52,1,1,1,1,1,-1,0,0,0,0,0,-2,1,1,1,1,-1,0,0,0,0,0,-2,1,1,1,1,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,71,7,7,7,72,1,1,1,1,1,1,61,6,6,6,62,1,1,1,1,1,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(34,4);
               this.StartPosWater = new b2Vec2(35,4);
               this.CreateFinish(new b2Vec2(4,20.5),new b2Vec2(13,23.5));
               this.CreateSlidePlatform(new b2Vec2(16,5),1.5,0.5,new b2Vec2(0,-1),-3,0,0,"lever",1);
               this.CreateLever(new b2Vec2(2.5,4),1,"l","r",true);
               this.CreateSlidePlatform(new b2Vec2(22,2),1.5,0.5,new b2Vec2(0,1),-3,0,0,"lever",1);
               this.CreateLever(new b2Vec2(2.5,4),1,"l","r",false);
               this.CreateSlidePlatform(new b2Vec2(3,10),0.5,1.5,new b2Vec2(-1,0),-3,0,0,"lever",1);
               this.CreateLever(new b2Vec2(2.5,4),1,"l","r",false);
               this.CreateSlidePlatform(new b2Vec2(13,19),0.5,1.5,new b2Vec2(0,-1),-2,0,0,"lever",2);
               this.CreateLever(new b2Vec2(33,16),2,"l","r",true);
               this.CreateSlidePlatform(new b2Vec2(20,17),0.5,1.5,new b2Vec2(0,1),-2,0,0,"lever",2);
               this.CreateLever(new b2Vec2(33,16),2,"l","r",false);
            }
            if(param2 == 17)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,1),new Array(1,1,1,1,1,1,-1,0,0,-4,0,0,-3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-4,0,0,-3,0,0,0,1),new Array(1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,-4,0,0,0,0,0,-3,1,-4,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,"bd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,-2,1,1,1,0,0,1,61,6,6,62,1,71,7,7,7,7,7,72,1,51,5,5,52,1,1,0,0,-1,0,0,0,1),new Array(1,0,0,-2,1,1,1,-4,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,-3,-1,0,0,1),new Array(1,0,0,1,0,0,0,0,0,0,0,0,0,-3,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,1),new Array(1,0,-2,1,0,0,0,0,0,0,0,0,0,0,-3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,0,0,0,1,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,0,0,0,0,0,"rd",0,0,0,0,0,0,0,0,1,-4,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,"bd",0,-3,0,0,1),new Array(1,1,-1,0,0,0,0,0,0,0,0,0,0,0,-2,-4,0,0,0,0,0,1,0,0,-2,1,1,1,-1,0,0,0,0,0,0,0,0,0,1),new Array(1,0,-3,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,-3,1,1,1,1,0,0,0,0,0,0,1),new Array(1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,"rd",0,0,0,0,0,0,0,0,0,0,0,0,-2,1),new Array(1,0,0,1,51,5,5,52,-4,0,0,0,-2,61,6,6,62,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,-1,0,-2,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,-1,0,0,0,0,0,0,0,-3,1,1,1,1),new Array(1,0,"bd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,-1,0,0,0,0,0,0,1,1),new Array(1,0,0,0,0,0,0,-2,1,1,0,0,0,-2,1,61,6,6,62,1,1,1,1,1,0,0,1,1,1,1,1,-1,0,0,0,"rd",0,1,1),new Array(1,0,0,0,0,0,-2,1,1,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1),new Array(1,-1,0,0,0,-2,1,1,1,1,0,0,-2,1,0,0,0,0,0,0,0,0,"rd",0,0,0,0,0,"bd",0,0,0,0,0,0,0,-2,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(17,6);
               this.StartPosWater = new b2Vec2(25,6);
               this.CreateFinish(new b2Vec2(1.7,3.5),new b2Vec2(4.2,3.5));
               this.CreateLightBeamer(new b2Vec2(10.5,1),Math.PI / 2,16777113);
               this.CreateLightBeamer(new b2Vec2(32.5,1),Math.PI / 2,6671615);
               this.CreateSlidePlatform(new b2Vec2(7,5),0.5,1.5,new b2Vec2(0,1),-4,0,0,"lpusher",6);
               this.CreateLightPusher(new b2Vec2(1,26.5),Math.PI / 2,16777113,true);
               this.CreateSlidePlatform(new b2Vec2(2,12),0.5,1.5,new b2Vec2(1,0),-3,0,0,"lpusher",5);
               this.CreateLightPusher(new b2Vec2(36,26.5),-Math.PI / 2,6671615,true);
               this.CreateMovingMirror(new b2Vec2(28.5,21),new b2Vec2(0.95,0.95),90);
               this.CreateSlidePlatform(new b2Vec2(10.5,9),0.5,1,new b2Vec2(-1,0),-2,0,0,"lever",1);
               this.CreateLever(new b2Vec2(18,13),1,"l","r",true);
               this.CreateSlidePlatform(new b2Vec2(32.5,9),0.5,1,new b2Vec2(-1,0),-2,0,0,"lever",2);
               this.CreateLever(new b2Vec2(18,18),2,"l","r",true);
               this.CreateSlidePlatform(new b2Vec2(24.5,23),0.5,1,new b2Vec2(-1,0),-2,0,0,"lever",3);
               this.CreateLever(new b2Vec2(20,22),3,"l","r",true);
               this.CreateMovingMirror(new b2Vec2(18,26),new b2Vec2(0.95,0.95),0);
            }
            if(param2 == 7)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"rd",0,"rd",0,1),new Array(1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,-1,0,0,0,0,0,-2,1,1,1,0,0,0,1,-4,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,1,1,1,1,1),new Array(1,1,1,1,1,1,1,1,1,1,-4,0,0,0,0,0,0,0,0,0,"bd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"bd",0,"bd",0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,-4,0,0,0,0,0,-2,0,0,0,1,1,1,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,1,1,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,-2,0,0,1,0,0,0,0,-3,1,1,1,1,1,1,1),new Array(1,0,0,0,0,"rd",0,-2,1,0,0,0,0,1,-1,0,0,0,0,0,0,0,-2,1,0,0,1,-1,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,0,0,1,1,-1,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,1,0,0,1,1,1,-1,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,-2,1,1,1,-4,0,"bd",0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,1,1,1,1,-1,0,0,0,0,0,0,0,1),new Array(1,0,0,0,1,1,1,1,0,0,0,0,-2,1,1,1,-1,0,0,0,0,1,1,1,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,1,0,0,0,0,1,1,1,0,0,-3,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,"rd",0,0,1,1,-4,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,1),new Array(1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1),new Array(1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1),new Array(1,0,0,1,-4,0,0,1,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,-3,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,0,0,1),new Array(1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,"bd",0,0,1),new Array(1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,-4,0,0,0,0,-3,1,1,1,1,1,1,0,0,0,0,1),new Array(1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,-4,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,1,-1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,1,1,1,1,1,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.LightSpeed = 40;
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(19.5,12);
               this.StartPosWater = new b2Vec2(14.5,14);
               this.CreateFinish(new b2Vec2(33,13.5),new b2Vec2(36,13.5));
               this.CreateLightBeamer(new b2Vec2(1,26.5),0,16777113);
               this.CreateMovingMirror(new b2Vec2(8.5,26.5),new b2Vec2(0.95,0.95),90);
               this.CreateMovingMirror(new b2Vec2(12,24.5),new b2Vec2(0.95,0.95),90);
               this.CreateMovingMirror(new b2Vec2(18,22.5),new b2Vec2(0.95,0.95),0);
               this.CreateMovingMirror(new b2Vec2(11,19.5),new b2Vec2(0.95,0.95),0);
               this.CreateMovingMirror(new b2Vec2(23,20.5),new b2Vec2(0.95,0.95),0);
               this.CreateMovingMirror(new b2Vec2(27,20.5),new b2Vec2(0.95,0.95),90);
               this.CreateMovingMirror(new b2Vec2(31,20.5),new b2Vec2(0.95,0.95),90);
               this.CreateSlidePlatform(new b2Vec2(28,7),0.5,1.5,new b2Vec2(1,0),-3,0,0,"lpusher",6);
               this.CreateLightPusher(new b2Vec2(37,21),-Math.PI / 2,16777113,true);
               this.CreateSlidePlatform(new b2Vec2(28,8),0.5,1.5,new b2Vec2(1,0),-3,0,0,"lever",2);
               this.CreateLever(new b2Vec2(7,4),2,"l","r",true);
               this.CreateSlidePlatform(new b2Vec2(28,9),0.5,1.5,new b2Vec2(1,0),-3,0,0,"pusher",1);
               this.CreatePusher(new b2Vec2(36.5,25),2,1,true);
               this.CreateSlidePlatform(new b2Vec2(15,4),0.5,1.5,new b2Vec2(0,-1),-3,0,0,"lpusher",6);
               this.CreateLightPusher(new b2Vec2(24.5,1),Math.PI,16777113,true);
               this.CreateSlidePlatform(new b2Vec2(32,2),1.5,0.5,new b2Vec2(0,1),-3,0,0,"lpusher",6);
               this.CreateLightPusher(new b2Vec2(19.5,14),Math.PI,16777113,true);
               this.CreateSlidePlatform(new b2Vec2(31,5),1.5,0.5,new b2Vec2(0,-1),-3,0,0,"lpusher",6);
               this.CreateLightPusher(new b2Vec2(14.5,16),Math.PI,16777113,true);
            }
            if(param2 == 8)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,-4,0,0,0,0,0,0,0,0,1,1,-4,0,0,0,0,-3,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,1,-4,0,0,0,0,0,0,-3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,0,0,0,0,"bd",0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,0,0,0,0,0,-2,1,1,1,-4,0,0,1,1,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,1),new Array(1,0,0,0,0,-2,-4,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,-1,0,0,0,0,0,-2,1,-1,0,0,0,1,0,0,1),new Array(1,0,0,0,0,1,0,0,0,0,0,0,"bd",0,0,0,0,0,0,0,0,0,0,-3,-1,0,0,0,0,1,0,0,0,0,0,1,0,0,1),new Array(1,0,0,0,-2,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,-4,0,0,0,0,0,1,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"rd",0,0,-2,1,1,1,1,0,0,1),new Array(1,0,0,1,1,1,1,1,1,1,-4,0,0,0,0,0,0,-3,1,1,1,51,5,5,52,1,0,0,0,0,0,0,1,0,0,0,0,0,1),new Array(1,0,0,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,0,0,0,0,0,0,1,1,1,1,0,0,1),new Array(1,0,0,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,0,0,0,0,1,0,0,1,0,0,1),new Array(1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,1,0,0,1,0,0,1),new Array(1,0,0,-3,0,0,0,0,0,0,0,0,"rd",0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,-1,0,0,0,1,0,0,1,0,0,1),new Array(1,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-4,0,-3,1,0,0,1,0,0,1,0,0,1),new Array(1,0,"rd",0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,1),new Array(1,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1),new Array(1,0,0,0,0,1,1,1,1,1,-4,0,0,0,0,0,0,-3,1,1,1,1,61,6,6,62,-1,0,0,0,-2,1,1,1,1,1,0,0,1),new Array(1,0,"bd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,-4,0,0,0,0,0,0,0,1,-4,0,0,-3,1,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,"bd",0,0,0,0,0,0,1,0,0,0,0,1,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,-2,1,1,1,0,0,"rd",0,1,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,-2,1,-4,0,0,0,0,0,0,1,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,-1,0,0,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,0,0,0,0,0,0,0,0,0,1,0,0,1),new Array(1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,1),new Array(1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,1),new Array(1,1,1,1,1,1,1,1,1,1,1,71,7,7,7,7,7,72,-1,0,0,0,0,0,0,0,0,0,0,0,1,-1,0,0,-2,1,0,0,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(19,15);
               this.StartPosWater = new b2Vec2(6,24);
               this.CreateFinish(new b2Vec2(21,3.5),new b2Vec2(26,5.5));
               this.CreateWind(new b2Vec2(8,20),new b2Vec2(10,27),1,5,"normal",true);
               this.CreateWind(new b2Vec2(9,15),new b2Vec2(18,17),2,1,"lever",false);
               this.CreateLever(new b2Vec2(23,27),1,"l","l",true);
               this.CreateWind(new b2Vec2(13,4),new b2Vec2(15,12),3,1,"lever",false);
               this.CreateLever(new b2Vec2(23,27),1,"l","r",false);
               this.CreateSlidePlatform(new b2Vec2(37,17),0.5,1.5,new b2Vec2(-1,0),-3,0,0,"lever",4);
               this.CreateLever(new b2Vec2(6,17),4,"r","l",true);
               this.CreateSlidePlatform(new b2Vec2(37,10),0.5,1.5,new b2Vec2(-1,0),-3,0,0,"pusher",3);
               this.CreatePusher(new b2Vec2(8,3),2,3,true);
               this.CreateLightBeamer(new b2Vec2(36.5,27),-Math.PI / 2,16777113);
               this.CreateSlidePlatform(new b2Vec2(30,23),1.5,0.5,new b2Vec2(0,1),-3,0,0,"lpusher",6);
               this.CreateLightPusher(new b2Vec2(36.5,1),Math.PI,16777113,true);
               this.CreateSlidePlatform(new b2Vec2(30,2),1.5,0.5,new b2Vec2(0,1),-3,0,0,"lever",5);
               this.CreateLever(new b2Vec2(32,24),5,"l","r",true);
            }
            if(param2 == 6)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"bd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1),new Array(1,1,1,1,1,0,0,0,-3,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,-4,0,0,0,0,0,0,0,-3,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,"rd",0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,-2,1,1,-1,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,0,0,0,0,0,0,0,0,0,-2,1,1,1,-4,0,0,0,-2,1),new Array(1,0,0,0,0,-2,1,61,6,6,6,6,62,1,1,1,1,1,1,1,-1,0,-2,1,1,1,1,1,1,-4,0,0,0,0,0,0,0,1,1),new Array(1,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1),new Array(1,0,0,0,0,1,1,1,1,1,1,1,1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,1,1,1,1),new Array(1,0,"bd",0,0,1,1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,-4,0,0,0,0,-3,1),new Array(1,0,0,0,0,-3,1,1,-4,0,0,0,0,0,0,0,-2,1,1,1,1,1,1,-4,0,0,0,0,0,0,-3,1,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,-3,1,0,0,-2,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1),new Array(1,-1,0,0,0,0,0,-3,-1,0,0,0,0,0,0,0,0,-3,1,1,1,1,1,-1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1),new Array(1,1,-1,0,0,0,0,0,-3,-1,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,1,1,-1,0,-2,1,0,0,0,0,0,0,1),new Array(1,1,1,1,-1,0,0,0,0,-3,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,0,0,0,0,0,0,1),new Array(1,0,0,0,-3,-1,0,0,0,0,-3,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,1),new Array(1,0,0,0,0,-3,-1,0,0,0,0,-3,1,1,1,1,1,1,1,-1,0,0,0,0,-3,1,-1,0,0,1,1,1,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,1,1,1,1,-4,0,0,-3,-1,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,-4,0,0,0,0,-3,-1,0,0,0,0,0,0,-2,1,1,1,0,0,0,0,0,0,1),new Array(1,1,1,1,1,0,0,0,"rd",0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,0,0,0,0,0,-3,1,1,1,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,-1,0,0,0,0,0,0,0,-3,-1,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,1,1,1,1,51,5,5,5,5,52,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,-1,0,-2,1,-1,0,0,0,-2,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(2,3);
               this.StartPosWater = new b2Vec2(3,3);
               this.CreateFinish(new b2Vec2(2.5,26.5),new b2Vec2(2.5,21.5));
               this.CreateSlidePlatform(new b2Vec2(28,9),0.5,1.5,new b2Vec2(0,-1),-3,0,0,"pusher",3);
               this.CreatePusher(new b2Vec2(16.5,9),2,3,true);
               this.CreateSlidePlatform(new b2Vec2(25,13),0.5,1.5,new b2Vec2(0,1),-3,0,0,"pusher",3);
               this.CreatePusher(new b2Vec2(16.5,9),2,3,false);
               this.CreateSlidePlatform(new b2Vec2(6,23.5),2,0.5,new b2Vec2(0,1),-4,0,0,"pusher",2);
               this.CreatePusher(new b2Vec2(30,27),2,2,true);
               this.CreateBall(new b2Vec2(10,3));
               this.CreateMovingBox(new b2Vec2(14,9),new b2Vec2(0.95,0.95));
            }
            if(param2 == 10)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,-4,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,-4,0,-3,1,0,0,0,0,0,0,0,0,0,0,"bd",0,0,0,0,0,0,-3,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,1,1,1,1,1,1,51,5,5,5,52,-1,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,-1,0,-2,-4,0,0,0,-3,1,1,1,1,1,1,1,1,1,1,-1,0,0,0,1),new Array(1,1,0,0,0,-2,1,1,1,1,1,1,1,1,1,1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,0,"rd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,0,0,0,0,0,0,0,0,0,0,0,-2,-1,0,0,0,0,0,0,-2,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,-1,0,0,"bd",0,-3,1,-1,0,0,-2,1,1,1,1),new Array(1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,-3,1),new Array(1,1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1),new Array(1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,0,0,0,0,"rd",0,1),new Array(1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,0,1),new Array(1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,"rd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"bd",0,1,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1),new Array(1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"bd",0,1),new Array(1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,-3,-1,0,0,1),new Array(1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,"rd",0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,1,1,71,7,7,7,7,7,72,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,-2,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(2,23);
               this.StartPosWater = new b2Vec2(4,23);
               this.CreateFinish(new b2Vec2(7.5,3.5),new b2Vec2(11.5,3.5));
               this.CreatRoman(new b2Vec2(12,17),3,13,"l");
               this.CreatRoman(new b2Vec2(25,23),2.6,14,"r");
               this.CreateSlidePlatform(new b2Vec2(5,7),1.5,0.5,new b2Vec2(-1,0),-4,0,0,"pusher",3);
               this.CreatePusher(new b2Vec2(27.5,11),2,3,true);
               this.CreateSlidePlatform(new b2Vec2(36,24),0.5,1.5,new b2Vec2(-1,0),-3,0,0,"pusher",3);
               this.CreatePusher(new b2Vec2(27.5,11),2,3,false);
               this.CreateSlidePlatform(new b2Vec2(21,3),0.5,1.5,new b2Vec2(1,0),-3,0,0,"pusher",4);
               this.CreatePusher(new b2Vec2(26.5,2),2,4,true);
               this.CreateMovingBox(new b2Vec2(25,2),new b2Vec2(0.95,0.95));
               this.CreateMovingBox(new b2Vec2(22,10),new b2Vec2(0.95,0.95));
               this.CreateSlidePlatform(new b2Vec2(3.5,5),0.5,2,new b2Vec2(0,-1),-5,0,0,"lever",6);
               this.CreateLever(new b2Vec2(29,27),6,"l","r",true);
               this.CreateWind(new b2Vec2(6,19.5),new b2Vec2(17,22.5),2,1,"normal",true);
            }
            if(param2 == 11)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,-4,0,0,0,-3,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,"rd",0,0,0,1,1,1,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,-3,1,1,1,0,0,0,1,0,0,0,0,0,0,0,"bd",0,0,-2,1,1,1,1,1,1,1,1,1,-1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,-3,1,0,0,0,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-4,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,"rd",0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,-4,0,0,0,-2,1,1,1,1,1),new Array(1,-1,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-4,0,0,0,1),new Array(1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,-4,0,0,0,0,0,0,0,1,0,0,0,1,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,"rd",0,0,0,0,0,1,1,0,0,0,1,0,0,0,-2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,-1,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,0,0,0,1,1,1,1,-1,0,0,"bd",0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,-4,0,0,0,0,0,0,0,1,0,0,0,1,1,0,0,0,1,-4,0,-3,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,"rd",0,0,0,0,0,1,1,0,0,0,1,0,0,0,-3,1,1,1,1,61,6,6,62,1,1,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1,0,"bd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,-1,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,1,1),new Array(1,-4,0,0,0,0,0,0,0,1,0,0,0,1,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,-4,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1,0,0,0,-2,1,1,1,1,1,1,1,1,1,-4,0,0,"bd",0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,-1,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,0,0,0,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,-2,1,1,1,1,1),new Array(1,-4,0,0,0,-3,1,-4,0,0,0,0,0,-3,1,0,0,0,1,-4,0,0,0,0,0,-3,-1,0,0,0,0,0,-2,-4,0,0,0,-3,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,0,0,0,"bd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,"rd",0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(5,21);
               this.StartPosWater = new b2Vec2(30,9);
               this.CreateFinish(new b2Vec2(3,26.5),new b2Vec2(35,26.5));
               this.CreatePulley(new b2Vec2(11,1.5),new b2Vec2(16,1.5),new b2Vec2(0.2,1.3),new b2Vec2(0.2,1.3),new b2Vec2(11,22.5),new b2Vec2(16,10));
               this.CreateSlidePlatform(new b2Vec2(12.5,22),0.5,1,new b2Vec2(1,0),-1,0,0,"pusher",3);
               this.CreatePusher(new b2Vec2(20.5,22),2,3,true);
               this.CreateSlidePlatform(new b2Vec2(12.5,17),0.5,1,new b2Vec2(1,0),-1,0,0,"pusher",3);
               this.CreatePusher(new b2Vec2(35,17),2,3,true);
               this.CreateSlidePlatform(new b2Vec2(12.5,12),0.5,1,new b2Vec2(1,0),-1,0,0,"pusher",3);
               this.CreatePusher(new b2Vec2(20,12),2,3,true);
               this.CreateSlidePlatform(new b2Vec2(9,16),1.5,0.5,new b2Vec2(0,1),-3,0,0,"lever",6);
               this.CreateLever(new b2Vec2(4,22),6,"l","r",true);
               this.CreateSlidePlatform(new b2Vec2(9,11),1.5,0.5,new b2Vec2(0,1),-3,0,0,"lever",5);
               this.CreateLever(new b2Vec2(4,17),5,"l","r",true);
               this.CreateSlidePlatform(new b2Vec2(9,6),1.5,0.5,new b2Vec2(0,1),-3,0,0,"lever",4);
               this.CreateLever(new b2Vec2(4,12),4,"l","r",true);
               this.CreateSlidePlatform(new b2Vec2(6,26),1.5,0.5,new b2Vec2(0,-1),-3,0,0,"pusher",2);
               this.CreatePusher(new b2Vec2(16.5,27),2,2,true);
               this.CreateSlidePlatform(new b2Vec2(32,26),1.5,0.5,new b2Vec2(0,-1),-3,0,0,"pusher",1);
               this.CreatePusher(new b2Vec2(27.5,5),2,1,true);
               this.CreateMovingBox(new b2Vec2(16,9),new b2Vec2(0.95,0.95));
               this.CreateMovingBox2(new b2Vec2(5,5),new b2Vec2(0.95,0.95));
            }
            if(param2 == 12)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,"rd",0,1,0,"rd",0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,-2,-1,0,0,0,0,0,-3,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,0,0,0,-2,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,0,0,1,1,1,0,1,1,0,1,1,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,-2,1,1,1,0,0,"rd",0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,"bd",0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,"bd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,-3,-1,0,0,0,0,0,0,0,0,0,0,0,"bd",0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,-1,0,0,0,0,0,0,1,-1,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,-1,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(30,9);
               this.StartPosWater = new b2Vec2(10,27);
               this.CreateFinish(new b2Vec2(19,2.5),new b2Vec2(18,26.5));
               this.CreateSlidePlatform(new b2Vec2(23,2),1.5,0.5,new b2Vec2(0,1),-3,0,0,"lever",4);
               this.CreateLever(new b2Vec2(35.5,3),4,"l","r",true);
               this.CreateSlidePlatform(new b2Vec2(26,2),1.5,0.5,new b2Vec2(0,1),-3,0,0,"lever",3);
               this.CreateLever(new b2Vec2(35.5,9),3,"l","r",true);
               this.CreateMirrorSlider(new b2Vec2(26.5,9.5),10,0,2,true);
               this.CreateInfiniteMirror(new b2Vec2(18.5,12.5),0,0,2);
               this.CreateLightBeamer(new b2Vec2(18.5,23),-Math.PI / 2,6671615);
               this.CreateLightBeamer(new b2Vec2(18.5,5),Math.PI / 2,16777113);
               this.CreateSlidePlatform(new b2Vec2(33,4),0.5,1.5,new b2Vec2(0,-1),-4,0,0,"lpusher",5);
               this.CreateLightPusher(new b2Vec2(1,6),Math.PI / 2,6671615,true);
               this.CreateSlidePlatform(new b2Vec2(4,18),0.5,1.5,new b2Vec2(1,0),-3,0,0,"lpusher",6);
               this.CreateLightPusher(new b2Vec2(37,14),-Math.PI / 2,16777113,true);
               this.CreateSlidePlatform(new b2Vec2(12,21),0.5,1.5,new b2Vec2(-1,0),-3,0,0,"lpusher",6);
               this.CreateLightPusher(new b2Vec2(37,24),-Math.PI / 2,16777113,true);
               this.CreateSlidePlatform(new b2Vec2(3,24),0.5,1.5,new b2Vec2(1,0),-3,0,0,"lpusher",6);
               this.CreateLightPusher(new b2Vec2(28.5,27),0,16777113,true);
               this.CreateSlidePlatform(new b2Vec2(34,6),1.5,0.5,new b2Vec2(1,0),-4,0,0,"lpusher",5);
               this.CreateLightPusher(new b2Vec2(12,1),Math.PI,6671615,true);
            }
            if(param2 == 16)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,1),new Array(1,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"rd",0,1,0,0,1,1,1,0,0,1,1),new Array(1,0,0,1,1,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,0,1,0,0,1,1,1,0,0,1,1),new Array(1,0,0,1,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,0,0,1,0,0,1,1,1,0,0,1,1),new Array(1,0,0,1,1,0,0,0,0,0,0,-2,-4,0,0,0,0,0,"bd",0,0,0,0,0,0,0,0,0,0,1,0,0,1,1,1,0,0,1,1),new Array(1,0,0,1,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,1,1,0,0,1,1),new Array(1,0,0,1,1,1,1,1,1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,0,0,1,1,1,0,0,1,1),new Array(1,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,0,0,1,1,1,0,0,1,1),new Array(1,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,1,1,0,0,1,1),new Array(1,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,1,1,0,0,1,1),new Array(1,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,0,0,1,0,0,1,1,1,0,0,1,1),new Array(1,0,0,1,1,0,0,0,0,0,0,-2,1,51,5,5,5,5,5,5,5,5,52,1,1,1,1,0,0,0,0,0,1,1,1,0,0,1,1),new Array(1,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,-4,0,0,0,0,0,0,0,0,0,1,1,0,0,1,1),new Array(1,0,0,1,1,1,1,1,1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,"rd",0,0,0,0,1,0,0,1,1),new Array(1,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,"bd",0,1,0,0,1,1),new Array(1,0,0,1,1,0,0,0,0,0,0,0,0,0,"rd",0,0,0,0,0,0,0,0,0,0,0,0,-3,-4,0,0,0,0,0,1,0,0,1,1),new Array(1,0,0,1,1,0,0,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,"bd",0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,1),new Array(1,0,0,-3,1,0,0,-4,0,0,0,-3,-1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,1,1,0,0,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,0,0,0,0,0,0,0,1,0,0,1,1,1,1,1,1,1,1,0,0,1,1),new Array(1,0,0,0,0,0,0,0,"bd",0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,1,0,0,0,1,0,0,0,0,0,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,1,0,1,0,1,0,0,0,0,0,1,1),new Array(1,1,1,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,-2,1,1,1,1,1,0,0,1,0,1,0,1,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,-1,0,0,0,1,1,1,1,1,1,0,0,1,0,1,0,1,0,0,0,0,0,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,1,1,0,0,1,0,0,0,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,"rd",0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,61,6,6,6,6,6,6,6,6,62,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(6,12);
               this.StartPosWater = new b2Vec2(9,12);
               this.CreateFinish(new b2Vec2(6,5.5),new b2Vec2(9,5.5));
               this.CreateSlidePlatform(new b2Vec2(5.5,17),0.5,1,new b2Vec2(1,0),-2,0,0,"lever",4);
               this.CreateLever(new b2Vec2(2.5,27),4,"l","r",true);
               this.CreateSlidePlatform(new b2Vec2(27.5,19),0.5,1,new b2Vec2(-1,0),-2,0,0,"lever",4);
               this.CreateLever(new b2Vec2(2.5,27),4,"l","r",false);
               this.CreateSlidePlatform(new b2Vec2(25,2),1.5,0.5,new b2Vec2(0,1),-3,0,0,"lpusher",5);
               this.CreateLightPusher(new b2Vec2(37,26.5),-Math.PI / 2,6671615,true);
               this.CreateLightBeamer(new b2Vec2(1.5,1),Math.PI / 2,16777113);
               this.CreateLightBeamer(new b2Vec2(25.5,13),Math.PI / 2,6671615);
               this.CreateSlidePlatform(new b2Vec2(2,7),0.5,1.5,new b2Vec2(1,0),-3,0,0,"pusher",3);
               this.CreatePusher(new b2Vec2(25.5,10),2,3,true);
               this.CreateSlidePlatform(new b2Vec2(17.5,12),0.5,1.5,new b2Vec2(0,-1),-2,0,0,"pusher",3);
               this.CreatePusher(new b2Vec2(25.5,10),2,3,false);
               this.CreateMovingMirror(new b2Vec2(7.5,15.5),new b2Vec2(0.95,0.95),0);
               this.CreateSlidePlatform(new b2Vec2(37.5,22),0.5,1,new b2Vec2(-1,0),-2,0,0,"lpusher",6);
               this.CreateLightPusher(new b2Vec2(21,20.5),-Math.PI / 2,16777113,true);
               this.CreatePulley(new b2Vec2(30.5,1.5),new b2Vec2(35.5,1.5),new b2Vec2(0.2,1),new b2Vec2(0.2,1),new b2Vec2(30.5,15),new b2Vec2(35.5,20));
               this.CreateMovingMirror(new b2Vec2(30.5,14.5),new b2Vec2(0.95,0.95),0);
               this.CreateMovingBox2(new b2Vec2(35.5,19),new b2Vec2(0.95,0.95));
            }
            if(param2 == 14)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,"rd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,-2,1,1,-1,0,0,0,0,0,"rd",0,0,0,"bd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,"bd",0,0,0,0,0,0,0,-3,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,-1,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,1,0,0,0,0,1),new Array(1,0,0,0,0,0,0,"rd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"bd",0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,1,1,1,71,7,7,7,72,1,1,1,1,-1,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"rd",0,0,0,0,0,0,0,"bd",0,0,0,0,0,0,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,61,6,6,6,62,1,1,1,51,5,5,5,52,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(2,27);
               this.StartPosWater = new b2Vec2(2,23);
               this.CreateFinish(new b2Vec2(32,4.5),new b2Vec2(35,4.5));
               this.CreateSlidePlatform(new b2Vec2(2.5,15),0.5,2,new b2Vec2(0,1),-3,0,0,"lever",6);
               this.CreateLever(new b2Vec2(10,19),6,"l","r",true);
               this.CreateSlidePlatform(new b2Vec2(35.5,12),0.5,2,new b2Vec2(0,1),-3,0,1,"pusher",1);
               this.CreatePusher(new b2Vec2(29.5,10),2,1,true);
               this.CreatePusher(new b2Vec2(10.5,14),2,1,true);
               this.CreateMovingBox(new b2Vec2(20,8),new b2Vec2(0.95,0.95));
            }
            if(param2 == 15)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,0,0,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,"bd",0,0,0,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1),new Array(1,-1,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,-2,1,1,1,1,1,-1,0,0,-2,1,1,1,1),new Array(1,1,0,0,1,0,0,0,0,0,"bd",0,0,0,0,0,"rd",0,0,0,1,0,0,0,-2,1,1,1,1,-4,0,0,0,0,0,0,-3,1,1),new Array(1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,-4,0,0,0,0,0,0,0,0,1,1),new Array(1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-4,0,0,0,0,0,0,0,0,0,1,1),new Array(1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1),new Array(1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,"bd",0,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,0,0,"rd",0,0,0,0,0,0,0,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,1,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,-3,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,1,1,1,1,1,1,1),new Array(1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,-2,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(5,26);
               this.StartPosWater = new b2Vec2(8,26);
               this.CreateFinish(new b2Vec2(2,19.5),new b2Vec2(9,19.5));
               this.CreateSlidePlatform(new b2Vec2(25,24),1.5,0.5,new b2Vec2(0,-1),-3,0,0,"lpusher",5);
               this.CreateLightPusher(new b2Vec2(17,26.5),-Math.PI / 2,6671615,true);
               this.CreateLightBeamer(new b2Vec2(2,26.5),0,6671615);
               this.CreateMovingMirror(new b2Vec2(30.5,22.5),new b2Vec2(0.95,0.95),0);
               this.CreateLightBeamer(new b2Vec2(2.5,16),-Math.PI / 2,16777113);
               this.CreateSlidePlatform(new b2Vec2(26,17),1.5,0.5,new b2Vec2(0,-1),-3,0,0,"lpusher",6);
               this.CreateLightPusher(new b2Vec2(37,22.5),-Math.PI / 2,16777113,true);
               this.CreateRotMirror(new b2Vec2(32.5,4.5),0,0,2);
               this.CreateLever(new b2Vec2(27,11),2,"r","l",true);
               this.CreateMirrorSlider(new b2Vec2(13,15.5),10,Math.PI / 2,4,true);
               this.CreateInfiniteMirror(new b2Vec2(2.5,4.5),0,0,4);
               this.CreateSlidePlatform(new b2Vec2(20,15),1.5,0.5,new b2Vec2(0,1),-3,0,0,"lpusher",6);
               this.CreateLightPusher(new b2Vec2(32.5,2),Math.PI,16777113,true);
               this.CreateSlidePlatform(new b2Vec2(6,17),0.5,1.5,new b2Vec2(1,0),-3,0,0,"lpusher",6);
               this.CreateLightPusher(new b2Vec2(19,11.5),-Math.PI / 2,16777113,true);
            }
            if(param2 == 13)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1,1),new Array(1,0,0,0,0,0,"rd",0,0,0,0,"bd",0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1),new Array(1,0,0,-2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1),new Array(1,0,-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1),new Array(1,0,0,0,0,0,"bd",0,0,0,0,"rd",0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1),new Array(1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,-2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1),new Array(1,0,-2,1,0,0,0,0,0,0,0,0,0,0,0,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,"rd",0,0,0,0,"bd",0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,1),new Array(1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-4,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,1),new Array(1,0,0,-2,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,1),new Array(1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1),new Array(1,0,-2,1,0,0,0,0,0,0,0,0,0,0,0,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1),new Array(1,0,0,0,0,0,"bd",0,0,0,0,"rd",0,0,0,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(4,6);
               this.StartPosWater = new b2Vec2(4,20);
               this.CreateFinish(new b2Vec2(17.2,10.5),new b2Vec2(20,10.5));
               this.CreateMirrorSlider(new b2Vec2(8.5,5.5),10,Math.PI / 4,1,true);
               this.CreateInfiniteMirror(new b2Vec2(18,2.5),0,0,1);
               this.CreateMirrorSlider(new b2Vec2(8.5,12.5),10,0,2,true);
               this.CreateInfiniteMirror(new b2Vec2(34,7.5),0,0,2);
               this.CreateMirrorSlider(new b2Vec2(8.5,19.5),10,Math.PI / 4,5,true);
               this.CreateInfiniteMirror(new b2Vec2(18,17.5),0,0,5);
               this.CreateMirrorSlider(new b2Vec2(8.5,26.5),10,0,4,true);
               this.CreateInfiniteMirror(new b2Vec2(24,26.5),0,0,4);
               this.CreateLightBeamer(new b2Vec2(37,26.5),-Math.PI,16777113);
               this.CreateRotMirror(new b2Vec2(29.5,2.5),0,0,3,true);
               this.CreateSlidePlatform(new b2Vec2(15,9.5),2,0.5,new b2Vec2(0,-1),-3,0,0,"lpusher",6);
               this.CreateLightPusher(new b2Vec2(29.5,19),0,16777113,true);
            }
            if(param2 == 4)
            {
               this.LevelArray = new Array(new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),new Array(1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,1,1,0,0,0,0,0,0,0,0,0,-3,1,1),new Array(1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,-4,0,0,0,0,0,0,0,0,0,0,-3,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,"bd",0,0,0,0,0,0,"rd",0,0,0,0,0,0,0,0,0,0,0,0,"bd",0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,-1,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,0,0,0,1),new Array(1,0,"rd",0,0,0,0,0,0,0,0,0,0,-3,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-4,0,0,0,0,0,0,0,1),new Array(1,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,0,0,0,0,0,0,-2,-4,0,0,0,"rd",0,0,0,0,1),new Array(1,0,0,0,0,0,-3,1,71,7,7,7,7,7,7,7,7,7,7,72,1,1,-1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1),new Array(1,0,"bd",0,0,0,0,1,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,-2,1),new Array(1,0,0,0,0,0,0,1,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,0,0,0,0,0,-2,1,1,1,1),new Array(1,0,0,0,0,0,0,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,-2,1,1,0,0,0,0,0,0,0,0,0,1),new Array(1,1,1,1,-1,0,0,1,0,0,0,0,0,0,0,0,"bd",0,0,1,0,0,1,1,0,0,1,1,1,-1,0,0,0,0,0,0,0,0,1),new Array(1,-4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,1,0,0,1,1,1,1,1,1,1,1,1,-1,0,0,1),new Array(1,0,0,0,0,0,-2,-4,0,0,0,0,0,0,0,0,0,0,0,1,0,0,-3,1,0,0,-3,1,1,-4,0,0,0,-3,1,1,0,0,1),new Array(1,0,0,0,0,-2,-4,0,0,0,1,1,1,1,51,5,5,5,52,-4,0,0,0,-3,-1,0,0,-3,1,0,0,"bd",0,0,-3,-4,0,0,1),new Array(1,0,0,0,1,-4,0,0,0,0,1,0,0,0,0,0,0,0,-3,0,0,"rd",0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,-4,0,0,0,0,-2,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,"bd",0,0,-2,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,0,0,-3,-1,0,0,-2,-1,0,0,0,-2,1),new Array(1,0,0,0,0,0,0,0,1,0,0,0,0,0,-2,61,6,6,6,6,6,6,6,62,1,1,0,0,0,1,0,0,0,-3,1,1,1,1,1),new Array(1,0,0,0,0,0,0,0,1,0,0,-2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,0,0,0,0,0,0,0,-3,1),new Array(1,0,0,0,1,1,1,1,-4,0,0,1,0,0,0,0,0,0,0,1,0,1,0,1,1,1,-1,0,0,-3,-1,0,0,0,0,0,0,0,1),new Array(1,0,0,0,-4,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,1,0,1,-4,0,0,0,"rd",0,-3,1,1,1,1,-1,0,0,1),new Array(1,0,0,0,0,"rd",0,0,0,0,0,1,0,0,0,0,0,0,0,-3,0,1,0,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,-1,0,0,0,0,0,0,0,0,0,1),new Array(1,0,0,0,0,0,0,0,0,0,-2,1,-1,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,1,-1,0,0,0,0,0,0,0,-2,1),new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));
               this.CreateGround(this.LevelArray);
               this.StartPosFire = new b2Vec2(4.5,7);
               this.StartPosWater = new b2Vec2(6.5,7);
               this.CreateFinish(new b2Vec2(14,26.5),new b2Vec2(17,26.5));
               this.CreateSlidePlatform(new b2Vec2(2,27),0.5,1.5,new b2Vec2(0,-1),-5,0,0,"pusher",2);
               this.CreatePusher(new b2Vec2(31.5,14),2,2,true);
               this.CreateSlidePlatform(new b2Vec2(2,22),0.5,1.5,new b2Vec2(0,-1),-5,0,0,"pusher",2);
               this.CreatePusher(new b2Vec2(31.5,14),2,2,false);
               this.CreateSlidePlatform(new b2Vec2(2,13),0.5,1.5,new b2Vec2(0,-1),-5,0,0,"pusher",2);
               this.CreatePusher(new b2Vec2(31.5,14),2,2,false);
               this.CreateSlidePlatform(new b2Vec2(22,26),1.5,0.5,new b2Vec2(0,-1),-2,0,0,"lever",3);
               this.CreateLever(new b2Vec2(12,16),3,"l","r",true);
               this.CreateSlidePlatform(new b2Vec2(20,26),1.5,0.5,new b2Vec2(0,-1),-2,0,0,"lever",4);
               this.CreateLever(new b2Vec2(7,27),4,"l","r",true);
            }
         }
         if(param1 == "adventure" && param2 == 14)
         {
            this.Tuting1 = true;
            this.tutlayer = new TutLayer();
            this.CharsLayer.addChild(this.tutlayer);
         }
         if(param1 == "adventure" && param2 == 15)
         {
            this.Tuting2 = true;
            this.tutlayer = new TutLayer2();
            this.CharsLayer.addChild(this.tutlayer);
         }
         var _loc9_:* = new Array();
         var _loc10_:* = new b2BodyDef();
         var _loc11_:*;
         (_loc11_ = new b2CircleDef()).radius = 0.5;
         _loc11_.density = 0.6;
         _loc11_.friction = 0;
         _loc11_.restitution = 0.1;
         _loc11_.localPosition.Set(0,-0.3);
         _loc11_.filter.groupIndex = -4;
         _loc10_.fixedRotation = true;
         _loc10_.userData = new FireBoy();
         _loc10_.userData.name = "pers1";
         _loc10_.userData.filters = [new GlowFilter(16737792,1,20,20,1,1,false,false)];
         _loc10_.position.Set(this.StartPosFire.x,this.StartPosFire.y);
         this.pers1 = this.m_world.CreateBody(_loc10_);
         this.pers1.CreateShape(_loc11_);
         _loc9_.push(_loc11_);
         (_loc11_ = new b2CircleDef()).radius = 0.3;
         _loc11_.density = 0.01;
         _loc11_.friction = 0.2;
         _loc11_.restitution = 0.1;
         _loc11_.localPosition.Set(0,0.5);
         _loc11_.filter.groupIndex = -4;
         _loc11_.userData = "firelegs";
         this.pers1.CreateShape(_loc11_);
         _loc9_.push(_loc11_);
         var _loc12_:*;
         (_loc12_ = new b2PolygonDef()).vertexCount = 4;
         _loc12_.vertices[0].Set(-0.5,-0.3);
         _loc12_.vertices[1].Set(0.5,-0.3);
         _loc12_.vertices[2].Set(0.3,0.5);
         _loc12_.vertices[3].Set(-0.3,0.5);
         _loc12_.friction = 0;
         _loc12_.density = 0.5;
         _loc12_.filter.groupIndex = -4;
         this.pers1.CreateShape(_loc12_);
         _loc9_.push(_loc12_);
         this.pers1.SetMassFromShapes();
         this.CharsLayer.addChild(_loc10_.userData);
         this.CreateLightBody(this.pers1,_loc10_,_loc9_);
         _loc9_ = new Array();
         _loc10_ = new b2BodyDef();
         (_loc11_ = new b2CircleDef()).radius = 0.5;
         _loc11_.density = 0.6;
         _loc11_.friction = 0;
         _loc11_.restitution = 0.1;
         _loc11_.localPosition.Set(0,-0.3);
         _loc11_.filter.groupIndex = -4;
         _loc10_.fixedRotation = true;
         _loc10_.userData = new WaterGirl();
         _loc10_.userData.name = "pers2";
         _loc10_.userData.filters = [new GlowFilter(9100543,1,20,20,1,1,false,false)];
         _loc10_.position.Set(this.StartPosWater.x,this.StartPosWater.y);
         this.pers2 = this.m_world.CreateBody(_loc10_);
         this.pers2.CreateShape(_loc11_);
         _loc9_.push(_loc11_);
         (_loc11_ = new b2CircleDef()).radius = 0.3;
         _loc11_.density = 0.01;
         _loc11_.friction = 0.2;
         _loc11_.restitution = 0.1;
         _loc11_.localPosition.Set(0,0.5);
         _loc11_.filter.groupIndex = -4;
         _loc11_.userData = "waterlegs";
         this.pers2.CreateShape(_loc11_);
         _loc9_.push(_loc11_);
         (_loc12_ = new b2PolygonDef()).vertexCount = 4;
         _loc12_.vertices[0].Set(-0.5,-0.3);
         _loc12_.vertices[1].Set(0.5,-0.3);
         _loc12_.vertices[2].Set(0.3,0.5);
         _loc12_.vertices[3].Set(-0.3,0.5);
         _loc12_.friction = 0;
         _loc12_.density = 0.5;
         _loc12_.filter.groupIndex = -4;
         this.pers2.CreateShape(_loc12_);
         _loc9_.push(_loc12_);
         this.pers2.SetMassFromShapes();
         this.CharsLayer.addChild(_loc10_.userData);
         this.CreateLightBody(this.pers2,_loc10_,_loc9_);
         addChild(this.SlidersAndRots);
         addChild(this.LightBoard);
         addChild(this.GroundLayer);
         addChild(this.DiamondsandRopes);
         addChild(this.CharsLayer);
         addChild(this.FiresandWaters);
         if(this.CurrentMode == "dark")
         {
            this.MaskLayer = new Sprite();
            this.MaskLayer.cacheAsBitmap = true;
            addChild(this.MaskLayer);
            this.GroundLayer.cacheAsBitmap = true;
            this.BkgLayer.cacheAsBitmap = true;
            this.cacheAsBitmap = true;
            this.mask = this.MaskLayer;
         }
         addEventListener(Event.ENTER_FRAME,this.Update,false,0,true);
      }
      
      public function Update(param1:Event) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:b2Vec2 = null;
         var _loc7_:* = undefined;
         var _loc8_:b2Vec2 = null;
         var _loc9_:* = undefined;
         var _loc10_:deadFire = null;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc15_:b2Vec2 = null;
         var _loc16_:b2AABB = null;
         var _loc17_:Number = NaN;
         var _loc18_:Array = null;
         var _loc19_:Number = NaN;
         var _loc20_:* = undefined;
         var _loc21_:* = undefined;
         if(this.Tuting1 == true && this.pers1.GetUserData().x != 0)
         {
            if(this.tutlayer.hitTestPoint(this.pers1.GetUserData().x * 0.8,this.pers1.GetUserData().y * 0.8,true) == false || this.tutlayer.hitTestPoint(this.pers2.GetUserData().x * 0.8,this.pers2.GetUserData().y * 0.8,true) == false)
            {
               this.tutlayer.play();
               this.tutlayer.alpha = 0;
            }
            else
            {
               this.tutlayer.alpha = 1;
            }
         }
         if(this.Tuting2 == true && this.pers1.GetUserData().x != 0)
         {
            if(this.tutlayer.hitTestPoint(this.pers1.GetUserData().x * 0.8,this.pers1.GetUserData().y * 0.8,true) == false || this.tutlayer.hitTestPoint(this.pers2.GetUserData().x * 0.8,this.pers2.GetUserData().y * 0.8,true) == false)
            {
               this.tutlayer.play();
               this.tutlayer.alpha = 0;
            }
            else
            {
               this.tutlayer.alpha = 1;
            }
         }
         if(this.CurrentMode == "dark")
         {
            _loc2_ = new Matrix();
            this.MaskLayer.graphics.clear();
            this.MaskLayer.graphics.lineStyle(1,0,0);
            _loc3_ = 120;
            _loc4_ = new b2Vec2(this.pers1.GetPosition().x * 20,this.pers1.GetPosition().y * 20);
            _loc2_.createGradientBox(2 * _loc3_,2 * _loc3_,0,_loc4_.x - _loc3_,_loc4_.y - _loc3_);
            this.MaskLayer.graphics.beginGradientFill("radial",[16777215,16777215,16777215],[0.8,0.4,0],[70 + Math.random() * 5,120 + Math.random() * 5,255 - Math.random() * 5],_loc2_,"pad","rgb",0);
            this.MaskLayer.graphics.drawCircle(_loc4_.x,_loc4_.y,_loc3_);
            _loc4_ = new b2Vec2(this.pers2.GetPosition().x * 20,this.pers2.GetPosition().y * 20);
            _loc2_.createGradientBox(2 * _loc3_,2 * _loc3_,0,_loc4_.x - _loc3_,_loc4_.y - _loc3_);
            this.MaskLayer.graphics.beginGradientFill("radial",[16777215,16777215,16777215],[0.8,0.4,0],[70 + Math.random() * 5,120 + Math.random() * 5,255 - Math.random() * 5],_loc2_,"pad","rgb",0);
            this.MaskLayer.graphics.drawCircle(_loc4_.x,_loc4_.y,_loc3_);
            _loc5_ = 0;
            while(_loc5_ < this.myActuateds2.length)
            {
               if(this.myActuateds2[_loc5_] is b2PrismaticJoint || this.myActuateds2[_loc5_] is b2RevoluteJoint)
               {
                  if(this.myActuateds2[_loc5_].GetUserData().GetUserData().bar.getChildByName("light").visible == true)
                  {
                     _loc4_ = new b2Vec2(this.myActuateds2[_loc5_].GetUserData().GetPosition().x * 20,this.myActuateds2[_loc5_].GetUserData().GetPosition().y * 20);
                     _loc2_.createGradientBox(2 * _loc3_,2 * _loc3_,0,_loc4_.x - _loc3_,_loc4_.y - _loc3_);
                     this.MaskLayer.graphics.beginGradientFill("radial",[16777215,16777215,16777215],[0.8,0.4,0],[70 + Math.random() * 5,120 + Math.random() * 5,255 - Math.random() * 5],_loc2_,"pad","rgb",0);
                     this.MaskLayer.graphics.drawCircle(_loc4_.x,_loc4_.y,_loc3_);
                  }
               }
               _loc5_++;
            }
            _loc5_ = 0;
            while(_loc5_ < this.myActuateds.length)
            {
               if(this.myActuateds[_loc5_] is b2PrismaticJoint || this.myActuateds[_loc5_] is b2RevoluteJoint)
               {
                  if(this.myActuateds[_loc5_].GetUserData().GetUserData().bar.getChildByName("light").visible == true)
                  {
                     _loc4_ = new b2Vec2(this.myActuateds[_loc5_].GetUserData().GetPosition().x * 20,this.myActuateds[_loc5_].GetUserData().GetPosition().y * 20);
                     _loc2_.createGradientBox(2 * _loc3_,2 * _loc3_,0,_loc4_.x - _loc3_,_loc4_.y - _loc3_);
                     this.MaskLayer.graphics.beginGradientFill("radial",[16777215,16777215,16777215],[0.8,0.4,0],[70 + Math.random() * 5,120 + Math.random() * 5,255 - Math.random() * 5],_loc2_,"pad","rgb",0);
                     this.MaskLayer.graphics.drawCircle(_loc4_.x,_loc4_.y,_loc3_);
                  }
               }
               _loc5_++;
            }
            _loc5_ = 0;
            while(_loc5_ < this.myWinds.length)
            {
               if(this.myWinds[_loc5_].on == true)
               {
                  _loc4_ = new b2Vec2((this.myWinds[_loc5_].lower.x + this.myWinds[_loc5_].upper.x) * 10,this.myWinds[_loc5_].upper.y * 20);
                  _loc2_.createGradientBox(2 * _loc3_,2 * _loc3_,0,_loc4_.x - _loc3_,_loc4_.y - _loc3_);
                  this.MaskLayer.graphics.beginGradientFill("radial",[16777215,16777215,16777215],[0.8,0.4,0],[70 + Math.random() * 5,120 + Math.random() * 5,255 - Math.random() * 5],_loc2_,"pad","rgb",0);
                  this.MaskLayer.graphics.drawCircle(_loc4_.x,_loc4_.y,_loc3_);
               }
               _loc5_++;
            }
         }
         if(this.pause == false)
         {
            this.pers1.GetUserData().mc_1.visible = false;
            this.pers1.GetUserData().mc_2.visible = false;
            this.pers1.GetUserData().mc_3.visible = false;
            this.pers1.GetUserData().mc_4.visible = false;
            this.pers1.GetUserData().mc_5.visible = false;
            this.pers2.GetUserData().mc_1.visible = false;
            this.pers2.GetUserData().mc_2.visible = false;
            this.pers2.GetUserData().mc_3.visible = false;
            this.pers2.GetUserData().mc_4.visible = false;
            this.pers2.GetUserData().mc_5.visible = false;
            this.allowjump1 = false;
            _loc6_ = new b2Vec2(0,0);
            _loc7_ = 0;
            while(_loc7_ < this.myContactListener.contactStack1.length)
            {
               if(this.myContactListener.contactStack1[_loc7_].y < _loc6_.y)
               {
                  _loc6_ = this.myContactListener.contactStack1[_loc7_].Copy();
               }
               _loc7_++;
            }
            if(_loc6_.y < -0.2)
            {
               this.allowjump1 = true;
            }
            if(this.allowjump1 == false)
            {
               if(this.pers1.GetLinearVelocity().x < -2)
               {
                  this.pers1.GetUserData().mc_4.visible = true;
                  this.pers1.GetUserData().mc_4.scaleX = -0.135;
                  this.pers1.GetUserData().mc_4.head.rotation = -Math.atan2(this.pers1.GetLinearVelocity().y,this.pers1.GetLinearVelocity().x) / Math.PI * 180 - 180;
               }
               else if(this.pers1.GetLinearVelocity().x > 2)
               {
                  this.pers1.GetUserData().mc_4.visible = true;
                  this.pers1.GetUserData().mc_4.scaleX = 0.135;
                  this.pers1.GetUserData().mc_4.head.rotation = Math.atan2(this.pers1.GetLinearVelocity().y,this.pers1.GetLinearVelocity().x) / Math.PI * 180;
               }
               else if(this.pers1.GetLinearVelocity().y < -3)
               {
                  this.pers1.GetUserData().mc_3.visible = true;
               }
               else if(this.pers1.GetLinearVelocity().y > 3)
               {
                  this.pers1.GetUserData().mc_2.visible = true;
               }
               else if(this.r_pressed == false && this.l_pressed == false)
               {
                  this.pers1.GetUserData().mc_1.visible = true;
               }
               else if(this.r_pressed == true)
               {
                  this.pers1.GetUserData().mc_5.visible = true;
                  this.pers1.GetUserData().mc_5.scaleX = 0.135;
               }
               else if(this.l_pressed)
               {
                  this.pers1.GetUserData().mc_5.visible = true;
                  this.pers1.GetUserData().mc_5.scaleX = -0.135;
               }
               else
               {
                  this.pers1.GetUserData().mc_1.visible = true;
               }
            }
            else if(this.r_pressed || this.l_pressed)
            {
               if(this.r_pressed)
               {
                  this.pers1.GetUserData().mc_5.visible = true;
                  this.pers1.GetUserData().mc_5.scaleX = 0.135;
                  this.pers1.GetUserData().mc_5.head.rotation = -Math.atan2(-_loc6_.y,_loc6_.x) / Math.PI * 180 + 90;
               }
               else if(this.l_pressed)
               {
                  this.pers1.GetUserData().mc_5.visible = true;
                  this.pers1.GetUserData().mc_5.scaleX = -0.135;
                  this.pers1.GetUserData().mc_5.head.rotation = Math.atan2(-_loc6_.y,_loc6_.x) / Math.PI * 180 - 90;
               }
            }
            else
            {
               this.pers1.GetUserData().mc_1.visible = true;
            }
            if(this.r_pressed && this.pers1.GetLinearVelocity().x < 7)
            {
               if(_loc6_.x == 0 && _loc6_.y == 0)
               {
                  _loc6_ = new b2Vec2(0,-1);
                  _loc8_ = new b2Vec2(-_loc6_.y * 17,_loc6_.x * 17);
               }
               else
               {
                  if((_loc8_ = new b2Vec2(-_loc6_.y * 17,_loc6_.x * 17)).y < 0 && _loc8_.y > -14)
                  {
                     _loc8_.x += 12;
                  }
                  if(_loc8_.y < -14)
                  {
                     _loc8_.y = 0;
                  }
               }
               if(this.pers1.GetLinearVelocity().x < 0)
               {
                  _loc8_.x *= 3;
               }
               this.pers1.ApplyForce(_loc8_,this.pers1.GetWorldCenter());
            }
            else if(this.l_pressed && this.pers1.GetLinearVelocity().x > -7)
            {
               if(_loc6_.x == 0 && _loc6_.y == 0)
               {
                  _loc6_ = new b2Vec2(0,-1);
                  _loc8_ = new b2Vec2(_loc6_.y * 17,-_loc6_.x * 17);
               }
               else
               {
                  if((_loc8_ = new b2Vec2(_loc6_.y * 17,-_loc6_.x * 17)).y < 0 && _loc8_.y > -14)
                  {
                     _loc8_.x -= 12;
                  }
                  if(_loc8_.y < -14)
                  {
                     _loc8_.y = 0;
                  }
               }
               if(this.pers1.GetLinearVelocity().x > 0)
               {
                  _loc8_.x *= 3;
               }
               this.pers1.ApplyForce(_loc8_,this.pers1.GetWorldCenter());
            }
            if(this.r_pressed == false && this.l_pressed == false)
            {
               if(this.pers1.GetLinearVelocity().x > 0)
               {
                  this.pers1.ApplyForce(new b2Vec2(-this.pers1.GetLinearVelocity().x * 7,0),this.pers1.GetWorldCenter());
               }
               else if(this.pers1.GetLinearVelocity().x < 0)
               {
                  this.pers1.ApplyForce(new b2Vec2(-this.pers1.GetLinearVelocity().x * 7,0),this.pers1.GetWorldCenter());
               }
            }
            if(this.prohibjump1 == false && this.allowjump1 && this.u_pressed)
            {
               this.J1.play();
               this.prohibjump1 = true;
               this.pers1.ApplyImpulse(new b2Vec2(0,-0.5),this.pers1.GetWorldCenter());
               this.pers1.SetLinearVelocity(new b2Vec2(this.pers1.GetLinearVelocity().x,-13.5));
            }
            if(this.u_pressed == false)
            {
               this.prohibjump1 = false;
            }
            this.allowjump2 = false;
            _loc6_ = new b2Vec2(0,0);
            _loc7_ = 0;
            while(_loc7_ < this.myContactListener.contactStack2.length)
            {
               if(this.myContactListener.contactStack2[_loc7_].y < _loc6_.y)
               {
                  _loc6_ = this.myContactListener.contactStack2[_loc7_].Copy();
               }
               _loc7_++;
            }
            if(_loc6_.y < -0.2)
            {
               this.allowjump2 = true;
            }
            if(this.allowjump2 == false)
            {
               if(this.pers2.GetLinearVelocity().x < -2)
               {
                  this.pers2.GetUserData().mc_4.visible = true;
                  this.pers2.GetUserData().mc_4.scaleX = -0.135;
                  this.pers2.GetUserData().mc_4.head.rotation = -Math.atan2(this.pers2.GetLinearVelocity().y,this.pers2.GetLinearVelocity().x) / Math.PI * 180 - 180;
               }
               else if(this.pers2.GetLinearVelocity().x > 2)
               {
                  this.pers2.GetUserData().mc_4.visible = true;
                  this.pers2.GetUserData().mc_4.scaleX = 0.135;
                  this.pers2.GetUserData().mc_4.head.rotation = Math.atan2(this.pers2.GetLinearVelocity().y,this.pers2.GetLinearVelocity().x) / Math.PI * 180;
               }
               else if(this.pers2.GetLinearVelocity().y < -3)
               {
                  this.pers2.GetUserData().mc_3.visible = true;
               }
               else if(this.pers2.GetLinearVelocity().y > 3)
               {
                  this.pers2.GetUserData().mc_2.visible = true;
               }
               else if(this.r_pressed2 == false && this.l_pressed2 == false)
               {
                  this.pers2.GetUserData().mc_1.visible = true;
               }
               else if(this.r_pressed2 == true)
               {
                  this.pers2.GetUserData().mc_5.visible = true;
                  this.pers2.GetUserData().mc_5.scaleX = 0.135;
               }
               else if(this.l_pressed2)
               {
                  this.pers2.GetUserData().mc_5.visible = true;
                  this.pers2.GetUserData().mc_5.scaleX = -0.135;
               }
               else
               {
                  this.pers2.GetUserData().mc_1.visible = true;
               }
            }
            else if(this.r_pressed2 || this.l_pressed2)
            {
               if(this.r_pressed2)
               {
                  this.pers2.GetUserData().mc_5.visible = true;
                  this.pers2.GetUserData().mc_5.scaleX = 0.135;
                  this.pers2.GetUserData().mc_5.head.rotation = -Math.atan2(-_loc6_.y,_loc6_.x) / Math.PI * 180 + 90;
               }
               else if(this.l_pressed2)
               {
                  this.pers2.GetUserData().mc_5.visible = true;
                  this.pers2.GetUserData().mc_5.scaleX = -0.135;
                  this.pers2.GetUserData().mc_5.head.rotation = Math.atan2(-_loc6_.y,_loc6_.x) / Math.PI * 180 - 90;
               }
            }
            else
            {
               this.pers2.GetUserData().mc_1.visible = true;
            }
            if(this.r_pressed2 && this.pers2.GetLinearVelocity().x < 7)
            {
               if(_loc6_.x == 0 && _loc6_.y == 0)
               {
                  _loc6_ = new b2Vec2(0,-1);
                  _loc8_ = new b2Vec2(-_loc6_.y * 17,_loc6_.x * 17);
               }
               else
               {
                  if((_loc8_ = new b2Vec2(-_loc6_.y * 17,_loc6_.x * 17)).y < 0 && _loc8_.y > -14)
                  {
                     _loc8_.x += 12;
                  }
                  if(_loc8_.y < -14)
                  {
                     _loc8_.y = 0;
                  }
               }
               if(this.pers2.GetLinearVelocity().x < 0)
               {
                  _loc8_.x *= 3;
               }
               this.pers2.ApplyForce(_loc8_,this.pers2.GetWorldCenter());
            }
            else if(this.l_pressed2 && this.pers2.GetLinearVelocity().x > -7)
            {
               if(_loc6_.x == 0 && _loc6_.y == 0)
               {
                  _loc6_ = new b2Vec2(0,-1);
                  _loc8_ = new b2Vec2(_loc6_.y * 17,-_loc6_.x * 17);
               }
               else
               {
                  if((_loc8_ = new b2Vec2(_loc6_.y * 17,-_loc6_.x * 17)).y < 0 && _loc8_.y > -14)
                  {
                     _loc8_.x -= 12;
                  }
                  if(_loc8_.y < -14)
                  {
                     _loc8_.y = 0;
                  }
               }
               if(this.pers2.GetLinearVelocity().x > 0)
               {
                  _loc8_.x *= 3;
               }
               this.pers2.ApplyForce(_loc8_,this.pers2.GetWorldCenter());
            }
            if(this.r_pressed2 == false && this.l_pressed2 == false)
            {
               if(this.pers2.GetLinearVelocity().x > 0)
               {
                  this.pers2.ApplyForce(new b2Vec2(-this.pers2.GetLinearVelocity().x * 7,0),this.pers2.GetWorldCenter());
               }
               else if(this.pers2.GetLinearVelocity().x < 0)
               {
                  this.pers2.ApplyForce(new b2Vec2(-this.pers2.GetLinearVelocity().x * 7,0),this.pers2.GetWorldCenter());
               }
            }
            if(this.prohibjump2 == false && this.allowjump2 && this.u_pressed2)
            {
               this.J2.play();
               this.prohibjump2 = true;
               this.pers2.ApplyImpulse(new b2Vec2(0,-0.5),this.pers2.GetWorldCenter());
               this.pers2.SetLinearVelocity(new b2Vec2(this.pers2.GetLinearVelocity().x,-13.5));
            }
            if(this.u_pressed2 == false)
            {
               this.prohibjump2 = false;
            }
            ++this.timecount;
            _loc9_ = 0;
            while(_loc9_ < this.myWinds.length)
            {
               if(this.windChannels[_loc9_] == undefined)
               {
                  this.myWinds[_loc9_].mc.sounding = false;
                  this.windChannels[_loc9_] = new SoundChannel();
               }
               if(this.myWinds[_loc9_].on == true)
               {
                  if(this.timecount > 2 && this.myWinds[_loc9_].mc.sounding == false)
                  {
                     this.myWinds[_loc9_].mc.sounding = true;
                     if(this.myWinds[_loc9_].mc.soundable == true)
                     {
                        this.windChannels[_loc9_] = this.WindSound.play(0,999);
                     }
                  }
                  this.myWinds[_loc9_].mc.getChildByName("light").visible = true;
                  this.myWinds[_loc9_].winder.visible = true;
                  this.myWinds[_loc9_].mc.blades.play();
                  _loc13_ = false;
                  _loc14_ = false;
                  (_loc16_ = new b2AABB()).lowerBound.Set(this.myWinds[_loc9_].lower.x,this.myWinds[_loc9_].lower.y);
                  _loc16_.upperBound.Set(this.myWinds[_loc9_].upper.x,this.myWinds[_loc9_].upper.y);
                  _loc17_ = 15;
                  _loc18_ = [];
                  _loc19_ = this.m_world.Query(_loc16_,_loc18_,_loc17_);
                  _loc11_ = 0;
                  while(_loc11_ < _loc19_)
                  {
                     if(_loc18_[_loc11_].GetBody().GetUserData().name == "pers1")
                     {
                        _loc13_ = true;
                     }
                     if(_loc18_[_loc11_].GetBody().GetUserData().name == "pers2")
                     {
                        _loc14_ = true;
                     }
                     _loc11_++;
                  }
                  if(_loc13_ == true)
                  {
                     switch(this.myWinds[_loc9_].vertical)
                     {
                        case 1:
                           _loc15_ = new b2Vec2(0,-Math.min(1 / Math.abs(this.pers1.GetPosition().y - this.myWinds[_loc9_].upper.y),0.4));
                           break;
                        case 2:
                           _loc15_ = new b2Vec2(Math.min(1 / Math.abs(this.pers1.GetPosition().x - this.myWinds[_loc9_].lower.x),0.4),0);
                           break;
                        case 3:
                           _loc15_ = new b2Vec2(0,Math.min(1 / Math.abs(this.pers1.GetPosition().y - this.myWinds[_loc9_].upper.y),0.4));
                           break;
                        case 4:
                           _loc15_ = new b2Vec2(-Math.min(1 / Math.abs(this.pers1.GetPosition().x - this.myWinds[_loc9_].upper.x),0.4),0);
                     }
                     _loc15_.x *= Math.abs(this.myWinds[_loc9_].upper.x - this.myWinds[_loc9_].lower.x) * 13 + 20 * (Math.sin(this.timecount / 10) + 1);
                     _loc15_.y *= Math.abs(this.myWinds[_loc9_].upper.y - this.myWinds[_loc9_].lower.y) * 13 + 20 * (Math.sin(this.timecount / 10) + 1);
                     this.pers1.ApplyForce(_loc15_,this.pers1.GetWorldCenter());
                     this.pers1.SetLinearVelocity(new b2Vec2(this.pers1.GetLinearVelocity().x * 0.95,this.pers1.GetLinearVelocity().y * 0.95));
                  }
                  if(_loc14_ == true)
                  {
                     switch(this.myWinds[_loc9_].vertical)
                     {
                        case 1:
                           _loc15_ = new b2Vec2(0,-Math.min(1 / Math.abs(this.pers2.GetPosition().y - this.myWinds[_loc9_].upper.y),0.4));
                           break;
                        case 2:
                           _loc15_ = new b2Vec2(Math.min(1 / Math.abs(this.pers2.GetPosition().x - this.myWinds[_loc9_].lower.x),0.4),0);
                           break;
                        case 3:
                           _loc15_ = new b2Vec2(0,Math.min(1 / Math.abs(this.pers2.GetPosition().y - this.myWinds[_loc9_].upper.y),0.4));
                           break;
                        case 4:
                           _loc15_ = new b2Vec2(-Math.min(1 / Math.abs(this.pers2.GetPosition().x - this.myWinds[_loc9_].upper.x),0.4),0);
                     }
                     _loc15_.x *= Math.abs(this.myWinds[_loc9_].upper.x - this.myWinds[_loc9_].lower.x) * 13 + 20 * (Math.sin(this.timecount / 10) + 1);
                     _loc15_.y *= Math.abs(this.myWinds[_loc9_].upper.y - this.myWinds[_loc9_].lower.y) * 13 + 20 * (Math.sin(this.timecount / 10) + 1);
                     this.pers2.ApplyForce(_loc15_,this.pers2.GetWorldCenter());
                     this.pers2.SetLinearVelocity(new b2Vec2(this.pers2.GetLinearVelocity().x * 0.95,this.pers2.GetLinearVelocity().y * 0.95));
                  }
               }
               else
               {
                  if(this.myWinds[_loc9_].mc.sounding == true)
                  {
                     this.myWinds[_loc9_].mc.sounding = false;
                     this.windChannels[_loc9_].stop();
                  }
                  this.myWinds[_loc9_].mc.getChildByName("light").visible = false;
                  this.myWinds[_loc9_].winder.visible = false;
                  this.myWinds[_loc9_].mc.blades.stop();
               }
               _loc9_++;
            }
            if((this.SlidersAndRots.getChildByName("finish2") as MovieClip).sounding == undefined)
            {
               (this.SlidersAndRots.getChildByName("finish2") as MovieClip).sounding = false;
            }
            if((this.SlidersAndRots.getChildByName("finish1") as MovieClip).sounding == undefined)
            {
               (this.SlidersAndRots.getChildByName("finish1") as MovieClip).sounding = false;
            }
            if(this.myContactListener.finish1 > 0)
            {
               if((this.SlidersAndRots.getChildByName("finish1") as MovieClip).currentFrame < 22)
               {
                  (this.SlidersAndRots.getChildByName("finish1") as MovieClip).gotoAndStop((this.SlidersAndRots.getChildByName("finish1") as MovieClip).currentFrame + 1);
                  if((this.SlidersAndRots.getChildByName("finish1") as MovieClip).sounding == false)
                  {
                     (this.SlidersAndRots.getChildByName("finish1") as MovieClip).sounding = true;
                     this.DoorChannel2 = this.DoorSound.play();
                  }
               }
               else if((this.SlidersAndRots.getChildByName("finish2") as MovieClip).currentFrame == 22 && getChildByName("ender") == null)
               {
                  (this.SlidersAndRots.getChildByName("finish1") as MovieClip).sounding = false;
                  this.DoorChannel2.stop();
                  this.pers1.GetUserData().visible = false;
                  (_loc20_ = addChild(new FireBoystairs())).x = this.SlidersAndRots.getChildByName("finish1").x;
                  _loc20_.y = this.SlidersAndRots.getChildByName("finish1").y;
                  _loc20_.name = "ender";
                  this.pers2.GetUserData().visible = false;
                  (_loc20_ = addChild(new WaterGirlStairs())).x = this.SlidersAndRots.getChildByName("finish2").x;
                  _loc20_.y = this.SlidersAndRots.getChildByName("finish2").y;
                  this.pause = true;
                  this.ended = true;
               }
               else
               {
                  (this.SlidersAndRots.getChildByName("finish1") as MovieClip).sounding = false;
                  this.DoorChannel2.stop();
               }
            }
            else if((this.SlidersAndRots.getChildByName("finish1") as MovieClip).currentFrame > 1)
            {
               (this.SlidersAndRots.getChildByName("finish1") as MovieClip).gotoAndStop((this.SlidersAndRots.getChildByName("finish1") as MovieClip).currentFrame - 1);
               if((this.SlidersAndRots.getChildByName("finish1") as MovieClip).sounding == false)
               {
                  (this.SlidersAndRots.getChildByName("finish1") as MovieClip).sounding = true;
                  this.DoorChannel2 = this.DoorSound.play();
               }
            }
            else if((this.SlidersAndRots.getChildByName("finish1") as MovieClip).sounding == true)
            {
               (this.SlidersAndRots.getChildByName("finish1") as MovieClip).sounding = false;
               this.DoorChannel2.stop();
            }
            if(this.myContactListener.finish2 > 0)
            {
               if((this.SlidersAndRots.getChildByName("finish2") as MovieClip).currentFrame < 22)
               {
                  (this.SlidersAndRots.getChildByName("finish2") as MovieClip).gotoAndStop((this.SlidersAndRots.getChildByName("finish2") as MovieClip).currentFrame + 1);
                  if((this.SlidersAndRots.getChildByName("finish2") as MovieClip).sounding == false)
                  {
                     (this.SlidersAndRots.getChildByName("finish2") as MovieClip).sounding = true;
                     this.DoorChannel = this.DoorSound.play();
                  }
               }
               else
               {
                  (this.SlidersAndRots.getChildByName("finish2") as MovieClip).sounding = false;
                  this.DoorChannel.stop();
               }
            }
            else if((this.SlidersAndRots.getChildByName("finish2") as MovieClip).currentFrame > 1)
            {
               (this.SlidersAndRots.getChildByName("finish2") as MovieClip).gotoAndStop((this.SlidersAndRots.getChildByName("finish2") as MovieClip).currentFrame - 1);
               if((this.SlidersAndRots.getChildByName("finish2") as MovieClip).sounding == false)
               {
                  (this.SlidersAndRots.getChildByName("finish2") as MovieClip).sounding = true;
                  this.DoorChannel = this.DoorSound.play();
               }
            }
            else if((this.SlidersAndRots.getChildByName("finish2") as MovieClip).sounding == true)
            {
               (this.SlidersAndRots.getChildByName("finish2") as MovieClip).sounding = false;
               this.DoorChannel.stop();
            }
            if(this.myContactListener.deadFire == true && this.pause == false)
            {
               this.pause = true;
               this.ended = true;
               this.pers1.GetUserData().visible = false;
               (_loc10_ = new deadFire()).x = this.pers1.GetUserData().x;
               _loc10_.y = this.pers1.GetUserData().y;
               addChild(_loc10_);
            }
            if(this.myContactListener.deadWater == true && this.pause == false)
            {
               this.pause = true;
               this.ended = true;
               this.pers2.GetUserData().visible = false;
               (_loc10_ = new deadFire()).x = this.pers2.GetUserData().x;
               _loc10_.y = this.pers2.GetUserData().y;
               addChild(_loc10_);
            }
            this.m_world.Step(this.m_timeStep,this.m_iterations);
            _loc11_ = 0;
            while(_loc11_ < this.myLevers.length)
            {
               if(this.myChannels[_loc11_] == undefined)
               {
                  this.myChannels[_loc11_] = new SoundChannel();
               }
               if(this.myLevers[_loc11_].GetJointAngle() > 0)
               {
                  this.myLevers[_loc11_].SetMotorSpeed(3);
               }
               else
               {
                  this.myLevers[_loc11_].SetMotorSpeed(-3);
               }
               if(this.myLevers[_loc11_].GetUserData().GetUserData().onis == "r" && this.myLevers[_loc11_].GetJointAngle() < 0 || this.myLevers[_loc11_].GetUserData().GetUserData().onis == "l" && this.myLevers[_loc11_].GetJointAngle() > 0)
               {
                  if(this.myLevers[_loc11_].GetUserData().GetUserData().clicker == 1 && this.myLevers[_loc11_].GetUserData().GetUserData().soundable == true)
                  {
                     this.LeverSound.play();
                  }
                  if(this.myActuateds2[_loc11_] is b2PrismaticJoint || this.myActuateds2[_loc11_] is b2RevoluteJoint)
                  {
                     this.myLevers[_loc11_].GetUserData().GetUserData().getChildByName("light").gotoAndStop(2);
                     if(this.myActuateds2[_loc11_].GetUserData().GetUserData().name == "rot")
                     {
                        this.myActuateds2[_loc11_].GetUserData().GetUserData().bar.getChildByName("light").gotoAndStop(2);
                        if(this.myLevers[_loc11_].GetUserData().GetUserData().clicker == 1)
                        {
                           this.myChannels[_loc11_].stop();
                           if(this.myLevers[_loc11_].GetUserData().GetUserData().soundable == true)
                           {
                              this.myChannels[_loc11_] = this.PlatformSound.play(1500,1);
                           }
                        }
                        else if(this.myActuateds2[_loc11_].GetJointAngle() < this.myActuateds2[_loc11_].GetLowerLimit())
                        {
                           this.myChannels[_loc11_].stop();
                           this.myActuateds2[_loc11_].GetUserData().SetXForm(this.myActuateds2[_loc11_].GetUserData().GetPosition(),-this.myActuateds2[_loc11_].GetLowerLimit());
                        }
                        this.myActuateds2[_loc11_].SetMotorSpeed(-1);
                        this.myActuateds2[_loc11_].GetUserData().ApplyTorque(-5);
                     }
                     else if(this.myActuateds2[_loc11_].GetUserData().GetUserData().name == "slide")
                     {
                        this.myActuateds2[_loc11_].GetUserData().GetUserData().bar.getChildByName("light").visible = true;
                        if(this.myLevers[_loc11_].GetUserData().GetUserData().clicker == 1)
                        {
                           this.myChannels[_loc11_].stop();
                           if(this.myLevers[_loc11_].GetUserData().GetUserData().soundable == true)
                           {
                              this.myChannels[_loc11_] = this.PlatformSound.play();
                           }
                        }
                        else if(Math.sqrt(this.myActuateds2[_loc11_].GetUserData().GetLinearVelocity().x ^ 2 + this.myActuateds2[_loc11_].GetUserData().GetLinearVelocity().y ^ 2) == 0)
                        {
                           this.myChannels[_loc11_].stop();
                        }
                        this.myActuateds2[_loc11_].SetMotorSpeed(-2);
                        this.myActuateds2[_loc11_].GetUserData().ApplyForce(new b2Vec2(-2,0),this.myActuateds2[_loc11_].GetUserData().GetWorldCenter());
                     }
                  }
                  else
                  {
                     this.myLevers[_loc11_].GetUserData().GetUserData().getChildByName("light").gotoAndStop(2);
                     this.myActuateds2[_loc11_].on = true;
                  }
                  this.myLevers[_loc11_].GetUserData().GetUserData().clicker = -1;
               }
               else if(this.myLevers[_loc11_].GetUserData().GetUserData().onis == "r" && this.myLevers[_loc11_].GetJointAngle() > 0 || this.myLevers[_loc11_].GetUserData().GetUserData().onis == "l" && this.myLevers[_loc11_].GetJointAngle() < 0)
               {
                  if(this.myLevers[_loc11_].GetUserData().GetUserData().clicker == -1 && this.myLevers[_loc11_].GetUserData().GetUserData().soundable == true)
                  {
                     this.LeverSound.play();
                  }
                  if(this.myActuateds2[_loc11_] is b2PrismaticJoint || this.myActuateds2[_loc11_] is b2RevoluteJoint)
                  {
                     this.myLevers[_loc11_].GetUserData().GetUserData().getChildByName("light").gotoAndStop(1);
                     if(this.myActuateds2[_loc11_].GetUserData().GetUserData().name == "rot")
                     {
                        this.myActuateds2[_loc11_].GetUserData().GetUserData().bar.getChildByName("light").gotoAndStop(1);
                        if(this.myLevers[_loc11_].GetUserData().GetUserData().clicker == -1)
                        {
                           this.myChannels[_loc11_].stop();
                           if(this.myLevers[_loc11_].GetUserData().GetUserData().soundable == true)
                           {
                              this.myChannels[_loc11_] = this.PlatformSound.play(1500,1);
                           }
                        }
                        else if(this.myActuateds2[_loc11_].GetJointAngle() > this.myActuateds2[_loc11_].GetUpperLimit())
                        {
                           this.myChannels[_loc11_].stop();
                           this.myActuateds2[_loc11_].GetUserData().SetXForm(this.myActuateds2[_loc11_].GetUserData().GetPosition(),-this.myActuateds2[_loc11_].GetUpperLimit());
                        }
                        this.myActuateds2[_loc11_].SetMotorSpeed(1);
                        this.myActuateds2[_loc11_].GetUserData().ApplyTorque(5);
                     }
                     else if(this.myActuateds2[_loc11_].GetUserData().GetUserData().name == "slide")
                     {
                        this.myActuateds2[_loc11_].GetUserData().GetUserData().bar.getChildByName("light").visible = false;
                        if(this.myLevers[_loc11_].GetUserData().GetUserData().clicker == -1)
                        {
                           this.myChannels[_loc11_].stop();
                           if(this.myLevers[_loc11_].GetUserData().GetUserData().soundable == true)
                           {
                              this.myChannels[_loc11_] = this.PlatformSound.play();
                           }
                        }
                        else if(Math.sqrt(this.myActuateds2[_loc11_].GetUserData().GetLinearVelocity().x ^ 2 + this.myActuateds2[_loc11_].GetUserData().GetLinearVelocity().y ^ 2) == 0)
                        {
                           this.myChannels[_loc11_].stop();
                        }
                        this.myActuateds2[_loc11_].SetMotorSpeed(2);
                        this.myActuateds2[_loc11_].GetUserData().ApplyForce(new b2Vec2(1,0),this.myActuateds2[_loc11_].GetUserData().GetWorldCenter());
                     }
                  }
                  else
                  {
                     this.myLevers[_loc11_].GetUserData().GetUserData().getChildByName("light").gotoAndStop(1);
                     this.myActuateds2[_loc11_].on = false;
                  }
                  this.myLevers[_loc11_].GetUserData().GetUserData().clicker = 1;
               }
               _loc11_++;
            }
            _loc11_ = 0;
            while(_loc11_ < this.myPushers.length)
            {
               if(this.myChannels2[_loc11_] == undefined)
               {
                  this.myChannels2[_loc11_] = new SoundChannel();
               }
               if(this.myPushers[_loc11_].GetUserData().GetPosition().y - this.myPushers[_loc11_].GetUserData().GetUserData().originy > 0.25)
               {
                  if(this.myPushers[_loc11_].GetUserData().GetUserData().clicker == 1 && this.myPushers[_loc11_].GetUserData().GetUserData().soundable == true)
                  {
                     this.PusherSound.play();
                  }
                  this.myActuateds[_loc11_].GetUserData().GetUserData().bar.getChildByName("light").visible = true;
                  this.myPushers[_loc11_].GetUserData().GetUserData().visible = false;
                  if(this.myActuateds[_loc11_].GetUserData().GetUserData().name == "rot")
                  {
                     if(this.myPushers[_loc11_].GetUserData().GetUserData().clicker == 1)
                     {
                        this.myChannels2[_loc11_].stop();
                        if(this.myPushers[_loc11_].GetUserData().GetUserData().soundable == true)
                        {
                           this.myChannels2[_loc11_] = this.PlatformSound.play(1500,1);
                        }
                     }
                     this.myActuateds[_loc11_].SetMotorSpeed(2);
                     this.myActuateds[_loc11_].GetUserData().ApplyTorque(1);
                  }
                  else if(this.myActuateds[_loc11_].GetUserData().GetUserData().name == "slide")
                  {
                     if(this.myPushers[_loc11_].GetUserData().GetUserData().clicker == 1)
                     {
                        this.myChannels2[_loc11_].stop();
                        if(this.myPushers[_loc11_].GetUserData().GetUserData().soundable == true)
                        {
                           this.myChannels2[_loc11_] = this.PlatformSound.play();
                        }
                     }
                     else if(Math.sqrt(this.myActuateds[_loc11_].GetUserData().GetLinearVelocity().x ^ 2 + this.myActuateds[_loc11_].GetUserData().GetLinearVelocity().y ^ 2) == 0)
                     {
                        this.myChannels2[_loc11_].stop();
                     }
                     this.myActuateds[_loc11_].SetMotorSpeed(-2);
                     this.myActuateds[_loc11_].GetUserData().ApplyForce(new b2Vec2(-1,0),this.myActuateds[_loc11_].GetUserData().GetWorldCenter());
                  }
                  this.myPushers[_loc11_].SetMotorSpeed(1);
                  this.myPushers[_loc11_].SetMaxMotorForce(0.1);
                  this.myPushers[_loc11_].GetUserData().GetUserData().clicker = -1;
               }
               else if(this.myPushers[_loc11_].GetUserData().IsSleeping() == false)
               {
                  this.myActuateds[_loc11_].GetUserData().GetUserData().bar.getChildByName("light").visible = false;
                  this.myPushers[_loc11_].GetUserData().GetUserData().visible = true;
                  if(this.myActuateds[_loc11_].GetUserData().GetUserData().name == "rot")
                  {
                     if(this.myPushers[_loc11_].GetUserData().GetUserData().clicker == -1)
                     {
                        this.myChannels2[_loc11_].stop();
                        if(this.myPushers[_loc11_].GetUserData().GetUserData().soundable == true)
                        {
                           this.myChannels2[_loc11_] = this.PlatformSound.play(1500,1);
                        }
                     }
                     this.myActuateds[_loc11_].SetMotorSpeed(-2);
                     this.myActuateds[_loc11_].GetUserData().ApplyTorque(-1);
                  }
                  else if(this.myActuateds[_loc11_].GetUserData().GetUserData().name == "slide")
                  {
                     if(this.myPushers[_loc11_].GetUserData().GetUserData().clicker == -1)
                     {
                        this.myChannels2[_loc11_].stop();
                        if(this.myPushers[_loc11_].GetUserData().GetUserData().soundable == true)
                        {
                           this.myChannels2[_loc11_] = this.PlatformSound.play();
                        }
                     }
                     else if(Math.sqrt(this.myActuateds[_loc11_].GetUserData().GetLinearVelocity().x ^ 2 + this.myActuateds[_loc11_].GetUserData().GetLinearVelocity().y ^ 2) == 0)
                     {
                        this.myChannels2[_loc11_].stop();
                     }
                     this.myActuateds[_loc11_].SetMotorSpeed(2);
                     this.myActuateds[_loc11_].GetUserData().ApplyForce(new b2Vec2(1,0),this.myActuateds[_loc11_].GetUserData().GetWorldCenter());
                  }
                  this.myPushers[_loc11_].SetMotorSpeed(2);
                  this.myPushers[_loc11_].SetMaxMotorForce(1);
                  this.myPushers[_loc11_].GetUserData().GetUserData().clicker = 1;
               }
               else
               {
                  if(this.myActuateds[_loc11_].GetUserData().GetUserData().name == "rot")
                  {
                     if(this.myPushers[_loc11_].GetUserData().GetUserData().clicker == -1)
                     {
                        this.myChannels2[_loc11_].stop();
                        this.myChannels2[_loc11_] = this.PlatformSound.play();
                     }
                     else if(Math.abs(this.myActuateds[_loc11_].GetUserData().GetAngularVelocity()) == 0)
                     {
                        this.myChannels2[_loc11_].stop();
                     }
                  }
                  else if(this.myActuateds[_loc11_].GetUserData().GetUserData().name == "slide")
                  {
                     if(this.myPushers[_loc11_].GetUserData().GetUserData().clicker == -1)
                     {
                        this.myChannels2[_loc11_].stop();
                        this.myChannels2[_loc11_] = this.PlatformSound.play();
                     }
                     else if(Math.sqrt(this.myActuateds[_loc11_].GetUserData().GetLinearVelocity().x ^ 2 + this.myActuateds[_loc11_].GetUserData().GetLinearVelocity().y ^ 2) == 0)
                     {
                        this.myChannels2[_loc11_].stop();
                     }
                  }
                  this.myPushers[_loc11_].GetUserData().GetUserData().clicker = 1;
               }
               _loc11_++;
            }
            _loc11_ = 0;
            while(_loc11_ < this.myLightPushers.length)
            {
               if(this.myChannels3[_loc11_] == undefined)
               {
                  this.myChannels3[_loc11_] = new SoundChannel();
               }
               if(this.myLightPushers[_loc11_].activated == true)
               {
                  if(this.myLightPushers[_loc11_].clicker == 1 && this.myLightPushers[_loc11_].soundable == true)
                  {
                     this.LPusherSound.play();
                  }
                  this.myActuateds4[_loc11_].GetUserData().GetUserData().bar.getChildByName("light").visible = true;
                  this.myLightPushers[_loc11_].light.visible = true;
                  if(this.myActuateds4[_loc11_].GetUserData().GetUserData().name == "rot")
                  {
                     if(this.myLightPushers[_loc11_].clicker == -1)
                     {
                        this.myChannels3[_loc11_].stop();
                        if(this.myLightPushers[_loc11_].soundable == true)
                        {
                           this.myChannels3[_loc11_] = this.PlatformSound.play(1500,1);
                        }
                     }
                     this.myActuateds4[_loc11_].SetMotorSpeed(-2);
                     this.myActuateds4[_loc11_].GetUserData().ApplyTorque(-1);
                  }
                  else if(this.myActuateds4[_loc11_].GetUserData().GetUserData().name == "slide")
                  {
                     if(this.myLightPushers[_loc11_].clicker == 1)
                     {
                        this.myChannels3[_loc11_].stop();
                        if(this.myLightPushers[_loc11_].soundable == true)
                        {
                           this.myChannels3[_loc11_] = this.PlatformSound.play();
                        }
                     }
                     else if(Math.sqrt(this.myActuateds4[_loc11_].GetUserData().GetLinearVelocity().x ^ 2 + this.myActuateds4[_loc11_].GetUserData().GetLinearVelocity().y ^ 2) == 0)
                     {
                        this.myChannels3[_loc11_].stop();
                     }
                     this.myActuateds4[_loc11_].SetMotorSpeed(-2);
                     this.myActuateds4[_loc11_].GetUserData().ApplyForce(new b2Vec2(-1,0),this.myActuateds4[_loc11_].GetUserData().GetWorldCenter());
                  }
                  this.myLightPushers[_loc11_].clicker = -1;
               }
               else
               {
                  this.myActuateds4[_loc11_].GetUserData().GetUserData().bar.getChildByName("light").visible = false;
                  this.myLightPushers[_loc11_].light.visible = false;
                  if(this.myActuateds4[_loc11_].GetUserData().GetUserData().name == "rot")
                  {
                     if(this.myLightPushers[_loc11_].clicker == -1)
                     {
                        this.myChannels3[_loc11_].stop();
                        if(this.myLightPushers[_loc11_].soundable == true)
                        {
                           this.myChannels3[_loc11_] = this.PlatformSound.play(1500,1);
                        }
                     }
                     this.myActuateds4[_loc11_].SetMotorSpeed(-2);
                     this.myActuateds4[_loc11_].GetUserData().ApplyTorque(-1);
                  }
                  else if(this.myActuateds4[_loc11_].GetUserData().GetUserData().name == "slide")
                  {
                     if(this.myLightPushers[_loc11_].clicker == -1)
                     {
                        this.myChannels3[_loc11_].stop();
                        if(this.myLightPushers[_loc11_].soundable == true)
                        {
                           this.myChannels3[_loc11_] = this.PlatformSound.play();
                        }
                     }
                     else if(Math.sqrt(this.myActuateds4[_loc11_].GetUserData().GetLinearVelocity().x ^ 2 + this.myActuateds4[_loc11_].GetUserData().GetLinearVelocity().y ^ 2) == 0)
                     {
                        this.myChannels3[_loc11_].stop();
                     }
                     this.myActuateds4[_loc11_].SetMotorSpeed(2);
                     this.myActuateds4[_loc11_].GetUserData().ApplyForce(new b2Vec2(1,0),this.myActuateds4[_loc11_].GetUserData().GetWorldCenter());
                  }
                  this.myLightPushers[_loc11_].clicker = 1;
               }
               this.myLightPushers[_loc11_].activated = false;
               _loc11_++;
            }
            _loc11_ = 0;
            while(_loc11_ < this.myMirrorSliders.length)
            {
               if(this.myMirrorSliders[_loc11_].GetUserData().GetPosition().y != this.myMirrorSliders[_loc11_].GetUserData().GetUserData().originy)
               {
                  this.myMirrorSliders[_loc11_].GetUserData().SetXForm(new b2Vec2(this.myMirrorSliders[_loc11_].GetUserData().GetPosition().x,this.myMirrorSliders[_loc11_].GetUserData().GetUserData().originy),0);
               }
               if(Math.abs((this.myMirrorSliders[_loc11_].GetUserData().GetPosition().x - this.myMirrorSliders[_loc11_].GetUserData().GetUserData().originx) / this.myMirrorSliders[_loc11_].GetUserData().GetUserData().length * Math.PI / 2 + this.myMirrorSliders[_loc11_].GetUserData().GetUserData().shift) != Math.abs(this.myActuateds3[_loc11_].GetJointAngle()))
               {
                  _loc21_ = this.myMirrorSliders[_loc11_].GetUserData().GetLinearVelocity();
                  trace("v " + _loc21_.Length());
                  if(_loc21_.Length() > 1)
                  {
                     this.myMirrorSliders[_loc11_].SetMaxMotorForce(15);
                  }
                  else
                  {
                     this.myMirrorSliders[_loc11_].SetMaxMotorForce(5);
                  }
                  this.myMirrorSliders[_loc11_].GetUserData().SetLinearVelocity(_loc21_);
                  if(this.clickPlaying == false && _loc21_.Length() > 0.2)
                  {
                     this.clickPlaying = true;
                     this.InfiniteChannel = this.ClickSound.play(1,0);
                     this.InfiniteChannel.addEventListener(Event.SOUND_COMPLETE,this.handleSoundComplete);
                  }
                  this.myActuateds3[_loc11_].GetUserData().SetXForm(this.myActuateds3[_loc11_].GetUserData().GetPosition(),(this.myMirrorSliders[_loc11_].GetUserData().GetPosition().x - this.myMirrorSliders[_loc11_].GetUserData().GetUserData().originx) / this.myMirrorSliders[_loc11_].GetUserData().GetUserData().length * Math.PI / 2 + this.myMirrorSliders[_loc11_].GetUserData().GetUserData().shift);
               }
               _loc11_++;
            }
            _loc12_ = this.m_world.m_bodyList;
            while(_loc12_)
            {
               if(_loc12_.m_userData is Sprite && _loc12_.IsSleeping() == false)
               {
                  _loc12_.m_userData.x = _loc12_.GetPosition().x * 20;
                  _loc12_.m_userData.y = _loc12_.GetPosition().y * 20;
                  if(_loc12_.m_userData.name != "pers1")
                  {
                     _loc12_.m_userData.rotation = _loc12_.GetAngle() * (180 / Math.PI);
                  }
                  if(_loc12_.m_userData.name == "HangingPlatform")
                  {
                     _loc12_.m_userData.rope.rotation = 180 / Math.PI * Math.atan2(_loc12_.m_userData.anchor.y - _loc12_.GetPosition().y,_loc12_.m_userData.anchor.x - _loc12_.GetPosition().x) + 90;
                  }
                  if(_loc12_.m_userData.name == "PulleyPlatform")
                  {
                     _loc12_.m_userData.rope.rotation = 180 / Math.PI * Math.atan2(_loc12_.m_userData.anchor.y - _loc12_.GetPosition().y + 34 / 20,_loc12_.m_userData.anchor.x - _loc12_.GetPosition().x) + 90;
                     _loc12_.m_userData.rope.chain.y = Math.sqrt(Math.pow(_loc12_.m_userData.anchor.y - _loc12_.GetPosition().y + 34 / 20,2) + Math.pow(_loc12_.m_userData.anchor.x - _loc12_.GetPosition().x,2)) * 20;
                     _loc12_.m_userData.rope.ropeMask.height = Math.sqrt(Math.pow(_loc12_.m_userData.anchor.y - _loc12_.GetPosition().y + 34 / 20,2) + Math.pow(_loc12_.m_userData.anchor.x - _loc12_.GetPosition().x,2)) * 20;
                     _loc12_.m_userData.connector.chain.x = -Math.sqrt(Math.pow(_loc12_.m_userData.anchor.y - _loc12_.GetPosition().y + 34 / 20,2) + Math.pow(_loc12_.m_userData.anchor.x - _loc12_.GetPosition().x,2)) * 20;
                     _loc12_.m_userData.anc1.rotation = -Math.sqrt(Math.pow(_loc12_.m_userData.anchor.y - _loc12_.GetPosition().y + 34 / 20,2) + Math.pow(_loc12_.m_userData.anchor.x - _loc12_.GetPosition().x,2)) * 200;
                     _loc12_.m_userData.anc2.rotation = -Math.sqrt(Math.pow(_loc12_.m_userData.anchor.y - _loc12_.GetPosition().y + 34 / 20,2) + Math.pow(_loc12_.m_userData.anchor.x - _loc12_.GetPosition().x,2)) * 200;
                  }
               }
               _loc12_ = _loc12_.m_next;
            }
            _loc12_ = this.m_lworld.m_bodyList;
            while(_loc12_)
            {
               if(_loc12_.m_userData is Sprite && Boolean(_loc12_.m_userData.pointer))
               {
                  _loc12_.SetXForm(new b2Vec2(_loc12_.m_userData.pointer.GetPosition().x,_loc12_.m_userData.pointer.GetPosition().y),_loc12_.m_userData.pointer.GetAngle());
               }
               _loc12_ = _loc12_.m_next;
            }
            this.LightBoard.graphics.clear();
            _loc12_ = this.m_world.m_bodyList;
            while(_loc12_)
            {
               if(_loc12_.m_userData is LightBeamer)
               {
                  this.TraceBeam(_loc12_);
               }
               _loc12_ = _loc12_.m_next;
            }
            _loc12_ = this.m_lworld.m_bodyList;
            while(_loc12_)
            {
               if(_loc12_.m_userData is Sprite)
               {
                  _loc12_.m_userData.x = _loc12_.GetPosition().x * 20;
                  _loc12_.m_userData.y = _loc12_.GetPosition().y * 20;
                  _loc12_.m_userData.rotation = _loc12_.GetAngle() * (180 / Math.PI);
               }
               _loc12_ = _loc12_.m_next;
            }
         }
      }
      
      public function CreateGround(param1:Array) : *
      {
         var _loc3_:b2BodyDef = null;
         var _loc4_:b2PolygonDef = null;
         var _loc5_:b2Body = null;
         var _loc6_:Sprite = null;
         var _loc7_:Object = null;
         var _loc8_:b2BodyDef = null;
         var _loc9_:b2Body = null;
         var _loc10_:b2Vec2 = null;
         var _loc11_:Number = NaN;
         var _loc12_:b2Vec2 = null;
         var _loc22_:* = undefined;
         var _loc13_:Array = param1;
         var _loc14_:* = new Sprite();
         _loc6_ = new Sprite();
         this.FiresandWaters = new Sprite();
         this.DiamondsandRopes = new Sprite();
         this.DiamondsandRopes.name = "DiamondsandRopes";
         _loc3_ = new b2BodyDef();
         _loc3_.position.Set(0,0);
         _loc3_.userData = new Object();
         _loc3_.userData.name = "ground";
         _loc5_ = this.m_world.CreateBody(_loc3_);
         var _loc15_:* = new Array();
         _loc12_ = new b2Vec2(0.5,0.5);
         _loc11_ = 0;
         var _loc16_:* = 0;
         while(_loc16_ < _loc13_.length)
         {
            _loc22_ = 0;
            while(_loc22_ < _loc13_[0].length)
            {
               if(_loc13_[_loc16_][_loc22_] == "bd")
               {
                  ++this.BDcount;
                  _loc10_ = new b2Vec2(_loc22_,_loc16_);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc12_.x,_loc12_.y,new b2Vec2(0,0),_loc11_);
                  _loc4_.isSensor = true;
                  (_loc8_ = new b2BodyDef()).position.Set(_loc10_.x,_loc10_.y + 0.5);
                  _loc8_.userData = new BlueDiamond();
                  _loc8_.userData.name = "bd";
                  (_loc9_ = this.m_world.CreateBody(_loc8_)).CreateShape(_loc4_);
                  this.DiamondsandRopes.addChild(_loc8_.userData);
               }
               else if(_loc13_[_loc16_][_loc22_] == "rd")
               {
                  ++this.RDcount;
                  _loc10_ = new b2Vec2(_loc22_,_loc16_);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc12_.x,_loc12_.y,new b2Vec2(0,0),_loc11_);
                  _loc4_.isSensor = true;
                  (_loc8_ = new b2BodyDef()).position.Set(_loc10_.x,_loc10_.y + 0.5);
                  _loc8_.userData = new RedDiamond();
                  _loc8_.userData.name = "rd";
                  (_loc9_ = this.m_world.CreateBody(_loc8_)).CreateShape(_loc4_);
                  this.DiamondsandRopes.addChild(_loc8_.userData);
               }
               else if(_loc13_[_loc16_][_loc22_] == "gr")
               {
                  _loc10_ = new b2Vec2(_loc22_,_loc16_);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc12_.x,_loc12_.y,new b2Vec2(0,0),_loc11_);
                  _loc4_.isSensor = true;
                  (_loc8_ = new b2BodyDef()).position.Set(_loc10_.x,_loc10_.y);
                  _loc8_.userData = new SilverDiamond();
                  _loc8_.userData.name = "gr";
                  (_loc9_ = this.m_world.CreateBody(_loc8_)).CreateShape(_loc4_);
                  this.DiamondsandRopes.addChild(_loc8_.userData);
               }
               if(_loc13_[_loc16_][_loc22_] == 1)
               {
                  _loc10_ = new b2Vec2(_loc22_,_loc16_);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc12_.x,_loc12_.y,_loc10_,_loc11_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc15_.push(_loc4_);
                  (_loc7_ = _loc6_.addChild(new GroundBox1())).scaleX = 1;
                  _loc7_.scaleY = 1;
                  _loc7_.x = _loc10_.x * 20;
                  _loc7_.y = _loc10_.y * 20;
                  (_loc7_ = _loc14_.addChild(new MaskBox())).scaleX = 1;
                  _loc7_.scaleY = 1;
                  _loc7_.x = _loc10_.x * 20;
                  _loc7_.y = _loc10_.y * 20;
                  _loc7_.rotation = Math.round(Math.random() * 4) * 90;
               }
               else if(_loc13_[_loc16_][_loc22_] == -1)
               {
                  _loc10_ = new b2Vec2(_loc22_,_loc16_);
                  (_loc4_ = new b2PolygonDef()).vertexCount = 3;
                  _loc4_.vertices[0].Set(_loc22_ - 0.5,_loc16_ + 0.5);
                  _loc4_.vertices[1].Set(_loc22_ - 0.5,_loc16_ - 0.5);
                  _loc4_.vertices[2].Set(_loc22_ + 0.5,_loc16_ + 0.5);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc15_.push(_loc4_);
                  (_loc7_ = _loc6_.addChild(new GroundTri_1())).scaleX = 1;
                  _loc7_.scaleY = 1;
                  _loc7_.x = _loc22_ * 20;
                  _loc7_.y = _loc16_ * 20;
                  (_loc7_ = _loc14_.addChild(new MaskBoxMaskTri())).scaleX = 1;
                  _loc7_.scaleY = 1;
                  _loc7_.x = _loc10_.x * 20;
                  _loc7_.y = _loc10_.y * 20;
               }
               else if(_loc13_[_loc16_][_loc22_] == -2)
               {
                  _loc10_ = new b2Vec2(_loc22_,_loc16_);
                  (_loc4_ = new b2PolygonDef()).vertexCount = 3;
                  _loc4_.vertices[0].Set(_loc22_ - 0.5,_loc16_ + 0.5);
                  _loc4_.vertices[1].Set(_loc22_ + 0.5,_loc16_ - 0.5);
                  _loc4_.vertices[2].Set(_loc22_ + 0.5,_loc16_ + 0.5);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc15_.push(_loc4_);
                  (_loc7_ = _loc6_.addChild(new GroundTri_1())).scaleX = 1;
                  _loc7_.scaleY = 1;
                  _loc7_.x = _loc22_ * 20;
                  _loc7_.y = _loc16_ * 20;
                  _loc7_.rotation = -90;
                  (_loc7_ = _loc14_.addChild(new MaskBoxMaskTri())).scaleX = 1;
                  _loc7_.scaleY = 1;
                  _loc7_.x = _loc10_.x * 20;
                  _loc7_.y = _loc10_.y * 20;
                  _loc7_.rotation = -90;
               }
               else if(_loc13_[_loc16_][_loc22_] == -3)
               {
                  _loc10_ = new b2Vec2(_loc22_,_loc16_);
                  (_loc4_ = new b2PolygonDef()).vertexCount = 3;
                  _loc4_.vertices[1].Set(_loc22_ + 0.5,_loc16_ - 0.5);
                  _loc4_.vertices[0].Set(_loc22_ - 0.5,_loc16_ - 0.5);
                  _loc4_.vertices[2].Set(_loc22_ + 0.5,_loc16_ + 0.5);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc15_.push(_loc4_);
                  (_loc7_ = _loc6_.addChild(new GroundTri_1())).scaleX = 1;
                  _loc7_.scaleY = 1;
                  _loc7_.x = _loc22_ * 20;
                  _loc7_.y = _loc16_ * 20;
                  _loc7_.rotation = 180;
                  (_loc7_ = _loc14_.addChild(new MaskBoxMaskTri())).scaleX = 1;
                  _loc7_.scaleY = 1;
                  _loc7_.x = _loc10_.x * 20;
                  _loc7_.y = _loc10_.y * 20;
                  _loc7_.rotation = 180;
               }
               else if(_loc13_[_loc16_][_loc22_] == -4)
               {
                  _loc10_ = new b2Vec2(_loc22_,_loc16_);
                  (_loc4_ = new b2PolygonDef()).vertexCount = 3;
                  _loc4_.vertices[1].Set(_loc22_ + 0.5,_loc16_ - 0.5);
                  _loc4_.vertices[0].Set(_loc22_ - 0.5,_loc16_ - 0.5);
                  _loc4_.vertices[2].Set(_loc22_ - 0.5,_loc16_ + 0.5);
                  _loc4_.friction = 1;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc15_.push(_loc4_);
                  (_loc7_ = _loc6_.addChild(new GroundTri_1())).scaleX = 1;
                  _loc7_.scaleY = 1;
                  _loc7_.x = _loc22_ * 20;
                  _loc7_.y = _loc16_ * 20;
                  _loc7_.rotation = 90;
                  (_loc7_ = _loc14_.addChild(new MaskBoxMaskTri())).scaleX = 1;
                  _loc7_.scaleY = 1;
                  _loc7_.x = _loc10_.x * 20;
                  _loc7_.y = _loc10_.y * 20;
                  _loc7_.rotation = 90;
               }
               if(_loc13_[_loc16_][_loc22_] == 5)
               {
                  _loc10_ = new b2Vec2(_loc22_,_loc16_ + 0.25);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc12_.x,_loc12_.y / 2,new b2Vec2(_loc22_,_loc16_ - 0.25),_loc11_);
                  _loc4_.friction = 0;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.isSensor = true;
                  _loc4_.userData = "water";
                  _loc5_.CreateShape(_loc4_);
                  _loc15_.push(_loc4_);
                  (_loc7_ = this.FiresandWaters.addChild(new WaterBox())).x = _loc10_.x * 20;
                  _loc7_.y = (_loc10_.y - 0.5) * 20;
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc12_.x,_loc12_.y / 2,_loc10_,_loc11_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc15_.push(_loc4_);
                  (_loc7_ = _loc6_.addChild(new GroundBoxHalf())).scaleX = 1;
                  _loc7_.scaleY = 1;
                  _loc7_.x = _loc10_.x * 20;
                  _loc7_.y = _loc10_.y * 20;
                  if(Math.random() > 0.4)
                  {
                     _loc7_.rotation = 180;
                  }
                  (_loc7_ = _loc14_.addChild(new MaskBoxHalf())).scaleX = 1;
                  _loc7_.scaleY = 1;
                  _loc7_.x = _loc10_.x * 20;
                  _loc7_.y = _loc10_.y * 20;
               }
               else if(_loc13_[_loc16_][_loc22_] == 51)
               {
                  _loc10_ = new b2Vec2(_loc22_,_loc16_ + 0.25);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc12_.x,_loc12_.y,_loc10_,_loc11_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.isSensor = true;
                  _loc4_.userData = "water";
                  _loc5_.CreateShape(_loc4_);
                  _loc15_.push(_loc4_);
                  (_loc7_ = this.FiresandWaters.addChild(new WaterBoxTri())).scaleX = 1;
                  _loc7_.scaleY = 0.5;
                  _loc7_.x = _loc10_.x * 20;
                  _loc7_.y = (_loc10_.y - 0.5) * 20;
                  (_loc4_ = new b2PolygonDef()).vertexCount = 3;
                  _loc4_.vertices[0].Set(_loc22_ - 0.5,_loc16_);
                  _loc4_.vertices[1].Set(_loc22_ - 0.5,_loc16_ - 0.5);
                  _loc4_.vertices[2].Set(_loc22_ + 0.5,_loc16_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc15_.push(_loc4_);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc12_.x,_loc12_.y / 2,_loc10_,_loc11_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc15_.push(_loc4_);
                  (_loc7_ = _loc14_.addChild(new MaskBoxMaskTri2())).scaleX = 1;
                  _loc7_.scaleY = 1;
                  _loc7_.x = _loc10_.x * 20;
                  _loc7_.y = _loc10_.y * 20;
               }
               else if(_loc13_[_loc16_][_loc22_] == 52)
               {
                  _loc10_ = new b2Vec2(_loc22_,_loc16_ + 0.25);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc12_.x,_loc12_.y,_loc10_,_loc11_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.isSensor = true;
                  _loc4_.userData = "water";
                  _loc5_.CreateShape(_loc4_);
                  _loc15_.push(_loc4_);
                  (_loc7_ = this.FiresandWaters.addChild(new WaterBoxTri())).scaleX = -1;
                  _loc7_.scaleY = 0.5;
                  _loc7_.x = _loc10_.x * 20;
                  _loc7_.y = (_loc10_.y - 0.5) * 20;
                  (_loc4_ = new b2PolygonDef()).vertexCount = 3;
                  _loc4_.vertices[0].Set(_loc22_ - 0.5,_loc16_);
                  _loc4_.vertices[1].Set(_loc22_ + 0.5,_loc16_ - 0.5);
                  _loc4_.vertices[2].Set(_loc22_ + 0.5,_loc16_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc15_.push(_loc4_);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc12_.x,_loc12_.y / 2,_loc10_,_loc11_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc15_.push(_loc4_);
                  (_loc7_ = _loc14_.addChild(new MaskBoxMaskTri3())).scaleX = 1;
                  _loc7_.scaleY = 1;
                  _loc7_.x = _loc10_.x * 20;
                  _loc7_.y = _loc10_.y * 20;
               }
               if(_loc13_[_loc16_][_loc22_] == 6)
               {
                  _loc10_ = new b2Vec2(_loc22_,_loc16_ + 0.25);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc12_.x,_loc12_.y / 2,new b2Vec2(_loc22_,_loc16_ - 0.25),_loc11_);
                  _loc4_.friction = 0;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.isSensor = true;
                  _loc4_.userData = "fire";
                  _loc5_.CreateShape(_loc4_);
                  _loc15_.push(_loc4_);
                  (_loc7_ = this.FiresandWaters.addChild(new FireBox())).x = _loc10_.x * 20;
                  _loc7_.y = (_loc10_.y - 0.5) * 20;
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc12_.x,_loc12_.y / 2,_loc10_,_loc11_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc15_.push(_loc4_);
                  (_loc7_ = _loc6_.addChild(new GroundBoxHalf())).scaleX = 1;
                  _loc7_.scaleY = 1;
                  _loc7_.x = _loc10_.x * 20;
                  _loc7_.y = _loc10_.y * 20;
                  if(Math.random() > 0.4)
                  {
                     _loc7_.rotation = 180;
                  }
                  (_loc7_ = _loc14_.addChild(new MaskBoxHalf())).scaleX = 1;
                  _loc7_.scaleY = 1;
                  _loc7_.x = _loc10_.x * 20;
                  _loc7_.y = _loc10_.y * 20;
               }
               else if(_loc13_[_loc16_][_loc22_] == 61)
               {
                  _loc10_ = new b2Vec2(_loc22_,_loc16_ + 0.25);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc12_.x,_loc12_.y,_loc10_,_loc11_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.isSensor = true;
                  _loc4_.userData = "fire";
                  _loc5_.CreateShape(_loc4_);
                  _loc15_.push(_loc4_);
                  (_loc7_ = this.FiresandWaters.addChild(new FireBoxTri())).scaleX = 1;
                  _loc7_.scaleY = 0.5;
                  _loc7_.x = _loc10_.x * 20;
                  _loc7_.y = (_loc10_.y - 0.5) * 20;
                  (_loc4_ = new b2PolygonDef()).vertexCount = 3;
                  _loc4_.vertices[0].Set(_loc22_ - 0.5,_loc16_);
                  _loc4_.vertices[1].Set(_loc22_ - 0.5,_loc16_ - 0.5);
                  _loc4_.vertices[2].Set(_loc22_ + 0.5,_loc16_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc15_.push(_loc4_);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc12_.x,_loc12_.y / 2,_loc10_,_loc11_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc15_.push(_loc4_);
                  (_loc7_ = _loc14_.addChild(new MaskBoxMaskTri2())).scaleX = 1;
                  _loc7_.scaleY = 1;
                  _loc7_.x = _loc10_.x * 20;
                  _loc7_.y = _loc10_.y * 20;
               }
               else if(_loc13_[_loc16_][_loc22_] == 62)
               {
                  _loc10_ = new b2Vec2(_loc22_,_loc16_ + 0.25);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc12_.x,_loc12_.y,_loc10_,_loc11_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.isSensor = true;
                  _loc4_.userData = "fire";
                  _loc5_.CreateShape(_loc4_);
                  _loc15_.push(_loc4_);
                  (_loc7_ = this.FiresandWaters.addChild(new FireBoxTri())).scaleX = -1;
                  _loc7_.scaleY = 0.5;
                  _loc7_.x = _loc10_.x * 20;
                  _loc7_.y = (_loc10_.y - 0.5) * 20;
                  (_loc4_ = new b2PolygonDef()).vertexCount = 3;
                  _loc4_.vertices[0].Set(_loc22_ - 0.5,_loc16_);
                  _loc4_.vertices[1].Set(_loc22_ + 0.5,_loc16_ - 0.5);
                  _loc4_.vertices[2].Set(_loc22_ + 0.5,_loc16_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc15_.push(_loc4_);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc12_.x,_loc12_.y / 2,_loc10_,_loc11_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc15_.push(_loc4_);
                  (_loc7_ = _loc14_.addChild(new MaskBoxMaskTri3())).scaleX = 1;
                  _loc7_.scaleY = 1;
                  _loc7_.x = _loc10_.x * 20;
                  _loc7_.y = _loc10_.y * 20;
               }
               if(_loc13_[_loc16_][_loc22_] == 7)
               {
                  _loc10_ = new b2Vec2(_loc22_,_loc16_ + 0.25);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc12_.x,_loc12_.y / 2,new b2Vec2(_loc22_,_loc16_ - 0.25),_loc11_);
                  _loc4_.friction = 0;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.isSensor = true;
                  _loc4_.userData = "black";
                  _loc5_.CreateShape(_loc4_);
                  _loc15_.push(_loc4_);
                  (_loc7_ = this.FiresandWaters.addChild(new BlackBox())).x = _loc10_.x * 20;
                  _loc7_.y = (_loc10_.y - 0.5) * 20;
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc12_.x,_loc12_.y / 2,_loc10_,_loc11_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc15_.push(_loc4_);
                  (_loc7_ = _loc6_.addChild(new GroundBoxHalf())).scaleX = 1;
                  _loc7_.scaleY = 1;
                  _loc7_.x = _loc10_.x * 20;
                  _loc7_.y = _loc10_.y * 20;
                  if(Math.random() > 0.4)
                  {
                     _loc7_.rotation = 180;
                  }
                  (_loc7_ = _loc14_.addChild(new MaskBoxHalf())).scaleX = 1;
                  _loc7_.scaleY = 1;
                  _loc7_.x = _loc10_.x * 20;
                  _loc7_.y = _loc10_.y * 20;
               }
               else if(_loc13_[_loc16_][_loc22_] == 71)
               {
                  _loc10_ = new b2Vec2(_loc22_,_loc16_ + 0.25);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc12_.x,_loc12_.y,_loc10_,_loc11_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.isSensor = true;
                  _loc4_.userData = "black";
                  _loc5_.CreateShape(_loc4_);
                  _loc15_.push(_loc4_);
                  (_loc7_ = this.FiresandWaters.addChild(new BlackBoxTri())).scaleX = 1;
                  _loc7_.scaleY = 0.5;
                  _loc7_.x = _loc10_.x * 20;
                  _loc7_.y = (_loc10_.y - 0.5) * 20;
                  (_loc4_ = new b2PolygonDef()).vertexCount = 3;
                  _loc4_.vertices[0].Set(_loc22_ - 0.5,_loc16_);
                  _loc4_.vertices[1].Set(_loc22_ - 0.5,_loc16_ - 0.5);
                  _loc4_.vertices[2].Set(_loc22_ + 0.5,_loc16_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc15_.push(_loc4_);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc12_.x,_loc12_.y / 2,_loc10_,_loc11_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc15_.push(_loc4_);
                  (_loc7_ = _loc14_.addChild(new MaskBoxMaskTri2())).scaleX = 1;
                  _loc7_.scaleY = 1;
                  _loc7_.x = _loc10_.x * 20;
                  _loc7_.y = _loc10_.y * 20;
               }
               else if(_loc13_[_loc16_][_loc22_] == 72)
               {
                  _loc10_ = new b2Vec2(_loc22_,_loc16_ + 0.25);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc12_.x,_loc12_.y,_loc10_,_loc11_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.isSensor = true;
                  _loc4_.userData = "black";
                  _loc5_.CreateShape(_loc4_);
                  _loc15_.push(_loc4_);
                  (_loc7_ = this.FiresandWaters.addChild(new BlackBoxTri())).scaleX = -1;
                  _loc7_.scaleY = 0.5;
                  _loc7_.x = _loc10_.x * 20;
                  _loc7_.y = (_loc10_.y - 0.5) * 20;
                  (_loc4_ = new b2PolygonDef()).vertexCount = 3;
                  _loc4_.vertices[0].Set(_loc22_ - 0.5,_loc16_);
                  _loc4_.vertices[1].Set(_loc22_ + 0.5,_loc16_ - 0.5);
                  _loc4_.vertices[2].Set(_loc22_ + 0.5,_loc16_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc15_.push(_loc4_);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc12_.x,_loc12_.y / 2,_loc10_,_loc11_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc15_.push(_loc4_);
                  (_loc7_ = _loc14_.addChild(new MaskBoxMaskTri3())).scaleX = 1;
                  _loc7_.scaleY = 1;
                  _loc7_.x = _loc10_.x * 20;
                  _loc7_.y = _loc10_.y * 20;
               }
               _loc22_++;
            }
            _loc16_++;
         }
         this.CreateLightBody(_loc5_,_loc3_,_loc15_);
         _loc5_.SetMassFromShapes();
         _loc6_.name = "GroundMC";
         this.FiresandWaters.name = "FiresandWaters";
         _loc14_.name = "GroundMask";
         var _loc17_:*;
         (_loc17_ = new LightMask()).name = "LightMask";
         var _loc18_:*;
         (_loc18_ = new texture1()).name = "texture";
         _loc18_.mask = _loc14_;
         _loc18_.filters = [new GlowFilter(8874040,1,5,5,3,2,true,false),new GlowFilter(0,1,2,2,30,2,false,false),new DropShadowFilter(8,45,0,1,4,4,0.5,3,false,false,false)];
         var _loc19_:*;
         (_loc19_ = new Matrix()).tx = 15;
         _loc19_.ty = 15;
         var _loc20_:BitmapData;
         (_loc20_ = new BitmapData(_loc18_.width + 10,_loc18_.height + 10,true,0)).draw(_loc18_,_loc19_);
         var _loc21_:Bitmap;
         (_loc21_ = new Bitmap(_loc20_)).smoothing = true;
         _loc21_.cacheAsBitmap = true;
         _loc21_.name = "cachedGround";
         _loc21_.x -= 15;
         _loc21_.y -= 15;
         this.GroundLayer.addChild(_loc21_);
      }
      
      public function CreatePusher(param1:b2Vec2, param2:Number, param3:Number, param4:Boolean) : *
      {
         var _loc7_:b2BodyDef = null;
         var _loc8_:b2PolygonDef = null;
         var _loc9_:b2Body = null;
         var _loc5_:b2Vec2 = new b2Vec2(0,1);
         var _loc6_:b2PrismaticJointDef = new b2PrismaticJointDef();
         (_loc7_ = new b2BodyDef()).userData = new ButtonBox();
         _loc7_.userData.cacheAsBitmap = true;
         _loc7_.position.Set(param1.x,param1.y);
         _loc7_.userData.name = "button";
         switch(param3)
         {
            case 1:
               _loc7_.userData.addChild(new lightpoint_1());
               break;
            case 2:
               _loc7_.userData.addChild(new lightpoint_2());
               break;
            case 3:
               _loc7_.userData.addChild(new lightpoint_3());
               break;
            case 4:
               _loc7_.userData.addChild(new lightpoint_4());
               break;
            case 5:
               _loc7_.userData.addChild(new lightpoint_5());
               break;
            case 6:
               _loc7_.userData.addChild(new lightpoint_6());
         }
         _loc7_.userData.anchorx = param1.x;
         _loc7_.userData.anchory = param1.y - 2;
         _loc7_.userData.originx = param1.x;
         _loc7_.userData.originy = param1.y;
         _loc9_ = this.m_world.CreateBody(_loc7_);
         (_loc8_ = new b2PolygonDef()).SetAsOrientedBox(0.5,0.4,new b2Vec2(0,0.6));
         _loc8_.restitution = 0;
         _loc8_.friction = 0;
         _loc8_.density = 0.001;
         _loc8_.filter.groupIndex = -8;
         _loc9_.CreateShape(_loc8_);
         (_loc8_ = new b2PolygonDef()).vertexCount = 3;
         _loc8_.vertices[0].Set(-1,1);
         _loc8_.vertices[1].Set(-0.5,0.2);
         _loc8_.vertices[2].Set(-0.5,1);
         _loc8_.friction = 0;
         _loc8_.density = 0.001;
         _loc8_.filter.groupIndex = -8;
         _loc9_.CreateShape(_loc8_);
         (_loc8_ = new b2PolygonDef()).vertexCount = 3;
         _loc8_.vertices[0].Set(0.5,0.2);
         _loc8_.vertices[1].Set(1,1);
         _loc8_.vertices[2].Set(0.5,1);
         _loc8_.friction = 0;
         _loc8_.density = 0.001;
         _loc8_.filter.groupIndex = -8;
         _loc9_.CreateShape(_loc8_);
         _loc9_.SetMassFromShapes();
         var _loc10_:*;
         (_loc10_ = new ButtonMask()).x = _loc7_.position.x * 20;
         _loc10_.y = _loc7_.position.y * 20;
         _loc7_.userData.mask = _loc10_;
         var _loc11_:*;
         (_loc11_ = new ButtonPlants()).x = _loc7_.position.x * 20;
         _loc11_.y = _loc7_.position.y * 20;
         addChild(_loc7_.userData);
         addChild(_loc10_);
         addChild(_loc11_);
         _loc6_.Initialize(_loc9_,this.m_world.GetGroundBody(),_loc9_.GetWorldCenter(),_loc5_);
         _loc6_.lowerTranslation = -1 / 3;
         _loc6_.upperTranslation = 0.1;
         _loc6_.enableLimit = true;
         _loc6_.motorSpeed = 1;
         _loc6_.maxMotorForce = 1;
         _loc6_.enableMotor = true;
         _loc6_.userData = _loc9_;
         _loc6_.userData.GetUserData().soundable = param4;
         this.myPushers.push(this.m_world.CreateJoint(_loc6_));
      }
      
      public function CreateMirrorSlider(param1:b2Vec2, param2:Number, param3:Number, param4:Number, param5:Boolean) : *
      {
         var _loc8_:b2BodyDef = null;
         var _loc9_:* = undefined;
         var _loc10_:b2Body = null;
         var _loc11_:* = undefined;
         var _loc6_:b2Vec2 = new b2Vec2(1,0);
         var _loc7_:b2PrismaticJointDef = new b2PrismaticJointDef();
         (_loc8_ = new b2BodyDef()).userData = new SliderLever();
         _loc8_.userData.cacheAsBitmap = true;
         _loc8_.position.Set(param1.x,param1.y);
         _loc8_.userData.name = "button";
         _loc8_.userData.shift = param3;
         switch(param4)
         {
            case 1:
               _loc11_ = new lever_light_1();
               break;
            case 2:
               _loc11_ = new lever_light_2();
               break;
            case 3:
               _loc11_ = new lever_light_3();
               break;
            case 4:
               _loc11_ = new lever_light_4();
               break;
            case 5:
               _loc11_ = new lever_light_5();
               break;
            case 6:
               _loc11_ = new lever_light_6();
         }
         _loc11_.y = 11.15;
         _loc8_.userData.addChild(_loc11_);
         _loc8_.userData.originx = param1.x;
         _loc8_.userData.originy = param1.y;
         _loc8_.userData.length = param2;
         _loc10_ = this.m_world.CreateBody(_loc8_);
         var _loc12_:*;
         (_loc12_ = new SliderHole()).x = param1.x * 20;
         _loc12_.y = param1.y * 20;
         addChild(_loc12_);
         switch(param4)
         {
            case 1:
               _loc11_ = new lightpoint_1();
               break;
            case 2:
               _loc11_ = new lightpoint_2();
               break;
            case 3:
               _loc11_ = new lightpoint_3();
               break;
            case 4:
               _loc11_ = new lightpoint_4();
               break;
            case 5:
               _loc11_ = new lightpoint_5();
               break;
            case 6:
               _loc11_ = new lightpoint_6();
         }
         _loc11_.rotation = 90;
         _loc11_.y = 1.6;
         _loc11_.x = 108.15;
         _loc12_.addChild(_loc11_);
         switch(param4)
         {
            case 1:
               _loc11_ = new lightpoint_1();
               break;
            case 2:
               _loc11_ = new lightpoint_2();
               break;
            case 3:
               _loc11_ = new lightpoint_3();
               break;
            case 4:
               _loc11_ = new lightpoint_4();
               break;
            case 5:
               _loc11_ = new lightpoint_5();
               break;
            case 6:
               _loc11_ = new lightpoint_6();
         }
         _loc11_.rotation = -90;
         _loc11_.y = -1.4;
         _loc11_.x = -107.55;
         _loc12_.addChild(_loc11_);
         (_loc9_ = new b2CircleDef()).radius = 0.25;
         _loc9_.restitution = 0.1;
         _loc9_.friction = 0.2;
         _loc9_.density = 1;
         _loc10_.CreateShape(_loc9_);
         _loc10_.SetMassFromShapes();
         addChild(_loc8_.userData);
         _loc7_.Initialize(_loc10_,this.m_world.GetGroundBody(),_loc10_.GetWorldCenter(),_loc6_);
         _loc7_.lowerTranslation = -param2 / 2;
         _loc7_.upperTranslation = param2 / 2;
         _loc7_.enableLimit = true;
         _loc7_.motorSpeed = 0;
         _loc7_.maxMotorForce = 1;
         _loc7_.enableMotor = true;
         _loc7_.userData = _loc10_;
         _loc7_.userData.GetUserData().soundable = param5;
         this.myMirrorSliders.push(this.m_world.CreateJoint(_loc7_));
      }
      
      public function CreateInfiniteMirror(param1:b2Vec2, param2:Number, param3:Number, param4:Number) : *
      {
         var _loc5_:b2BodyDef = null;
         var _loc6_:* = undefined;
         var _loc7_:b2Body = null;
         var _loc11_:Sprite = null;
         var _loc10_:b2RevoluteJointDef = new b2RevoluteJointDef();
         (_loc5_ = new b2BodyDef()).userData = new RotMirrorInfinite();
         _loc5_.userData.cacheAsBitmap = true;
         _loc5_.userData.name = "rot";
         switch(param4)
         {
            case 1:
               _loc11_ = new rot_mirror_light_1();
               break;
            case 2:
               _loc11_ = new rot_mirror_light_2();
               break;
            case 3:
               _loc11_ = new rot_mirror_light_3();
               break;
            case 4:
               _loc11_ = new rot_mirror_light_4();
               break;
            case 5:
               _loc11_ = new rot_mirror_light_5();
               break;
            case 6:
               _loc11_ = new rot_mirror_light_6();
         }
         _loc11_.name = "light";
         _loc5_.userData.bar.addChild(_loc11_);
         _loc5_.position.Set(param1.x,param1.y);
         _loc7_ = this.m_world.CreateBody(_loc5_);
         this.SlidersAndRots.addChild(_loc5_.userData);
         var _loc12_:* = new Array();
         (_loc6_ = new b2PolygonDef()).filter.groupIndex = -1;
         _loc6_.SetAsOrientedBox(0.9,1 / 10,new b2Vec2(0,0),Math.PI / 4);
         _loc6_.density = 0.5;
         _loc6_.restitution = 1;
         _loc6_.friction = 0;
         _loc12_.push(_loc6_);
         _loc7_.GetUserData().mirror = true;
         (_loc6_ = new b2PolygonDef()).filter.groupIndex = -1;
         _loc6_.SetAsOrientedBox(0.2,0.2,new b2Vec2(-0.9,-0.9),Math.PI / 4);
         _loc6_.density = 0.5;
         _loc6_.restitution = 0;
         _loc6_.friction = 1;
         _loc12_.push(_loc6_);
         (_loc6_ = new b2PolygonDef()).filter.groupIndex = -1;
         _loc6_.SetAsOrientedBox(0.2,0.2,new b2Vec2(0.9,0.9),Math.PI / 4);
         _loc6_.density = 0.5;
         _loc6_.restitution = 0;
         _loc6_.friction = 1;
         _loc12_.push(_loc6_);
         this.CreateLightBody(_loc7_,_loc5_,_loc12_);
         (_loc6_ = new b2PolygonDef()).filter.groupIndex = -1;
         _loc6_.SetAsOrientedBox(0.9,1 / 20,new b2Vec2(0,0),Math.PI / 4);
         _loc6_.density = 0;
         _loc6_.friction = 0.3;
         _loc7_.CreateShape(_loc6_);
         _loc7_.SetMassFromShapes();
         _loc10_.Initialize(_loc7_,this.m_world.GetGroundBody(),new b2Vec2(_loc7_.GetWorldCenter().x,_loc7_.GetWorldCenter().y));
         _loc7_.SetXForm(_loc7_.GetPosition(),-param2);
         _loc10_.enableLimit = true;
         _loc10_.maxMotorTorque = 500;
         _loc10_.motorSpeed = 0;
         _loc10_.enableMotor = true;
         _loc10_.userData = _loc7_;
         this.myActuateds3.push(this.m_world.CreateJoint(_loc10_));
      }
      
      public function CreateRotPlatform(param1:b2Vec2, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:String, param9:Number) : *
      {
         var _loc10_:b2BodyDef = null;
         var _loc11_:b2PolygonDef = null;
         var _loc12_:b2Body = null;
         var _loc13_:b2RevoluteJointDef = null;
         var _loc14_:Sprite = null;
         var _loc15_:* = undefined;
         _loc13_ = new b2RevoluteJointDef();
         (_loc10_ = new b2BodyDef()).userData = new Platform1();
         _loc10_.userData.cacheAsBitmap = true;
         _loc10_.userData.name = "rot";
         switch(param9)
         {
            case 1:
               _loc14_ = new light_off_1();
               break;
            case 2:
               _loc14_ = new light_off_2();
               break;
            case 3:
               _loc14_ = new light_off_3();
               break;
            case 4:
               _loc14_ = new light_off_4();
               break;
            case 5:
               _loc14_ = new light_off_5();
               break;
            case 6:
               _loc14_ = new light_off_6();
         }
         _loc10_.userData.bar.addChild(_loc14_);
         switch(param9)
         {
            case 1:
               _loc14_ = new light_on_1();
               break;
            case 2:
               _loc14_ = new light_on_2();
               break;
            case 3:
               _loc14_ = new light_on_3();
               break;
            case 4:
               _loc14_ = new light_on_4();
               break;
            case 5:
               _loc14_ = new light_on_5();
               break;
            case 6:
               _loc14_ = new light_on_6();
         }
         _loc14_.name = "light";
         _loc10_.userData.bar.addChild(_loc14_);
         if(param2 > param3)
         {
            _loc10_.userData.bar.rotation = 90;
            _loc10_.userData.bar.scaleX = param3 * 40 / 20;
            _loc10_.userData.bar.scaleY = param2 * 40 / 80;
         }
         else
         {
            _loc10_.userData.bar.scaleX = param2 * 40 / 20;
            _loc10_.userData.bar.scaleY = param3 * 40 / 80;
         }
         _loc10_.position.Set(param1.x,param1.y);
         _loc12_ = this.m_world.CreateBody(_loc10_);
         this.SlidersAndRots.addChild(_loc10_.userData);
         (_loc11_ = new b2PolygonDef()).SetAsOrientedBox(param2,param3,new b2Vec2(0,0),param4);
         _loc11_.friction = 0.3;
         _loc11_.density = 0.1;
         _loc11_.filter.groupIndex = -8;
         _loc12_.CreateShape(_loc11_);
         this.CreateLightBody(_loc12_,_loc10_,new Array(_loc11_));
         _loc12_.SetMassFromShapes();
         _loc13_.Initialize(_loc12_,this.m_world.GetGroundBody(),new b2Vec2(_loc12_.GetWorldCenter().x,_loc12_.GetWorldCenter().y - param3 / 2));
         _loc13_.lowerAngle = param6 * b2Settings.b2_pi + 0.02;
         _loc13_.upperAngle = param5 * b2Settings.b2_pi - 0.02;
         _loc13_.enableLimit = true;
         _loc13_.maxMotorTorque = 10000;
         _loc13_.motorSpeed = -1;
         _loc13_.enableMotor = true;
         _loc13_.userData = _loc12_;
         _loc15_ = 0;
         if(param8 == "pusher")
         {
            this.myActuateds.push(this.m_world.CreateJoint(_loc13_));
            _loc15_ = 0;
            while(_loc15_ < param7)
            {
               this.myActuateds.push(this.myActuateds[this.myActuateds.length - 1]);
               _loc15_++;
            }
         }
         else if(param8 == "lever")
         {
            this.myActuateds2.push(this.m_world.CreateJoint(_loc13_));
            _loc15_ = 0;
            while(_loc15_ < param7)
            {
               this.myActuateds2.push(this.myActuateds2[this.myActuateds2.length - 1]);
               _loc15_++;
            }
         }
      }
      
      public function CreatePulley(param1:b2Vec2, param2:b2Vec2, param3:b2Vec2, param4:b2Vec2, param5:b2Vec2, param6:b2Vec2) : *
      {
         var _loc9_:b2PulleyJointDef = null;
         var _loc10_:b2BodyDef = null;
         var _loc11_:b2PolygonDef = null;
         var _loc12_:b2Body = null;
         var _loc13_:b2Body = null;
         var _loc14_:* = undefined;
         var _loc15_:* = undefined;
         var _loc7_:b2Vec2 = param1;
         var _loc8_:b2Vec2 = param2;
         _loc9_ = new b2PulleyJointDef();
         (_loc10_ = new b2BodyDef()).userData = new PlatformPulleyBox();
         _loc10_.userData.name = "PulleyPlatform";
         _loc10_.userData.platform.width = param3.y * 40;
         _loc10_.userData.platform.height = param3.x * 40;
         _loc10_.userData.anchor = param1;
         _loc10_.position.Set(param5.x,param5.y);
         _loc10_.fixedRotation = true;
         (_loc14_ = new RopePulley()).x = param1.x * 20;
         _loc14_.y = param1.y * 20;
         _loc14_.ropeMask.height = (param5.y - param1.y) * 20 - 34;
         _loc14_.cacheAsBitmap = true;
         this.DiamondsandRopes.addChild(_loc14_);
         _loc10_.userData.rope = _loc14_;
         _loc12_ = this.m_world.CreateBody(_loc10_);
         this.DiamondsandRopes.addChild(_loc10_.userData);
         (_loc11_ = new b2PolygonDef()).SetAsOrientedBox(param3.y,param3.x,new b2Vec2(0,0),0);
         _loc11_.friction = 0.1;
         _loc11_.density = 0.7;
         _loc12_.CreateShape(_loc11_);
         _loc12_.SetMassFromShapes();
         _loc10_.userData.connector = new Connector();
         _loc10_.userData.connector.x = param1.x * 20;
         _loc10_.userData.connector.y = param1.y * 20 - 10;
         _loc10_.userData.connector.ropeMask.rotation = 0;
         _loc10_.userData.connector.ropeMask.height = (param2.x - param1.x) * 20;
         _loc10_.userData.connector.ropeMask.rotation = -90;
         _loc10_.userData.connector.chain.x = (param2.x - param1.x) * 20;
         this.DiamondsandRopes.addChild(_loc10_.userData.connector);
         (_loc15_ = new PulleyAnchor()).x = param1.x * 20 + 5;
         _loc15_.y = param1.y * 20 - 5;
         this.DiamondsandRopes.addChild(_loc15_);
         _loc10_.userData.anc1 = _loc15_;
         (_loc15_ = new PulleyAnchor2()).x = param2.x * 20 - 5;
         _loc15_.y = param2.y * 20 - 5;
         this.DiamondsandRopes.addChild(_loc15_);
         _loc10_.userData.anc2 = _loc15_;
         (_loc10_ = new b2BodyDef()).userData = new PlatformPulleyBox();
         _loc10_.userData.name = "PulleyPlatform";
         _loc10_.userData.platform.width = param4.y * 40;
         _loc10_.userData.platform.height = param4.x * 40;
         _loc10_.userData.anchor = param2;
         _loc10_.position.Set(param6.x,param6.y);
         _loc10_.fixedRotation = true;
         (_loc14_ = new RopePulley()).x = param2.x * 20;
         _loc14_.y = param2.y * 20;
         _loc14_.ropeMask.height = (param6.y - param2.y) * 20 - 34;
         _loc14_.cacheAsBitmap = true;
         this.DiamondsandRopes.addChild(_loc14_);
         _loc10_.userData.rope = _loc14_;
         _loc13_ = this.m_world.CreateBody(_loc10_);
         this.DiamondsandRopes.addChild(_loc10_.userData);
         (_loc11_ = new b2PolygonDef()).SetAsOrientedBox(param3.y,param4.x,new b2Vec2(0,0),0);
         _loc11_.friction = 0.1;
         _loc11_.density = 0.7;
         _loc13_.CreateShape(_loc11_);
         _loc13_.SetMassFromShapes();
         _loc10_.userData.connector = new Connector();
         _loc10_.userData.anc1 = new PulleyAnchor();
         _loc10_.userData.anc2 = new PulleyAnchor();
         _loc9_.Initialize(_loc12_,_loc13_,param1,param2,_loc12_.GetWorldCenter(),_loc13_.GetWorldCenter(),1);
         _loc9_.maxLength1 = 30;
         _loc9_.maxLength2 = 30;
         this.m_world.CreateJoint(_loc9_);
      }
      
      public function CreateSlidePlatform(param1:b2Vec2, param2:Number, param3:Number, param4:b2Vec2, param5:Number, param6:Number, param7:Number, param8:String, param9:Number) : *
      {
         var _loc10_:b2Vec2 = null;
         var _loc11_:b2BodyDef = null;
         var _loc12_:b2PolygonDef = null;
         var _loc13_:b2Body = null;
         var _loc14_:b2PrismaticJointDef = null;
         var _loc15_:Sprite = null;
         var _loc16_:* = undefined;
         _loc10_ = param4;
         _loc14_ = new b2PrismaticJointDef();
         (_loc11_ = new b2BodyDef()).userData = new Platform1();
         _loc11_.userData.cacheAsBitmap = true;
         _loc11_.userData.name = "slide";
         switch(param9)
         {
            case 1:
               _loc15_ = new light_off_1();
               break;
            case 2:
               _loc15_ = new light_off_2();
               break;
            case 3:
               _loc15_ = new light_off_3();
               break;
            case 4:
               _loc15_ = new light_off_4();
               break;
            case 5:
               _loc15_ = new light_off_5();
               break;
            case 6:
               _loc15_ = new light_off_6();
         }
         _loc11_.userData.bar.addChild(_loc15_);
         switch(param9)
         {
            case 1:
               _loc15_ = new light_on_1();
               break;
            case 2:
               _loc15_ = new light_on_2();
               break;
            case 3:
               _loc15_ = new light_on_3();
               break;
            case 4:
               _loc15_ = new light_on_4();
               break;
            case 5:
               _loc15_ = new light_on_5();
               break;
            case 6:
               _loc15_ = new light_on_6();
         }
         _loc15_.name = "light";
         _loc15_.visible = false;
         _loc11_.userData.bar.addChild(_loc15_);
         if(param3 > param2)
         {
            _loc11_.userData.bar.rotation = 90;
            _loc11_.userData.bar.scaleX = param2 * 40 / 20;
            _loc11_.userData.bar.scaleY = param3 * 40 / 80;
         }
         else
         {
            _loc11_.userData.bar.scaleX = param3 * 40 / 20;
            _loc11_.userData.bar.scaleY = param2 * 40 / 80;
         }
         _loc11_.position.Set(param1.x,param1.y);
         _loc13_ = this.m_world.CreateBody(_loc11_);
         this.SlidersAndRots.addChild(_loc11_.userData);
         (_loc12_ = new b2PolygonDef()).SetAsOrientedBox(param3,param2 * 0.8,new b2Vec2(0,0),0);
         _loc12_.friction = 0.3;
         _loc12_.density = 0.3;
         _loc12_.filter.groupIndex = -8;
         _loc13_.CreateShape(_loc12_);
         this.CreateLightBody(_loc13_,_loc11_,new Array(_loc12_));
         _loc13_.SetMassFromShapes();
         _loc14_.Initialize(_loc13_,this.m_world.GetGroundBody(),_loc13_.GetWorldCenter(),_loc10_);
         _loc14_.lowerTranslation = param5;
         _loc14_.upperTranslation = param6;
         _loc14_.enableLimit = true;
         _loc14_.motorSpeed = 2;
         _loc14_.maxMotorForce = 500;
         _loc14_.enableMotor = true;
         _loc14_.userData = _loc13_;
         _loc16_ = 0;
         if(param8 == "pusher")
         {
            this.myActuateds.push(this.m_world.CreateJoint(_loc14_));
            _loc16_ = 0;
            while(_loc16_ < param7)
            {
               this.myActuateds.push(this.myActuateds[this.myActuateds.length - 1]);
               _loc16_++;
            }
         }
         else if(param8 == "lever")
         {
            this.myActuateds2.push(this.m_world.CreateJoint(_loc14_));
            _loc16_ = 0;
            while(_loc16_ < param7)
            {
               this.myActuateds2.push(this.myActuateds2[this.myActuateds2.length - 1]);
               _loc16_++;
            }
         }
         else if(param8 == "lpusher")
         {
            this.myActuateds4.push(this.m_world.CreateJoint(_loc14_));
            _loc16_ = 0;
            while(_loc16_ < param7)
            {
               this.myActuateds4.push(this.myActuateds4[this.myActuateds4.length - 1]);
               _loc16_++;
            }
         }
      }
      
      public function CreateLever(param1:b2Vec2, param2:Number, param3:String, param4:String, param5:Boolean) : *
      {
         var _loc6_:b2BodyDef = null;
         var _loc7_:b2PolygonDef = null;
         var _loc8_:b2Body = null;
         var _loc9_:b2RevoluteJointDef = null;
         var _loc10_:Sprite = null;
         var _loc11_:* = undefined;
         _loc9_ = new b2RevoluteJointDef();
         (_loc6_ = new b2BodyDef()).userData = new LeverMc();
         _loc6_.userData.cacheAsBitmap = true;
         _loc6_.userData.name = "platform";
         switch(param2)
         {
            case 1:
               _loc10_ = new lever_light_1();
               break;
            case 2:
               _loc10_ = new lever_light_2();
               break;
            case 3:
               _loc10_ = new lever_light_3();
               break;
            case 4:
               _loc10_ = new lever_light_4();
               break;
            case 5:
               _loc10_ = new lever_light_5();
               break;
            case 6:
               _loc10_ = new lever_light_6();
         }
         _loc10_.name = "light";
         _loc6_.userData.addChild(_loc10_);
         _loc6_.position.Set(param1.x,param1.y);
         _loc8_ = this.m_world.CreateBody(_loc6_);
         this.DiamondsandRopes.addChild(_loc6_.userData);
         (_loc11_ = new LeverBase()).x = param1.x * 20;
         _loc11_.y = param1.y * 20;
         switch(param2)
         {
            case 1:
               _loc10_ = new lever_base_light_1();
               break;
            case 2:
               _loc10_ = new lever_base_light_2();
               break;
            case 3:
               _loc10_ = new lever_base_light_3();
               break;
            case 4:
               _loc10_ = new lever_base_light_4();
               break;
            case 5:
               _loc10_ = new lever_base_light_5();
               break;
            case 6:
               _loc10_ = new lever_base_light_6();
         }
         _loc10_.x = 2;
         _loc10_.y = 13;
         _loc11_.addChild(_loc10_);
         this.DiamondsandRopes.addChild(_loc11_);
         (_loc7_ = new b2PolygonDef()).SetAsOrientedBox(0.25,0.75,new b2Vec2(0,0),0);
         _loc7_.friction = 0.1;
         _loc7_.density = 0.1;
         _loc7_.filter.groupIndex = -8;
         _loc8_.CreateShape(_loc7_);
         _loc8_.SetMassFromShapes();
         _loc9_.Initialize(_loc8_,this.m_world.GetGroundBody(),new b2Vec2(_loc8_.GetWorldCenter().x,_loc8_.GetWorldCenter().y + 0.6));
         _loc9_.lowerAngle = -0.2 * b2Settings.b2_pi;
         _loc9_.upperAngle = 0.2 * b2Settings.b2_pi;
         _loc9_.enableLimit = true;
         _loc9_.maxMotorTorque = 1;
         _loc9_.motorSpeed = 3;
         _loc9_.enableMotor = true;
         _loc9_.userData = _loc8_;
         _loc9_.userData.GetUserData().soundable = param5;
         if(param4 == "r")
         {
            _loc9_.userData.GetUserData().onis = "l";
         }
         else if(param4 == "l")
         {
            _loc9_.userData.GetUserData().onis = "r";
         }
         this.myLevers.push(this.m_world.CreateJoint(_loc9_));
         if(param3 == "r")
         {
            _loc8_.SetXForm(_loc8_.GetPosition(),-0.5 * b2Settings.b2_pi);
         }
         else if(param3 == "l")
         {
            _loc8_.SetXForm(_loc8_.GetPosition(),0.5 * b2Settings.b2_pi);
         }
      }
      
      public function CreateMovingEmitter(param1:b2Vec2, param2:b2Vec2) : *
      {
         var _loc3_:b2BodyDef = null;
         var _loc4_:b2PolygonDef = null;
         var _loc5_:b2Body = null;
         _loc3_ = new b2BodyDef();
         _loc3_.userData = new MovingBox();
         _loc3_.userData.name = "box";
         _loc3_.position.Set(param1.x,param1.y);
         _loc3_.linearDamping = 2;
         _loc3_.angularDamping = 2;
         this.CharsLayer.addChild(_loc3_.userData);
         _loc5_ = this.m_world.CreateBody(_loc3_);
         (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(param2.x,param2.y,new b2Vec2(0,0),0);
         _loc4_.friction = 0.05;
         _loc4_.density = 0.3;
         _loc4_.userData = new Object();
         _loc4_.restitution = 0;
         _loc5_.CreateShape(_loc4_);
         _loc5_.SetMassFromShapes();
      }
      
      public function CreateLightPusher(param1:b2Vec2, param2:Number, param3:Number, param4:Boolean) : *
      {
         var _loc5_:b2BodyDef = null;
         var _loc6_:b2PolygonDef = null;
         var _loc7_:b2Body = null;
         var _loc8_:* = undefined;
         (_loc5_ = new b2BodyDef()).userData = new LightPusher();
         _loc5_.userData.cacheAsBitmap = true;
         _loc5_.position.Set(param1.x,param1.y);
         _loc5_.userData.name = "LightPusher";
         _loc5_.userData.color = param3;
         switch(param3)
         {
            case 6671615:
               _loc8_ = new ll5();
               break;
            case 16777113:
               _loc8_ = new ll6();
         }
         _loc8_.y = 11.7;
         _loc8_.x = 0.55;
         _loc8_.scaleX = 1.2;
         _loc8_.scaleY = -1.04;
         _loc8_.cacheAsBitmap = true;
         _loc5_.userData.addChild(_loc8_);
         switch(param3)
         {
            case 6671615:
               _loc8_ = new lightpoint_52();
               break;
            case 16777113:
               _loc8_ = new lightpoint_62();
         }
         _loc8_.y = 10;
         _loc8_.x = 2.7;
         _loc8_.scaleX = 1.94;
         _loc8_.scaleY = 0.9;
         _loc8_.cacheAsBitmap = true;
         _loc5_.userData.addChild(_loc8_);
         _loc5_.userData.light = _loc8_;
         _loc7_ = this.m_world.CreateBody(_loc5_);
         (_loc6_ = new b2PolygonDef()).SetAsOrientedBox(0.3,0.2,new b2Vec2(0,0.5),0);
         _loc6_.restitution = 0;
         _loc6_.friction = 1;
         _loc6_.density = 0;
         _loc6_.filter.groupIndex = -8;
         _loc7_.CreateShape(_loc6_);
         this.DiamondsandRopes.addChild(_loc5_.userData);
         _loc5_.userData.activated == false;
         _loc5_.userData.soundable = param4;
         this.myLightPushers.push(_loc5_.userData);
         this.CreateLightBody(_loc7_,_loc5_,new Array(_loc6_));
         _loc7_.SetXForm(param1,param2);
         _loc7_.SetMassFromShapes();
      }
      
      public function CreateRotMirror(param1:b2Vec2, param2:Number, param3:Number, param4:Number, param5:Boolean = false) : *
      {
         var _loc6_:b2BodyDef = null;
         var _loc7_:* = undefined;
         var _loc8_:b2Body = null;
         var _loc11_:b2RevoluteJointDef = null;
         var _loc12_:Sprite = null;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         _loc11_ = new b2RevoluteJointDef();
         (_loc6_ = new b2BodyDef()).userData = new RotMirror();
         _loc6_.userData.cacheAsBitmap = true;
         _loc6_.userData.name = "rot";
         switch(param4)
         {
            case 1:
               _loc12_ = new rot_mirror_light_1();
               break;
            case 2:
               _loc12_ = new rot_mirror_light_2();
               break;
            case 3:
               _loc12_ = new rot_mirror_light_3();
               break;
            case 4:
               _loc12_ = new rot_mirror_light_4();
               break;
            case 5:
               _loc12_ = new rot_mirror_light_5();
               break;
            case 6:
               _loc12_ = new rot_mirror_light_6();
         }
         _loc12_.name = "light";
         _loc6_.userData.bar.addChild(_loc12_);
         _loc6_.position.Set(param1.x,param1.y);
         _loc8_ = this.m_world.CreateBody(_loc6_);
         this.SlidersAndRots.addChild(_loc6_.userData);
         _loc13_ = new Array();
         (_loc7_ = new b2PolygonDef()).filter.groupIndex = -1;
         _loc7_.SetAsOrientedBox(0.9,1 / 20,new b2Vec2(0,0),Math.PI / 4);
         _loc7_.density = 0.5;
         _loc7_.restitution = 1;
         _loc7_.friction = 0;
         _loc13_.push(_loc7_);
         _loc8_.GetUserData().mirror = true;
         (_loc7_ = new b2PolygonDef()).filter.groupIndex = -1;
         _loc7_.SetAsOrientedBox(0.2,0.2,new b2Vec2(-0.9,-0.9),Math.PI / 4);
         _loc7_.density = 0.5;
         _loc7_.restitution = 0;
         _loc7_.friction = 1;
         _loc13_.push(_loc7_);
         (_loc7_ = new b2PolygonDef()).filter.groupIndex = -1;
         _loc7_.SetAsOrientedBox(0.2,0.2,new b2Vec2(0.9,0.9),Math.PI / 4);
         _loc7_.density = 0.5;
         _loc7_.restitution = 0;
         _loc7_.friction = 1;
         _loc13_.push(_loc7_);
         (_loc7_ = new b2PolygonDef()).filter.groupIndex = -1;
         _loc7_.SetAsOrientedBox(0.2,0.2,new b2Vec2(0.9,-0.9),Math.PI / 4);
         _loc7_.density = 0.5;
         _loc7_.restitution = 0;
         _loc7_.friction = 1;
         _loc13_.push(_loc7_);
         (_loc7_ = new b2PolygonDef()).filter.groupIndex = -1;
         _loc7_.SetAsOrientedBox(0.2,0.2,new b2Vec2(-0.9,0.9),Math.PI / 4);
         _loc7_.density = 0.5;
         _loc7_.restitution = 0;
         _loc7_.friction = 1;
         _loc13_.push(_loc7_);
         this.CreateLightBody(_loc8_,_loc6_,_loc13_);
         (_loc7_ = new b2PolygonDef()).SetAsOrientedBox(1,1,new b2Vec2(0,0),0);
         _loc7_.friction = 0.3;
         _loc7_.density = 20;
         _loc7_.filter.groupIndex = -8;
         _loc8_.CreateShape(_loc7_);
         if(param5 == false)
         {
            _loc8_.SetMassFromShapes();
            _loc11_.Initialize(_loc8_,this.m_world.GetGroundBody(),new b2Vec2(_loc8_.GetWorldCenter().x,_loc8_.GetWorldCenter().y));
            _loc8_.SetXForm(_loc8_.GetPosition(),-param2);
            if(param2 == 0)
            {
               _loc11_.lowerAngle = -Math.PI / 2;
               _loc11_.upperAngle = 0;
            }
            else
            {
               _loc11_.lowerAngle = 0;
               _loc11_.upperAngle = Math.PI / 2;
            }
            _loc11_.enableLimit = true;
            _loc11_.maxMotorTorque = 500;
            _loc11_.motorSpeed = -2;
            _loc11_.enableMotor = true;
            _loc11_.userData = _loc8_;
            _loc14_ = 0;
            this.myActuateds2.push(this.m_world.CreateJoint(_loc11_));
            _loc14_ = 0;
            while(_loc14_ < param3)
            {
               this.myActuateds2.push(this.myActuateds2[this.myActuateds2.length - 1]);
               _loc14_++;
            }
         }
         else
         {
            _loc8_.SetXForm(param1,param2);
         }
      }
      
      public function CreateMovingBox(param1:b2Vec2, param2:b2Vec2) : *
      {
         var _loc3_:b2BodyDef = null;
         var _loc4_:b2PolygonDef = null;
         var _loc5_:b2Body = null;
         _loc3_ = new b2BodyDef();
         _loc3_.userData = new MovingBox();
         _loc3_.userData.cacheAsBitmap = true;
         _loc3_.userData.name = "box";
         _loc3_.position.Set(param1.x,param1.y);
         _loc3_.linearDamping = 2;
         _loc3_.angularDamping = 2;
         this.CharsLayer.addChild(_loc3_.userData);
         _loc5_ = this.m_world.CreateBody(_loc3_);
         (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(param2.x,param2.y,new b2Vec2(0,0),0);
         _loc4_.friction = 0.05;
         _loc4_.density = 0.3;
         _loc4_.userData = new Object();
         _loc4_.userData.name = "wind";
         _loc4_.restitution = 0;
         _loc5_.CreateShape(_loc4_);
         this.CreateLightBody(_loc5_,_loc3_,new Array(_loc4_));
         _loc5_.SetMassFromShapes();
      }
      
      public function CreateMovingBox2(param1:b2Vec2, param2:b2Vec2) : *
      {
         var _loc3_:b2BodyDef = null;
         var _loc4_:b2PolygonDef = null;
         var _loc5_:b2Body = null;
         _loc3_ = new b2BodyDef();
         _loc3_.userData = new MovingBox2();
         _loc3_.userData.cacheAsBitmap = true;
         _loc3_.userData.name = "box";
         _loc3_.position.Set(param1.x,param1.y);
         _loc3_.linearDamping = 2;
         _loc3_.angularDamping = 2;
         this.CharsLayer.addChild(_loc3_.userData);
         _loc5_ = this.m_world.CreateBody(_loc3_);
         (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(param2.x,param2.y,new b2Vec2(0,0),0);
         _loc4_.friction = 0.05;
         _loc4_.density = 0.7;
         _loc4_.userData = new Object();
         _loc4_.userData.name = "wind";
         _loc4_.restitution = 0;
         _loc5_.CreateShape(_loc4_);
         this.CreateLightBody(_loc5_,_loc3_,new Array(_loc4_));
         _loc5_.SetMassFromShapes();
      }
      
      public function CreateJumper(param1:b2Vec2, param2:Number) : *
      {
         var _loc3_:b2Vec2 = null;
         var _loc4_:b2PrismaticJointDef = null;
         var _loc5_:b2BodyDef = null;
         var _loc6_:b2PolygonDef = null;
         var _loc7_:b2Body = null;
         _loc3_ = new b2Vec2(0,1);
         _loc4_ = new b2PrismaticJointDef();
         (_loc5_ = new b2BodyDef()).userData = new JumperBox();
         _loc5_.position.Set(param1.x,param1.y);
         _loc5_.userData.name = "button";
         _loc5_.userData.anchorx = param1.x;
         _loc5_.userData.anchory = param1.y - 2;
         _loc5_.userData.originx = param1.x;
         _loc5_.userData.originy = param1.y;
         _loc7_ = this.m_world.CreateBody(_loc5_);
         (_loc6_ = new b2PolygonDef()).SetAsOrientedBox(0.75,0.4,new b2Vec2(0,0.6));
         _loc6_.restitution = 0;
         _loc6_.friction = 0;
         _loc6_.density = 0.001;
         _loc6_.filter.groupIndex = -8;
         _loc7_.CreateShape(_loc6_);
         _loc7_.SetMassFromShapes();
         addChild(_loc5_.userData);
         _loc4_.Initialize(_loc7_,this.m_world.GetGroundBody(),_loc7_.GetWorldCenter(),_loc3_);
         _loc4_.lowerTranslation = -1 / 3;
         _loc4_.upperTranslation = 0;
         _loc4_.enableLimit = true;
         _loc4_.motorSpeed = 1;
         _loc4_.maxMotorForce = 1;
         _loc4_.enableMotor = true;
         _loc4_.userData = _loc7_;
         this.myJumpers.push(this.m_world.CreateJoint(_loc4_));
      }
      
      public function CreateHangingPlatform(param1:b2Vec2, param2:b2Vec2, param3:Number, param4:String) : *
      {
         var _loc5_:b2BodyDef = null;
         var _loc6_:b2PolygonDef = null;
         var _loc7_:b2Body = null;
         var _loc9_:* = undefined;
         var _loc10_:b2DistanceJointDef = null;
         (_loc5_ = new b2BodyDef()).userData = new PlatformBox();
         _loc5_.userData.width = param2.x * 40;
         _loc5_.userData.height = param2.y * 40;
         switch(param4)
         {
            case "down":
               _loc5_.position.Set(param1.x,param1.y + param3);
               break;
            case "up":
               _loc5_.position.Set(param1.x,param1.y - param3);
               break;
            case "left":
               _loc5_.position.Set(param1.x - param3,param1.y);
               break;
            case "right":
               _loc5_.position.Set(param1.x + param3,param1.y);
         }
         _loc7_ = this.m_world.CreateBody(_loc5_);
         addChild(_loc5_.userData);
         _loc9_ = new Rope();
         _loc5_.userData.rope = _loc9_;
         _loc5_.userData.anchor = param1;
         _loc5_.userData.name = "HangingPlatform";
         _loc9_.ropeMask.height = param3 * 20;
         _loc9_.cacheAsBitmap = true;
         _loc9_.x = param1.x * 20;
         _loc9_.y = param1.y * 20;
         this.DiamondsandRopes.addChild(_loc9_);
         (_loc6_ = new b2PolygonDef()).SetAsOrientedBox(param2.x,param2.y,new b2Vec2(0,0),0);
         _loc6_.friction = 0.3;
         _loc6_.density = 1.5;
         _loc7_.CreateShape(_loc6_);
         _loc7_.SetMassFromShapes();
         (_loc10_ = new b2DistanceJointDef()).Initialize(_loc7_,this.m_world.GetGroundBody(),_loc7_.GetWorldCenter(),new b2Vec2(param1.x,param1.y));
         _loc10_.collideConnected = true;
         this.m_world.CreateJoint(_loc10_);
      }
      
      public function CreateWind(param1:b2Vec2, param2:b2Vec2, param3:Number, param4:Number, param5:String, param6:Boolean) : *
      {
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:Sprite = null;
         (_loc7_ = new Object()).lower = param1;
         _loc7_.upper = param2;
         _loc7_.vertical = param3;
         _loc7_.on = true;
         (_loc8_ = new Wind()).cacheAsBitmap = true;
         _loc8_.width = (param2.x - param1.x) * 20;
         _loc8_.height = (param2.y - param1.y) * 20;
         if(param3 == 1)
         {
            _loc8_.width += 30;
         }
         if(param3 == 2)
         {
            _loc8_.insideWind.rotation = 90;
            _loc8_.height += 30;
         }
         if(param3 == 3)
         {
            _loc8_.insideWind.rotation = 180;
            _loc8_.width += 30;
         }
         if(param3 == 4)
         {
            _loc8_.insideWind.rotation = 270;
            _loc8_.height += 30;
         }
         _loc7_.winder = _loc8_;
         _loc8_.x = (param1.x + (param2.x - param1.x) / 2) * 20;
         _loc8_.y = (param1.y + (param2.y - param1.y) / 2) * 20;
         addChild(_loc8_);
         (_loc8_ = new WindMaker()).cacheAsBitmap = true;
         _loc7_.mc = _loc8_;
         _loc7_.mc.soundable = param6;
         this.myWinds.push(_loc7_);
         switch(param4)
         {
            case 1:
               _loc9_ = new light_off_1();
               break;
            case 2:
               _loc9_ = new light_off_2();
               break;
            case 3:
               _loc9_ = new light_off_3();
               break;
            case 4:
               _loc9_ = new light_off_4();
               break;
            case 5:
               _loc9_ = new light_off_5();
               break;
            case 6:
               _loc9_ = new light_off_6();
         }
         _loc8_.addChild(_loc9_);
         _loc9_.x = -1;
         _loc9_.y = 4.5;
         _loc9_.width = 4.5;
         _loc9_.height = 50;
         _loc9_.rotation = 90;
         if(param5 == "lever")
         {
            _loc7_.on = false;
            switch(param4)
            {
               case 1:
                  _loc9_ = new light_on_1();
                  break;
               case 2:
                  _loc9_ = new light_on_2();
                  break;
               case 3:
                  _loc9_ = new light_on_3();
                  break;
               case 4:
                  _loc9_ = new light_on_4();
                  break;
               case 5:
                  _loc9_ = new light_on_5();
                  break;
               case 6:
                  _loc9_ = new light_on_6();
            }
            _loc9_.x = -1;
            _loc9_.y = 4.5;
            _loc9_.width = 4.5;
            _loc9_.height = 50;
            _loc9_.rotation = 90;
            _loc9_.name = "light";
            _loc8_.addChild(_loc9_);
         }
         else
         {
            _loc9_.name = "light";
         }
         if(param3 == 1)
         {
            _loc8_.x = (param1.x + (param2.x - param1.x) / 2) * 20;
            _loc8_.y = (param1.y + (param2.y - param1.y)) * 20;
         }
         if(param3 == 2)
         {
            _loc8_.x = param1.x * 20;
            _loc8_.y = (param1.y + (param2.y - param1.y) / 2) * 20;
            _loc8_.rotation = 90;
         }
         if(param3 == 3)
         {
            _loc8_.x = (param1.x + (param2.x - param1.x) / 2) * 20;
            _loc8_.y = param1.y * 20;
            _loc8_.rotation = 180;
         }
         if(param3 == 4)
         {
            _loc8_.x = param2.x * 20;
            _loc8_.y = (param1.y + (param2.y - param1.y) / 2) * 20;
            _loc8_.rotation = 270;
         }
         this.DiamondsandRopes.addChild(_loc8_);
         if(param5 == "lever")
         {
            this.myActuateds2.push(_loc7_);
         }
      }
      
      public function CreateBall(param1:b2Vec2) : *
      {
         var _loc2_:b2BodyDef = null;
         var _loc3_:b2CircleDef = null;
         var _loc4_:* = undefined;
         _loc2_ = new b2BodyDef();
         _loc2_.userData = new Ball();
         _loc2_.position.Set(param1.x,param1.y);
         _loc4_ = this.m_world.CreateBody(_loc2_);
         this.CharsLayer.addChild(_loc2_.userData);
         _loc3_ = new b2CircleDef();
         _loc3_.radius = 0.47;
         _loc3_.restitution = 0.1;
         _loc3_.friction = 0.2;
         _loc3_.density = 1.9;
         _loc4_.CreateShape(_loc3_);
         _loc4_.SetMassFromShapes();
      }
      
      public function CreateFinish(param1:b2Vec2, param2:b2Vec2) : *
      {
         var _loc3_:b2BodyDef = null;
         var _loc4_:b2PolygonDef = null;
         var _loc5_:b2Body = null;
         var _loc6_:b2Vec2 = null;
         _loc6_ = param1;
         var _loc7_:b2Vec2 = new b2Vec2(3,3);
         _loc3_ = new b2BodyDef();
         _loc3_.position.Set(_loc6_.x,_loc6_.y + 0.66);
         _loc3_.userData = new FinishBoy();
         _loc3_.userData.cacheAsBitmap = true;
         _loc3_.userData.name = "finish1";
         _loc5_ = this.m_world.CreateBody(_loc3_);
         this.SlidersAndRots.addChild(_loc3_.userData);
         (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(1,0.3,new b2Vec2(0,0.6));
         _loc4_.userData = "FinishBoy";
         _loc4_.filter.groupIndex = -8;
         _loc5_.CreateShape(_loc4_);
         (_loc4_ = new b2PolygonDef()).vertexCount = 3;
         _loc4_.vertices[0].Set(-1.5,0.4);
         _loc4_.vertices[1].Set(-1,0.3);
         _loc4_.vertices[2].Set(-1,0.4);
         _loc4_.filter.groupIndex = -8;
         _loc5_.CreateShape(_loc4_);
         (_loc4_ = new b2PolygonDef()).vertexCount = 3;
         _loc4_.vertices[0].Set(1.5,0.4);
         _loc4_.vertices[1].Set(1,0.4);
         _loc4_.vertices[2].Set(1,0.3);
         _loc4_.filter.groupIndex = -8;
         _loc5_.CreateShape(_loc4_);
         _loc6_ = param2;
         _loc3_ = new b2BodyDef();
         _loc3_.position.Set(_loc6_.x,_loc6_.y + 0.66);
         _loc3_.userData = new FinishGirl();
         _loc3_.userData.name = "finish2";
         _loc5_ = this.m_world.CreateBody(_loc3_);
         this.SlidersAndRots.addChild(_loc3_.userData);
         (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(1,0.3,new b2Vec2(0,0.6));
         _loc4_.userData = "FinishGirl";
         _loc4_.filter.groupIndex = -8;
         _loc5_.CreateShape(_loc4_);
         (_loc4_ = new b2PolygonDef()).vertexCount = 3;
         _loc4_.vertices[0].Set(-1.5,0.4);
         _loc4_.vertices[1].Set(-1,0.3);
         _loc4_.vertices[2].Set(-1,0.4);
         _loc5_.CreateShape(_loc4_);
         (_loc4_ = new b2PolygonDef()).vertexCount = 3;
         _loc4_.vertices[0].Set(1.5,0.4);
         _loc4_.vertices[1].Set(1,0.4);
         _loc4_.vertices[2].Set(1,0.3);
         _loc5_.CreateShape(_loc4_);
      }
      
      public function CreatRoman(param1:b2Vec2, param2:Number, param3:Number, param4:String) : *
      {
         var _loc5_:b2BodyDef = null;
         var _loc6_:b2PolygonDef = null;
         var _loc7_:b2Body = null;
         var _loc8_:b2RevoluteJointDef = null;
         (_loc5_ = new b2BodyDef()).userData = new RomanBase();
         _loc5_.userData.cacheAsBitmap = true;
         _loc5_.userData.height = (param2 - 0.5) * 20;
         _loc5_.position.Set(param1.x,param1.y - 0.5);
         this.SlidersAndRots.addChild(_loc5_.userData);
         _loc7_ = this.m_world.CreateBody(_loc5_);
         (_loc6_ = new b2PolygonDef()).vertexCount = 3;
         _loc6_.vertices[0].Set(-1,0);
         _loc6_.vertices[1].Set(0,-param2 + 0.5);
         _loc6_.vertices[2].Set(1,0);
         _loc6_.friction = 0.3;
         _loc6_.density = 0;
         _loc6_.filter.groupIndex = -8;
         _loc7_.CreateShape(_loc6_);
         _loc7_.SetMassFromShapes();
         (_loc5_ = new b2BodyDef()).userData = new Roman();
         _loc5_.userData.stick.width = param3 * 20;
         _loc5_.userData.tri1.x = -param3 * 10 - 20;
         _loc5_.userData.tri2.x = param3 * 10 + 20;
         _loc5_.position.Set(param1.x,param1.y - param2);
         this.SlidersAndRots.addChild(_loc5_.userData);
         _loc7_ = this.m_world.CreateBody(_loc5_);
         (_loc6_ = new b2PolygonDef()).SetAsOrientedBox(param3 / 2,0.25,new b2Vec2(0,0),0);
         _loc6_.friction = 0.3;
         _loc6_.density = 0.3;
         _loc6_.filter.groupIndex = -8;
         _loc7_.CreateShape(_loc6_);
         (_loc6_ = new b2PolygonDef()).vertexCount = 3;
         _loc6_.vertices[0].Set(-param3 / 2 - 2,-0.25);
         _loc6_.vertices[1].Set(-param3 / 2,-0.25);
         _loc6_.vertices[2].Set(-param3 / 2,0.25);
         _loc6_.friction = 0.3;
         _loc6_.density = 0;
         _loc7_.CreateShape(_loc6_);
         (_loc6_ = new b2PolygonDef()).vertexCount = 3;
         _loc6_.vertices[0].Set(param3 / 2,0.25);
         _loc6_.vertices[1].Set(param3 / 2,-0.25);
         _loc6_.vertices[2].Set(param3 / 2 + 2,-0.25);
         _loc6_.friction = 0.3;
         _loc6_.density = 0;
         _loc7_.CreateShape(_loc6_);
         _loc7_.CreateShape(_loc6_);
         _loc7_.SetMassFromShapes();
         if(param4 == "r")
         {
            _loc7_.SetXForm(_loc7_.GetPosition(),Math.acos((param2 + 0.25) / (param3 / 2 + 2)) - Math.PI / 2);
         }
         else if(param4 == "l")
         {
            _loc7_.SetXForm(_loc7_.GetPosition(),-Math.acos((param2 + 0.25) / (param3 / 2 + 2)) + Math.PI / 2);
         }
         (_loc8_ = new b2RevoluteJointDef()).Initialize(_loc7_,this.m_world.GetGroundBody(),_loc7_.GetWorldCenter());
         _loc8_.collideConnected = true;
         this.m_world.CreateJoint(_loc8_);
      }
      
      public function CreateMovingMirror(param1:b2Vec2, param2:b2Vec2, param3:*, param4:* = false) : *
      {
         var _loc5_:b2BodyDef = null;
         var _loc6_:b2PolygonDef = null;
         var _loc7_:b2Body = null;
         (_loc5_ = new b2BodyDef()).userData = new MovingMirror();
         _loc5_.userData.cacheAsBitmap = true;
         _loc5_.userData.name = "box";
         _loc5_.position.Set(param1.x,param1.y);
         _loc5_.angle = param3 / 180 * Math.PI;
         _loc5_.linearDamping = 2;
         _loc5_.angularDamping = 2;
         addChild(_loc5_.userData);
         _loc7_ = this.m_world.CreateBody(_loc5_);
         (_loc6_ = new b2PolygonDef()).filter.groupIndex = -1;
         _loc6_.SetAsOrientedBox(0.9,1 / 20,new b2Vec2(0,0),Math.PI / 4);
         _loc6_.density = 0;
         _loc6_.restitution = 1;
         _loc6_.friction = 0;
         _loc7_.GetUserData().mirror = true;
         this.CreateLightBody(_loc7_,_loc5_,new Array(_loc6_));
         (_loc6_ = new b2PolygonDef()).SetAsOrientedBox(param2.x,param2.y,new b2Vec2(0,0),0);
         _loc6_.friction = 0.05;
         if(param4 == false)
         {
            _loc6_.density = 0.3;
         }
         else
         {
            _loc6_.density = 0;
         }
         _loc7_.CreateShape(_loc6_);
         _loc7_.SetMassFromShapes();
      }
      
      public function CreateLightBeamer(param1:b2Vec2, param2:*, param3:*) : *
      {
         var _loc4_:b2BodyDef = null;
         var _loc5_:b2PolygonDef = null;
         var _loc6_:b2Body = null;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         _loc4_ = new b2BodyDef();
         (_loc8_ = (_loc7_ = new LightBeamer()).glower.transform.colorTransform).color = param3;
         _loc7_.glower.transform.colorTransform = _loc8_;
         _loc4_.userData = _loc7_;
         _loc4_.userData.name = "beamer";
         _loc7_.bullet = this.CreateBullet(new b2Vec2(param1.x,param1.y),new b2Vec2(0,0),param3);
         _loc7_.startPoint = new b2Vec2(param1.x - 0.3 * Math.cos(param2),param1.y - 0.3 * Math.sin(param2));
         _loc7_.color = param3;
         _loc4_.position.Set(param1.x,param1.y);
         this.DiamondsandRopes.addChild(_loc4_.userData);
         _loc6_ = this.m_world.CreateBody(_loc4_);
         (_loc5_ = new b2PolygonDef()).SetAsOrientedBox(0.3,1,new b2Vec2(-0.5,0),0);
         _loc5_.friction = 0.05;
         _loc5_.density = 0;
         _loc6_.CreateShape(_loc5_);
         _loc6_.SetXForm(new b2Vec2(param1.x,param1.y),param2);
         _loc6_.SetMassFromShapes();
      }
      
      public function TraceBeam(param1:*) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         this.LightBoard.graphics.lineStyle(20,param1.m_userData.color,1,false,"normal","none","bevel",0.1);
         this.LightBoard.graphics.moveTo(param1.m_userData.startPoint.x * 20,param1.m_userData.startPoint.y * 20);
         param1.m_userData.bullet.SetXForm(new b2Vec2(param1.m_userData.startPoint.x,param1.m_userData.startPoint.y),0);
         _loc2_ = new b2Vec2(Math.cos(param1.GetAngle()),Math.sin(param1.GetAngle()));
         _loc2_.Multiply(this.LightSpeed);
         param1.m_userData.bullet.SetLinearVelocity(_loc2_);
         _loc3_ = 300;
         param1.m_userData.bullet.m_userData.Path = new Array();
         param1.m_userData.bullet.m_userData.Path.push(new b2Vec2(param1.m_userData.startPoint.x,param1.m_userData.startPoint.y));
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(param1.m_userData.bullet.IsSleeping() == true)
            {
               param1.m_userData.bullet.WakeUp();
            }
            this.m_lworld.Step(1 / 26,50);
            if(param1.m_userData.bullet.GetLinearVelocity().Length() < 1)
            {
               _loc4_ = _loc3_;
            }
            _loc4_++;
         }
         param1.m_userData.bullet.m_userData.Path.push(new b2Vec2(param1.m_userData.bullet.GetPosition().x,param1.m_userData.bullet.GetPosition().y));
         this.LightBoard.graphics.lineStyle(20,param1.m_userData.color,1,false,"normal","round","bevel",1);
         _loc8_ = 1;
         while(_loc8_ < param1.m_userData.bullet.m_userData.Path.length - 1)
         {
            _loc5_ = new Point(param1.m_userData.bullet.m_userData.Path[_loc8_ - 1].x * 20,param1.m_userData.bullet.m_userData.Path[_loc8_ - 1].y * 20);
            _loc9_ = (_loc6_ = new Point(param1.m_userData.bullet.m_userData.Path[_loc8_].x * 20,param1.m_userData.bullet.m_userData.Path[_loc8_].y * 20)).subtract(_loc5_);
            _loc10_ = Math.atan2(_loc9_.y,_loc9_.x);
            (_loc7_ = new Matrix()).createGradientBox(20,20,_loc10_ + Math.PI / 2,_loc5_.x - 10,_loc5_.y - 10);
            this.LightBoard.graphics.lineGradientStyle("linear",[param1.m_userData.color,param1.m_userData.color,param1.m_userData.color,param1.m_userData.color,param1.m_userData.color],[0,0.3,0.5,0.3,0],[0,63,127,190,255],_loc7_,"pad");
            _loc9_.normalize(11);
            this.LightBoard.graphics.moveTo(_loc5_.x + _loc9_.x,_loc5_.y + _loc9_.y);
            this.LightBoard.graphics.lineTo(_loc6_.x - _loc9_.x,_loc6_.y - _loc9_.y);
            _loc8_++;
         }
         _loc8_ = param1.m_userData.bullet.m_userData.Path.length - 1;
         _loc5_ = new Point(param1.m_userData.bullet.m_userData.Path[_loc8_ - 1].x * 20,param1.m_userData.bullet.m_userData.Path[_loc8_ - 1].y * 20);
         _loc9_ = (_loc6_ = new Point(param1.m_userData.bullet.m_userData.Path[_loc8_].x * 20,param1.m_userData.bullet.m_userData.Path[_loc8_].y * 20)).subtract(_loc5_);
         _loc10_ = Math.atan2(_loc9_.y,_loc9_.x);
         (_loc7_ = new Matrix()).createGradientBox(20,20,_loc10_ + Math.PI / 2,_loc5_.x - 10,_loc5_.y - 10);
         this.LightBoard.graphics.lineGradientStyle("linear",[param1.m_userData.color,param1.m_userData.color,param1.m_userData.color,param1.m_userData.color,param1.m_userData.color],[0,0.3,0.5,0.3,0],[0,63,127,190,255],_loc7_,"pad");
         if(_loc9_.length > 11)
         {
            _loc9_.normalize(11);
            this.LightBoard.graphics.moveTo(_loc5_.x + _loc9_.x,_loc5_.y + _loc9_.y);
            this.LightBoard.graphics.lineTo(_loc6_.x,_loc6_.y);
         }
         else
         {
            this.LightBoard.graphics.moveTo(_loc5_.x,_loc5_.y);
            this.LightBoard.graphics.lineTo(_loc6_.x,_loc6_.y);
         }
      }
      
      public function CreateBullet(param1:*, param2:*, param3:*) : *
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         _loc5_ = new b2BodyDef();
         _loc6_ = new Bullet();
         _loc5_.userData = _loc6_;
         _loc6_.slow = 0;
         _loc6_.Path = new Array();
         _loc6_.color = param3;
         _loc5_.isBullet = false;
         _loc5_.massData.mass = 1;
         _loc4_ = this.m_lworld.CreateBody(_loc5_);
         (_loc7_ = new b2CircleDef()).radius = 0.1;
         _loc7_.userData = "LightBall";
         _loc7_.localPosition.Set(0,0);
         _loc7_.density = 1;
         _loc7_.restitution = 0;
         _loc7_.friction = 999;
         _loc7_.filter.groupIndex = -1;
         _loc4_.CreateShape(_loc7_);
         (_loc7_ = new b2CircleDef()).radius = 0.0001;
         _loc7_.localPosition.Set(0,0);
         _loc7_.density = 1;
         _loc7_.restitution = 0;
         _loc7_.friction = 999;
         _loc4_.CreateShape(_loc7_);
         _loc4_.SetXForm(new b2Vec2(param1.x,param1.y),0);
         _loc4_.SetLinearVelocity(param2);
         this.LightBoard.addChild(_loc4_.GetUserData());
         this.LightBoard.cacheAsBitmap = true;
         return _loc4_;
      }
      
      public function CreateLightBody(param1:*, param2:*, param3:*) : *
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         _loc4_ = this.m_lworld.CreateBody(param2);
         _loc5_ = 0;
         while(_loc5_ < param3.length)
         {
            if(param1.GetUserData().mirror != true)
            {
               param3[_loc5_].restitution = 0;
               param3[_loc5_].friction = 999;
            }
            _loc4_.CreateShape(param3[_loc5_]);
            _loc5_++;
         }
         _loc4_.m_userData.pointer = param1;
      }
      
      public function handleSoundComplete(param1:Event) : *
      {
         this.clickPlaying = false;
      }
   }
}
