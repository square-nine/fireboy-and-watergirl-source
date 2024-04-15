package
{
   import Box2D.Common.Math.b2Vec2;
   import flash.events.Event;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.utils.Timer;
   
   public class Mechanism
   {
       
      
      internal var Sensors:Array;
      
      internal var Actuators:Array;
      
      internal var _index:Number;
      
      internal var inputActive:Boolean;
      
      internal var outputActive:Boolean;
      
      internal var timedActive:Boolean;
      
      internal var _value:Number = 0;
      
      internal var master:Object;
      
      internal var LEVER_SOUND:* = "LeverSound";
      
      internal var PUSHER_SOUND:* = "PusherSound";
      
      internal var LIGHT_PUSHER_SOUND:* = "LPusherSound";
      
      internal var PLATFORM_SOUND:* = "PlatformSound";
      
      internal var WIND_SOUND:* = "WindSound";
      
      internal var INFINITE_SOUND:* = "ClickSound";
      
      internal var PORTAL_LOOP_SOUND:* = "PortalLoopSound";
      
      internal var PORTAL_OPEN_SOUND:* = "PortalOpenSound";
      
      internal var PORTAL_CLOSED_SOUND:* = "PortalCloseSound";
      
      internal var TIME_SOUND:* = "ClockSound";
      
      internal var NULL_SOUND:* = "";
      
      internal var eventSounds:Array;
      
      internal var longSounds:Array;
      
      internal var mySoundChannels:Array;
      
      internal var longSoundFlags:Array;
      
      internal var allDevices:Array;
      
      internal var clickPlaying:int = 0;
      
      internal var hasSlider:* = false;
      
      internal var soundTimer:Timer;
      
      internal var soundAllowedThisFrame:Boolean = true;
      
      public function Mechanism(param1:Number)
      {
         super();
         this._index = param1;
         this.Sensors = new Array();
         this.Actuators = new Array();
         this.eventSounds = new Array();
         this.longSounds = new Array();
         this.longSoundFlags = new Array();
         this.allDevices = new Array();
         this.mySoundChannels = new Array();
         this.inputActive = false;
         this.outputActive = false;
      }
      
      public function addDevice(param1:*) : void
      {
         if(param1.type == "pusher" || param1.type == "timedPusher" || param1.type == "lever" || param1.type == "mirrorSlider" || param1.type == "lightPusher")
         {
            this.Sensors.push(param1);
         }
         else
         {
            this.Actuators.push(param1);
         }
         this.allDevices.push(param1);
         this.eventSounds.push(this.NULL_SOUND);
         this.longSounds.push(this.NULL_SOUND);
         this.longSoundFlags.push(false);
         this.mySoundChannels.push(null);
         param1.myMechanism = this;
         switch(param1.type)
         {
            case "pusher":
               this.eventSounds[this.eventSounds.length - 1] = this.PUSHER_SOUND;
               break;
            case "timedPusher":
               this.eventSounds[this.eventSounds.length - 1] = this.LEVER_SOUND;
               this.mySoundChannels[this.mySoundChannels.length - 1] = new SoundChannel();
               this.longSounds[this.longSounds.length - 1] = this.TIME_SOUND;
               break;
            case "lever":
               this.eventSounds[this.eventSounds.length - 1] = this.LEVER_SOUND;
               break;
            case "lightPusher":
               this.eventSounds[this.eventSounds.length - 1] = this.LIGHT_PUSHER_SOUND;
               break;
            case "slidePlatform":
               this.longSounds[this.longSounds.length - 1] = this.PLATFORM_SOUND;
               this.mySoundChannels[this.mySoundChannels.length - 1] = new SoundChannel();
               break;
            case "rotMirror":
               this.longSounds[this.longSounds.length - 1] = this.PLATFORM_SOUND;
               break;
            case "mirrorSlider":
               this.eventSounds[this.eventSounds.length - 1] = this.INFINITE_SOUND;
               break;
            case "wind":
               this.longSounds[this.longSounds.length - 1] = this.WIND_SOUND;
               break;
            case "portal":
               this.longSounds[this.longSounds.length - 1] = this.PORTAL_LOOP_SOUND;
         }
         if(param1.type == "slidePlatform")
         {
            if(this.hasSlider)
            {
               trace("HAS SLIDER ALREADY");
               this.longSounds[this.longSounds.length - 1] = this.NULL_SOUND;
               this.mySoundChannels[this.mySoundChannels.length - 1] = null;
            }
            else
            {
               trace("DOes NOT ÇHAS SLIDER");
            }
            this.hasSlider = true;
         }
      }
      
      public function checkState() : Boolean
      {
         var _loc1_:* = false;
         var _loc2_:* = 0;
         while(_loc2_ < this.Sensors.length)
         {
            if(this.checkSensorState(this.Sensors[_loc2_]))
            {
               _loc1_ = true;
            }
            _loc2_++;
         }
         if(this._index == -1)
         {
            _loc1_ = true;
         }
         this.setState(_loc1_);
         return _loc1_;
      }
      
      public function checkSensorState(param1:Object) : Boolean
      {
         switch(param1.type)
         {
            case "pusher":
               return this.checkPusher(param1);
            case "timedPusher":
               return this.checkTimedPusher(param1);
            case "lever":
               return this.checkLever(param1);
            case "lightPusher":
               return this.checkLightPusher(param1);
            case "mirrorSlider":
               return this.checkMirrorSlider(param1);
            default:
               trace("NOT SENSOR TYPE " + param1.type);
               return false;
         }
      }
      
      public function setState(param1:Boolean) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc2_:* = false;
         if(param1 && !this.inputActive)
         {
            this.inputActive = true;
            this.outputActive = true;
            _loc2_ = true;
         }
         else if(!param1 && this.inputActive || !this.timedActive && !this.inputActive && this.outputActive)
         {
            this.inputActive = false;
            if(!this.timedActive)
            {
               this.outputActive = false;
            }
            _loc2_ = true;
         }
         if(_loc2_)
         {
            _loc3_ = 0;
            while(_loc3_ < this.Actuators.length)
            {
               this.setActuatorState(this.Actuators[_loc3_]);
               _loc3_++;
            }
            _loc4_ = 0;
            while(_loc4_ < this.longSoundFlags.length)
            {
               if(this.longSoundFlags[_loc4_])
               {
                  trace("STARTNG LONG SOUND " + this.longSounds[_loc4_] + " AT " + _loc4_);
                  this.startSound(_loc4_);
               }
               else if(this.longSounds[_loc4_] != this.TIME_SOUND || !this.timedActive)
               {
                  this.stopSound(_loc4_);
               }
               _loc4_++;
            }
         }
      }
      
      public function setActuatorState(param1:Object) : *
      {
         switch(param1.type)
         {
            case "slidePlatform":
               this.setSliderPlatform(param1);
               break;
            case "rotMirror":
               this.setRotatingObject(param1);
               break;
            case "infiniteMirror":
               this.setInfiniteMirror(param1);
               break;
            case "wind":
               this.setWind(param1);
               break;
            case "portal":
               this.setPortal(param1);
               break;
            case "lightBeamer":
               this.setLightBeamer(param1);
               break;
            default:
               trace("NOT ACTUATOR TYPE " + param1.type);
         }
      }
      
      public function playSound(param1:String) : *
      {
         trace("MECHANISM: Play Sound " + param1);
         if(!this.soundTimer)
         {
            this.soundTimer = new Timer(200,0);
         }
         trace(this.soundTimer.running + " " + this.soundTimer.currentCount);
         if(!this.soundTimer.running || this.soundTimer.currentCount > 0)
         {
            trace("SOUND TIMeR ALLOWS");
            this.soundTimer.reset();
            this.soundTimer.start();
            this.soundAllowedThisFrame = true;
            this.master.playSound(param1);
         }
         else if(this.soundAllowedThisFrame && (param1 == this.PORTAL_CLOSED_SOUND || param1 == this.PORTAL_OPEN_SOUND))
         {
            this.master.playSound(param1);
         }
         else
         {
            this.soundAllowedThisFrame = false;
         }
      }
      
      public function startSound(param1:int, param2:Number = 0) : *
      {
         var _loc3_:* = this.longSounds[param1];
         var _loc4_:*;
         if(_loc4_ = this.mySoundChannels[param1])
         {
            _loc4_.stop();
         }
         trace("STARTing SOUND " + _loc3_);
         if(_loc3_ != this.NULL_SOUND)
         {
            this.mySoundChannels[param1] = this.master.startSound(_loc4_,_loc3_,param2);
            if(_loc3_ == this.PORTAL_LOOP_SOUND)
            {
               this.mySoundChannels[param1].soundTransform = new SoundTransform(0);
            }
         }
      }
      
      public function stopSound(param1:int) : *
      {
         var _loc2_:* = this.longSounds[param1];
         var _loc3_:* = this.mySoundChannels[param1];
         trace("STOPing SOUND " + _loc2_);
         if(_loc2_ && _loc3_)
         {
            trace("STOPing SOUND for real" + _loc2_);
            _loc3_.stop();
         }
      }
      
      public function checkPusher(param1:Object) : Boolean
      {
         var _loc2_:* = param1.oldObject;
         if(_loc2_.GetUserData().GetPosition().y - _loc2_.GetUserData().GetUserData().originy > 0.25)
         {
            _loc2_.SetMotorSpeed(1);
            _loc2_.SetMaxMotorForce(0.1);
            if(!param1.on)
            {
               this.playSound(this.eventSounds[this.allDevices.indexOf(param1)]);
            }
            param1.on = true;
            return true;
         }
         if(_loc2_.GetUserData().IsSleeping() == false)
         {
            _loc2_.SetMotorSpeed(2);
            _loc2_.SetMaxMotorForce(1);
            if(param1.on)
            {
               this.playSound(this.eventSounds[this.allDevices.indexOf(param1)]);
            }
            param1.on = false;
            _loc2_.GetUserData().GetUserData().clicker = 1;
            return false;
         }
         return false;
      }
      
      public function checkTimedPusher(param1:Object) : Boolean
      {
         var _loc2_:* = param1.oldObject;
         _loc2_.GetUserData().GetUserData().base.msk.scaleX = _loc2_.GetUserData().GetUserData().Time / _loc2_.GetUserData().GetUserData().delayTime;
         if(_loc2_.GetUserData().GetUserData().Time > 0)
         {
            --_loc2_.GetUserData().GetUserData().Time;
         }
         if(_loc2_.GetUserData().GetPosition().y - _loc2_.GetUserData().GetUserData().originy > 0.25)
         {
            _loc2_.SetMotorSpeed(1);
            _loc2_.SetMaxMotorForce(0.1);
            _loc2_.GetUserData().GetUserData().clicker = -1;
            if(!param1.on)
            {
               this.playSound(this.eventSounds[this.allDevices.indexOf(param1)]);
            }
            param1.on = true;
            _loc2_.GetUserData().GetUserData().Time = _loc2_.GetUserData().GetUserData().delayTime;
            if(this.mySoundChannels[this.allDevices.indexOf(param1)])
            {
               this.mySoundChannels[this.allDevices.indexOf(param1)].stop();
            }
            this.timedActive = false;
            return true;
         }
         if(_loc2_.GetUserData().GetUserData().Time > 0)
         {
            if(_loc2_.GetUserData().GetUserData().Time == _loc2_.GetUserData().GetUserData().delayTime - 1)
            {
               if(this.mySoundChannels[this.allDevices.indexOf(param1)])
               {
                  this.mySoundChannels[this.allDevices.indexOf(param1)].stop();
               }
               this.startSound(this.allDevices.indexOf(param1),_loc2_.GetUserData().GetUserData().delayTime * 1000 / 25);
            }
            if(param1.on)
            {
               this.playSound(this.eventSounds[this.allDevices.indexOf(param1)]);
            }
            param1.on = false;
            this.timedActive = true;
            return false;
         }
         if(this.timedActive == true)
         {
            this.playSound(this.eventSounds[this.allDevices.indexOf(param1)]);
         }
         if(_loc2_.GetUserData().IsSleeping() == false)
         {
            _loc2_.SetMotorSpeed(2);
            _loc2_.SetMaxMotorForce(1);
            _loc2_.GetUserData().GetUserData().clicker = 1;
         }
         this.timedActive = false;
         return false;
      }
      
      public function checkLever(param1:Object) : Boolean
      {
         var _loc2_:* = param1.oldObject;
         if(_loc2_.GetJointAngle() > 0)
         {
            _loc2_.SetMotorSpeed(3);
         }
         else
         {
            _loc2_.SetMotorSpeed(-3);
         }
         if(_loc2_.GetUserData().GetUserData().onis == "r" && _loc2_.GetJointAngle() < 0 || _loc2_.GetUserData().GetUserData().onis == "l" && _loc2_.GetJointAngle() > 0)
         {
            _loc2_.GetUserData().GetUserData().getChildByName("light").gotoAndStop(2);
            if(!param1.on)
            {
               this.playSound(this.eventSounds[this.allDevices.indexOf(param1)]);
            }
            param1.on = true;
            return true;
         }
         _loc2_.GetUserData().GetUserData().getChildByName("light").gotoAndStop(1);
         if(param1.on)
         {
            this.playSound(this.eventSounds[this.allDevices.indexOf(param1)]);
         }
         param1.on = false;
         return false;
      }
      
      public function checkLightPusher(param1:Object) : Boolean
      {
         var _loc2_:* = param1.oldObject;
         var _loc3_:* = false;
         if(_loc2_.activated == true)
         {
            _loc2_.light.visible = true;
            _loc3_ = true;
            if(!param1.on)
            {
               this.playSound(this.eventSounds[this.allDevices.indexOf(param1)]);
            }
            param1.on = true;
         }
         else
         {
            param1.on = false;
            _loc2_.light.visible = false;
            _loc3_ = false;
         }
         _loc2_.activated = false;
         return _loc3_;
      }
      
      public function checkMirrorSlider(param1:Object) : Boolean
      {
         var _loc2_:* = param1.oldObject;
         if(_loc2_.GetUserData().GetPosition().y != _loc2_.GetUserData().GetUserData().originy)
         {
            _loc2_.GetUserData().SetXForm(new b2Vec2(_loc2_.GetUserData().GetPosition().x,_loc2_.GetUserData().GetUserData().originy),0);
         }
         var _loc3_:* = _loc2_.GetUserData().GetLinearVelocity();
         if(_loc3_.Length() > 1)
         {
            _loc2_.SetMaxMotorForce(15);
         }
         else
         {
            _loc2_.SetMaxMotorForce(5);
         }
         _loc2_.GetUserData().SetLinearVelocity(_loc3_);
         var _loc4_:* = (_loc2_.GetUserData().GetPosition().x - _loc2_.GetUserData().GetUserData().originx) / _loc2_.GetUserData().GetUserData().length * Math.PI / 2 + _loc2_.GetUserData().GetUserData().shift;
         if(this._value != _loc4_)
         {
            trace("CLICKLPALTYIN" + this.clickPlaying);
            if(this.clickPlaying <= 0)
            {
               this.playSound(this.eventSounds[this.allDevices.indexOf(param1)]);
               this.clickPlaying = 3;
               param1.addEventListener(Event.ENTER_FRAME,this.waitForClick);
            }
            this._value = _loc4_;
            return !this.inputActive;
         }
         return this.inputActive;
      }
      
      public function waitForClick(param1:*) : void
      {
         --this.clickPlaying;
         if(this.clickPlaying <= 0)
         {
            param1.target.removeEventListener(Event.ENTER_FRAME,this.waitForClick);
         }
      }
      
      public function checkToEndSliderSound(param1:*) : void
      {
         trace("slider running");
         var _loc2_:* = param1.target.oldObject;
         if(Math.sqrt(_loc2_.GetUserData().GetLinearVelocity().x ^ 2 + _loc2_.GetUserData().GetLinearVelocity().y ^ 2) == 0)
         {
            this.stopSound(this.allDevices.indexOf(param1.target));
            param1.target.removeEventListener(Event.ENTER_FRAME,this.checkToEndSliderSound);
         }
      }
      
      public function checkToEndRotateSound(param1:*) : void
      {
         var _loc2_:* = param1.target.oldObject;
         trace("rotater running ");
         if(_loc2_.GetJointAngle() <= _loc2_.GetLowerLimit() || _loc2_.GetJointAngle() >= _loc2_.GetUpperLimit())
         {
            this.stopSound(this.allDevices.indexOf(param1.target));
            param1.target.removeEventListener(Event.ENTER_FRAME,this.checkToEndRotateSound);
         }
      }
      
      public function setSliderPlatform(param1:Object) : *
      {
         var _loc2_:* = param1.oldObject;
         if(this.outputActive)
         {
            _loc2_.GetUserData().GetUserData().bar.getChildByName("light").visible = true;
            _loc2_.SetMotorSpeed(-2);
            _loc2_.GetUserData().ApplyForce(new b2Vec2(-1,0),_loc2_.GetUserData().GetWorldCenter());
         }
         else
         {
            _loc2_.GetUserData().GetUserData().bar.getChildByName("light").visible = false;
            _loc2_.SetMotorSpeed(2);
            _loc2_.GetUserData().ApplyForce(new b2Vec2(1,0),_loc2_.GetUserData().GetWorldCenter());
         }
         trace("---------SLIDER STARTED ---------------");
         this.longSoundFlags[this.allDevices.indexOf(param1)] = true;
         if(param1.hasEventListener(Event.ENTER_FRAME))
         {
            this.stopSound(this.allDevices.indexOf(param1));
            param1.removeEventListener(Event.ENTER_FRAME,this.checkToEndSliderSound);
         }
         param1.addEventListener(Event.ENTER_FRAME,this.checkToEndSliderSound);
      }
      
      public function setRotatingObject(param1:Object) : *
      {
         var _loc2_:* = param1.oldObject;
         if(this.outputActive)
         {
            _loc2_.GetUserData().GetUserData().bar.getChildByName("light").gotoAndStop(2);
            _loc2_.SetMotorSpeed(2);
            _loc2_.GetUserData().ApplyTorque(1);
         }
         else
         {
            _loc2_.GetUserData().GetUserData().bar.getChildByName("light").gotoAndStop(1);
            _loc2_.SetMotorSpeed(-2);
            _loc2_.GetUserData().ApplyTorque(-1);
         }
         this.longSoundFlags[this.allDevices.indexOf(param1)] = true;
         if(param1.hasEventListener(Event.ENTER_FRAME))
         {
            this.stopSound(this.allDevices.indexOf(param1));
            param1.removeEventListener(Event.ENTER_FRAME,this.checkToEndRotateSound);
         }
         param1.addEventListener(Event.ENTER_FRAME,this.checkToEndRotateSound);
      }
      
      public function setInfiniteMirror(param1:Object) : *
      {
         var _loc2_:* = param1.oldObject;
         _loc2_.GetUserData().SetXForm(_loc2_.GetUserData().GetPosition(),this._value);
      }
      
      public function setWind(param1:Object) : *
      {
         var _loc2_:* = param1.oldObject;
         if(this.outputActive)
         {
            this.longSoundFlags[this.allDevices.indexOf(param1)] = true;
            _loc2_.on = true;
         }
         else
         {
            this.longSoundFlags[this.allDevices.indexOf(param1)] = false;
            _loc2_.on = false;
         }
      }
      
      public function setPortal(param1:Object) : *
      {
         var _loc2_:* = param1.oldObject;
         if(this.outputActive)
         {
            if(this._index != -1 && !_loc2_.on)
            {
               this.playSound(this.PORTAL_OPEN_SOUND);
            }
            this.longSoundFlags[this.allDevices.indexOf(param1)] = true;
            _loc2_.on = true;
         }
         else
         {
            if(this._index != -1 && Boolean(_loc2_.on))
            {
               this.playSound(this.PORTAL_CLOSED_SOUND);
            }
            this.longSoundFlags[this.allDevices.indexOf(param1)] = false;
            _loc2_.on = false;
         }
      }
      
      public function killSounds() : *
      {
         var _loc1_:* = 0;
         while(_loc1_ < this.longSoundFlags.length)
         {
            this.stopSound(_loc1_);
            _loc1_++;
         }
      }
      
      public function setPortalVolume(param1:Number, param2:Object) : void
      {
         var _loc3_:* = undefined;
         if(this.mySoundChannels[this.allDevices.indexOf(param2)])
         {
            if(this.mySoundChannels[this.allDevices.indexOf(param2)].soundTransform.volume != param1)
            {
               _loc3_ = Math.max(0,param1 * 1.5 - 0.5);
               this.mySoundChannels[this.allDevices.indexOf(param2)].soundTransform = new SoundTransform(_loc3_);
            }
         }
      }
      
      public function setLightBeamer(param1:Object) : *
      {
         var _loc2_:* = param1.oldObject;
         if(this.outputActive)
         {
            _loc2_.on = true;
            _loc2_.glower.visible = true;
         }
         else
         {
            _loc2_.on = false;
            _loc2_.glower.visible = false;
         }
      }
   }
}
