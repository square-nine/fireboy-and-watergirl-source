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
   import com.adobe.serialization.json.JSON;
   import de.polygonal.math.*;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.*;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.geom.*;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.net.SharedObject;
   import flash.ui.*;
   import flash.utils.ByteArray;
   
   [Embed(source="/_assets/assets.swf", symbol="level")]
   public class level extends Sprite
   {
       
      
      internal var colorsArray:Array;
      
      internal var freezeColor:* = 11596281;
      
      internal var meltColor:* = 16677980;
      
      internal var defaultColor:* = 16777113;
      
      internal var Tuting1:Boolean;
      
      internal var Tuting2:Boolean;
      
      internal var tutlayer:*;
      
      public var pause:Boolean;
      
      public var ended:Boolean;
      
      internal var teta:Number;
      
      public var pressings1:*;
      
      public var pressings2:*;
      
      internal var r_wasPressed:Boolean;
      
      internal var l_wasPressed:Boolean;
      
      internal var r_wasPressed2:Boolean;
      
      internal var l_wasPressed2:Boolean;
      
      internal var r_isPressed:Boolean;
      
      internal var l_isPressed:Boolean;
      
      internal var r_isPressed2:Boolean;
      
      internal var l_isPressed2:Boolean;
      
      internal var r_pressed:Boolean;
      
      internal var l_pressed:Boolean;
      
      internal var u_pressed:Boolean;
      
      internal var r_pressed2:Boolean;
      
      internal var l_pressed2:Boolean;
      
      internal var u_pressed2:Boolean;
      
      internal var r_allow1:Boolean = true;
      
      internal var r_allow2:Boolean = true;
      
      internal var l_allow1:Boolean = true;
      
      internal var l_allow2:Boolean = true;
      
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
      
      public var LightSpeed:* = 50;
      
      internal var myMechanisms:*;
      
      internal var myActuators:*;
      
      internal var mySensors:*;
      
      internal var myRotMirrorJoints:*;
      
      internal var myActuateds:*;
      
      internal var myActuateds2:*;
      
      internal var myActuateds3:*;
      
      internal var myActuateds4:*;
      
      internal var myActuateds5:*;
      
      internal var myJumpers:*;
      
      internal var mySliders:*;
      
      internal var myWinds:*;
      
      internal var myIces:*;
      
      internal var myPortals:*;
      
      internal var timecount:* = 0;
      
      internal var myContactListener:ContactListener;
      
      internal var myContactListenerBullet:ContactListenerBullet;
      
      internal var m_physScale:Number = 1;
      
      internal var pers1:b2Body;
      
      internal var pers2:b2Body;
      
      internal var LevelArray:Array;
      
      internal var LevelArray2:Array;
      
      internal var FiresandWaters:Sprite;
      
      internal var PortalsLayer:Sprite;
      
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
      
      internal var ClockSound:Clock_Sound;
      
      internal var FreezeSound:Freeze_Sound;
      
      internal var MeltSound:Melt_Sound;
      
      internal var WaterStepsSound:WaterSteps_Sound;
      
      internal var NormalStepsSound:NormalSteps_Sound;
      
      internal var Ice1StepsSound:Ice1Steps_Sound;
      
      internal var Ice2StepsSound:Ice2Steps_Sound;
      
      internal var LavaStepsSound:LavaSteps_Sound;
      
      internal var PortalLoopSound:PortalLoop_Sound;
      
      internal var PortalOpenSound:PortalOpen_Sound;
      
      internal var PortalCloseSound:PortalClose_Sound;
      
      internal var PortalTransportSound:PortalTransport_Sound;
      
      internal var clickPlaying:Boolean = false;
      
      internal var InfiniteChannel:SoundChannel;
      
      internal var myChannels:Array;
      
      internal var myChannels2:Array;
      
      internal var myChannels3:Array;
      
      internal var myChannels4:Array;
      
      internal var windChannels:Array;
      
      internal var DoorChannel:SoundChannel;
      
      internal var DoorChannel2:SoundChannel;
      
      internal var FreezeChannel:SoundChannel;
      
      internal var WGChannel:SoundChannel;
      
      internal var FBChannel:SoundChannel;
      
      internal var currentWGSound:*;
      
      internal var currentFBSound:*;
      
      internal var DiamondSound:Diamond_Sound;
      
      internal var BDcount:Number;
      
      internal var RDcount:Number;
      
      internal var The_cookie:Object;
      
      internal var SharedLevelsArray:Object;
      
      internal var m_levelData:Object;
      
      internal var useJson:* = true;
      
      private const JsonData:Class = level_JsonData;
      
      public function level(param1:Number)
      {
         var _loc16_:* = undefined;
         var _loc23_:* = undefined;
         var _loc24_:* = undefined;
         this.pressings1 = new Array();
         this.pressings2 = new Array();
         this.myMechanisms = new Object();
         this.myActuators = new Array();
         this.mySensors = new Array();
         this.myRotMirrorJoints = new Array();
         this.myActuateds = new Array();
         this.myActuateds2 = new Array();
         this.myActuateds3 = new Array();
         this.myActuateds4 = new Array();
         this.myActuateds5 = new Array();
         this.myJumpers = new Array();
         this.mySliders = new Array();
         this.myWinds = new Array();
         this.myIces = new Array();
         this.myPortals = new Array();
         super();
         this.colorsArray = new Array(12452093,59392,16777215,16737792,11596281,15790080,2128383);
         trace("COLORS ARE " + this.colorsArray);
         this.LoadCookie();
         this.RDcount = 0;
         this.BDcount = 0;
         this.CurrentLevel = param1;
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
         this.ClockSound = new Clock_Sound();
         this.FreezeSound = new Freeze_Sound();
         this.MeltSound = new Melt_Sound();
         this.PortalLoopSound = new PortalLoop_Sound();
         this.PortalOpenSound = new PortalOpen_Sound();
         this.PortalCloseSound = new PortalClose_Sound();
         this.PortalTransportSound = new PortalTransport_Sound();
         this.WaterStepsSound = new WaterSteps_Sound();
         this.NormalStepsSound = new NormalSteps_Sound();
         this.Ice1StepsSound = new Ice1Steps_Sound();
         this.Ice2StepsSound = new Ice2Steps_Sound();
         this.LavaStepsSound = new LavaSteps_Sound();
         this.DoorChannel = new SoundChannel();
         this.DoorChannel2 = new SoundChannel();
         this.FreezeChannel = new SoundChannel();
         this.WGChannel = new SoundChannel();
         this.FBChannel = new SoundChannel();
         this.WGChannel = this.NormalStepsSound.play(0,999999,new SoundTransform(0));
         this.FBChannel = this.NormalStepsSound.play(0,999999,new SoundTransform(0));
         this.currentWGSound = 0;
         this.currentFBSound = 0;
         this.InfiniteChannel = new SoundChannel();
         this.myChannels = new Array();
         this.myChannels2 = new Array();
         this.myChannels3 = new Array();
         this.myChannels4 = new Array();
         this.windChannels = new Array();
         var _loc2_:b2AABB = new b2AABB();
         _loc2_.lowerBound.Set(-this.world_aa,-this.world_aa);
         _loc2_.upperBound.Set(this.world_bb,this.world_bb);
         var _loc3_:b2Vec2 = new b2Vec2(0,26);
         var _loc4_:Boolean = true;
         this.m_world = new b2World(_loc2_,_loc3_,_loc4_);
         _loc3_ = new b2Vec2(0,0);
         this.m_lworld = new b2World(_loc2_,_loc3_,_loc4_);
         this.myContactListener = new ContactListener();
         this.myContactListener.finish1 = -1;
         this.myContactListener.finish2 = -1;
         this.m_world.SetContactListener(this.myContactListener);
         this.myContactListenerBullet = new ContactListenerBullet();
         this.myContactListenerBullet.m_level = this;
         this.m_lworld.SetContactListener(this.myContactListenerBullet);
         this.BkgLayer = new BackGround();
         this.BkgLayer.scaleX /= 0.8;
         this.BkgLayer.scaleY /= 0.8;
         this.BkgLayer.x -= 16;
         this.BkgLayer.y -= 16;
         this.SlidersAndRots = new Sprite();
         this.LightBoard = new Sprite();
         this.CharsLayer = new Sprite();
         this.FiresandWaters = new Sprite();
         this.PortalsLayer = new Sprite();
         this.DiamondsandRopes = new Sprite();
         this.DiamondsandRopes.name = "DiamondsandRopes";
         addChild(this.BkgLayer);
         this.GroundLayer = new Sprite();
         var _loc5_:* = "bd";
         var _loc6_:* = "rd";
         var _loc7_:* = "gr";
         var _loc8_:* = "i";
         var _loc9_:* = "i1";
         var _loc10_:* = "i2";
         var _loc11_:* = "i3";
         var _loc12_:* = "i4";
         this.m_levelData = this.LoadDataFromString(this.SharedLevelsArray[this.CurrentLevel - 1]);
         this.LevelArray = this.m_levelData.GroundArray;
         this.LevelArray2 = new Array();
         var _loc13_:* = 0;
         while(_loc13_ < 100)
         {
            this.LevelArray2.push(new Array());
            _loc23_ = 0;
            while(_loc23_ < 100)
            {
               this.LevelArray2[_loc13_].push(0);
               _loc23_++;
            }
            _loc13_++;
         }
         _loc13_ = 0;
         while(_loc13_ < this.LevelArray.length)
         {
            _loc23_ = 0;
            while(_loc23_ < this.LevelArray[_loc13_].length)
            {
               this.LevelArray2[_loc13_][_loc23_] = this.LevelArray[_loc13_][_loc23_];
               _loc23_++;
            }
            _loc13_++;
         }
         var _loc14_:* = new b2Vec2(5,5);
         var _loc15_:* = new b2Vec2(15,5);
         if(this.m_levelData.lightSpeed)
         {
            this.LightSpeed = this.m_levelData.lightSpeed;
         }
         for(_loc16_ in this.m_levelData.ObjectsArray)
         {
            _loc24_ = this.m_levelData.ObjectsArray[_loc16_];
            trace(_loc24_.type);
            trace("POSITION IS " + _loc24_.position);
            switch(_loc24_.type)
            {
               case "Ball":
                  this.CreateBall(this.createVector(_loc24_.position));
                  break;
               case "MovingBox":
                  this.CreateMovingBox(this.createVector(_loc24_.position));
                  break;
               case "Pusher":
                  this.CreatePusher(this.createVector(_loc24_.position),_loc24_.index,_loc24_.rotation,_loc24_.color);
                  break;
               case "Lever":
                  this.CreateLever(this.createVector(_loc24_.position),_loc24_.index,_loc24_.color,_loc24_.BeginOn,_loc24_.Onis);
                  break;
               case "SlidePlatform":
                  this.CreateSlidePlatform(_loc24_.index,_loc24_.color,this.createVector(_loc24_.position),_loc24_.rotation,_loc24_.length,this.createVector(_loc24_.dir),_loc24_.distance);
                  break;
               case "TimedPusher":
                  this.CreateTimedPusher(_loc24_.index,_loc24_.color,this.createVector(_loc24_.position),_loc24_.rotation,_loc24_.delay);
                  break;
               case "LightPusher":
                  this.CreateLightPusher(_loc24_.index,_loc24_.color,this.createVector(_loc24_.position),_loc24_.rotation);
                  break;
               case "Emitter":
                  this.CreateLightBeamer(_loc24_.index,_loc24_.color,this.createVector(_loc24_.position),_loc24_.rotation);
                  break;
               case "StartFire":
                  this.StartPosFire = this.createVector(_loc24_.position);
                  break;
               case "StartWater":
                  this.StartPosWater = this.createVector(_loc24_.position);
                  break;
               case "EndWater":
                  _loc14_ = this.createVector(_loc24_.position);
                  break;
               case "EndFire":
                  _loc15_ = this.createVector(_loc24_.position);
                  break;
               case "MovingMirror":
                  this.CreateMovingMirror(this.createVector(_loc24_.position),_loc24_.rotation);
                  break;
               case "RotMirror":
                  this.CreateRotMirror(_loc24_.index,_loc24_.color,this.createVector(_loc24_.position),_loc24_.rotation);
                  break;
               case "MovingBox2":
                  this.CreateMovingBox2(this.createVector(_loc24_.position));
                  break;
               case "Wind":
                  this.CreateWind(_loc24_.index,_loc24_.color,this.createVector(_loc24_.position),this.createVector(_loc24_.lowerAA),this.createVector(_loc24_.upperBB),_loc24_.vert);
                  break;
               case "PortalPair":
                  this.CreatePortalPair(_loc24_.index,_loc24_.color,this.createVector(_loc24_.pos1),_loc24_.ori1,this.createVector(_loc24_.pos2),_loc24_.ori2,_loc24_.inverted,_loc24_.inWall1,_loc24_.inWall2);
                  break;
               case "Pulley":
                  this.CreatePulley(this.createVector(_loc24_.anchor1),this.createVector(_loc24_.anchor2),this.createVector(_loc24_.size1),this.createVector(_loc24_.size2),this.createVector(_loc24_.pos1),this.createVector(_loc24_.pos2));
                  break;
               case "HangingPlatform":
                  this.CreateHangingPlatform(this.createVector(_loc24_.position),this.createVector(_loc24_.size),_loc24_.dist);
                  break;
               case "InfiniteMirror":
                  this.CreateInfiniteMirror(_loc24_.index,_loc24_.color,this.createVector(_loc24_.position),_loc24_.rotation);
                  break;
               case "MirrorSlider":
                  this.CreateMirrorSlider(_loc24_.index,_loc24_.color,this.createVector(_loc24_.position),_loc24_.length,_loc24_.shift);
                  break;
               case "Roman":
                  this.CreateRoman(this.createVector(_loc24_.position),_loc24_.Height,_loc24_.Length,_loc24_.startup);
                  break;
            }
         }
         this.CreateFinish(_loc15_,_loc14_);
         this.CreateGround(this.LevelArray);
         if(param1 == 32)
         {
            this.Tuting1 = true;
            this.tutlayer = new TutLayer();
            this.CharsLayer.addChild(this.tutlayer);
         }
         if(param1 == 33)
         {
            this.Tuting2 = true;
            this.tutlayer = new TutLayer2();
            this.CharsLayer.addChild(this.tutlayer);
         }
         if(param1 == 34)
         {
            this.Tuting2 = true;
            this.tutlayer = new TutLayer3();
            this.CharsLayer.addChild(this.tutlayer);
         }
         if(param1 == 29)
         {
            this.Tuting2 = true;
            this.tutlayer = new TutLayer4();
            this.CharsLayer.addChild(this.tutlayer);
         }
         var _loc17_:* = new Array();
         var _loc18_:* = new b2BodyDef();
         var _loc19_:*;
         (_loc19_ = new b2CircleDef()).radius = 0.5;
         _loc19_.density = 0.6;
         _loc19_.friction = 0;
         _loc19_.restitution = 0.1;
         _loc19_.localPosition.Set(0,-0.3);
         _loc19_.filter.groupIndex = -4;
         _loc18_.fixedRotation = true;
         _loc18_.userData = new FireBoy();
         _loc18_.userData.name = "pers1";
         _loc18_.userData.filters = [new GlowFilter(16737792,1,20,20,1,1,false,false)];
         _loc18_.position.Set(this.StartPosFire.x,this.StartPosFire.y);
         this.pers1 = this.m_world.CreateBody(_loc18_);
         this.pers1.CreateShape(_loc19_);
         _loc17_.push(_loc19_);
         (_loc19_ = new b2CircleDef()).radius = 0.3;
         _loc19_.density = 0.01;
         _loc19_.friction = 0.2;
         _loc19_.restitution = 0.1;
         _loc19_.localPosition.Set(0,0.5);
         _loc19_.filter.groupIndex = -4;
         _loc19_.userData = "firelegs";
         this.pers1.CreateShape(_loc19_);
         _loc17_.push(_loc19_);
         (_loc19_ = new b2CircleDef()).radius = 0.1;
         _loc19_.density = 0.01;
         _loc19_.friction = 0.2;
         _loc19_.restitution = 0;
         _loc19_.localPosition.Set(0,0);
         _loc19_.filter.groupIndex = -3;
         _loc19_.filter.categoryBits = 4096;
         _loc19_.filter.maskBits = 4096;
         this.pers1.CreateShape(_loc19_);
         var _loc20_:*;
         (_loc20_ = new b2PolygonDef()).vertexCount = 4;
         _loc20_.vertices[0].Set(-0.5,-0.3);
         _loc20_.vertices[1].Set(0.5,-0.3);
         _loc20_.vertices[2].Set(0.3,0.5);
         _loc20_.vertices[3].Set(-0.3,0.5);
         _loc20_.friction = 0;
         _loc20_.density = 0.5;
         _loc20_.filter.groupIndex = -4;
         this.pers1.CreateShape(_loc20_);
         _loc17_.push(_loc20_);
         this.pers1.SetMassFromShapes();
         this.CharsLayer.addChild(_loc18_.userData);
         this.CreateLightBody(this.pers1,_loc18_,_loc17_);
         _loc17_ = new Array();
         _loc18_ = new b2BodyDef();
         (_loc19_ = new b2CircleDef()).radius = 0.5;
         _loc19_.density = 0.6;
         _loc19_.friction = 0;
         _loc19_.restitution = 0.1;
         _loc19_.localPosition.Set(0,-0.3);
         _loc19_.filter.groupIndex = -4;
         _loc18_.fixedRotation = true;
         _loc18_.userData = new WaterGirl();
         _loc18_.userData.name = "pers2";
         _loc18_.userData.filters = [new GlowFilter(9100543,1,20,20,1,1,false,false)];
         _loc18_.position.Set(this.StartPosWater.x,this.StartPosWater.y);
         this.pers2 = this.m_world.CreateBody(_loc18_);
         this.pers2.CreateShape(_loc19_);
         _loc17_.push(_loc19_);
         (_loc19_ = new b2CircleDef()).radius = 0.3;
         _loc19_.density = 0.01;
         _loc19_.friction = 0.2;
         _loc19_.restitution = 0.1;
         _loc19_.localPosition.Set(0,0.5);
         _loc19_.filter.groupIndex = -4;
         _loc19_.userData = "waterlegs";
         this.pers2.GetUserData().legs = this.pers2.CreateShape(_loc19_);
         _loc17_.push(_loc19_);
         (_loc19_ = new b2CircleDef()).radius = 0.1;
         _loc19_.density = 0.01;
         _loc19_.friction = 0.2;
         _loc19_.restitution = 0;
         _loc19_.localPosition.Set(0,0);
         _loc19_.filter.groupIndex = -3;
         _loc19_.filter.categoryBits = 4096;
         _loc19_.filter.maskBits = 4096;
         this.pers2.CreateShape(_loc19_);
         (_loc20_ = new b2PolygonDef()).vertexCount = 4;
         _loc20_.vertices[0].Set(-0.5,-0.3);
         _loc20_.vertices[1].Set(0.5,-0.3);
         _loc20_.vertices[2].Set(0.3,0.5);
         _loc20_.vertices[3].Set(-0.3,0.5);
         _loc20_.friction = 0;
         _loc20_.density = 0.5;
         _loc20_.filter.groupIndex = -4;
         this.pers2.CreateShape(_loc20_);
         _loc17_.push(_loc20_);
         this.pers2.SetMassFromShapes();
         this.CharsLayer.addChild(_loc18_.userData);
         this.CreateLightBody(this.pers2,_loc18_,_loc17_);
         addChild(this.SlidersAndRots);
         addChild(this.LightBoard);
         addChild(this.GroundLayer);
         addChild(this.DiamondsandRopes);
         addChild(this.CharsLayer);
         addChild(this.FiresandWaters);
         addChild(this.PortalsLayer);
         addEventListener(Event.ENTER_FRAME,this.Update,false,0,true);
         var _loc21_:* = new Stats();
         var _loc22_:*;
         (_loc22_ = new Sprite()).graphics.beginFill(0,1);
         _loc22_.graphics.drawRect(-100,-100,this.width + 200,this.height + 200);
         this.addChild(_loc22_);
         _loc22_.addEventListener(Event.ENTER_FRAME,this.fadeInHandler);
      }
      
      public function LoadCookie() : void
      {
         this.The_cookie = SharedObject.getLocal("FB4","/");
         var _loc1_:ByteArray = new this.JsonData() as ByteArray;
         var _loc2_:Object = com.adobe.serialization.json.JSON.decode(_loc1_.readUTFBytes(_loc1_.length));
         if(this.useJson)
         {
            this.SharedLevelsArray = _loc2_;
         }
         else
         {
            this.SharedLevelsArray = this.The_cookie.data.LevelsArray;
         }
      }
      
      public function LoadDataFromString(param1:String) : Object
      {
         return com.adobe.serialization.json.JSON.decode(param1);
      }
      
      public function fadeInHandler(param1:Event) : *
      {
         param1.target.alpha = Math.max(0,param1.target.alpha - 0.3);
         if(param1.target.alpha <= 0)
         {
            param1.target.removeEventListener(Event.ENTER_FRAME,this.fadeInHandler);
            param1.target.parent.removeChild(param1.target);
         }
      }
      
      public function createVector(param1:Object) : b2Vec2
      {
         return new b2Vec2(param1.x,param1.y);
      }
      
      public function StopSounds() : *
      {
         var _loc2_:* = undefined;
         var _loc1_:* = 0;
         while(_loc1_ < this.myChannels4.length)
         {
            this.myChannels4[_loc1_].stop();
            _loc1_++;
         }
         for(_loc2_ in this.myMechanisms)
         {
            this.myMechanisms[_loc2_].killSounds();
         }
      }
      
      public function DeterminePressings() : void
      {
         if(this.r_isPressed && !this.r_wasPressed)
         {
            this.r_pressed = true;
            this.l_pressed = false;
         }
         if(this.l_isPressed && !this.l_wasPressed)
         {
            this.l_pressed = true;
            this.r_pressed = false;
         }
         if(this.r_isPressed2 && !this.r_wasPressed2)
         {
            this.r_pressed2 = true;
            this.l_pressed2 = false;
         }
         if(this.l_isPressed2 && !this.l_wasPressed2)
         {
            this.l_pressed2 = true;
            this.r_pressed2 = false;
         }
         if(!this.r_isPressed && this.r_wasPressed)
         {
            this.r_pressed = false;
            if(!this.l_isPressed)
            {
               this.l_pressed = false;
            }
         }
         if(!this.l_isPressed && this.l_wasPressed)
         {
            this.l_pressed = false;
            if(!this.r_isPressed)
            {
               this.r_pressed = false;
            }
         }
         if(!this.r_isPressed2 && this.r_wasPressed2)
         {
            this.r_pressed2 = false;
            if(!this.l_isPressed2)
            {
               this.l_pressed2 = false;
            }
         }
         if(!this.l_isPressed2 && this.l_wasPressed2)
         {
            this.l_pressed2 = false;
            if(!this.r_isPressed2)
            {
               this.r_pressed2 = false;
            }
         }
         this.r_wasPressed = this.r_isPressed;
         this.l_wasPressed = this.l_isPressed;
         this.r_wasPressed2 = this.r_isPressed2;
         this.l_wasPressed2 = this.l_isPressed2;
      }
      
      public function Update(param1:Event) : void
      {
         var _loc2_:b2Vec2 = null;
         var _loc3_:* = undefined;
         var _loc4_:b2Vec2 = null;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:deadFire = null;
         var _loc10_:* = undefined;
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
         var _loc22_:Matrix = null;
         var _loc23_:* = undefined;
         var _loc24_:* = undefined;
         var _loc25_:int = 0;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:* = undefined;
         var _loc29_:* = undefined;
         var _loc30_:b2RevoluteJoint = null;
         this.DeterminePressings();
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
         if(this.pause == false)
         {
            this.pers1.GetUserData().mc_1.visible = false;
            this.pers1.GetUserData().mc_2.visible = false;
            this.pers1.GetUserData().mc_3.visible = false;
            this.pers1.GetUserData().mc_4.visible = false;
            this.pers1.GetUserData().mc_5.visible = false;
            this.pers1.GetUserData().mc_52.visible = false;
            this.pers2.GetUserData().mc_1.visible = false;
            this.pers2.GetUserData().mc_2.visible = false;
            this.pers2.GetUserData().mc_3.visible = false;
            this.pers2.GetUserData().mc_4.visible = false;
            this.pers2.GetUserData().mc_5.visible = false;
            this.pers2.GetUserData().mc_52.visible = false;
            this.allowjump1 = false;
            _loc2_ = new b2Vec2(0,0);
            _loc3_ = 0;
            while(_loc3_ < this.myContactListener.contactStack1.length)
            {
               if(this.myContactListener.contactStack1[_loc3_].y < _loc2_.y)
               {
                  _loc2_ = this.myContactListener.contactStack1[_loc3_].Copy();
               }
               _loc3_++;
            }
            if(_loc2_.y < -0.2)
            {
               this.allowjump1 = true;
            }
            if(this.pers1.m_userData.isOnLava)
            {
               if(this.currentFBSound != 1)
               {
                  this.FBChannel.stop();
                  this.currentFBSound = 1;
                  this.FBChannel = this.LavaStepsSound.play(0,99);
               }
            }
            else if(this.pers1.m_userData.isOnIce)
            {
               if(this.currentFBSound != 2)
               {
                  this.FBChannel.stop();
                  this.currentFBSound = 2;
                  this.FBChannel = this.Ice2StepsSound.play(0,99);
               }
            }
            else if(this.currentFBSound != 0)
            {
               if(this.FBChannel.position > 400)
               {
                  this.FBChannel.stop();
                  this.currentFBSound = 0;
                  this.FBChannel = this.NormalStepsSound.play(0,999);
               }
            }
            if(this.allowjump1 == true && (this.r_pressed || this.l_pressed || Math.abs(this.pers1.GetLinearVelocity().x) > 2))
            {
               if(this.FBChannel.soundTransform.volume != 1)
               {
                  this.FBChannel.soundTransform = new SoundTransform(Math.min(1,Math.abs(this.pers1.GetLinearVelocity().x) / 5));
               }
            }
            else if(this.FBChannel.soundTransform.volume != 0)
            {
               this.FBChannel.soundTransform = new SoundTransform(0);
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
                  if(!this.pers1.m_userData.isOnIce)
                  {
                     this.pers1.GetUserData().mc_5.visible = true;
                     this.pers1.GetUserData().mc_5.scaleX = 0.135;
                     this.pers1.GetUserData().mc_5.head.rotation = -Math.atan2(-_loc2_.y,_loc2_.x) / Math.PI * 180 + 90;
                  }
                  else
                  {
                     this.pers1.GetUserData().mc_52.visible = true;
                     this.pers1.GetUserData().mc_52.scaleX = 0.135;
                     this.pers1.GetUserData().mc_52.head.rotation = -Math.atan2(-_loc2_.y,_loc2_.x) / Math.PI * 180 + 90;
                     this.pers1.GetUserData().mc_52.meltMC.rotation = -Math.atan2(-_loc2_.y,_loc2_.x) / Math.PI * 180 + 90;
                  }
               }
               else if(this.l_pressed)
               {
                  if(!this.pers1.m_userData.isOnIce)
                  {
                     this.pers1.GetUserData().mc_5.visible = true;
                     this.pers1.GetUserData().mc_5.scaleX = -0.135;
                     this.pers1.GetUserData().mc_5.head.rotation = Math.atan2(-_loc2_.y,_loc2_.x) / Math.PI * 180 - 90;
                  }
                  else
                  {
                     this.pers1.GetUserData().mc_52.visible = true;
                     this.pers1.GetUserData().mc_52.scaleX = -0.135;
                     this.pers1.GetUserData().mc_52.head.rotation = Math.atan2(-_loc2_.y,_loc2_.x) / Math.PI * 180 - 90;
                     this.pers1.GetUserData().mc_52.meltMC.rotation = -Math.atan2(-_loc2_.y,_loc2_.x) / Math.PI * 180 + 90;
                  }
               }
            }
            else
            {
               this.pers1.GetUserData().mc_1.visible = true;
            }
            _loc5_ = 9;
            if(!this.pers1.m_userData.isOnIce)
            {
               if(this.r_pressed && this.pers1.GetLinearVelocity().x < _loc5_)
               {
                  if(_loc2_.x == 0 && _loc2_.y == 0)
                  {
                     _loc2_ = new b2Vec2(0,-1);
                     _loc4_ = new b2Vec2(-_loc2_.y * 17,_loc2_.x * 17);
                  }
                  else
                  {
                     if((_loc4_ = new b2Vec2(-_loc2_.y * 17,_loc2_.x * 17)).y < 0 && _loc4_.y > -14)
                     {
                        _loc4_.x += 12;
                     }
                     if(_loc4_.y < -14)
                     {
                        _loc4_.y = 0;
                     }
                  }
                  if(this.pers1.GetLinearVelocity().x < 0)
                  {
                     _loc4_.x *= 3;
                  }
                  this.pers1.ApplyForce(_loc4_,this.pers1.GetWorldCenter());
               }
               else if(this.l_pressed && this.pers1.GetLinearVelocity().x > -_loc5_)
               {
                  if(_loc2_.x == 0 && _loc2_.y == 0)
                  {
                     _loc2_ = new b2Vec2(0,-1);
                     _loc4_ = new b2Vec2(_loc2_.y * 17,-_loc2_.x * 17);
                  }
                  else
                  {
                     if((_loc4_ = new b2Vec2(_loc2_.y * 17,-_loc2_.x * 17)).y < 0 && _loc4_.y > -14)
                     {
                        _loc4_.x -= 12;
                     }
                     if(_loc4_.y < -14)
                     {
                        _loc4_.y = 0;
                     }
                  }
                  if(this.pers1.GetLinearVelocity().x > 0)
                  {
                     _loc4_.x *= 3;
                  }
                  this.pers1.ApplyForce(_loc4_,this.pers1.GetWorldCenter());
               }
            }
            else if(this.r_pressed && this.pers1.GetLinearVelocity().x < 12)
            {
               if(_loc2_.x == 0 && _loc2_.y == 0)
               {
                  _loc2_ = new b2Vec2(0,-1);
                  _loc4_ = new b2Vec2(-_loc2_.y * 17,_loc2_.x * 17);
               }
               else if((_loc4_ = new b2Vec2(-_loc2_.y * 25,_loc2_.x * 25)).y < -14)
               {
                  _loc4_.x = -2;
                  _loc4_.y = 2;
               }
               this.pers1.ApplyForce(_loc4_,this.pers1.GetWorldCenter());
            }
            else if(this.l_pressed && this.pers1.GetLinearVelocity().x > -12)
            {
               if(_loc2_.x == 0 && _loc2_.y == 0)
               {
                  _loc2_ = new b2Vec2(0,-1);
                  _loc4_ = new b2Vec2(_loc2_.y * 17,-_loc2_.x * 17);
               }
               else if((_loc4_ = new b2Vec2(_loc2_.y * 25,-_loc2_.x * 25)).y < -14)
               {
                  _loc4_.x = 2;
                  _loc4_.y = 2;
               }
               this.pers1.ApplyForce(_loc4_,this.pers1.GetWorldCenter());
            }
            if(this.r_pressed == false && this.l_pressed == false)
            {
               if(!this.pers1.m_userData.isOnIce)
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
               else if(this.pers1.GetLinearVelocity().x > 0)
               {
                  this.pers1.ApplyForce(new b2Vec2(-this.pers1.GetLinearVelocity().x * 1,0),this.pers1.GetWorldCenter());
               }
               else if(this.pers1.GetLinearVelocity().x < 0)
               {
                  this.pers1.ApplyForce(new b2Vec2(-this.pers1.GetLinearVelocity().x * 1,0),this.pers1.GetWorldCenter());
               }
            }
            if(this.prohibjump1 == false && this.allowjump1 && this.u_pressed)
            {
               if(!this.pers1.m_userData.isOnIce)
               {
                  this.J1.play();
                  this.pers1.ApplyImpulse(new b2Vec2(0,-0.5),this.pers1.GetWorldCenter());
                  this.pers1.SetLinearVelocity(new b2Vec2(this.pers1.GetLinearVelocity().x,-13.5));
               }
               else if(Math.abs(_loc2_.x) <= 0.5)
               {
                  this.pers1.ApplyImpulse(new b2Vec2(0,-0.5),this.pers1.GetWorldCenter());
                  this.pers1.SetLinearVelocity(new b2Vec2(this.pers1.GetLinearVelocity().x,-3));
               }
               this.prohibjump1 = true;
            }
            if(this.u_pressed == false)
            {
               this.prohibjump1 = false;
            }
            this.allowjump2 = false;
            _loc2_ = new b2Vec2(0,0);
            _loc3_ = 0;
            while(_loc3_ < this.myContactListener.contactStack2.length)
            {
               if(this.myContactListener.contactStack2[_loc3_].y < _loc2_.y)
               {
                  _loc2_ = this.myContactListener.contactStack2[_loc3_].Copy();
               }
               _loc3_++;
            }
            if(_loc2_.y < -0.2)
            {
               this.allowjump2 = true;
            }
            if(this.pers2.m_userData.isOnWater)
            {
               if(this.currentWGSound != 1)
               {
                  this.WGChannel.stop();
                  this.currentWGSound = 1;
                  this.WGChannel = this.WaterStepsSound.play(0,99);
               }
            }
            else if(this.pers2.m_userData.isOnIce)
            {
               if(this.currentWGSound != 2)
               {
                  this.WGChannel.stop();
                  this.currentWGSound = 2;
                  this.WGChannel = this.Ice1StepsSound.play(0,99);
               }
            }
            else if(this.currentWGSound != 0)
            {
               if(this.WGChannel.position > 400)
               {
                  this.WGChannel.stop();
                  this.currentWGSound = 0;
                  this.WGChannel = this.NormalStepsSound.play(0,999);
               }
            }
            if(this.allowjump2 == true && (this.r_pressed2 || this.l_pressed2))
            {
               if(this.WGChannel.soundTransform.volume != 1)
               {
                  this.WGChannel.soundTransform = new SoundTransform(1);
               }
            }
            else if(this.WGChannel.soundTransform.volume != 0)
            {
               this.WGChannel.soundTransform = new SoundTransform(0);
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
                  if(!this.pers2.m_userData.isOnIce)
                  {
                     this.pers2.GetUserData().mc_5.visible = true;
                     this.pers2.GetUserData().mc_5.scaleX = 0.135;
                     this.pers2.GetUserData().mc_5.head.rotation = -Math.atan2(-_loc2_.y,_loc2_.x) / Math.PI * 180 + 90;
                  }
                  else
                  {
                     this.pers2.GetUserData().mc_52.visible = true;
                     this.pers2.GetUserData().mc_52.scaleX = 0.135;
                     this.pers2.GetUserData().mc_52.head.rotation = -Math.atan2(-_loc2_.y,_loc2_.x) / Math.PI * 180 + 90;
                  }
               }
               else if(this.l_pressed2)
               {
                  if(!this.pers2.m_userData.isOnIce)
                  {
                     this.pers2.GetUserData().mc_5.visible = true;
                     this.pers2.GetUserData().mc_5.scaleX = -0.135;
                     this.pers2.GetUserData().mc_5.head.rotation = Math.atan2(-_loc2_.y,_loc2_.x) / Math.PI * 180 - 90;
                  }
                  else
                  {
                     this.pers2.GetUserData().mc_52.visible = true;
                     this.pers2.GetUserData().mc_52.scaleX = -0.135;
                     this.pers2.GetUserData().mc_52.head.rotation = Math.atan2(-_loc2_.y,_loc2_.x) / Math.PI * 180 - 90;
                  }
               }
            }
            else
            {
               this.pers2.GetUserData().mc_1.visible = true;
            }
            _loc6_ = 1;
            if(!this.pers2.m_userData.isOnIce)
            {
               if(this.r_pressed2 && this.pers2.GetLinearVelocity().x < _loc5_)
               {
                  if(_loc2_.x == 0 && _loc2_.y == 0)
                  {
                     _loc2_ = new b2Vec2(0,-1);
                     _loc4_ = new b2Vec2(-_loc2_.y * 17,_loc2_.x * 17);
                  }
                  else
                  {
                     if((_loc4_ = new b2Vec2(-_loc2_.y * 17,_loc2_.x * 17)).y < 0 && _loc4_.y > -14)
                     {
                        _loc4_.x += 12;
                     }
                     if(_loc4_.y < -14)
                     {
                        _loc4_.y = 0;
                     }
                  }
                  if(this.pers2.GetLinearVelocity().x < 0)
                  {
                     _loc4_.x *= 3;
                  }
                  this.pers2.ApplyForce(_loc4_,this.pers2.GetWorldCenter());
               }
               else if(this.l_pressed2 && this.pers2.GetLinearVelocity().x > -_loc5_)
               {
                  if(_loc2_.x == 0 && _loc2_.y == 0)
                  {
                     _loc2_ = new b2Vec2(0,-1);
                     _loc4_ = new b2Vec2(_loc2_.y * 17,-_loc2_.x * 17);
                  }
                  else
                  {
                     if((_loc4_ = new b2Vec2(_loc2_.y * 17,-_loc2_.x * 17)).y < 0 && _loc4_.y > -14)
                     {
                        _loc4_.x -= 12;
                     }
                     if(_loc4_.y < -14)
                     {
                        _loc4_.y = 0;
                     }
                  }
                  if(this.pers2.GetLinearVelocity().x > 0)
                  {
                     _loc4_.x *= 3;
                  }
                  this.pers2.ApplyForce(_loc4_,this.pers2.GetWorldCenter());
               }
            }
            else
            {
               if(this.pers2.GetLinearVelocity().x > 0 && this.pers2.GetLinearVelocity().x > 2)
               {
                  this.pers2.GetLinearVelocity().x = 2;
               }
               if(this.pers2.GetLinearVelocity().x < 0 && this.pers2.GetLinearVelocity().x < -2)
               {
                  this.pers2.GetLinearVelocity().x = -2;
               }
               if(this.r_pressed2 && this.pers2.GetLinearVelocity().x < 2)
               {
                  if(_loc2_.x == 0 && _loc2_.y == 0)
                  {
                     _loc2_ = new b2Vec2(0,-1);
                     _loc4_ = new b2Vec2(-_loc2_.y * 10,_loc2_.x * 10);
                  }
                  else
                  {
                     if((_loc4_ = new b2Vec2(-_loc2_.y * 10,_loc2_.x * 10)).y < 0 && _loc4_.y > -14)
                     {
                        _loc4_.x += 17;
                     }
                     if(_loc4_.y < -14)
                     {
                        _loc4_.y = 0;
                     }
                  }
                  if(this.pers2.GetLinearVelocity().x < 0)
                  {
                     _loc4_.x *= 3;
                  }
                  this.pers2.ApplyForce(_loc4_,this.pers2.GetWorldCenter());
               }
               else if(this.l_pressed2 && this.pers2.GetLinearVelocity().x > -2)
               {
                  if(_loc2_.x == 0 && _loc2_.y == 0)
                  {
                     _loc2_ = new b2Vec2(0,-1);
                     _loc4_ = new b2Vec2(_loc2_.y * 10,-_loc2_.x * 10);
                  }
                  else
                  {
                     if((_loc4_ = new b2Vec2(_loc2_.y * 10,-_loc2_.x * 10)).y < 0 && _loc4_.y > -14)
                     {
                        _loc4_.x -= 17;
                     }
                     if(_loc4_.y < -14)
                     {
                        _loc4_.y = 0;
                     }
                  }
                  if(this.pers2.GetLinearVelocity().x > 0)
                  {
                     _loc4_.x *= 3;
                  }
                  this.pers2.ApplyForce(_loc4_,this.pers2.GetWorldCenter());
               }
            }
            if(this.r_pressed2 == false && this.l_pressed2 == false)
            {
               if(!this.pers2.m_userData.isOnIce)
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
               else
               {
                  if(this.pers2.GetLinearVelocity().x > 0)
                  {
                     this.pers2.ApplyForce(new b2Vec2(-this.pers2.GetLinearVelocity().x * 7,0),this.pers2.GetWorldCenter());
                  }
                  else if(this.pers2.GetLinearVelocity().x < 0)
                  {
                     this.pers2.ApplyForce(new b2Vec2(-this.pers2.GetLinearVelocity().x * 7,0),this.pers2.GetWorldCenter());
                  }
                  if(this.pers2.GetLinearVelocity().y > 0)
                  {
                     this.pers2.ApplyForce(new b2Vec2(0,-this.pers2.GetMass() * 26),this.pers2.GetWorldCenter());
                  }
               }
            }
            if(this.prohibjump2 == false && this.allowjump2 && this.u_pressed2)
            {
               this.prohibjump2 = true;
               if(!this.pers2.m_userData.isOnIce)
               {
                  this.J2.play();
                  this.pers2.ApplyImpulse(new b2Vec2(0,-0.5),this.pers2.GetWorldCenter());
                  this.pers2.SetLinearVelocity(new b2Vec2(this.pers2.GetLinearVelocity().x,-13.5));
               }
               else
               {
                  this.pers2.ApplyImpulse(new b2Vec2(0,-0.5),this.pers2.GetWorldCenter());
                  this.pers2.SetLinearVelocity(new b2Vec2(0,-3));
               }
            }
            if(this.u_pressed2 == false)
            {
               this.prohibjump2 = false;
            }
            ++this.timecount;
            _loc7_ = 0;
            while(_loc7_ < this.myWinds.length)
            {
               if(this.windChannels[_loc7_] == undefined)
               {
                  this.myWinds[_loc7_].mc.sounding = false;
                  this.windChannels[_loc7_] = new SoundChannel();
               }
               if(this.myWinds[_loc7_].on == true)
               {
                  if(this.timecount > 2 && this.myWinds[_loc7_].mc.sounding == false)
                  {
                     this.myWinds[_loc7_].mc.sounding = true;
                     if(this.myWinds[_loc7_].mc.soundable == true)
                     {
                        this.windChannels[_loc7_] = this.WindSound.play(0,999);
                     }
                  }
                  this.myWinds[_loc7_].mc.getChildByName("light").visible = true;
                  this.myWinds[_loc7_].winder.visible = true;
                  this.myWinds[_loc7_].mc.blades.play();
                  _loc13_ = false;
                  _loc14_ = false;
                  _loc16_ = new b2AABB();
                  trace("MYWINDS THING" + this.myWinds[_loc7_].lower.x + " " + this.myWinds[_loc7_].upper.y);
                  _loc16_.lowerBound.Set(this.myWinds[_loc7_].lower.x,this.myWinds[_loc7_].lower.y);
                  _loc16_.upperBound.Set(this.myWinds[_loc7_].upper.x,this.myWinds[_loc7_].upper.y);
                  _loc17_ = 50;
                  _loc18_ = [];
                  _loc19_ = this.m_world.Query(_loc16_,_loc18_,_loc17_);
                  _loc20_ = 0;
                  while(_loc20_ < _loc19_)
                  {
                     if(_loc18_[_loc20_].GetBody().GetUserData().name == "pers1")
                     {
                        _loc13_ = true;
                     }
                     if(_loc18_[_loc20_].GetBody().GetUserData().name == "pers2")
                     {
                        _loc14_ = true;
                     }
                     _loc20_++;
                  }
                  if(_loc13_ == true)
                  {
                     trace("P1 WIND");
                     switch(this.myWinds[_loc7_].vertical)
                     {
                        case 1:
                           _loc15_ = new b2Vec2(0,-Math.min(1 / Math.abs(this.pers1.GetPosition().y - this.myWinds[_loc7_].upper.y),0.4));
                           break;
                        case 2:
                           _loc15_ = new b2Vec2(Math.min(1 / Math.abs(this.pers1.GetPosition().x - this.myWinds[_loc7_].lower.x),0.4),0);
                           break;
                        case 3:
                           _loc15_ = new b2Vec2(0,Math.min(1 / Math.abs(this.pers1.GetPosition().y - this.myWinds[_loc7_].upper.y),0.4));
                           break;
                        case 4:
                           _loc15_ = new b2Vec2(-Math.min(1 / Math.abs(this.pers1.GetPosition().x - this.myWinds[_loc7_].upper.x),0.4),0);
                     }
                     _loc15_.x *= Math.abs(this.myWinds[_loc7_].upper.x - this.myWinds[_loc7_].lower.x) * 13 + 20 * (Math.sin(this.timecount / 10) + 1);
                     _loc15_.y *= Math.abs(this.myWinds[_loc7_].upper.y - this.myWinds[_loc7_].lower.y) * 13 + 20 * (Math.sin(this.timecount / 10) + 1);
                     this.pers1.ApplyForce(_loc15_,this.pers1.GetWorldCenter());
                     this.pers1.SetLinearVelocity(new b2Vec2(this.pers1.GetLinearVelocity().x * 0.95,this.pers1.GetLinearVelocity().y * 0.95));
                  }
                  if(_loc14_ == true)
                  {
                     trace("P2 WIND");
                     switch(this.myWinds[_loc7_].vertical)
                     {
                        case 1:
                           _loc15_ = new b2Vec2(0,-Math.min(1 / Math.abs(this.pers2.GetPosition().y - this.myWinds[_loc7_].upper.y),0.4));
                           break;
                        case 2:
                           _loc15_ = new b2Vec2(Math.min(1 / Math.abs(this.pers2.GetPosition().x - this.myWinds[_loc7_].lower.x),0.4),0);
                           break;
                        case 3:
                           _loc15_ = new b2Vec2(0,Math.min(1 / Math.abs(this.pers2.GetPosition().y - this.myWinds[_loc7_].upper.y),0.4));
                           break;
                        case 4:
                           _loc15_ = new b2Vec2(-Math.min(1 / Math.abs(this.pers2.GetPosition().x - this.myWinds[_loc7_].upper.x),0.4),0);
                     }
                     _loc15_.x *= Math.abs(this.myWinds[_loc7_].upper.x - this.myWinds[_loc7_].lower.x) * 13 + 20 * (Math.sin(this.timecount / 10) + 1);
                     _loc15_.y *= Math.abs(this.myWinds[_loc7_].upper.y - this.myWinds[_loc7_].lower.y) * 13 + 20 * (Math.sin(this.timecount / 10) + 1);
                     this.pers2.ApplyForce(_loc15_,this.pers2.GetWorldCenter());
                     this.pers2.SetLinearVelocity(new b2Vec2(this.pers2.GetLinearVelocity().x * 0.95,this.pers2.GetLinearVelocity().y * 0.95));
                  }
               }
               else
               {
                  if(this.myWinds[_loc7_].mc.sounding == true)
                  {
                     this.myWinds[_loc7_].mc.sounding = false;
                     this.windChannels[_loc7_].stop();
                  }
                  this.myWinds[_loc7_].mc.getChildByName("light").visible = false;
                  this.myWinds[_loc7_].winder.visible = false;
                  this.myWinds[_loc7_].mc.blades.stop();
               }
               _loc7_++;
            }
            _loc8_ = 0;
            while(_loc8_ < this.myIces.length)
            {
               if(this.myIces[_loc8_].freeze == true && this.myIces[_loc8_].melt == false && this.myIces[_loc8_].frozen == false)
               {
                  this.myIces[_loc8_].frozen = true;
                  this.FreezeIce(this.myIces[_loc8_]);
               }
               else if(this.myIces[_loc8_].melt == true && this.myIces[_loc8_].frozen == true)
               {
                  this.myIces[_loc8_].frozen = false;
                  this.MeltIce(this.myIces[_loc8_]);
               }
               this.myIces[_loc8_].freeze = false;
               this.myIces[_loc8_].melt = false;
               _loc8_++;
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
                  (_loc21_ = addChild(new FireBoystairs())).x = this.SlidersAndRots.getChildByName("finish1").x;
                  _loc21_.y = this.SlidersAndRots.getChildByName("finish1").y;
                  _loc21_.name = "ender";
                  this.pers2.GetUserData().visible = false;
                  (_loc21_ = addChild(new WaterGirlStairs())).x = this.SlidersAndRots.getChildByName("finish2").x;
                  _loc21_.y = this.SlidersAndRots.getChildByName("finish2").y;
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
               (_loc9_ = new deadFire()).x = this.pers1.GetUserData().x;
               _loc9_.y = this.pers1.GetUserData().y;
               addChild(_loc9_);
               this.FBChannel.stop();
               this.WGChannel.stop();
               (_loc22_ = new Matrix()).translate(this.pers2.GetUserData().width / 2,this.pers2.GetUserData().height / 2);
               (_loc23_ = new BitmapData(200,200,true,255)).draw(this.pers2.GetUserData(),_loc22_,null,null,null,true);
               (_loc24_ = new Bitmap(_loc23_)).x = this.pers2.GetUserData().x - this.pers2.GetUserData().width / 2;
               _loc24_.y = this.pers2.GetUserData().y - this.pers2.GetUserData().height / 2;
               addChild(_loc24_);
               this.pers2.GetUserData().visible = false;
            }
            if(this.myContactListener.deadWater == true && this.pause == false)
            {
               this.pause = true;
               this.ended = true;
               this.pers2.GetUserData().visible = false;
               this.pers1.GetUserData().visible = false;
               (_loc9_ = new deadFire()).x = this.pers2.GetUserData().x;
               _loc9_.y = this.pers2.GetUserData().y;
               addChild(_loc9_);
               this.FBChannel.stop();
               this.WGChannel.stop();
               (_loc22_ = new Matrix()).translate(this.pers1.GetUserData().width / 2,this.pers1.GetUserData().height / 2);
               (_loc23_ = new BitmapData(200,200,true,255)).draw(this.pers1.GetUserData(),_loc22_,null,null,null,true);
               (_loc24_ = new Bitmap(_loc23_)).x = this.pers1.GetUserData().x - this.pers1.GetUserData().width / 2;
               _loc24_.y = this.pers1.GetUserData().y - this.pers1.GetUserData().height / 2;
               addChild(_loc24_);
               this.pers1.GetUserData().visible = false;
            }
            _loc20_ = 0;
            while(_loc20_ < this.myPortals.length)
            {
               if(Boolean(this.myPortals[_loc20_].on) && !this.myPortals[_loc20_].working)
               {
                  this.OpenPortalPair(this.myPortals[_loc20_]);
               }
               if(!this.myPortals[_loc20_].on && Boolean(this.myPortals[_loc20_].working))
               {
                  this.ClosePortalPair(this.myPortals[_loc20_]);
               }
               _loc27_ = 1000;
               if(this.myPortals[_loc20_].working)
               {
                  _loc13_ = this.myPortals[_loc20_];
                  _loc14_ = this.myPortals[_loc20_].other;
                  if(!this.myPortals[_loc20_].inverted && this.myPortals[_loc20_].other.maskedByL.length == 0 || this.myPortals[_loc20_].inverted && this.myPortals[_loc20_].other.maskedByR.length == 0)
                  {
                     this.myPortals[_loc20_].PortalRight.visible = false;
                     this.myPortals[_loc20_].PortalRight.alpha = 0;
                  }
                  if(!this.myPortals[_loc20_].inverted && this.myPortals[_loc20_].other.maskedByR.length == 0 || this.myPortals[_loc20_].inverted && this.myPortals[_loc20_].other.maskedByL.length == 0)
                  {
                     this.myPortals[_loc20_].PortalLeft.visible = false;
                     this.myPortals[_loc20_].PortalLeft.alpha = 0;
                  }
                  if(this.myPortals[_loc20_].maskedByR.length > 0 || Boolean(this.myPortals[_loc20_].maskedLightR))
                  {
                     if(this.myPortals[_loc20_].maskedLightL)
                     {
                        _loc28_ = 1;
                     }
                     else
                     {
                        _loc25_ = 0;
                        while(_loc25_ < this.myPortals[_loc20_].maskedByR.length)
                        {
                           if((_loc26_ = this.PortalDistance(this.myPortals[_loc20_],this.myPortals[_loc20_].maskedByR[_loc25_])) < _loc27_)
                           {
                              _loc27_ = _loc26_;
                           }
                           _loc25_++;
                        }
                        _loc28_ = 1 - (_loc26_ - 14) / 45;
                     }
                     if(this.myPortals[_loc20_].maskedLightR)
                     {
                        _loc28_ = 1;
                     }
                     _loc13_.PortalRight.visible = true;
                     _loc13_.PortalRight.alpha = _loc28_;
                     if(!_loc13_.inverted)
                     {
                        _loc14_.PortalLeft.visible = true;
                        _loc14_.PortalLeft.alpha = _loc28_;
                     }
                     else
                     {
                        _loc14_.PortalRight.visible = true;
                        _loc14_.PortalRight.alpha = _loc28_;
                     }
                  }
                  if(this.myPortals[_loc20_].maskedByL.length > 0 || Boolean(this.myPortals[_loc20_].maskedLightL))
                  {
                     if(this.myPortals[_loc20_].maskedLightL)
                     {
                        _loc28_ = 1;
                     }
                     else
                     {
                        _loc25_ = 0;
                        while(_loc25_ < this.myPortals[_loc20_].maskedByL.length)
                        {
                           if((_loc26_ = this.PortalDistance(this.myPortals[_loc20_],this.myPortals[_loc20_].maskedByL[_loc25_])) < _loc27_)
                           {
                              _loc27_ = _loc26_;
                           }
                           _loc25_++;
                        }
                        _loc28_ = 1 - (_loc26_ - 14) / 45;
                     }
                     _loc13_.PortalLeft.visible = true;
                     _loc13_.PortalLeft.alpha = _loc28_;
                     if(!_loc13_.inverted)
                     {
                        _loc14_.PortalRight.visible = true;
                        _loc14_.PortalRight.alpha = _loc28_;
                     }
                     else
                     {
                        _loc14_.PortalLeft.visible = true;
                        _loc14_.PortalLeft.alpha = _loc28_;
                     }
                  }
                  _loc29_ = Math.max(_loc13_.PortalLeft.alpha,_loc13_.PortalRight.alpha,_loc14_.PortalLeft.alpha,_loc14_.PortalRight.alpha);
                  if(_loc13_.myMechanism != undefined)
                  {
                     if(Boolean(_loc13_.maskedLightR) || Boolean(_loc13_.maskedLightL) || Boolean(_loc14_.maskedLightR) || Boolean(_loc14_.maskedLightL))
                     {
                        _loc13_.myMechanism.setPortalVolume(0,_loc13_);
                     }
                     else
                     {
                        _loc13_.myMechanism.setPortalVolume(_loc29_,_loc13_);
                     }
                  }
               }
               _loc20_++;
            }
            _loc20_ = 0;
            while(_loc20_ < this.myPortals.length)
            {
               if(this.myPortals[_loc20_].working)
               {
                  if(this.myPortals[_loc20_].activeObject)
                  {
                     this.transportObject(this.myPortals[_loc20_].activeBody,this.myPortals[_loc20_]);
                  }
               }
               _loc20_++;
            }
            this.m_world.Step(this.m_timeStep,this.m_iterations);
            for(_loc10_ in this.myMechanisms)
            {
               this.myMechanisms[_loc10_].checkState();
            }
            _loc11_ = this.m_world.m_bodyList;
            while(_loc11_)
            {
               if(_loc11_.m_userData is Sprite && _loc11_.IsSleeping() == false)
               {
                  _loc11_.m_userData.x = _loc11_.GetPosition().x * 20;
                  _loc11_.m_userData.y = _loc11_.GetPosition().y * 20;
                  if(_loc11_.m_userData.name != "pers1")
                  {
                     _loc11_.m_userData.rotation = _loc11_.GetAngle() * (180 / Math.PI);
                  }
                  if(_loc11_.m_userData.name == "HangingPlatform")
                  {
                     _loc11_.m_userData.rope.rotation = 180 / Math.PI * Math.atan2(_loc11_.m_userData.anchor.y - _loc11_.GetPosition().y,_loc11_.m_userData.anchor.x - _loc11_.GetPosition().x) + 90;
                  }
                  if(_loc11_.m_userData.name == "PulleyPlatform")
                  {
                     _loc11_.m_userData.rope.rotation = 180 / Math.PI * Math.atan2(_loc11_.m_userData.anchor.y - _loc11_.GetPosition().y + 34 / 20,_loc11_.m_userData.anchor.x - _loc11_.GetPosition().x) + 90;
                     _loc11_.m_userData.rope.chain.y = Math.sqrt(Math.pow(_loc11_.m_userData.anchor.y - _loc11_.GetPosition().y + 34 / 20,2) + Math.pow(_loc11_.m_userData.anchor.x - _loc11_.GetPosition().x,2)) * 20;
                     _loc11_.m_userData.rope.ropeMask.height = Math.sqrt(Math.pow(_loc11_.m_userData.anchor.y - _loc11_.GetPosition().y + 34 / 20,2) + Math.pow(_loc11_.m_userData.anchor.x - _loc11_.GetPosition().x,2)) * 20;
                     _loc11_.m_userData.connector.chain.x = -Math.sqrt(Math.pow(_loc11_.m_userData.anchor.y - _loc11_.GetPosition().y + 34 / 20,2) + Math.pow(_loc11_.m_userData.anchor.x - _loc11_.GetPosition().x,2)) * 20;
                     _loc11_.m_userData.anc1.rotation = -Math.sqrt(Math.pow(_loc11_.m_userData.anchor.y - _loc11_.GetPosition().y + 34 / 20,2) + Math.pow(_loc11_.m_userData.anchor.x - _loc11_.GetPosition().x,2)) * 200;
                     _loc11_.m_userData.anc2.rotation = -Math.sqrt(Math.pow(_loc11_.m_userData.anchor.y - _loc11_.GetPosition().y + 34 / 20,2) + Math.pow(_loc11_.m_userData.anchor.x - _loc11_.GetPosition().x,2)) * 200;
                  }
               }
               _loc11_ = _loc11_.m_next;
            }
            _loc11_ = this.m_lworld.m_bodyList;
            while(_loc11_)
            {
               if(_loc11_.m_userData is Sprite && Boolean(_loc11_.m_userData.pointer))
               {
                  _loc11_.SetXForm(new b2Vec2(_loc11_.m_userData.pointer.GetPosition().x,_loc11_.m_userData.pointer.GetPosition().y),_loc11_.m_userData.pointer.GetAngle());
               }
               _loc11_ = _loc11_.m_next;
            }
            this.LightBoard.graphics.clear();
            _loc12_ = 0;
            while(_loc12_ < this.myRotMirrorJoints.length)
            {
               if((_loc30_ = this.myRotMirrorJoints[_loc12_].oldObject).GetBody1().GetAngle() > this.myRotMirrorJoints[_loc12_].shift)
               {
                  _loc30_.GetBody1().SetXForm(_loc30_.GetBody1().GetPosition(),this.myRotMirrorJoints[_loc12_].shift);
               }
               else if(_loc30_.GetBody1().GetAngle() < this.myRotMirrorJoints[_loc12_].shift - Math.PI / 2)
               {
                  _loc30_.GetBody1().SetXForm(_loc30_.GetBody1().GetPosition(),this.myRotMirrorJoints[_loc12_].shift - Math.PI / 2);
               }
               _loc12_++;
            }
            _loc11_ = this.m_world.m_bodyList;
            while(_loc11_)
            {
               if(_loc11_.m_userData is LightBeamer)
               {
                  if(_loc11_.m_userData.on)
                  {
                     this.TraceBeam(_loc11_);
                  }
               }
               _loc11_ = _loc11_.m_next;
            }
            _loc11_ = this.m_lworld.m_bodyList;
            while(_loc11_)
            {
               if(_loc11_.m_userData is Sprite)
               {
                  _loc11_.m_userData.x = _loc11_.GetPosition().x * 20;
                  _loc11_.m_userData.y = _loc11_.GetPosition().y * 20;
                  _loc11_.m_userData.rotation = _loc11_.GetAngle() * (180 / Math.PI);
               }
               _loc11_ = _loc11_.m_next;
            }
         }
      }
      
      public function CreateGround(param1:Array) : *
      {
         var _loc2_:Array = null;
         var _loc3_:b2BodyDef = null;
         var _loc4_:b2PolygonDef = null;
         var _loc5_:b2Body = null;
         var _loc6_:b2Body = null;
         var _loc7_:Sprite = null;
         var _loc8_:Object = null;
         var _loc9_:b2BodyDef = null;
         var _loc10_:b2Body = null;
         var _loc11_:b2Vec2 = null;
         var _loc12_:Number = NaN;
         var _loc13_:b2Vec2 = null;
         var _loc14_:Array = null;
         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         var _loc17_:* = undefined;
         var _loc18_:* = undefined;
         var _loc19_:* = undefined;
         var _loc20_:* = undefined;
         var _loc21_:* = undefined;
         var _loc22_:* = undefined;
         var _loc23_:* = undefined;
         var _loc24_:* = undefined;
         var _loc25_:BitmapData = null;
         var _loc26_:* = undefined;
         var _loc27_:Bitmap = null;
         var _loc28_:* = undefined;
         var _loc29_:* = undefined;
         var _loc30_:* = undefined;
         var _loc31_:* = undefined;
         var _loc32_:* = undefined;
         var _loc33_:* = undefined;
         var _loc34_:* = undefined;
         var _loc35_:* = undefined;
         var _loc36_:* = undefined;
         var _loc37_:* = undefined;
         var _loc38_:* = undefined;
         var _loc39_:* = undefined;
         var _loc40_:* = undefined;
         var _loc41_:* = undefined;
         var _loc42_:* = undefined;
         var _loc43_:* = undefined;
         var _loc44_:* = undefined;
         var _loc45_:* = undefined;
         var _loc46_:* = undefined;
         var _loc47_:* = undefined;
         var _loc48_:* = undefined;
         _loc14_ = param1;
         _loc15_ = new Sprite();
         _loc16_ = new Sprite();
         _loc17_ = new Sprite();
         _loc7_ = new Sprite();
         _loc3_ = new b2BodyDef();
         _loc3_.position.Set(0,0);
         _loc3_.userData = new Object();
         _loc3_.userData.name = "ground";
         _loc5_ = this.m_world.CreateBody(_loc3_);
         _loc3_ = new b2BodyDef();
         _loc3_.position.Set(0,0);
         _loc3_.userData = new Object();
         _loc3_.userData.name = "ice";
         _loc6_ = this.m_world.CreateBody(_loc3_);
         _loc18_ = new Array();
         _loc13_ = new b2Vec2(0.5,0.5);
         _loc12_ = 0;
         _loc19_ = 0;
         this.preProcessGround(_loc14_);
         _loc20_ = 0;
         while(_loc20_ < _loc14_.length)
         {
            _loc19_ = 0;
            _loc29_ = 0;
            while(_loc29_ < _loc14_[0].length)
            {
               if(_loc14_[_loc20_][_loc29_] == "bd")
               {
                  ++this.BDcount;
                  _loc11_ = new b2Vec2(_loc29_,_loc20_ - 0.5);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc13_.x,_loc13_.y,new b2Vec2(0,0),_loc12_);
                  _loc4_.isSensor = true;
                  (_loc9_ = new b2BodyDef()).position.Set(_loc11_.x,_loc11_.y + 0.5);
                  _loc9_.userData = new BlueDiamond();
                  _loc9_.userData.name = "bd";
                  (_loc10_ = this.m_world.CreateBody(_loc9_)).CreateShape(_loc4_);
                  this.DiamondsandRopes.addChild(_loc9_.userData);
               }
               else if(_loc14_[_loc20_][_loc29_] == "rd")
               {
                  ++this.RDcount;
                  _loc11_ = new b2Vec2(_loc29_,_loc20_ - 0.5);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc13_.x,_loc13_.y,new b2Vec2(0,0),_loc12_);
                  _loc4_.isSensor = true;
                  (_loc9_ = new b2BodyDef()).position.Set(_loc11_.x,_loc11_.y + 0.5);
                  _loc9_.userData = new RedDiamond();
                  _loc9_.userData.name = "rd";
                  (_loc10_ = this.m_world.CreateBody(_loc9_)).CreateShape(_loc4_);
                  this.DiamondsandRopes.addChild(_loc9_.userData);
               }
               else if(_loc14_[_loc20_][_loc29_] == "gr")
               {
                  _loc11_ = new b2Vec2(_loc29_,_loc20_ + 0.5);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc13_.x,_loc13_.y,new b2Vec2(0,0),_loc12_);
                  _loc4_.isSensor = true;
                  (_loc9_ = new b2BodyDef()).position.Set(_loc11_.x,_loc11_.y);
                  _loc9_.userData = new SilverDiamond();
                  _loc9_.userData.name = "gr";
                  (_loc10_ = this.m_world.CreateBody(_loc9_)).CreateShape(_loc4_);
                  this.DiamondsandRopes.addChild(_loc9_.userData);
               }
               if(_loc14_[_loc20_][_loc29_] == 1)
               {
                  _loc11_ = new b2Vec2(_loc29_,_loc20_);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc13_.x,_loc13_.y,_loc11_,_loc12_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc18_.push(_loc4_);
                  (_loc8_ = _loc15_.addChild(new MaskBox())).scaleX = 1;
                  _loc8_.scaleY = 1;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
                  _loc8_.rotation = Math.round(Math.random() * 4) * 90;
                  (_loc8_ = _loc16_.addChild(new MaskBox())).scaleX = 1.2;
                  _loc8_.scaleY = 1.2;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
                  _loc8_.rotation = Math.round(Math.random() * 4) * 90;
               }
               if(_loc14_[_loc20_][_loc29_] == "f")
               {
                  _loc11_ = new b2Vec2(_loc29_,_loc20_);
                  (_loc8_ = _loc15_.addChild(new MaskBox())).scaleX = 1;
                  _loc8_.scaleY = 1;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
                  _loc8_.rotation = Math.round(Math.random() * 4) * 90;
                  (_loc8_ = _loc16_.addChild(new MaskBox())).scaleX = 1.2;
                  _loc8_.scaleY = 1.2;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
                  _loc8_.rotation = Math.round(Math.random() * 4) * 90;
               }
               else if(_loc14_[_loc20_][_loc29_] == "i")
               {
                  _loc11_ = new b2Vec2(_loc29_,_loc20_);
                  if(_loc14_[_loc20_][_loc29_ + 1] == "i")
                  {
                     _loc19_++;
                  }
                  else
                  {
                     trace("SnowCount " + _loc19_);
                     (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc19_ / 2 + 0.5,_loc13_.y,new b2Vec2(_loc11_.x - _loc19_ / 2,_loc11_.y),_loc12_);
                     _loc4_.friction = 0.3;
                     _loc4_.density = 0;
                     _loc4_.restitution = 0;
                     _loc4_.filter.groupIndex = -8;
                     _loc6_.CreateShape(_loc4_);
                     _loc18_.push(_loc4_);
                     _loc19_ = 0;
                  }
                  (_loc8_ = _loc17_.addChild(new MaskBoxIce())).scaleY = 1;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
                  (_loc8_ = _loc15_.addChild(new MaskBox())).scaleX = 1;
                  _loc8_.scaleY = 1;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
                  _loc8_.rotation = Math.round(Math.random() * 4) * 90;
               }
               else if(_loc14_[_loc20_][_loc29_] == -1)
               {
                  _loc11_ = new b2Vec2(_loc29_,_loc20_);
                  (_loc4_ = new b2PolygonDef()).vertexCount = 3;
                  _loc4_.vertices[0].Set(_loc29_ - 0.5,_loc20_ + 0.5);
                  _loc4_.vertices[1].Set(_loc29_ - 0.5,_loc20_ - 0.5);
                  _loc4_.vertices[2].Set(_loc29_ + 0.5,_loc20_ + 0.5);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc18_.push(_loc4_);
                  (_loc8_ = _loc15_.addChild(new MaskBoxMaskTri())).scaleX = 1;
                  _loc8_.scaleY = 1;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
                  (_loc8_ = _loc16_.addChild(new MaskBoxMaskTri())).scaleX = 1.2;
                  _loc8_.scaleY = 1.2;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
               }
               else if(_loc14_[_loc20_][_loc29_] == "i1")
               {
                  _loc11_ = new b2Vec2(_loc29_,_loc20_);
                  (_loc4_ = new b2PolygonDef()).vertexCount = 3;
                  _loc4_.vertices[0].Set(_loc29_ - 0.5,_loc20_ + 0.5);
                  _loc4_.vertices[1].Set(_loc29_ - 0.5,_loc20_ - 0.5);
                  _loc4_.vertices[2].Set(_loc29_ + 0.5,_loc20_ + 0.5);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc6_.CreateShape(_loc4_);
                  _loc18_.push(_loc4_);
                  (_loc8_ = _loc15_.addChild(new MaskBoxMaskTri())).scaleX = 1;
                  _loc8_.scaleY = 1;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
                  (_loc8_ = _loc17_.addChild(new MaskBoxMaskTriIce())).scaleX = 1;
                  _loc8_.scaleY = 1;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
               }
               else if(_loc14_[_loc20_][_loc29_] == -2)
               {
                  _loc11_ = new b2Vec2(_loc29_,_loc20_);
                  (_loc4_ = new b2PolygonDef()).vertexCount = 3;
                  _loc4_.vertices[0].Set(_loc29_ - 0.5,_loc20_ + 0.5);
                  _loc4_.vertices[1].Set(_loc29_ + 0.5,_loc20_ - 0.5);
                  _loc4_.vertices[2].Set(_loc29_ + 0.5,_loc20_ + 0.5);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc18_.push(_loc4_);
                  (_loc8_ = _loc15_.addChild(new MaskBoxMaskTri())).scaleX = 1;
                  _loc8_.scaleY = 1;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
                  _loc8_.rotation = -90;
                  (_loc8_ = _loc16_.addChild(new MaskBoxMaskTri())).scaleX = 1.2;
                  _loc8_.scaleY = 1.2;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
                  _loc8_.rotation = -90;
               }
               else if(_loc14_[_loc20_][_loc29_] == "i2")
               {
                  _loc11_ = new b2Vec2(_loc29_,_loc20_);
                  (_loc4_ = new b2PolygonDef()).vertexCount = 3;
                  _loc4_.vertices[0].Set(_loc29_ - 0.5,_loc20_ + 0.5);
                  _loc4_.vertices[1].Set(_loc29_ + 0.5,_loc20_ - 0.5);
                  _loc4_.vertices[2].Set(_loc29_ + 0.5,_loc20_ + 0.5);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc6_.CreateShape(_loc4_);
                  _loc18_.push(_loc4_);
                  (_loc8_ = _loc15_.addChild(new MaskBoxMaskTri())).scaleX = 1;
                  _loc8_.scaleY = 1;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
                  _loc8_.rotation = -90;
                  (_loc8_ = _loc17_.addChild(new MaskBoxMaskTriIce())).scaleX = 1;
                  _loc8_.scaleY = 1;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
                  _loc8_.rotation = -90;
               }
               else if(_loc14_[_loc20_][_loc29_] == -3)
               {
                  _loc11_ = new b2Vec2(_loc29_,_loc20_);
                  (_loc4_ = new b2PolygonDef()).vertexCount = 3;
                  _loc4_.vertices[1].Set(_loc29_ + 0.5,_loc20_ - 0.5);
                  _loc4_.vertices[0].Set(_loc29_ - 0.5,_loc20_ - 0.5);
                  _loc4_.vertices[2].Set(_loc29_ + 0.5,_loc20_ + 0.5);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc18_.push(_loc4_);
                  (_loc8_ = _loc15_.addChild(new MaskBoxMaskTri())).scaleX = 1;
                  _loc8_.scaleY = 1;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
                  _loc8_.rotation = 180;
                  (_loc8_ = _loc16_.addChild(new MaskBoxMaskTri())).scaleX = 1.2;
                  _loc8_.scaleY = 1.2;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
                  _loc8_.rotation = 180;
               }
               else if(_loc14_[_loc20_][_loc29_] == "i3")
               {
                  _loc11_ = new b2Vec2(_loc29_,_loc20_);
                  (_loc4_ = new b2PolygonDef()).vertexCount = 3;
                  _loc4_.vertices[1].Set(_loc29_ + 0.5,_loc20_ - 0.5);
                  _loc4_.vertices[0].Set(_loc29_ - 0.5,_loc20_ - 0.5);
                  _loc4_.vertices[2].Set(_loc29_ + 0.5,_loc20_ + 0.5);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc6_.CreateShape(_loc4_);
                  _loc18_.push(_loc4_);
                  (_loc8_ = _loc17_.addChild(new MaskBoxMaskTri())).scaleX = 1;
                  _loc8_.scaleY = 1;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
                  _loc8_.rotation = 180;
               }
               else if(_loc14_[_loc20_][_loc29_] == -4)
               {
                  _loc11_ = new b2Vec2(_loc29_,_loc20_);
                  (_loc4_ = new b2PolygonDef()).vertexCount = 3;
                  _loc4_.vertices[1].Set(_loc29_ + 0.5,_loc20_ - 0.5);
                  _loc4_.vertices[0].Set(_loc29_ - 0.5,_loc20_ - 0.5);
                  _loc4_.vertices[2].Set(_loc29_ - 0.5,_loc20_ + 0.5);
                  _loc4_.friction = 1;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc18_.push(_loc4_);
                  (_loc8_ = _loc15_.addChild(new MaskBoxMaskTri())).scaleX = 1;
                  _loc8_.scaleY = 1;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
                  _loc8_.rotation = 90;
                  (_loc8_ = _loc16_.addChild(new MaskBoxMaskTri())).scaleX = 1.2;
                  _loc8_.scaleY = 1.2;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
                  _loc8_.rotation = 90;
               }
               else if(_loc14_[_loc20_][_loc29_] == "i4")
               {
                  _loc11_ = new b2Vec2(_loc29_,_loc20_);
                  (_loc4_ = new b2PolygonDef()).vertexCount = 3;
                  _loc4_.vertices[1].Set(_loc29_ + 0.5,_loc20_ - 0.5);
                  _loc4_.vertices[0].Set(_loc29_ - 0.5,_loc20_ - 0.5);
                  _loc4_.vertices[2].Set(_loc29_ - 0.5,_loc20_ + 0.5);
                  _loc4_.friction = 1;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc6_.CreateShape(_loc4_);
                  _loc18_.push(_loc4_);
                  (_loc8_ = _loc17_.addChild(new MaskBoxMaskTri())).scaleX = 1;
                  _loc8_.scaleY = 1;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
                  _loc8_.rotation = 90;
               }
               if(_loc14_[_loc20_][_loc29_] == 5)
               {
                  _loc11_ = new b2Vec2(_loc29_,_loc20_ + 0.25);
                  (_loc8_ = new Sprite()).x = _loc11_.x * 20;
                  _loc8_.y = (_loc11_.y - 0.5) * 20;
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc13_.x,_loc13_.y / 2,_loc11_,_loc12_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc18_.push(_loc4_);
                  (_loc8_ = _loc7_.addChild(new GroundBoxHalf())).scaleX = 1;
                  _loc8_.scaleY = 1;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
                  if(Math.random() > 0.4)
                  {
                     _loc8_.rotation = 180;
                  }
                  (_loc8_ = _loc15_.addChild(new MaskBoxHalf())).scaleX = 1;
                  _loc8_.scaleY = 1;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
               }
               else if(_loc14_[_loc20_][_loc29_] == 51 || _loc14_[_loc20_][_loc29_] == 53)
               {
                  _loc11_ = new b2Vec2(_loc29_,_loc20_ + 0.25);
                  (_loc8_ = new Sprite()).scaleX = 1;
                  _loc8_.scaleY = 0.5;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = (_loc11_.y - 0.5) * 20;
                  (_loc4_ = new b2PolygonDef()).vertexCount = 3;
                  _loc4_.vertices[0].Set(_loc29_ - 0.5,_loc20_);
                  _loc4_.vertices[1].Set(_loc29_ - 0.5,_loc20_ - 0.5);
                  _loc4_.vertices[2].Set(_loc29_ + 0.5,_loc20_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc18_.push(_loc4_);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc13_.x,_loc13_.y / 2,_loc11_,_loc12_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc18_.push(_loc4_);
                  (_loc8_ = _loc15_.addChild(new MaskBoxMaskTri2())).scaleX = 1;
                  _loc8_.scaleY = 1;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
               }
               else if(_loc14_[_loc20_][_loc29_] == 52)
               {
                  _loc11_ = new b2Vec2(_loc29_,_loc20_ + 0.25);
                  (_loc8_ = new Sprite()).scaleX = -1;
                  _loc8_.scaleY = 0.5;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = (_loc11_.y - 0.5) * 20;
                  (_loc4_ = new b2PolygonDef()).vertexCount = 3;
                  _loc4_.vertices[0].Set(_loc29_ - 0.5,_loc20_);
                  _loc4_.vertices[1].Set(_loc29_ + 0.5,_loc20_ - 0.5);
                  _loc4_.vertices[2].Set(_loc29_ + 0.5,_loc20_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc18_.push(_loc4_);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc13_.x,_loc13_.y / 2,_loc11_,_loc12_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc18_.push(_loc4_);
                  (_loc8_ = _loc15_.addChild(new MaskBoxMaskTri3())).scaleX = 1;
                  _loc8_.scaleY = 1;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
               }
               if(_loc14_[_loc20_][_loc29_] == 6)
               {
                  _loc11_ = new b2Vec2(_loc29_,_loc20_ + 0.25);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc13_.x,_loc13_.y / 2,new b2Vec2(_loc29_,_loc20_ - 0.25),_loc12_);
                  _loc4_.friction = 0;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.isSensor = true;
                  _loc4_.userData = "fire";
                  _loc5_.CreateShape(_loc4_);
                  _loc18_.push(_loc4_);
                  (_loc8_ = this.FiresandWaters.addChild(new FireBox())).x = _loc11_.x * 20;
                  _loc8_.y = (_loc11_.y - 0.5) * 20;
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc13_.x,_loc13_.y / 2,_loc11_,_loc12_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc18_.push(_loc4_);
                  (_loc8_ = _loc7_.addChild(new GroundBoxHalf())).scaleX = 1;
                  _loc8_.scaleY = 1;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
                  if(Math.random() > 0.4)
                  {
                     _loc8_.rotation = 180;
                  }
                  (_loc8_ = _loc15_.addChild(new MaskBoxHalf())).scaleX = 1;
                  _loc8_.scaleY = 1;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
               }
               else if(_loc14_[_loc20_][_loc29_] == 61)
               {
                  _loc11_ = new b2Vec2(_loc29_,_loc20_ + 0.25);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc13_.x,_loc13_.y,_loc11_,_loc12_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.isSensor = true;
                  _loc4_.userData = "fire";
                  _loc5_.CreateShape(_loc4_);
                  _loc18_.push(_loc4_);
                  (_loc8_ = this.FiresandWaters.addChild(new FireBoxTri())).scaleX = 1;
                  _loc8_.scaleY = 0.5;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = (_loc11_.y - 0.5) * 20;
                  (_loc4_ = new b2PolygonDef()).vertexCount = 3;
                  _loc4_.vertices[0].Set(_loc29_ - 0.5,_loc20_);
                  _loc4_.vertices[1].Set(_loc29_ - 0.5,_loc20_ - 0.5);
                  _loc4_.vertices[2].Set(_loc29_ + 0.5,_loc20_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc18_.push(_loc4_);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc13_.x,_loc13_.y / 2,_loc11_,_loc12_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc18_.push(_loc4_);
                  (_loc8_ = _loc15_.addChild(new MaskBoxMaskTri2())).scaleX = 1;
                  _loc8_.scaleY = 1;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
               }
               else if(_loc14_[_loc20_][_loc29_] == 62)
               {
                  _loc11_ = new b2Vec2(_loc29_,_loc20_ + 0.25);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc13_.x,_loc13_.y,_loc11_,_loc12_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.isSensor = true;
                  _loc4_.userData = "fire";
                  _loc5_.CreateShape(_loc4_);
                  _loc18_.push(_loc4_);
                  (_loc8_ = this.FiresandWaters.addChild(new FireBoxTri())).scaleX = -1;
                  _loc8_.scaleY = 0.5;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = (_loc11_.y - 0.5) * 20;
                  (_loc4_ = new b2PolygonDef()).vertexCount = 3;
                  _loc4_.vertices[0].Set(_loc29_ - 0.5,_loc20_);
                  _loc4_.vertices[1].Set(_loc29_ + 0.5,_loc20_ - 0.5);
                  _loc4_.vertices[2].Set(_loc29_ + 0.5,_loc20_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc18_.push(_loc4_);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc13_.x,_loc13_.y / 2,_loc11_,_loc12_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc18_.push(_loc4_);
                  (_loc8_ = _loc15_.addChild(new MaskBoxMaskTri3())).scaleX = 1;
                  _loc8_.scaleY = 1;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
               }
               if(_loc14_[_loc20_][_loc29_] == 7)
               {
                  _loc11_ = new b2Vec2(_loc29_,_loc20_ + 0.25);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc13_.x,_loc13_.y / 2,new b2Vec2(_loc29_,_loc20_ - 0.25),_loc12_);
                  _loc4_.friction = 0;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.isSensor = true;
                  _loc4_.userData = "black";
                  _loc5_.CreateShape(_loc4_);
                  _loc18_.push(_loc4_);
                  (_loc8_ = this.FiresandWaters.addChild(new BlackBox())).x = _loc11_.x * 20;
                  _loc8_.y = (_loc11_.y - 0.5) * 20;
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc13_.x,_loc13_.y / 2,_loc11_,_loc12_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc18_.push(_loc4_);
                  (_loc8_ = _loc7_.addChild(new GroundBoxHalf())).scaleX = 1;
                  _loc8_.scaleY = 1;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
                  if(Math.random() > 0.4)
                  {
                     _loc8_.rotation = 180;
                  }
                  (_loc8_ = _loc15_.addChild(new MaskBoxHalf())).scaleX = 1;
                  _loc8_.scaleY = 1;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
               }
               else if(_loc14_[_loc20_][_loc29_] == 71)
               {
                  _loc11_ = new b2Vec2(_loc29_,_loc20_ + 0.25);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc13_.x,_loc13_.y,_loc11_,_loc12_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.isSensor = true;
                  _loc4_.userData = "black";
                  _loc5_.CreateShape(_loc4_);
                  _loc18_.push(_loc4_);
                  (_loc8_ = this.FiresandWaters.addChild(new BlackBoxTri())).scaleX = 1;
                  _loc8_.scaleY = 0.5;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = (_loc11_.y - 0.5) * 20;
                  (_loc4_ = new b2PolygonDef()).vertexCount = 3;
                  _loc4_.vertices[0].Set(_loc29_ - 0.5,_loc20_);
                  _loc4_.vertices[1].Set(_loc29_ - 0.5,_loc20_ - 0.5);
                  _loc4_.vertices[2].Set(_loc29_ + 0.5,_loc20_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc18_.push(_loc4_);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc13_.x,_loc13_.y / 2,_loc11_,_loc12_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc18_.push(_loc4_);
                  (_loc8_ = _loc15_.addChild(new MaskBoxMaskTri2())).scaleX = 1;
                  _loc8_.scaleY = 1;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
               }
               else if(_loc14_[_loc20_][_loc29_] == 72)
               {
                  _loc11_ = new b2Vec2(_loc29_,_loc20_ + 0.25);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc13_.x,_loc13_.y,_loc11_,_loc12_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.isSensor = true;
                  _loc4_.userData = "black";
                  _loc5_.CreateShape(_loc4_);
                  _loc18_.push(_loc4_);
                  (_loc8_ = this.FiresandWaters.addChild(new BlackBoxTri())).scaleX = -1;
                  _loc8_.scaleY = 0.5;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = (_loc11_.y - 0.5) * 20;
                  (_loc4_ = new b2PolygonDef()).vertexCount = 3;
                  _loc4_.vertices[0].Set(_loc29_ - 0.5,_loc20_);
                  _loc4_.vertices[1].Set(_loc29_ + 0.5,_loc20_ - 0.5);
                  _loc4_.vertices[2].Set(_loc29_ + 0.5,_loc20_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc18_.push(_loc4_);
                  (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc13_.x,_loc13_.y / 2,_loc11_,_loc12_);
                  _loc4_.friction = 0.3;
                  _loc4_.density = 0;
                  _loc4_.restitution = 0;
                  _loc4_.filter.groupIndex = -8;
                  _loc5_.CreateShape(_loc4_);
                  _loc18_.push(_loc4_);
                  (_loc8_ = _loc15_.addChild(new MaskBoxMaskTri3())).scaleX = 1;
                  _loc8_.scaleY = 1;
                  _loc8_.x = _loc11_.x * 20;
                  _loc8_.y = _loc11_.y * 20;
               }
               _loc29_++;
            }
            _loc20_++;
         }
         _loc20_ = 0;
         while(_loc20_ < _loc14_.length)
         {
            _loc29_ = 0;
            while(_loc29_ < _loc14_[0].length)
            {
               if(_loc14_[_loc20_][_loc29_] == 51 || _loc14_[_loc20_][_loc29_] == 53)
               {
                  (_loc31_ = new b2BodyDef()).userData = new Object();
                  _loc31_.userData.name = "ground";
                  _loc30_ = this.m_world.CreateBody(_loc31_);
                  _loc32_ = 0;
                  while(_loc32_ < 25)
                  {
                     if(_loc14_[_loc20_][_loc29_ + _loc32_] == 52)
                     {
                        _loc33_ = new Sprite();
                        (_loc34_ = this.CreateIceBlock(new b2Vec2(_loc29_ + _loc32_ / 2,_loc20_),new b2Vec2((_loc32_ + 1) / 2,0.5),0)).y = -6;
                        _loc34_.scaleY = 0.5;
                        (_loc35_ = new Sprite()).graphics.beginFill(16711935,0.5);
                        _loc35_.graphics.drawRect(-20 * (_loc32_ + 1) / 2,-15,(_loc32_ + 1) * 20,20);
                        (_loc36_ = new Sprite()).graphics.beginFill(16711935,0.5);
                        _loc36_.graphics.drawRect(-20 * (_loc32_ + 1) / 2,-15,(_loc32_ + 1) * 20,20);
                        _loc37_ = new Sprite();
                        _loc33_.addChild(_loc34_);
                        _loc33_.addChild(_loc37_);
                        _loc33_.addChild(_loc35_);
                        _loc33_.addChild(_loc36_);
                        (_loc39_ = new FreezingEffect()).y = -10;
                        _loc39_.visible = false;
                        _loc33_.addChild(_loc39_);
                        (_loc40_ = new FreezingEffect()).visible = false;
                        _loc40_.y = -10;
                        _loc33_.addChild(_loc40_);
                        (_loc41_ = new MeltSmoke()).visible = false;
                        _loc41_.cacheAsBitmap = true;
                        _loc41_.meltsmoke.width = (_loc32_ + 1) * 20;
                        _loc33_.addChild(_loc41_);
                        (_loc42_ = new Sprite()).graphics.beginFill(16711935,0.5);
                        _loc42_.graphics.drawRect(-20 * (_loc32_ + 1) / 2,-100,(_loc32_ + 1) * 20,150);
                        _loc42_.graphics.endFill();
                        _loc33_.addChild(_loc42_);
                        _loc42_.cacheAsBitmap = true;
                        _loc41_.cacheAsBitmap = true;
                        _loc41_.mask = _loc42_;
                        _loc34_.mask = _loc35_;
                        _loc37_.mask = _loc36_;
                        _loc33_.x = (_loc29_ + _loc32_ / 2) * 20;
                        _loc33_.y = _loc20_ * 20;
                        this.FiresandWaters.addChild(_loc33_);
                        (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc32_ / 2,0.6,new b2Vec2(_loc29_ + _loc32_ / 2,_loc20_),_loc12_);
                        _loc4_.friction = 0;
                        _loc4_.density = 0;
                        _loc4_.restitution = 1;
                        _loc4_.filter.maskBits = 0;
                        (_loc43_ = new b2BodyDef()).userData = new MovieClip();
                        _loc43_.userData.mirror = false;
                        if(_loc14_[_loc20_][_loc29_ + _loc32_] == 52)
                        {
                           _loc4_.filter.maskBits = 65535;
                           _loc43_.userData.mirror = true;
                        }
                        (_loc44_ = this.m_lworld.CreateBody(_loc43_)).CreateShape(_loc4_);
                        _loc45_ = new b2BodyDef();
                        (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc32_ / 2,1,new b2Vec2(_loc29_ + _loc32_ / 2,_loc20_),_loc12_);
                        _loc4_.friction = 0.3;
                        _loc4_.density = 0;
                        _loc4_.restitution = 0;
                        _loc4_.isSensor = true;
                        _loc4_.userData = "iceSensor";
                        _loc45_.userData = new MovieClip();
                        _loc45_.userData.iceMC = _loc34_;
                        _loc45_.userData.waterMC = _loc37_;
                        _loc45_.userData.waterMask = _loc36_;
                        _loc45_.userData.iceMask = _loc35_;
                        _loc45_.userData.f1 = _loc39_;
                        _loc45_.userData.f2 = _loc40_;
                        _loc45_.userData.m = _loc41_;
                        _loc45_.userData.l = (_loc32_ + 1) * 20;
                        _loc45_.userData.contactPoint = new b2Vec2(0,0);
                        _loc45_.userData.pos = new b2Vec2(_loc29_ + _loc32_ / 2,_loc20_);
                        _loc45_.userData.mirrorBody = _loc44_;
                        (_loc46_ = this.m_lworld.CreateBody(_loc45_)).CreateShape(_loc4_);
                        this.myIces.push(_loc46_.GetUserData());
                        _loc46_.GetUserData().body = _loc34_.body;
                        _loc46_.GetUserData().bodyDef = _loc34_.bodyDef;
                        _loc46_.GetUserData().boxDef = _loc34_.boxDef;
                        _loc46_.GetUserData().shapes = new Array();
                        _loc46_.GetUserData().freeze = false;
                        _loc46_.GetUserData().melt = false;
                        if(_loc14_[_loc20_][_loc29_] == 51)
                        {
                           _loc35_.graphics.clear();
                           _loc46_.GetUserData().frozen = false;
                           (_loc48_ = new b2FilterData()).maskBits = 0;
                           _loc46_.GetUserData().mirrorBody.GetShapeList().SetFilterData(_loc48_);
                           this.m_world.DestroyBody(_loc34_.body);
                        }
                        else if(_loc14_[_loc20_][_loc29_] == 53)
                        {
                           _loc36_.graphics.clear();
                           _loc46_.GetUserData().frozen = true;
                        }
                        (_loc38_ = new WaterBoxTri()).x = -_loc32_ / 2 * 20;
                        _loc38_.y = -5;
                        _loc38_.scaleY = 0.5;
                        _loc37_.addChild(_loc38_);
                        (_loc38_ = new WaterBoxTri()).x = _loc32_ / 2 * 20;
                        _loc38_.y = -5;
                        _loc38_.scaleY = 0.5;
                        _loc38_.scaleX = -1;
                        _loc37_.addChild(_loc38_);
                        (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc13_.x / 2,_loc13_.y / 2,new b2Vec2(_loc29_ + 0.5,_loc20_ - 0.25),_loc12_);
                        _loc4_.friction = 0.3;
                        _loc4_.density = 0;
                        _loc4_.restitution = 0;
                        _loc4_.isSensor = true;
                        _loc4_.userData = "water";
                        _loc30_.CreateShape(_loc4_);
                        _loc18_.push(_loc4_);
                        _loc46_.GetUserData().shapes.push(_loc30_.GetShapeList());
                        (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc13_.x / 2,_loc13_.y / 2,new b2Vec2(_loc29_ + _loc32_ - 0.5,_loc20_ - 0.25),_loc12_);
                        _loc4_.friction = 0.3;
                        _loc4_.density = 0;
                        _loc4_.restitution = 0;
                        _loc4_.isSensor = true;
                        _loc4_.userData = "water";
                        _loc30_.CreateShape(_loc4_);
                        _loc18_.push(_loc4_);
                        _loc46_.GetUserData().shapes.push(_loc30_.GetShapeList());
                        _loc47_ = 1;
                        while(_loc47_ < _loc32_)
                        {
                           (_loc38_ = new WaterBox()).x = (-_loc32_ / 2 + _loc47_) * 20;
                           _loc38_.y = -5;
                           _loc37_.addChild(_loc38_);
                           (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc13_.x,_loc13_.y / 2,new b2Vec2(_loc29_ + _loc47_,_loc20_ - 0.25),_loc12_);
                           _loc4_.friction = 0;
                           _loc4_.density = 0;
                           _loc4_.restitution = 0;
                           _loc4_.isSensor = true;
                           _loc4_.userData = "water";
                           _loc30_.CreateShape(_loc4_);
                           _loc18_.push(_loc4_);
                           _loc46_.GetUserData().shapes.push(_loc30_.GetShapeList());
                           _loc47_++;
                        }
                        _loc30_.GetUserData().pnt = _loc46_.GetUserData();
                        _loc30_.SetMassFromShapes();
                        if(_loc14_[_loc20_][_loc29_] == 53)
                        {
                           (_loc48_ = new b2FilterData()).maskBits = 0;
                           _loc47_ = 0;
                           while(_loc47_ < _loc46_.GetUserData().shapes.length)
                           {
                              _loc46_.GetUserData().shapes[_loc47_].SetFilterData(_loc48_);
                              _loc47_++;
                           }
                        }
                        _loc32_ = 25;
                     }
                     _loc32_++;
                  }
               }
               _loc29_++;
            }
            _loc20_++;
         }
         this.CreateLightBody(_loc5_,_loc3_,_loc18_);
         _loc5_.SetMassFromShapes();
         _loc6_.SetMassFromShapes();
         _loc7_.name = "GroundMC";
         this.FiresandWaters.name = "FiresandWaters";
         _loc15_.name = "GroundMask";
         (_loc21_ = new LightMask()).name = "LightMask";
         (_loc22_ = new texture1()).name = "texture";
         _loc23_ = new SnowFull();
         _loc22_.mask = _loc15_;
         _loc23_.mask = _loc17_;
         _loc22_.filters = [new GlowFilter(11184810,1,4,4,1,2,true,false),new GlowFilter(0,1,2,2,30,2,false,false),new DropShadowFilter(8,45,0,1,4,4,0.5,3,false,false,false)];
         _loc23_.filters = [new GlowFilter(3223368,1,5,5,1,2,true,false),new GlowFilter(0,1,2,2,30,2,false,false),new DropShadowFilter(3,45,0,1,4,4,0.5,3,false,false,false)];
         (_loc24_ = new Matrix()).tx = 15;
         _loc24_.ty = 15;
         _loc25_ = new BitmapData(_loc22_.width + 10,_loc22_.height + 10,true,0);
         _loc26_ = new ColorTransform();
         _loc25_.draw(_loc22_,_loc24_,_loc26_);
         _loc25_.draw(_loc23_,_loc24_);
         (_loc27_ = new Bitmap(_loc25_)).smoothing = true;
         _loc27_.cacheAsBitmap = true;
         _loc27_.name = "cachedGround";
         _loc27_.x -= 15;
         _loc27_.y -= 15;
         this.GroundLayer.addChild(_loc27_);
         (_loc28_ = this.CreateCristals(this.LevelArray2)).cacheAsBitmap = true;
         this.FiresandWaters.addChild(_loc28_);
      }
      
      internal function preProcessGround(param1:Array) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = 0;
            while(_loc3_ < param1[_loc2_].length)
            {
               if(param1[_loc2_][_loc3_] == 5 && param1[_loc2_][_loc3_ - 1] != 5 && param1[_loc2_][_loc3_ - 1] != 51 && param1[_loc2_][_loc3_ - 1] != 53)
               {
                  param1[_loc2_][_loc3_] = 51;
               }
               if(param1[_loc2_][_loc3_] == 5 && param1[_loc2_][_loc3_ + 1] != 5)
               {
                  param1[_loc2_][_loc3_] = 52;
               }
               if(param1[_loc2_][_loc3_] == 6 && param1[_loc2_][_loc3_ - 1] != 6 && param1[_loc2_][_loc3_ - 1] != 61)
               {
                  param1[_loc2_][_loc3_] = 61;
               }
               if(param1[_loc2_][_loc3_] == 6 && param1[_loc2_][_loc3_ + 1] != 6)
               {
                  param1[_loc2_][_loc3_] = 62;
               }
               if(param1[_loc2_][_loc3_] == 7 && param1[_loc2_][_loc3_ - 1] != 7 && param1[_loc2_][_loc3_ - 1] != 71)
               {
                  param1[_loc2_][_loc3_] = 71;
               }
               if(param1[_loc2_][_loc3_] == 7 && param1[_loc2_][_loc3_ + 1] != 7)
               {
                  param1[_loc2_][_loc3_] = 72;
               }
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      private function disableGround(param1:Number, param2:Number) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc3_ = Math.floor(param2);
         _loc4_ = Math.floor(param1);
         trace("indices " + _loc3_ + " " + _loc4_);
         try
         {
            this.LevelArray2[_loc3_][_loc4_] = 100;
         }
         catch(error1:*)
         {
         }
         try
         {
            this.LevelArray2[_loc3_ + 1][_loc4_] = 100;
         }
         catch(error2:*)
         {
         }
         try
         {
            this.LevelArray2[_loc3_][_loc4_ + 1] = 100;
         }
         catch(error3:*)
         {
         }
         try
         {
            this.LevelArray2[_loc3_ - 1][_loc4_] = 100;
         }
         catch(error4:*)
         {
         }
         try
         {
            this.LevelArray2[_loc3_][_loc4_ - 1] = 100;
         }
         catch(error5:*)
         {
         }
         try
         {
            this.LevelArray2[_loc3_ + 1][_loc4_ + 1] = 100;
         }
         catch(error2:*)
         {
         }
         try
         {
            this.LevelArray2[_loc3_ - 1][_loc4_ + 1] = 100;
         }
         catch(error3:*)
         {
         }
         try
         {
            this.LevelArray2[_loc3_ - 1][_loc4_ - 1] = 100;
         }
         catch(error4:*)
         {
         }
         try
         {
            this.LevelArray2[_loc3_ + 1][_loc4_ - 1] = 100;
         }
         catch(error5:*)
         {
         }
      }
      
      internal function CreateCristals(param1:*) : *
      {
         var pr:PM_PRNG = null;
         var cristalcount:* = undefined;
         var graph:* = undefined;
         var mc:* = undefined;
         var Temp:* = undefined;
         var i:* = undefined;
         var j:* = undefined;
         var w:* = undefined;
         var h:* = undefined;
         var n:* = undefined;
         var rot:* = undefined;
         var temped:* = undefined;
         var t:* = undefined;
         var A:* = param1;
         pr = new PM_PRNG();
         pr.seed = 1;
         cristalcount = 0;
         graph = new Sprite();
         Temp = new Array();
         i = 0;
         while(i < A.length)
         {
            Temp.push(new Array());
            j = 0;
            while(j < A[i].length)
            {
               Temp[i].push(0);
               j++;
            }
            i++;
         }
         i = 0;
         while(i < A.length)
         {
            w = A.length - 1;
            j = 0;
            while(j < A[i].length)
            {
               h = A[i].length - 1;
               if(A[i][j] == 1)
               {
                  n = 0;
                  rot = -1;
                  try
                  {
                     if(A[i + 1][j] == 0 && A[i + 1][j - 1] == 0 && A[i + 1][j + 1] == 0 && A[i + 2][j] == 0)
                     {
                        rot = 180;
                     }
                  }
                  catch(error:*)
                  {
                  }
                  try
                  {
                     if(A[i - 1][j] == 0 && A[i - 1][j - 1] == 0 && A[i - 1][j + 1] == 0 && A[i - 2][j] == 0)
                     {
                        rot = 0;
                     }
                  }
                  catch(error:*)
                  {
                  }
                  try
                  {
                     if(A[i][j + 1] == 0 && A[i + 1][j + 1] == 0 && A[i - 1][j + 1] == 0 && A[i][j + 2] == 0)
                     {
                        rot = 90;
                     }
                  }
                  catch(error:*)
                  {
                  }
                  try
                  {
                     if(A[i][j - 1] == 0 && A[i + 1][j - 1] == 0 && A[i - 1][j - 1] == 0 && A[i][j - 2] == 0)
                     {
                        rot = 270;
                     }
                  }
                  catch(error:*)
                  {
                  }
                  temped = false;
                  if(i < w && Temp[i + 1][j] != 0)
                  {
                     temped = true;
                  }
                  if(i > 0 && Temp[i - 1][j] != 0)
                  {
                     temped = true;
                  }
                  if(j < h && Temp[i][j + 1] != 0)
                  {
                     temped = true;
                  }
                  if(j > 0 && Temp[i][j - 1] != 0)
                  {
                     temped = true;
                  }
                  if(rot != -1 && temped == false)
                  {
                     if(pr.nextDouble() < 0.1)
                     {
                        Temp[i][j] = 1;
                        try
                        {
                           Temp[i + 1][j] = 1;
                        }
                        catch(error:*)
                        {
                           trace("ERROR CONTROLED");
                        }
                        try
                        {
                           Temp[i - 1][j] = 1;
                        }
                        catch(error:*)
                        {
                           trace("ERROR CONTROLED");
                        }
                        try
                        {
                           Temp[i][j + 1] = 1;
                        }
                        catch(error:*)
                        {
                           trace("ERROR CONTROLED");
                        }
                        try
                        {
                           Temp[i][j - 1] = 1;
                        }
                        catch(error:*)
                        {
                           trace("ERROR CONTROLED");
                        }
                        cristalcount = (cristalcount + 1) % 6;
                        t = cristalcount;
                        if(t == 0)
                        {
                           mc = new BkgCristal1();
                        }
                        else if(t == 1)
                        {
                           mc = new BkgCristal2();
                        }
                        else if(t == 2)
                        {
                           mc = new BkgCristal3();
                        }
                        else if(t == 3)
                        {
                           mc = new BkgCristal4();
                        }
                        else if(t == 4)
                        {
                           mc = new BkgCristal5();
                        }
                        else if(t == 5)
                        {
                           mc = new BkgCristal6();
                        }
                        mc.rotation = rot;
                        mc.y = i * 20;
                        mc.x = j * 20;
                        graph.addChild(mc);
                     }
                  }
               }
               j++;
            }
            i++;
         }
         return graph;
      }
      
      public function addToMechanism(param1:Number, param2:Object) : *
      {
         if(this.myMechanisms[param1] is Mechanism)
         {
            this.myMechanisms[param1].addDevice(param2);
         }
         else
         {
            this.myMechanisms[param1] = new Mechanism(param1);
            this.myMechanisms[param1].master = this;
            this.myMechanisms[param1].addDevice(param2);
         }
      }
      
      public function CreatePusher(param1:b2Vec2, param2:Number, param3:Number, param4:Number) : *
      {
         var _loc5_:b2Vec2 = null;
         var _loc6_:b2PrismaticJointDef = null;
         var _loc7_:b2BodyDef = null;
         var _loc8_:b2PolygonDef = null;
         var _loc9_:b2Body = null;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         _loc5_ = new b2Vec2(0,1);
         _loc6_ = new b2PrismaticJointDef();
         this.disableGround(param1.x,param1.y);
         (_loc7_ = new b2BodyDef()).userData = new ButtonBox();
         _loc7_.userData.cacheAsBitmap = true;
         _loc7_.position.Set(param1.x,param1.y);
         _loc7_.userData.name = "button";
         _loc7_.userData.index = param2;
         _loc10_ = new lightpoint_3();
         this.setTintFromInt(_loc10_,param4);
         _loc7_.userData.addChild(_loc10_);
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
         (_loc11_ = new ButtonMask()).x = _loc7_.position.x * 20;
         _loc11_.y = _loc7_.position.y * 20;
         _loc7_.userData.mask = _loc11_;
         (_loc12_ = new ButtonPlants()).x = _loc7_.position.x * 20;
         _loc12_.y = _loc7_.position.y * 20;
         addChild(_loc7_.userData);
         addChild(_loc11_);
         addChild(_loc12_);
         _loc6_.Initialize(_loc9_,this.m_world.GetGroundBody(),_loc9_.GetWorldCenter(),_loc5_);
         _loc6_.lowerTranslation = -1 / 3;
         _loc6_.upperTranslation = 0.1;
         _loc6_.enableLimit = true;
         _loc6_.motorSpeed = 1;
         _loc6_.maxMotorForce = 1;
         _loc6_.enableMotor = true;
         _loc6_.userData = _loc9_;
         _loc7_.userData.oldObject = this.m_world.CreateJoint(_loc6_);
         _loc7_.userData.type = "pusher";
         this.addToMechanism(param2,_loc7_.userData);
      }
      
      public function CreateTimedPusher(param1:Number, param2:Number, param3:b2Vec2, param4:Number, param5:Number) : *
      {
         var _loc6_:b2Vec2 = null;
         var _loc7_:b2PrismaticJointDef = null;
         var _loc8_:b2BodyDef = null;
         var _loc9_:b2PolygonDef = null;
         var _loc10_:b2Body = null;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc15_:* = undefined;
         _loc6_ = new b2Vec2(0,1);
         _loc7_ = new b2PrismaticJointDef();
         this.disableGround(param3.x,param3.y);
         (_loc8_ = new b2BodyDef()).userData = new TimedButtonBox();
         _loc8_.userData.cacheAsBitmap = true;
         _loc8_.position.Set(param3.x,param3.y);
         _loc8_.userData.name = "button";
         _loc11_ = new lightpoint_3();
         this.setTintFromInt(_loc11_,param2);
         _loc8_.userData.addChild(_loc11_);
         _loc8_.userData.anchorx = param3.x;
         _loc8_.userData.anchory = param3.y - 2;
         _loc8_.userData.originx = param3.x;
         _loc8_.userData.originy = param3.y;
         _loc10_ = this.m_world.CreateBody(_loc8_);
         (_loc9_ = new b2PolygonDef()).SetAsOrientedBox(0.5,0.4,new b2Vec2(0,0.6));
         _loc9_.restitution = 0;
         _loc9_.friction = 0;
         _loc9_.density = 0.001;
         _loc9_.filter.groupIndex = -8;
         _loc10_.CreateShape(_loc9_);
         (_loc9_ = new b2PolygonDef()).vertexCount = 3;
         _loc9_.vertices[0].Set(-1,1);
         _loc9_.vertices[1].Set(-0.5,0.2);
         _loc9_.vertices[2].Set(-0.5,1);
         _loc9_.friction = 0;
         _loc9_.density = 0.001;
         _loc9_.filter.groupIndex = -8;
         _loc10_.CreateShape(_loc9_);
         (_loc9_ = new b2PolygonDef()).vertexCount = 3;
         _loc9_.vertices[0].Set(0.5,0.2);
         _loc9_.vertices[1].Set(1,1);
         _loc9_.vertices[2].Set(0.5,1);
         _loc9_.friction = 0;
         _loc9_.density = 0.001;
         _loc9_.filter.groupIndex = -8;
         _loc10_.CreateShape(_loc9_);
         _loc10_.SetMassFromShapes();
         (_loc12_ = new ButtonMask()).x = _loc8_.position.x * 20;
         _loc12_.y = _loc8_.position.y * 20;
         _loc8_.userData.mask = _loc12_;
         (_loc13_ = new ButtonPlants()).x = _loc8_.position.x * 20;
         _loc13_.y = _loc8_.position.y * 20;
         addChild(_loc8_.userData);
         addChild(_loc12_);
         addChild(_loc13_);
         (_loc14_ = new TimedBase()).x = param3.x * 20;
         _loc14_.y = param3.y * 20;
         _loc15_ = new ll33();
         this.setTintFromInt(_loc15_,param2);
         _loc15_.rotation = 180;
         _loc15_.width = 35.9;
         _loc15_.height = 4.7;
         _loc15_.y = 13.5;
         _loc14_.addChild(_loc15_);
         _loc15_ = new lever_base_light_3();
         this.setTintFromInt(_loc15_,param2);
         _loc15_.rotation = 180;
         _loc15_.mask = _loc14_.msk;
         _loc15_.y = 13.5;
         _loc15_.width = 35;
         _loc15_.height = 4.2;
         _loc14_.addChild(_loc15_);
         this.DiamondsandRopes.addChild(_loc14_);
         _loc7_.Initialize(_loc10_,this.m_world.GetGroundBody(),_loc10_.GetWorldCenter(),_loc6_);
         _loc7_.lowerTranslation = -1 / 3;
         _loc7_.upperTranslation = 0.1;
         _loc7_.enableLimit = true;
         _loc7_.motorSpeed = 1;
         _loc7_.maxMotorForce = 1;
         _loc7_.enableMotor = true;
         _loc7_.userData = _loc10_;
         _loc7_.userData.GetUserData().Time = 0;
         _loc7_.userData.GetUserData().delayTime = param5 * 40;
         _loc7_.userData.GetUserData().base = _loc14_;
         _loc8_.userData.oldObject = this.m_world.CreateJoint(_loc7_);
         _loc8_.userData.type = "timedPusher";
         this.addToMechanism(param1,_loc8_.userData);
      }
      
      public function CreateMirrorSlider(param1:Number, param2:Number, param3:b2Vec2, param4:Number, param5:Number) : *
      {
         var _loc6_:b2Vec2 = null;
         var _loc7_:b2PrismaticJointDef = null;
         var _loc8_:b2BodyDef = null;
         var _loc9_:* = undefined;
         var _loc10_:b2Body = null;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         trace("DSAFSD" + param1 + " " + param2 + " " + param3 + " " + param4 + " " + param5);
         _loc6_ = new b2Vec2(1,0);
         _loc7_ = new b2PrismaticJointDef();
         (_loc8_ = new b2BodyDef()).userData = new SliderLever();
         _loc8_.userData.cacheAsBitmap = true;
         _loc8_.position.Set(param3.x,param3.y);
         _loc8_.userData.name = "button";
         _loc8_.userData.shift = param5 * Math.PI / 180;
         _loc11_ = new lever_light_3();
         this.setTintFromInt(_loc11_,param2);
         _loc11_.y = 11.15;
         _loc8_.userData.addChild(_loc11_);
         _loc8_.userData.originx = param3.x;
         _loc8_.userData.originy = param3.y;
         _loc8_.userData.length = param4;
         _loc10_ = this.m_world.CreateBody(_loc8_);
         (_loc12_ = new SliderHole()).x = param3.x * 20;
         _loc12_.y = param3.y * 20;
         addChild(_loc12_);
         _loc11_ = new lightpoint_3();
         this.setTintFromInt(_loc11_,param2);
         _loc11_.rotation = 90;
         _loc11_.y = 1.6;
         _loc11_.x = 108.15;
         _loc12_.addChild(_loc11_);
         _loc11_ = new lightpoint_3();
         this.setTintFromInt(_loc11_,param2);
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
         _loc7_.lowerTranslation = -param4;
         _loc7_.upperTranslation = param4;
         _loc7_.enableLimit = true;
         _loc7_.motorSpeed = 0;
         _loc7_.maxMotorForce = 1;
         _loc7_.enableMotor = true;
         _loc7_.userData = _loc10_;
         _loc8_.userData.oldObject = this.m_world.CreateJoint(_loc7_);
         _loc8_.userData.type = "mirrorSlider";
         this.addToMechanism(param1,_loc8_.userData);
      }
      
      public function CreateInfiniteMirror(param1:Number, param2:Number, param3:b2Vec2, param4:Number) : *
      {
         var _loc5_:b2BodyDef = null;
         var _loc6_:* = undefined;
         var _loc7_:b2Body = null;
         var _loc10_:b2RevoluteJointDef = null;
         var _loc11_:Sprite = null;
         var _loc12_:* = undefined;
         var _loc8_:* = 0;
         var _loc9_:* = 180;
         _loc10_ = new b2RevoluteJointDef();
         (_loc5_ = new b2BodyDef()).userData = new RotMirrorInfinite();
         _loc5_.userData.cacheAsBitmap = true;
         _loc5_.userData.name = "rot";
         _loc11_ = new rot_mirror_light_3();
         this.setTintFromInt(_loc11_,param2);
         _loc11_.name = "light";
         _loc5_.userData.bar.addChild(_loc11_);
         _loc5_.position.Set(param3.x,param3.y);
         _loc7_ = this.m_world.CreateBody(_loc5_);
         this.SlidersAndRots.addChild(_loc5_.userData);
         _loc12_ = new Array();
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
         _loc7_.SetXForm(_loc7_.GetPosition(),-param4);
         _loc10_.enableLimit = true;
         _loc10_.maxMotorTorque = 500;
         _loc10_.motorSpeed = 0;
         _loc10_.enableMotor = true;
         _loc10_.userData = _loc7_;
         var _loc13_:* = 0;
         _loc5_.userData.oldObject = this.m_world.CreateJoint(_loc10_);
         _loc5_.userData.type = "infiniteMirror";
         this.addToMechanism(param1,_loc5_.userData);
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
      
      public function CreateSlidePlatform(param1:Number, param2:Number, param3:b2Vec2, param4:Number, param5:Number, param6:b2Vec2, param7:Number) : *
      {
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:b2Vec2 = null;
         var _loc11_:b2BodyDef = null;
         var _loc12_:b2PolygonDef = null;
         var _loc13_:b2Body = null;
         var _loc14_:b2PrismaticJointDef = null;
         var _loc15_:Sprite = null;
         _loc8_ = param5 / 2;
         _loc9_ = 0.5;
         _loc10_ = param6;
         _loc14_ = new b2PrismaticJointDef();
         (_loc11_ = new b2BodyDef()).userData = new Platform1();
         _loc11_.userData.cacheAsBitmap = true;
         _loc11_.userData.name = "slide";
         _loc11_.userData.index = param1;
         _loc15_ = new light_off_3();
         this.setTintFromInt(_loc15_,param2);
         _loc11_.userData.bar.addChild(_loc15_);
         _loc15_ = _loc15_ = new light_on_3();
         this.setTintFromInt(_loc15_,param2);
         _loc15_.name = "light";
         _loc15_.visible = false;
         _loc11_.userData.bar.addChild(_loc15_);
         if(_loc8_ > _loc9_)
         {
            _loc11_.userData.bar.rotation = 90;
            _loc11_.userData.bar.scaleX = _loc9_ * 40 / 20;
            _loc11_.userData.bar.scaleY = _loc8_ * 40 / 80;
         }
         else
         {
            _loc11_.userData.bar.scaleX = _loc8_ * 40 / 20;
            _loc11_.userData.bar.scaleY = _loc9_ * 40 / 80;
         }
         _loc11_.position.Set(param3.x,param3.y);
         _loc13_ = this.m_world.CreateBody(_loc11_);
         _loc13_.SetXForm(_loc13_.GetPosition(),param4 * Math.PI / 180);
         this.SlidersAndRots.addChild(_loc11_.userData);
         (_loc12_ = new b2PolygonDef()).SetAsOrientedBox(_loc8_,_loc9_ * 0.8,new b2Vec2(0,0),0);
         _loc12_.friction = 0.3;
         _loc12_.density = 0.3;
         _loc12_.filter.groupIndex = -8;
         _loc13_.CreateShape(_loc12_);
         this.CreateLightBody(_loc13_,_loc11_,new Array(_loc12_));
         _loc13_.SetMassFromShapes();
         _loc14_.Initialize(_loc13_,this.m_world.GetGroundBody(),_loc13_.GetWorldCenter(),_loc10_);
         _loc14_.lowerTranslation = -param7;
         _loc14_.upperTranslation = 0;
         _loc14_.enableLimit = true;
         _loc14_.motorSpeed = 2;
         _loc14_.maxMotorForce = 500;
         _loc14_.enableMotor = true;
         _loc14_.userData = _loc13_;
         _loc11_.userData.oldObject = this.m_world.CreateJoint(_loc14_);
         _loc11_.userData.type = "slidePlatform";
         this.addToMechanism(param1,_loc11_.userData);
      }
      
      public function CreateLever(param1:b2Vec2, param2:Number, param3:Number, param4:String, param5:String) : *
      {
         var _loc6_:b2BodyDef = null;
         var _loc7_:b2PolygonDef = null;
         var _loc8_:b2Body = null;
         var _loc9_:b2RevoluteJointDef = null;
         var _loc10_:Sprite = null;
         var _loc11_:* = undefined;
         this.disableGround(param1.x,param1.y);
         _loc9_ = new b2RevoluteJointDef();
         (_loc6_ = new b2BodyDef()).userData = new LeverMc();
         _loc6_.userData.cacheAsBitmap = true;
         _loc6_.userData.name = "platform";
         _loc10_ = new lever_light_3();
         this.setTintFromInt(_loc10_,param3);
         _loc10_.name = "light";
         _loc6_.userData.addChild(_loc10_);
         _loc6_.position.Set(param1.x,param1.y);
         _loc8_ = this.m_world.CreateBody(_loc6_);
         this.DiamondsandRopes.addChild(_loc6_.userData);
         (_loc11_ = new LeverBase()).x = param1.x * 20;
         _loc11_.y = param1.y * 20;
         _loc10_ = new lever_base_light_3();
         this.setTintFromInt(_loc10_,param3);
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
         if(param5 == "r")
         {
            _loc9_.userData.GetUserData().onis = "l";
         }
         else if(param5 == "l")
         {
            _loc9_.userData.GetUserData().onis = "r";
         }
         if(param4 == "r")
         {
            _loc8_.SetXForm(_loc8_.GetPosition(),-0.5 * b2Settings.b2_pi);
         }
         else if(param4 == "l")
         {
            _loc8_.SetXForm(_loc8_.GetPosition(),0.5 * b2Settings.b2_pi);
         }
         _loc6_.userData.oldObject = this.m_world.CreateJoint(_loc9_);
         _loc6_.userData.type = "lever";
         this.addToMechanism(param2,_loc6_.userData);
      }
      
      public function CreateLightPusher(param1:Number, param2:Number, param3:b2Vec2, param4:Number) : *
      {
         var _loc5_:b2BodyDef = null;
         var _loc6_:b2PolygonDef = null;
         var _loc7_:b2Body = null;
         var _loc8_:* = undefined;
         this.disableGround(param3.x,param3.y);
         (_loc5_ = new b2BodyDef()).userData = new LightPusher();
         _loc5_.userData.cacheAsBitmap = true;
         _loc5_.position.Set(param3.x,param3.y);
         _loc5_.userData.name = "LightPusher";
         _loc5_.userData.color = param2;
         if(param2 == 5)
         {
            _loc8_ = new ll5();
         }
         else
         {
            _loc8_ = new ll6();
         }
         _loc8_.y = 11.7;
         _loc8_.x = 0.55;
         _loc8_.scaleX = 1.2;
         _loc8_.scaleY = -1.04;
         _loc8_.cacheAsBitmap = true;
         _loc5_.userData.addChild(_loc8_);
         if(param2 == 5)
         {
            _loc8_ = new lightpoint_52();
         }
         else
         {
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
         _loc5_.userData.oldObject = _loc5_.userData;
         _loc5_.userData.type = "lightPusher";
         this.addToMechanism(param1,_loc5_.userData);
         this.CreateLightBody(_loc7_,_loc5_,new Array(_loc6_));
         _loc7_.SetXForm(param3,param4 * Math.PI / 180);
         _loc7_.SetMassFromShapes();
      }
      
      public function CreateRotMirror(param1:Number, param2:Number, param3:b2Vec2, param4:Number) : *
      {
         var _loc5_:b2BodyDef = null;
         var _loc6_:* = undefined;
         var _loc7_:b2Body = null;
         var _loc8_:b2RevoluteJointDef = null;
         var _loc9_:Sprite = null;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         _loc8_ = new b2RevoluteJointDef();
         (_loc5_ = new b2BodyDef()).userData = new RotMirror();
         _loc5_.userData.cacheAsBitmap = true;
         _loc5_.userData.name = "rot";
         _loc9_ = new rot_mirror_light_3();
         this.setTintFromInt(_loc9_,param2);
         _loc9_.name = "light";
         _loc5_.userData.bar.addChild(_loc9_);
         _loc5_.position.Set(param3.x,param3.y);
         _loc7_ = this.m_world.CreateBody(_loc5_);
         this.SlidersAndRots.addChild(_loc5_.userData);
         _loc10_ = new Array();
         (_loc6_ = new b2PolygonDef()).filter.groupIndex = -1;
         _loc6_.SetAsOrientedBox(0.9,1 / 20,new b2Vec2(0,0),Math.PI / 4);
         _loc6_.density = 0.5;
         _loc6_.restitution = 1;
         _loc6_.friction = 0;
         _loc10_.push(_loc6_);
         _loc7_.GetUserData().mirror = true;
         (_loc6_ = new b2PolygonDef()).filter.groupIndex = -1;
         _loc6_.SetAsOrientedBox(0.2,0.2,new b2Vec2(-0.9,-0.9),Math.PI / 4);
         _loc6_.density = 0.5;
         _loc6_.restitution = 0;
         _loc6_.friction = 1;
         _loc10_.push(_loc6_);
         (_loc6_ = new b2PolygonDef()).filter.groupIndex = -1;
         _loc6_.SetAsOrientedBox(0.2,0.2,new b2Vec2(0.9,0.9),Math.PI / 4);
         _loc6_.density = 0.5;
         _loc6_.restitution = 0;
         _loc6_.friction = 1;
         _loc10_.push(_loc6_);
         (_loc6_ = new b2PolygonDef()).filter.groupIndex = -1;
         _loc6_.SetAsOrientedBox(0.2,0.2,new b2Vec2(0.9,-0.9),Math.PI / 4);
         _loc6_.density = 0.5;
         _loc6_.restitution = 0;
         _loc6_.friction = 1;
         _loc10_.push(_loc6_);
         (_loc6_ = new b2PolygonDef()).filter.groupIndex = -1;
         _loc6_.SetAsOrientedBox(0.2,0.2,new b2Vec2(-0.9,0.9),Math.PI / 4);
         _loc6_.density = 0.5;
         _loc6_.restitution = 0;
         _loc6_.friction = 1;
         _loc10_.push(_loc6_);
         this.CreateLightBody(_loc7_,_loc5_,_loc10_);
         (_loc6_ = new b2PolygonDef()).SetAsOrientedBox(1,1,new b2Vec2(0,0),0);
         _loc6_.friction = 0.3;
         _loc6_.density = 20;
         _loc6_.filter.groupIndex = -8;
         _loc7_.CreateShape(_loc6_);
         _loc7_.SetXForm(param3,param4 * Math.PI / 180);
         if(param1 != -1)
         {
            _loc7_.SetMassFromShapes();
            _loc8_.Initialize(_loc7_,this.m_world.GetGroundBody(),new b2Vec2(_loc7_.GetWorldCenter().x,_loc7_.GetWorldCenter().y));
            _loc8_.lowerAngle = 0;
            _loc8_.upperAngle = Math.PI / 2;
            _loc8_.enableLimit = true;
            _loc8_.maxMotorTorque = 500;
            _loc8_.motorSpeed = -2;
            _loc8_.enableMotor = true;
            _loc8_.userData = _loc7_;
            _loc11_ = 0;
            trace("ORI " + param4 + " SHIFT " + _loc5_.userData.shift);
            _loc5_.userData.shift = param4 * Math.PI / 180;
            _loc5_.userData.oldObject = this.m_world.CreateJoint(_loc8_);
            _loc5_.userData.type = "rotMirror";
            this.addToMechanism(param1,_loc5_.userData);
            trace("222ORI " + param4 + " SHIFT " + _loc5_.userData.shift);
         }
         if(_loc5_.userData)
         {
            this.myRotMirrorJoints.push(_loc5_.userData);
         }
      }
      
      public function CreateMovingBox(param1:b2Vec2) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:b2BodyDef = null;
         var _loc4_:b2PolygonDef = null;
         var _loc5_:b2Body = null;
         var _loc6_:b2CircleDef = null;
         _loc2_ = new b2Vec2(0.95,0.95);
         _loc3_ = new b2BodyDef();
         _loc3_.userData = new MovingBox();
         _loc3_.userData.cacheAsBitmap = true;
         _loc3_.userData.name = "box";
         _loc3_.position.Set(param1.x,param1.y);
         _loc3_.linearDamping = 2;
         _loc3_.angularDamping = 2;
         this.CharsLayer.addChild(_loc3_.userData);
         _loc5_ = this.m_world.CreateBody(_loc3_);
         (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc2_.x,_loc2_.y,new b2Vec2(0,0),0);
         _loc4_.friction = 0.05;
         _loc4_.density = 0.3;
         _loc4_.userData = "box";
         _loc4_.restitution = 0;
         _loc5_.CreateShape(_loc4_);
         (_loc6_ = new b2CircleDef()).radius = 0.1;
         _loc6_.density = 0.01;
         _loc6_.friction = 0.2;
         _loc6_.restitution = 0;
         _loc6_.localPosition.Set(0,0);
         _loc6_.filter.groupIndex = -3;
         _loc6_.filter.categoryBits = 4096;
         _loc6_.filter.maskBits = 4096;
         _loc5_.CreateShape(_loc6_);
         this.CreateLightBody(_loc5_,_loc3_,new Array(_loc4_));
         _loc5_.SetMassFromShapes();
         _loc5_.GetUserData().mass = _loc5_.GetMass();
         _loc5_.GetUserData().waterCC = null;
      }
      
      public function CreateMovingBox2(param1:b2Vec2) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:b2BodyDef = null;
         var _loc4_:b2PolygonDef = null;
         var _loc5_:b2Body = null;
         var _loc6_:b2CircleDef = null;
         _loc2_ = new b2Vec2(0.95,0.95);
         _loc3_ = new b2BodyDef();
         _loc3_.userData = new MovingBox2();
         _loc3_.userData.cacheAsBitmap = true;
         _loc3_.userData.name = "box";
         _loc3_.position.Set(param1.x,param1.y);
         _loc3_.linearDamping = 2;
         _loc3_.angularDamping = 2;
         this.CharsLayer.addChild(_loc3_.userData);
         _loc5_ = this.m_world.CreateBody(_loc3_);
         (_loc4_ = new b2PolygonDef()).SetAsOrientedBox(_loc2_.x,_loc2_.y,new b2Vec2(0,0),0);
         _loc4_.friction = 0.05;
         _loc4_.density = 0.7;
         _loc4_.userData = new Object();
         _loc4_.userData.name = "box";
         _loc4_.restitution = 0;
         _loc5_.CreateShape(_loc4_);
         (_loc6_ = new b2CircleDef()).radius = 0.1;
         _loc6_.density = 0.01;
         _loc6_.friction = 0.2;
         _loc6_.restitution = 0;
         _loc6_.localPosition.Set(0,0);
         _loc6_.filter.groupIndex = -3;
         _loc6_.filter.categoryBits = 4096;
         _loc6_.filter.maskBits = 4096;
         _loc5_.CreateShape(_loc6_);
         this.CreateLightBody(_loc5_,_loc3_,new Array(_loc4_));
         _loc5_.GetUserData().mass = _loc5_.GetMass();
         _loc5_.GetUserData().waterCC = null;
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
      
      public function CreateHangingPlatform(param1:b2Vec2, param2:b2Vec2, param3:Number) : *
      {
         var _loc4_:b2BodyDef = null;
         var _loc5_:b2PolygonDef = null;
         var _loc6_:b2Body = null;
         var _loc7_:b2Body = null;
         var _loc8_:* = undefined;
         var _loc9_:b2DistanceJointDef = null;
         (_loc4_ = new b2BodyDef()).userData = new PlatformBox();
         _loc4_.userData.width = param2.x * 40;
         _loc4_.userData.height = param2.y * 40;
         _loc4_.position.Set(param1.x,param1.y + param3);
         _loc6_ = this.m_world.CreateBody(_loc4_);
         addChild(_loc4_.userData);
         _loc8_ = new Rope();
         _loc4_.userData.rope = _loc8_;
         _loc4_.userData.anchor = param1;
         _loc4_.userData.name = "HangingPlatform";
         _loc8_.ropeMask.height = param3 * 20;
         _loc8_.cacheAsBitmap = true;
         _loc8_.x = param1.x * 20;
         _loc8_.y = param1.y * 20;
         this.DiamondsandRopes.addChild(_loc8_);
         (_loc5_ = new b2PolygonDef()).SetAsOrientedBox(param2.x,param2.y,new b2Vec2(0,0),0);
         _loc5_.friction = 0.3;
         _loc5_.density = 1.5;
         _loc6_.CreateShape(_loc5_);
         _loc6_.SetMassFromShapes();
         (_loc9_ = new b2DistanceJointDef()).Initialize(_loc6_,this.m_world.GetGroundBody(),_loc6_.GetWorldCenter(),new b2Vec2(param1.x,param1.y));
         _loc9_.collideConnected = true;
         this.m_world.CreateJoint(_loc9_);
      }
      
      public function CreateWind(param1:Number, param2:Number, param3:b2Vec2, param4:b2Vec2, param5:b2Vec2, param6:Number) : *
      {
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:Sprite = null;
         _loc7_ = new b2Vec2(param4.x + param3.x,param4.y + param3.y);
         _loc8_ = new b2Vec2(param5.x + param3.x,param5.y + param3.y);
         (_loc9_ = new Object()).lower = _loc7_;
         _loc9_.upper = _loc8_;
         _loc9_.vertical = param6;
         _loc9_.on = true;
         (_loc10_ = new Wind()).cacheAsBitmap = true;
         _loc10_.width = (_loc8_.x - _loc7_.x) * 20;
         _loc10_.height = (_loc8_.y - _loc7_.y) * 20;
         if(param6 == 1)
         {
            _loc10_.width += 30;
         }
         if(param6 == 2)
         {
            _loc10_.insideWind.rotation = 90;
            _loc10_.height += 30;
         }
         if(param6 == 3)
         {
            _loc10_.insideWind.rotation = 180;
            _loc10_.width += 30;
         }
         if(param6 == 4)
         {
            _loc10_.insideWind.rotation = 270;
            _loc10_.height += 30;
         }
         _loc9_.winder = _loc10_;
         _loc10_.x = (_loc7_.x + (_loc8_.x - _loc7_.x) / 2) * 20;
         _loc10_.y = (_loc7_.y + (_loc8_.y - _loc7_.y) / 2) * 20;
         addChild(_loc10_);
         (_loc10_ = new WindMaker()).cacheAsBitmap = true;
         _loc9_.mc = _loc10_;
         this.myWinds.push(_loc9_);
         _loc11_ = new light_off_3();
         this.setTintFromInt(_loc11_,param2);
         _loc10_.addChild(_loc11_);
         _loc11_.x = -1;
         _loc11_.y = 4.5;
         _loc11_.width = 4.5;
         _loc11_.height = 50;
         _loc11_.rotation = 90;
         if(param1 != -1)
         {
            _loc9_.on = false;
            _loc11_ = new light_on_3();
            this.setTintFromInt(_loc11_,param2);
            _loc11_.x = -1;
            _loc11_.y = 4.5;
            _loc11_.width = 4.5;
            _loc11_.height = 50;
            _loc11_.rotation = 90;
            _loc11_.name = "light";
            _loc10_.addChild(_loc11_);
            _loc10_.oldObject = _loc9_;
            _loc10_.type = "wind";
            this.addToMechanism(param1,_loc10_);
         }
         else
         {
            _loc11_.name = "light";
         }
         if(param6 == 1)
         {
            _loc10_.x = (_loc7_.x + (_loc8_.x - _loc7_.x) / 2) * 20;
            _loc10_.y = (_loc7_.y + (_loc8_.y - _loc7_.y)) * 20;
         }
         if(param6 == 2)
         {
            _loc10_.x = _loc7_.x * 20;
            _loc10_.y = (_loc7_.y + (_loc8_.y - _loc7_.y) / 2) * 20;
            _loc10_.rotation = 90;
         }
         if(param6 == 3)
         {
            _loc10_.x = (_loc7_.x + (_loc8_.x - _loc7_.x) / 2) * 20;
            _loc10_.y = _loc7_.y * 20;
            _loc10_.rotation = 180;
         }
         if(param6 == 4)
         {
            _loc10_.x = _loc8_.x * 20;
            _loc10_.y = (_loc7_.y + (_loc8_.y - _loc7_.y) / 2) * 20;
            _loc10_.rotation = 270;
         }
         this.DiamondsandRopes.addChild(_loc10_);
      }
      
      public function CreateBall(param1:b2Vec2) : *
      {
         var _loc2_:b2BodyDef = null;
         var _loc3_:b2CircleDef = null;
         var _loc4_:* = undefined;
         _loc2_ = new b2BodyDef();
         _loc2_.userData = new Ball();
         _loc2_.position.Set(param1.x,param1.y);
         _loc2_.userData.name = "box";
         _loc4_ = this.m_world.CreateBody(_loc2_);
         this.CharsLayer.addChild(_loc2_.userData);
         _loc3_ = new b2CircleDef();
         _loc3_.radius = 0.47;
         _loc3_.restitution = 0.1;
         _loc3_.friction = 0.2;
         _loc3_.density = 1.9;
         _loc3_.userData = "box";
         _loc4_.CreateShape(_loc3_);
         _loc3_ = new b2CircleDef();
         _loc3_.radius = 0.1;
         _loc3_.density = 0.01;
         _loc3_.friction = 0.2;
         _loc3_.restitution = 0;
         _loc3_.localPosition.Set(0,0);
         _loc3_.filter.groupIndex = -3;
         _loc3_.filter.categoryBits = 4096;
         _loc3_.filter.maskBits = 4096;
         _loc4_.CreateShape(_loc3_);
         _loc4_.GetUserData().mass = _loc4_.GetMass();
         _loc4_.GetUserData().waterCC = null;
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
      
      public function CreateIceBlock(param1:b2Vec2, param2:b2Vec2, param3:Number, param4:* = true) : *
      {
         var _loc5_:* = undefined;
         var _loc6_:b2BodyDef = null;
         var _loc7_:b2PolygonDef = null;
         var _loc8_:b2Body = null;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         _loc5_ = false;
         if(param4 == false)
         {
            param1.y -= 0.02;
         }
         (_loc6_ = new b2BodyDef()).userData = new MovieClip();
         _loc9_ = new MovieClip();
         _loc10_ = 2 * param2.x;
         var _loc11_:* = 0;
         _loc12_ = 0;
         while(_loc12_ < _loc10_)
         {
            if(_loc12_ == 0)
            {
               _loc13_ = new iceCubeTri();
            }
            else if(_loc12_ == _loc10_ - 1)
            {
               (_loc13_ = new iceCubeTri()).scaleX = -1;
            }
            else
            {
               _loc13_ = new iceCube();
               if(Math.random() < 0.5)
               {
                  _loc13_.rays.rotation = 180;
               }
            }
            _loc13_.x = -20 * (_loc10_ / 2 - 0.5) + _loc12_ * 20;
            _loc13_.cacheAsBitmap = true;
            _loc9_.addChild(_loc13_);
            _loc12_++;
         }
         _loc9_.cacheAsBitmap = true;
         _loc6_.userData.name = "ice";
         if(_loc5_ == true)
         {
            (_loc14_ = new Sprite()).graphics.beginFill(16776960,0.5);
            _loc14_.graphics.drawRect(-20 * param2.x,-10,40 * param2.x,20);
            _loc14_.x = param1.x * 20;
            _loc14_.y = param1.y * 20;
            _loc14_.rotation = param3 * 180 / Math.PI;
            this.FiresandWaters.addChild(_loc14_);
         }
         _loc6_.position = param1;
         _loc8_ = this.m_world.CreateBody(_loc6_);
         (_loc7_ = new b2PolygonDef()).SetAsOrientedBox(param2.x,param2.y,new b2Vec2(0,0),param3);
         _loc7_.userData = "fjdksal";
         _loc7_.density = 0;
         _loc8_.CreateShape(_loc7_);
         _loc8_.SetMassFromShapes();
         _loc9_.body = _loc8_;
         _loc9_.bodyDef = _loc6_;
         _loc9_.boxDef = _loc7_;
         return _loc9_;
      }
      
      public function CreateRoman(param1:b2Vec2, param2:Number, param3:Number, param4:String) : *
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
      
      public function CreateMovingMirror(param1:b2Vec2, param2:Number) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:b2BodyDef = null;
         var _loc5_:b2PolygonDef = null;
         var _loc6_:b2Body = null;
         var _loc7_:b2CircleDef = null;
         _loc3_ = new b2Vec2(0.95,0.95);
         (_loc4_ = new b2BodyDef()).userData = new MovingMirror();
         _loc4_.userData.cacheAsBitmap = true;
         _loc4_.userData.name = "box";
         _loc4_.position.Set(param1.x,param1.y);
         _loc4_.angle = param2 / 180 * Math.PI;
         _loc4_.linearDamping = 2;
         _loc4_.angularDamping = 2;
         addChild(_loc4_.userData);
         _loc6_ = this.m_world.CreateBody(_loc4_);
         (_loc5_ = new b2PolygonDef()).filter.groupIndex = -1;
         _loc5_.SetAsOrientedBox(0.9,1 / 20,new b2Vec2(0,0),Math.PI / 4);
         _loc5_.density = 0;
         _loc5_.restitution = 1;
         _loc5_.friction = 0;
         _loc6_.GetUserData().mirror = true;
         this.CreateLightBody(_loc6_,_loc4_,new Array(_loc5_));
         (_loc5_ = new b2PolygonDef()).SetAsOrientedBox(_loc3_.x,_loc3_.y,new b2Vec2(0,0),0);
         _loc5_.userData = "box";
         _loc5_.friction = 0.05;
         _loc5_.density = 0.3;
         _loc6_.CreateShape(_loc5_);
         (_loc7_ = new b2CircleDef()).radius = 0.1;
         _loc7_.density = 0.01;
         _loc7_.friction = 0.2;
         _loc7_.restitution = 0;
         _loc7_.localPosition.Set(0,0);
         _loc7_.filter.groupIndex = -3;
         _loc7_.filter.categoryBits = 4096;
         _loc7_.filter.maskBits = 4096;
         _loc6_.CreateShape(_loc7_);
         _loc6_.GetUserData().mass = _loc6_.GetMass();
         _loc6_.GetUserData().waterCC = null;
         _loc6_.SetMassFromShapes();
      }
      
      public function CreateLightBeamer(param1:Number, param2:Number, param3:b2Vec2, param4:Number) : *
      {
         var _loc5_:b2BodyDef = null;
         var _loc6_:b2PolygonDef = null;
         var _loc7_:b2Body = null;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:Sprite = null;
         var _loc11_:* = undefined;
         param4 -= 90;
         this.disableGround(param3.x,param3.y);
         _loc5_ = new b2BodyDef();
         _loc9_ = (_loc8_ = new LightBeamer()).glower.transform.colorTransform;
         _loc10_ = new ll3();
         this.setTintFromInt(_loc10_,param2);
         _loc10_.x = -6.25;
         _loc10_.scaleX = 1.38;
         _loc10_.scaleY = 1.41;
         _loc10_.rotation = -90;
         _loc8_.addChild(_loc10_);
         if(param2 == 5)
         {
            _loc11_ = this.freezeColor;
         }
         else if(param2 == 4)
         {
            _loc11_ = this.meltColor;
         }
         else
         {
            _loc11_ = this.defaultColor;
         }
         _loc9_.color = _loc11_;
         _loc8_.glower.transform.colorTransform = _loc9_;
         _loc5_.userData = _loc8_;
         _loc5_.userData.name = "beamer";
         _loc8_.bullet = this.CreateBullet(new b2Vec2(param3.x,param3.y),new b2Vec2(0,0),param2);
         _loc8_.startPoint = new b2Vec2(param3.x - 0.3 * Math.cos(param4 * Math.PI / 180),param3.y - 0.3 * Math.sin(param4 * Math.PI / 180));
         _loc8_.color = param2;
         _loc5_.position.Set(param3.x,param3.y);
         this.DiamondsandRopes.addChild(_loc5_.userData);
         _loc7_ = this.m_world.CreateBody(_loc5_);
         (_loc6_ = new b2PolygonDef()).SetAsOrientedBox(0.3,1,new b2Vec2(-0.5,0),0);
         _loc6_.friction = 0.05;
         _loc6_.density = 0;
         _loc7_.CreateShape(_loc6_);
         _loc7_.SetXForm(new b2Vec2(param3.x,param3.y),param4 * Math.PI / 180);
         _loc7_.SetMassFromShapes();
         _loc8_.on = true;
         if(param1 != -1)
         {
            _loc8_.on = false;
            _loc8_.glower.visible = false;
            _loc8_.oldObject = _loc8_;
            _loc8_.type = "lightBeamer";
            this.addToMechanism(param1,_loc8_);
         }
      }
      
      public function CreatePortalPair(param1:Number, param2:Number, param3:b2Vec2, param4:Number, param5:b2Vec2, param6:Number, param7:Number, param8:Number = 0, param9:Number = 0) : void
      {
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:Boolean = false;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         _loc10_ = false;
         _loc11_ = false;
         if(param8 == 1)
         {
            _loc10_ = true;
         }
         if(param9 == 1)
         {
            _loc11_ = true;
         }
         _loc12_ = false;
         if(param7 == 1)
         {
            _loc12_ = true;
         }
         param4 = Math.PI * param4 / 180;
         param6 = Math.PI * param6 / 180;
         _loc13_ = this.CreatePortal(param3,param4,_loc12_,param2,true,_loc10_);
         _loc14_ = this.CreatePortal(param5,param6,_loc12_,param2,false,_loc11_);
         _loc13_.other = _loc14_;
         _loc14_.other = _loc13_;
         if(param1 != -1)
         {
            this.ClosePortalPair(_loc13_);
            this.myActuateds5.push(_loc13_);
            _loc13_.oldObject = _loc13_;
            _loc13_.type = "portal";
            this.addToMechanism(param1,_loc13_);
         }
         else
         {
            _loc13_.oldObject = _loc13_;
            _loc13_.type = "portal";
            this.addToMechanism(param1,_loc13_);
            this.OpenPortalPair(_loc13_,true);
         }
      }
      
      public function CreatePortal(param1:b2Vec2, param2:Number, param3:Boolean, param4:uint, param5:Boolean, param6:Boolean) : Object
      {
         var _loc7_:b2BodyDef = null;
         var _loc8_:b2PolygonDef = null;
         var _loc9_:b2Body = null;
         var _loc10_:* = undefined;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:ColorTransform = null;
         var _loc14_:Array = null;
         var _loc15_:Number = NaN;
         var _loc17_:* = undefined;
         _loc7_ = new b2BodyDef();
         (_loc10_ = new Portal()).Sides = new Sprite();
         this.disableGround(param1.x,param1.y);
         this.disableGround(param1.x - 1,param1.y);
         this.disableGround(param1.x + 1,param1.y);
         this.disableGround(param1.x,param1.y - 1);
         this.disableGround(param1.x,param1.y + 1);
         _loc10_.PortalLeft = new PortalSide();
         _loc10_.PortalRight = new PortalSide();
         Sprite(_loc10_.PortalRight).rotation = 180;
         _loc11_ = 16777215;
         _loc12_ = 0;
         if(!param3 && !param5)
         {
            _loc17_ = _loc11_;
            _loc11_ = _loc12_;
            _loc12_ = _loc17_;
         }
         (_loc13_ = new ColorTransform()).color = _loc12_;
         _loc10_.PortalRight.transform.colorTransform = _loc13_;
         _loc10_.PortalRight.filters = [new GlowFilter(_loc11_,1,8,8,2,1,false,false)];
         (_loc13_ = new ColorTransform()).color = _loc11_;
         _loc10_.PortalLeft.transform.colorTransform = _loc13_;
         _loc10_.PortalLeft.filters = [new GlowFilter(_loc12_,1,8,8,2,1,false,false)];
         _loc10_.PortalRight.gotoAndPlay(Math.floor(Math.random() * 100));
         _loc10_.PortalLeft.gotoAndPlay(Math.floor(Math.random() * 100));
         _loc10_.PortalRight.cacheAsBitmap = true;
         _loc10_.PortalLeft.cacheAsBitmap = true;
         _loc10_.PortalCenter.cacheAsBitmap = true;
         _loc10_.addChild(_loc10_.Sides);
         _loc10_.Sides.addChild(_loc10_.PortalRight);
         _loc10_.Sides.addChild(_loc10_.PortalLeft);
         if(!param3 && !param5)
         {
            _loc17_ = _loc11_;
            _loc11_ = _loc12_;
            _loc12_ = _loc17_;
         }
         if(!param3 && !param5)
         {
            _loc10_.PortalCenter.scaleX *= -1;
            _loc10_.PortalBase.scaleX *= -1;
         }
         _loc10_.setChildIndex(_loc10_.PortalBase,_loc10_.numChildren - 1);
         _loc10_.Light1 = new lever_light_3();
         _loc10_.Light1.gotoAndStop(2);
         this.setTintFromInt(_loc10_.Light1,param4);
         _loc10_.Light2 = new lever_light_3();
         _loc10_.Light2.gotoAndStop(2);
         this.setTintFromInt(_loc10_.Light2,param4);
         _loc10_.PortalBase.UpMC.CoverMC.LightContainer.addChild(_loc10_.Light1);
         _loc10_.PortalBase.DownMC.CoverMC.LightContainer.addChild(_loc10_.Light2);
         _loc7_.userData = _loc10_;
         _loc7_.userData.on = true;
         _loc7_.userData.working = true;
         _loc7_.userData.ori = param2;
         _loc7_.userData.inverted = param3;
         _loc7_.userData.selfInverted = param5;
         _loc7_.userData.forcedObjects = new Array();
         _loc7_.userData.maskedByR = new Array();
         _loc7_.userData.maskedByL = new Array();
         _loc7_.userData.inWall = param6;
         _loc7_.userData.name = "Portal";
         _loc7_.userData.other = null;
         this.myPortals.push(_loc7_.userData);
         _loc10_.color = param4;
         _loc7_.position.Set(param1.x,param1.y);
         this.PortalsLayer.addChild(_loc7_.userData);
         _loc9_ = this.m_world.CreateBody(_loc7_);
         _loc7_.userData.body = _loc9_;
         _loc14_ = new Array();
         _loc15_ = 3;
         var _loc16_:Number = 2;
         _loc10_.shapes = new Array();
         (_loc8_ = new b2PolygonDef()).SetAsOrientedBox(0.05,_loc15_ / 2,new b2Vec2(0,0),0);
         _loc8_.friction = 0.05;
         _loc8_.density = 0;
         _loc8_.filter.maskBits = 4096;
         _loc8_.filter.categoryBits = 4096;
         _loc8_.userData = "TransportSensor";
         _loc10_.shapes.push(_loc9_.CreateShape(_loc8_));
         (_loc8_ = new b2PolygonDef()).SetAsOrientedBox(0.02,_loc15_ / 2,new b2Vec2(0,0),0);
         _loc8_.friction = 0.05;
         _loc8_.density = 0;
         _loc8_.filter.maskBits = 4096;
         _loc8_.filter.categoryBits = 4096;
         _loc8_.userData = "wall";
         _loc10_.shapes.push(_loc9_.CreateShape(_loc8_));
         (_loc8_ = new b2PolygonDef()).SetAsOrientedBox(0.1,_loc15_ / 2,new b2Vec2(0,0),0);
         _loc8_.friction = 0.05;
         _loc8_.density = 0;
         _loc8_.userData = "TransportSensorLight";
         _loc8_.filter.maskBits = 4369;
         _loc8_.filter.categoryBits = 4369;
         _loc14_.push(_loc8_);
         (_loc8_ = new b2PolygonDef()).SetAsOrientedBox(1.5,2,new b2Vec2(-1.5,0),0);
         _loc8_.friction = 0.05;
         _loc8_.density = 0;
         _loc8_.isSensor = true;
         _loc8_.filter.maskBits = 4096;
         _loc8_.filter.categoryBits = 4096;
         _loc8_.userData = "MaskSensorR";
         _loc10_.shapes.push(_loc9_.CreateShape(_loc8_));
         _loc8_.filter.maskBits = 4369;
         _loc8_.filter.categoryBits = 4369;
         _loc14_.push(_loc8_);
         (_loc8_ = new b2PolygonDef()).SetAsOrientedBox(1.5,2,new b2Vec2(1.5,0),0);
         _loc8_.friction = 0.05;
         _loc8_.density = 0;
         _loc8_.isSensor = true;
         _loc8_.filter.maskBits = 4096;
         _loc8_.filter.categoryBits = 4096;
         _loc8_.userData = "MaskSensorL";
         _loc10_.shapes.push(_loc9_.CreateShape(_loc8_));
         _loc8_.filter.maskBits = 4369;
         _loc8_.filter.categoryBits = 4369;
         _loc14_.push(_loc8_);
         _loc10_.shapes.push(this.CreateLightBody(_loc9_,_loc7_,_loc14_)[0]);
         _loc9_.SetXForm(new b2Vec2(param1.x,param1.y),param2);
         return _loc9_.GetUserData();
      }
      
      protected function setTint(param1:Sprite, param2:uint) : void
      {
         var _loc3_:ColorTransform = null;
         var _loc4_:* = undefined;
         _loc3_ = new ColorTransform();
         _loc4_ = this.hexToRGB(param2);
         _loc3_.redMultiplier = _loc4_[0] / 255;
         _loc3_.greenMultiplier = _loc4_[1] / 255;
         _loc3_.blueMultiplier = _loc4_[2] / 255;
         param1.transform.colorTransform = _loc3_;
      }
      
      internal function hexToRGB(param1:Number) : Object
      {
         return new Array((param1 & 16711680) >> 16,(param1 & 65280) >> 8,param1 & 255);
      }
      
      protected function setTintFromInt(param1:Sprite, param2:int) : void
      {
         this.setTint(param1,this.colorsArray[param2 - 1]);
      }
      
      public function applyPortalForce(param1:Object, param2:Object) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         _loc3_ = new b2Vec2(param1.GetPosition().x - param2.body.GetPosition().x,param1.GetPosition().y - param2.body.GetPosition().y);
         _loc4_ = _loc3_.Length();
         (_loc5_ = new b2Vec2(_loc3_.x / (_loc4_ * _loc4_),_loc3_.y / (_loc4_ * _loc4_))).Multiply(-200);
         b2Body(param1).ApplyForce(_loc5_,param1.GetWorldCenter());
      }
      
      public function OpenPortalPair(param1:Object, param2:Boolean = false) : void
      {
         this.OpenPortal(param1,param2);
         this.OpenPortal(param1.other,param2);
      }
      
      public function ClosePortalPair(param1:Object) : void
      {
         this.ClosePortal(param1);
         this.ClosePortal(param1.other);
      }
      
      public function PortalFadeOut(param1:*) : void
      {
         trace("FADING PORTAL");
         --param1.target.counter;
         param1.target.PortalLeft.visible = true;
         param1.target.PortalRight.visible = true;
         param1.target.PortalLeft.alpha = param1.target.counter / 25;
         param1.target.PortalRight.alpha = param1.target.counter / 25;
         trace("ALPHJA IS " + param1.target.PortalLeft.alpha);
         if(param1.target.counter <= 0)
         {
            param1.target.PortalLeft.alpha = 0;
            param1.target.PortalRight.alpha = 0;
            param1.target.removeEventListener(Event.ENTER_FRAME,this.PortalFadeOut);
         }
      }
      
      public function OpenPortal(param1:Object, param2:Boolean = false) : void
      {
         var _loc3_:* = undefined;
         param1.on = true;
         param1.working = true;
         param1.Sides.visible = true;
         param1.PortalCenter.visible = true;
         trace("OPing PORTAL");
         param1.counter = 25;
         if(!param2)
         {
            param1.addEventListener(Event.ENTER_FRAME,this.PortalFadeOut);
         }
         else if(param1.myMechanism != undefined)
         {
            param1.myMechanism.setPortalVolume(0,param1);
         }
         _loc3_ = 0;
         while(_loc3_ < param1.shapes.length)
         {
            if((!param1.inWall || param1.shapes[_loc3_].m_userData != "wall") && param1.shapes[_loc3_].m_userData != "TransportSensorLight")
            {
               param1.shapes[_loc3_].m_filter.maskBits = 4096;
               param1.shapes[_loc3_].m_filter.categoryBits = 4096;
               this.m_world.Refilter(param1.shapes[_loc3_]);
            }
            if(param1.shapes[_loc3_].m_userData == "TransportSensorLight")
            {
               param1.shapes[_loc3_].m_filter.maskBits = 4369;
               param1.shapes[_loc3_].m_filter.categoryBits = 4369;
               this.m_lworld.Refilter(param1.shapes[_loc3_]);
            }
            else
            {
               trace("SKIPPING OPEN");
            }
            _loc3_++;
         }
      }
      
      public function ClosePortal(param1:Object) : void
      {
         var _loc2_:* = undefined;
         param1.on = false;
         param1.working = false;
         param1.Sides.visible = false;
         param1.PortalCenter.visible = false;
         _loc2_ = 0;
         while(_loc2_ < param1.shapes.length)
         {
            if((!param1.inWall || param1.shapes[_loc2_].m_userData != "wall") && param1.shapes[_loc2_].m_userData != "TransportSensorLight")
            {
               param1.shapes[_loc2_].m_filter.maskBits = 0;
               param1.shapes[_loc2_].m_filter.categoryBits = 0;
               this.m_world.Refilter(param1.shapes[_loc2_]);
            }
            if(param1.shapes[_loc2_].m_userData == "TransportSensorLight")
            {
               param1.shapes[_loc2_].m_filter.maskBits = 0;
               param1.shapes[_loc2_].m_filter.categoryBits = 0;
               this.m_lworld.Refilter(param1.shapes[_loc2_]);
            }
            else
            {
               trace("SKIPPING CLOSE");
            }
            _loc2_++;
         }
      }
      
      public function transportObject(param1:Object, param2:Object) : *
      {
         var _loc4_:b2Vec2 = null;
         var _loc7_:b2Vec2 = null;
         var _loc8_:b2Vec2 = null;
         var _loc9_:b2Vec2 = null;
         if(!(param1.GetUserData() is Bullet))
         {
            this.playSound("PortalTransportSound");
         }
         if(param2.maskedByL.length != 0)
         {
            param2.PortalLeft.visible = true;
            param2.PortalLeft.alpha = 1;
         }
         if(param2.other.maskedByL.length != 0)
         {
            param2.other.PortalLeft.visible = true;
            param2.other.PortalLeft.alpha = 1;
         }
         if(param2.maskedByR.length != 0)
         {
            param2.PortalRight.visible = true;
            param2.PortalRight.alpha = 1;
         }
         if(param2.other.maskedByR.length != 0)
         {
            param2.other.PortalRight.visible = true;
            param2.other.PortalRight.alpha = 1;
         }
         if(param1.GetUserData() is WaterGirl)
         {
            this.pers2.GetUserData().mc_1.visible = false;
            this.pers2.GetUserData().mc_2.visible = false;
            this.pers2.GetUserData().mc_3.visible = false;
            this.pers2.GetUserData().mc_4.visible = false;
            this.pers2.GetUserData().mc_5.visible = false;
            this.pers2.GetUserData().mc_52.visible = false;
            if(param2.inverted)
            {
               if(!(param2.ori == Math.PI * 90 / 180 && param2.ori == param2.other.ori || param2.ori == Math.PI * 270 / 180 && param2.ori == param2.other.ori))
               {
                  if(this.r_pressed2)
                  {
                     this.r_pressed2 = false;
                     this.l_pressed2 = true;
                  }
                  else if(this.l_pressed2)
                  {
                     this.l_pressed2 = false;
                     this.r_pressed2 = true;
                  }
               }
            }
         }
         else if(param1.GetUserData() is FireBoy)
         {
            this.pers1.GetUserData().mc_1.visible = false;
            this.pers1.GetUserData().mc_2.visible = false;
            this.pers1.GetUserData().mc_3.visible = false;
            this.pers1.GetUserData().mc_4.visible = false;
            this.pers1.GetUserData().mc_5.visible = false;
            this.pers1.GetUserData().mc_52.visible = false;
            if(param2.inverted)
            {
               if(!(param2.ori == Math.PI * 90 / 180 && param2.ori == param2.other.ori || param2.ori == Math.PI * 270 / 180 && param2.ori == param2.other.ori))
               {
                  if(this.r_pressed)
                  {
                     this.r_pressed = false;
                     this.l_pressed = true;
                  }
                  else if(this.l_pressed)
                  {
                     this.l_pressed = false;
                     this.r_pressed = true;
                  }
               }
            }
         }
         var _loc3_:* = new b2Vec2(param2.other.body.GetPosition().x - param2.body.GetPosition().x,param2.other.body.GetPosition().y - param2.body.GetPosition().y);
         _loc4_ = param2.body.GetLocalVector(new b2Vec2(param2.enterSpeed.x,param2.enterSpeed.y));
         if(param2.inverted)
         {
            _loc4_.x = -_loc4_.x;
         }
         var _loc5_:* = _loc4_.Length();
         var _loc6_:int = 2;
         _loc7_ = param2.other.body.GetWorldVector(_loc4_);
         if(param2.other.ori % 180 != 0)
         {
            if(_loc7_.y < 0 && _loc7_.y > -10)
            {
               if(Math.abs(_loc7_.x) < 6)
               {
                  _loc7_.y = -10;
               }
            }
         }
         b2Body(param1).SetLinearVelocity(new b2Vec2(_loc7_.x,_loc7_.y));
         _loc8_ = param2.body.GetLocalPoint(b2Body(param1).GetPosition());
         if(!param2.inverted)
         {
            _loc8_.x = -_loc8_.x;
         }
         _loc9_ = param2.other.body.GetWorldPoint(_loc8_);
         b2Body(param1).SetXForm(_loc9_,b2Body(param1).GetAngle());
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
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         if(param1.m_userData.color == 5)
         {
            _loc2_ = this.freezeColor;
         }
         else if(param1.m_userData.color == 4)
         {
            _loc2_ = this.meltColor;
         }
         else
         {
            _loc2_ = this.defaultColor;
         }
         this.LightBoard.graphics.lineStyle(20,_loc2_,1,false,"normal","none","bevel",0.1);
         this.LightBoard.graphics.moveTo(param1.m_userData.startPoint.x * 20,param1.m_userData.startPoint.y * 20);
         param1.m_userData.bullet.SetXForm(new b2Vec2(param1.m_userData.startPoint.x,param1.m_userData.startPoint.y),0);
         _loc3_ = new b2Vec2(Math.cos(param1.GetAngle()),Math.sin(param1.GetAngle()));
         _loc3_.Multiply(this.LightSpeed);
         param1.m_userData.bullet.SetLinearVelocity(_loc3_);
         _loc4_ = 300;
         param1.m_userData.bullet.m_userData.Path = new Array();
         param1.m_userData.bullet.m_userData.Path.push(new b2Vec2(param1.m_userData.startPoint.x,param1.m_userData.startPoint.y));
         _loc5_ = 0;
         while(_loc5_ < this.myPortals.length)
         {
            this.myPortals[_loc5_].maskedLightR = false;
            this.myPortals[_loc5_].maskedLightL = false;
            _loc5_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            if(param1.m_userData.bullet.IsSleeping() == true)
            {
               param1.m_userData.bullet.WakeUp();
            }
            this.m_lworld.Step(1 / 26,50);
            _loc5_ = 0;
            while(_loc5_ < this.myPortals.length)
            {
               if(this.myPortals[_loc5_].working)
               {
                  if(Boolean(this.myPortals[_loc5_].activeBody) && this.myPortals[_loc5_].activeBody.GetUserData() is Bullet)
                  {
                     (_loc11_ = this.myPortals[_loc5_].activeBody).GetUserData().Path.push(new b2Vec2(_loc11_.GetPosition().x,_loc11_.GetPosition().y));
                     _loc11_.GetUserData().Path.push(new b2Vec2());
                     this.transportObject(this.myPortals[_loc5_].activeBody,this.myPortals[_loc5_]);
                     _loc11_.GetUserData().Path.push(new b2Vec2(_loc11_.GetPosition().x,_loc11_.GetPosition().y));
                  }
               }
               _loc5_++;
            }
            if(param1.m_userData.bullet.GetLinearVelocity().Length() < 1)
            {
               _loc6_ = _loc4_;
            }
            _loc6_++;
         }
         param1.m_userData.bullet.m_userData.Path.push(new b2Vec2(param1.m_userData.bullet.GetPosition().x,param1.m_userData.bullet.GetPosition().y));
         this.LightBoard.graphics.lineStyle(20,_loc2_,1,false,"normal","round","bevel",1);
         _loc10_ = 1;
         while(_loc10_ < param1.m_userData.bullet.m_userData.Path.length - 1)
         {
            _loc7_ = new Point(param1.m_userData.bullet.m_userData.Path[_loc10_ - 1].x * 20,param1.m_userData.bullet.m_userData.Path[_loc10_ - 1].y * 20);
            _loc8_ = new Point(param1.m_userData.bullet.m_userData.Path[_loc10_].x * 20,param1.m_userData.bullet.m_userData.Path[_loc10_].y * 20);
            if(!(_loc7_.x == 0 && _loc7_.y == 0) && !(_loc8_.x == 0 && _loc8_.y == 0))
            {
               _loc12_ = _loc8_.subtract(_loc7_);
               _loc13_ = Math.atan2(_loc12_.y,_loc12_.x);
               (_loc9_ = new Matrix()).createGradientBox(20,20,_loc13_ + Math.PI / 2,_loc7_.x - 10,_loc7_.y - 10);
               this.LightBoard.graphics.lineGradientStyle("linear",[_loc2_,_loc2_,_loc2_,_loc2_,_loc2_],[0,0.3,0.5,0.3,0],[0,63,127,190,255],_loc9_,"pad");
               _loc12_.normalize(11);
               this.LightBoard.graphics.moveTo(_loc7_.x + _loc12_.x,_loc7_.y + _loc12_.y);
               this.LightBoard.graphics.lineTo(_loc8_.x - _loc12_.x,_loc8_.y - _loc12_.y);
            }
            _loc10_++;
         }
         _loc10_ = param1.m_userData.bullet.m_userData.Path.length - 1;
         _loc7_ = new Point(param1.m_userData.bullet.m_userData.Path[_loc10_ - 1].x * 20,param1.m_userData.bullet.m_userData.Path[_loc10_ - 1].y * 20);
         _loc12_ = (_loc8_ = new Point(param1.m_userData.bullet.m_userData.Path[_loc10_].x * 20,param1.m_userData.bullet.m_userData.Path[_loc10_].y * 20)).subtract(_loc7_);
         _loc13_ = Math.atan2(_loc12_.y,_loc12_.x);
         (_loc9_ = new Matrix()).createGradientBox(20,20,_loc13_ + Math.PI / 2,_loc7_.x - 10,_loc7_.y - 10);
         this.LightBoard.graphics.lineGradientStyle("linear",[_loc2_,_loc2_,_loc2_,_loc2_,_loc2_],[0,0.3,0.5,0.3,0],[0,63,127,190,255],_loc9_,"pad");
         if(_loc12_.length > 11)
         {
            _loc12_.normalize(11);
            this.LightBoard.graphics.moveTo(_loc7_.x + _loc12_.x,_loc7_.y + _loc12_.y);
            this.LightBoard.graphics.lineTo(_loc8_.x,_loc8_.y);
         }
         else
         {
            this.LightBoard.graphics.moveTo(_loc7_.x,_loc7_.y);
            this.LightBoard.graphics.lineTo(_loc8_.x,_loc8_.y);
         }
      }
      
      public function CreateBullet(param1:*, param2:*, param3:*) : *
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         if(param3 == 5)
         {
            _loc5_ = this.freezeColor;
         }
         else if(param3 == 4)
         {
            _loc5_ = this.meltColor;
         }
         else
         {
            _loc5_ = this.defaultColor;
         }
         _loc6_ = new b2BodyDef();
         _loc7_ = new Bullet();
         _loc6_.userData = _loc7_;
         _loc7_.slow = 0;
         _loc7_.Path = new Array();
         _loc7_.color = param3;
         _loc7_.uintColor = _loc5_;
         _loc6_.isBullet = false;
         _loc6_.massData.mass = 1;
         _loc4_ = this.m_lworld.CreateBody(_loc6_);
         (_loc8_ = new b2CircleDef()).radius = 0.1;
         _loc8_.userData = "LightBall";
         _loc8_.localPosition.Set(0,0);
         _loc8_.density = 1;
         _loc8_.restitution = 0;
         _loc8_.friction = 999;
         _loc8_.filter.groupIndex = -1;
         _loc4_.CreateShape(_loc8_);
         (_loc8_ = new b2CircleDef()).radius = 0.0001;
         _loc8_.localPosition.Set(0,0);
         _loc8_.density = 1;
         _loc8_.restitution = 0;
         _loc8_.friction = 999;
         _loc4_.CreateShape(_loc8_);
         _loc4_.SetXForm(new b2Vec2(param1.x,param1.y),0);
         _loc4_.SetLinearVelocity(param2);
         this.LightBoard.addChild(_loc4_.GetUserData());
         this.LightBoard.cacheAsBitmap = true;
         return _loc4_;
      }
      
      public function CreateLightBody(param1:*, param2:*, param3:*) : Array
      {
         var _loc4_:Array = null;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         _loc4_ = new Array();
         _loc5_ = this.m_lworld.CreateBody(param2);
         _loc6_ = 0;
         while(_loc6_ < param3.length)
         {
            if(param1.GetUserData().mirror != true)
            {
               param3[_loc6_].restitution = 0;
               param3[_loc6_].friction = 999;
            }
            _loc4_.push(_loc5_.CreateShape(param3[_loc6_]));
            _loc6_++;
         }
         _loc5_.m_userData.pointer = param1;
         return _loc4_;
      }
      
      public function FreezeIce(param1:*) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         _loc2_ = new b2FilterData();
         _loc2_.maskBits = 65535;
         param1.mirrorBody.GetShapeList().SetFilterData(_loc2_);
         param1.mirror = false;
         this.FreezeChannel.stop();
         param1.m.visible = false;
         param1.m.meltsmoke.stop();
         this.FreezeChannel = this.FreezeSound.play(0,1);
         _loc3_ = this.m_world.m_bodyList;
         while(_loc3_)
         {
            if(_loc3_.m_userData is Sprite)
            {
               if(_loc3_.GetUserData().waterCC)
               {
                  if(_loc3_.GetUserData().waterCC == param1)
                  {
                     _loc3_.GetUserData().frozeOn = param1;
                     _loc3_.SetMass(new b2MassData());
                  }
               }
               _loc3_.WakeUp();
            }
            _loc3_ = _loc3_.m_next;
         }
         param1.body = this.m_world.CreateBody(param1.bodyDef);
         param1.body.CreateShape(param1.boxDef);
         param1.body.SetMassFromShapes();
         param1.body.WakeUp();
         param1.mirror = false;
         _loc2_ = new b2FilterData();
         _loc2_.maskBits = 0;
         _loc4_ = 0;
         while(_loc4_ < param1.shapes.length)
         {
            param1.shapes[_loc4_].SetFilterData(_loc2_);
            trace("jkflsdñafj " + param1.shapes[_loc4_].GetFilterData().maskBits);
            _loc4_++;
         }
         if(param1.hasEventListener(Event.ENTER_FRAME))
         {
            param1.removeEventListener(Event.ENTER_FRAME,this.MeltUpdate);
         }
         param1.count = 30;
         param1.cp = new b2Vec2(param1.contactPoint.x - param1.pos.x,param1.contactPoint.y - param1.pos.y);
         param1.f1.x = param1.cp.x * 20;
         param1.f2.x = param1.cp.x * 20;
         param1.f1.visible = true;
         param1.f2.visible = true;
         param1.f1.scaleY = 1;
         param1.f2.scaleY = 1;
         param1.addEventListener(Event.ENTER_FRAME,this.FreezeUpdate);
      }
      
      public function FreezeUpdate(param1:*) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = param1.target;
         if(_loc2_.count > 0)
         {
            --_loc2_.count;
            _loc2_.iceMask.graphics.clear();
            _loc2_.waterMask.graphics.clear();
            _loc3_ = _loc2_.l * (1 - _loc2_.count / 30);
            _loc2_.f1.x = _loc2_.cp.x * 20 + _loc3_;
            _loc2_.f2.x = _loc2_.cp.x * 20 - _loc3_;
            if(_loc2_.f1.x >= _loc2_.l / 2 - 20)
            {
               _loc2_.f1.visible = false;
            }
            if(_loc2_.f2.x <= -_loc2_.l / 2 + 20)
            {
               _loc2_.f2.visible = false;
            }
            if(_loc2_.f1.x > _loc2_.l / 2 - 40)
            {
               _loc2_.f1.scaleY *= 0.9;
               _loc2_.f2.scaleY *= 0.9;
            }
            _loc2_.iceMask.graphics.beginFill(16711935,0.5);
            _loc2_.iceMask.graphics.drawRect(_loc2_.cp.x * 20,-15,_loc3_,20);
            _loc2_.iceMask.graphics.endFill();
            _loc2_.iceMask.graphics.beginFill(16711935,0.5);
            _loc2_.iceMask.graphics.drawRect(_loc2_.cp.x * 20,-15,-_loc3_,20);
            _loc2_.iceMask.graphics.endFill();
            _loc2_.waterMask.graphics.beginFill(16711935,0.5);
            _loc2_.waterMask.graphics.drawRect(_loc2_.cp.x * 20 - _loc2_.l,-15,_loc2_.l - _loc3_,20);
            _loc2_.waterMask.graphics.endFill();
            _loc2_.waterMask.graphics.beginFill(16711935,0.5);
            _loc2_.waterMask.graphics.drawRect(_loc2_.cp.x * 20 + _loc3_,-15,_loc2_.l - _loc3_,20);
            _loc2_.waterMask.graphics.endFill();
         }
         else
         {
            this.FreezeChannel.stop();
            _loc2_.removeEventListener(Event.ENTER_FRAME,this.FreezeUpdate);
         }
      }
      
      public function MeltIce(param1:*) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         _loc2_ = new b2FilterData();
         _loc2_.maskBits = 0;
         param1.mirrorBody.GetShapeList().SetFilterData(_loc2_);
         param1.mirror = false;
         this.FreezeChannel.stop();
         this.FreezeChannel = this.MeltSound.play(0,1);
         _loc2_ = new b2FilterData();
         this.m_world.DestroyBody(param1.body);
         _loc2_.maskBits = 65535;
         _loc3_ = this.m_world.m_bodyList;
         while(_loc3_)
         {
            if(_loc3_.m_userData is Sprite)
            {
               if(_loc3_.GetUserData().frozeOn)
               {
                  if(_loc3_.GetUserData().frozeOn == param1)
                  {
                     _loc3_.GetUserData().frozeOn = null;
                     _loc3_.GetUserData().waterCC = param1;
                     _loc3_.SetMassFromShapes();
                  }
               }
               _loc3_.WakeUp();
            }
            _loc3_ = _loc3_.m_next;
         }
         _loc4_ = 0;
         while(_loc4_ < param1.shapes.length)
         {
            param1.shapes[_loc4_].SetFilterData(_loc2_);
            _loc4_++;
         }
         if(param1.hasEventListener(Event.ENTER_FRAME))
         {
            param1.removeEventListener(Event.ENTER_FRAME,this.FreezeUpdate);
         }
         param1.count = 30;
         param1.cp = new b2Vec2(param1.contactPoint.x - param1.pos.x,param1.contactPoint.y - param1.pos.y);
         param1.f1.x = param1.cp.x * 20;
         param1.f2.x = param1.cp.x * 20;
         param1.f1.visible = true;
         param1.f2.visible = true;
         param1.f1.scaleY = 1;
         param1.f2.scaleY = 1;
         param1.m.visible = true;
         param1.m.meltsmoke.gotoAndPlay(1);
         param1.m.x = param1.cp.x * 20;
         param1.addEventListener(Event.ENTER_FRAME,this.MeltUpdate);
      }
      
      public function MeltUpdate(param1:*) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = param1.target;
         if(_loc2_.count > 0)
         {
            --_loc2_.count;
            _loc2_.iceMask.graphics.clear();
            _loc2_.waterMask.graphics.clear();
            _loc3_ = _loc2_.l * (1 - _loc2_.count / 30);
            _loc2_.f1.x = _loc2_.cp.x * 20 + _loc3_;
            _loc2_.f2.x = _loc2_.cp.x * 20 - _loc3_;
            if(_loc2_.f1.x >= _loc2_.l / 2 - 20)
            {
               _loc2_.f1.visible = false;
            }
            if(_loc2_.f2.x <= -_loc2_.l / 2 + 20)
            {
               _loc2_.f2.visible = false;
            }
            if(_loc2_.f1.x > _loc2_.l / 2 - 40)
            {
               _loc2_.f1.scaleY *= 0.9;
               _loc2_.f2.scaleY *= 0.9;
            }
            _loc2_.waterMask.graphics.beginFill(16711935,0.5);
            _loc2_.waterMask.graphics.drawRect(_loc2_.cp.x * 20,-15,_loc3_,20);
            _loc2_.waterMask.graphics.endFill();
            _loc2_.waterMask.graphics.beginFill(16711935,0.5);
            _loc2_.waterMask.graphics.drawRect(_loc2_.cp.x * 20,-15,-_loc3_,20);
            _loc2_.waterMask.graphics.endFill();
            _loc2_.iceMask.graphics.beginFill(16711935,0.5);
            _loc2_.iceMask.graphics.drawRect(_loc2_.cp.x * 20 - _loc2_.l,-15,_loc2_.l - _loc3_,20);
            _loc2_.iceMask.graphics.endFill();
            _loc2_.iceMask.graphics.beginFill(16711935,0.5);
            _loc2_.iceMask.graphics.drawRect(_loc2_.cp.x * 20 + _loc3_,-15,_loc2_.l - _loc3_,20);
            _loc2_.iceMask.graphics.endFill();
         }
         else
         {
            this.FreezeChannel.stop();
            _loc2_.m.visible = false;
            _loc2_.m.meltsmoke.stop();
            _loc2_.removeEventListener(Event.ENTER_FRAME,this.MeltUpdate);
         }
      }
      
      public function PortalDistance(param1:Object, param2:Object) : Number
      {
         var _loc3_:b2Vec2 = null;
         _loc3_ = new b2Vec2(param2.x,param2.y);
         _loc3_.Subtract(new b2Vec2(param1.x,param1.y));
         return _loc3_.Length();
      }
      
      public function handleSoundComplete(param1:Event) : *
      {
         this.clickPlaying = false;
      }
      
      public function playSound(param1:String) : *
      {
         this[param1].play();
      }
      
      public function startSound(param1:SoundChannel, param2:String, param3:Number = 0, param4:Number = 999) : Object
      {
         trace("REAL STARTING " + param2 + " " + param1 + " " + param3);
         if(param3 != 0)
         {
            param1 = this[param2].play(this[param2].length - param3,param4);
         }
         else
         {
            param1 = this[param2].play(0,param4);
         }
         return param1;
      }
      
      public function stopSound(param1:SoundChannel, param2:String) : *
      {
         trace("REAL STOPPING " + param2 + " " + param1);
         param1.stop();
      }
   }
}
