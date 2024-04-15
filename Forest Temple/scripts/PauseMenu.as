package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.*;
   import flash.media.SoundTransform;
   import flash.text.TextField;
   import flash.ui.*;
   
   [Embed(source="/_assets/assets.swf", symbol="PauseMenu")]
   public class PauseMenu extends Sprite
   {
       
      
      internal var ps:level;
      
      public var RedCount:TextField;
      
      public var btn:SimpleButton;
      
      internal var MaxPos:Number = 90;
      
      internal var transition:Number = 0;
      
      internal var OverSound:Over_Sound;
      
      internal var acc:Number = -9;
      
      internal var v:Number = 0;
      
      internal var trans:SoundTransform;
      
      public var retryBtn:SimpleButton;
      
      public var endGameBtn:SimpleButton;
      
      public var BlueCount:TextField;
      
      public var Tapper:MovieClip;
      
      internal var MinPos:Number = 480;
      
      public function PauseMenu()
      {
         MaxPos = 90;
         MinPos = 480;
         transition = 0;
         acc = -9;
         v = 0;
         super();
         btn.addEventListener(MouseEvent.MOUSE_DOWN,Show_Hide);
         addEventListener(Event.ENTER_FRAME,Update,false,0,true);
         retryBtn.addEventListener(MouseEvent.MOUSE_DOWN,RetryLevel);
         endGameBtn.addEventListener(MouseEvent.MOUSE_DOWN,EndGame);
         retryBtn.addEventListener(MouseEvent.MOUSE_OVER,OverSounder);
         endGameBtn.addEventListener(MouseEvent.MOUSE_OVER,OverSounder);
         trans = new SoundTransform(1);
         OverSound = new Over_Sound();
      }
      
      internal function Show_Hide(param1:MouseEvent) : *
      {
         BlueCount.text = String((this.parent.getChildByName("m_level") as level).myContactListener.BlueCount);
         RedCount.text = String((this.parent.getChildByName("m_level") as level).myContactListener.RedCount);
         if((this.parent.getChildByName("m_level") as level).ended == false)
         {
            if(this.y > MaxPos + 300)
            {
               transition = 1;
            }
            else
            {
               transition = -1;
            }
         }
      }
      
      public function OverSounder(param1:MouseEvent) : *
      {
         OverSound.play(0,1);
      }
      
      internal function EndGame(param1:MouseEvent) : *
      {
         trace("a");
         (this.parent as Game).EndGame();
         trace("b");
      }
      
      public function Update(param1:Event) : void
      {
         var _loc2_:* = undefined;
         if(transition == 1)
         {
            if(trans.volume - 0.1 >= 0.2)
            {
               trans.volume -= 0.1;
            }
            else
            {
               trans.volume = 0.2;
            }
            (this.parent as Game).MusicChannel.soundTransform = trans;
            _loc2_ = 0;
            while(_loc2_ < (this.parent as Game).m_level.windChannels.length)
            {
               (this.parent as Game).m_level.windChannels[_loc2_].soundTransform = trans;
               _loc2_++;
            }
            (this.parent.getChildByName("m_level") as level).pause = true;
            if(this.y > MaxPos + 100)
            {
               acc = -(this.y - MaxPos) / 20;
            }
            else
            {
               acc = -(this.y - MaxPos) / 10;
            }
            this.y += v;
            v += acc;
            if(this.y > MaxPos + 100)
            {
               v *= 0.8;
            }
            else
            {
               v *= 0.6;
            }
            if(Math.abs(MaxPos - this.y) < 0.2 && Math.abs(v) < 0.2)
            {
               this.y = MaxPos;
               transition = 0;
               trans.volume = 0.2;
            }
         }
         if(transition == -1)
         {
            if(trans.volume + 0.1 <= 1)
            {
               trans.volume += 0.1;
            }
            else
            {
               trans.volume = 1;
            }
            (this.parent as Game).MusicChannel.soundTransform = trans;
            _loc2_ = 0;
            while(_loc2_ < (this.parent as Game).m_level.windChannels.length)
            {
               (this.parent as Game).m_level.windChannels[_loc2_].soundTransform = trans;
               _loc2_++;
            }
            if((this.parent.getChildByName("m_level") as level).ended == false)
            {
               (this.parent.getChildByName("m_level") as level).pause = false;
            }
            if(this.y < MinPos - 100)
            {
               acc = -(this.y - MinPos) / 20;
            }
            else
            {
               acc = -(this.y - MinPos) / 10;
            }
            this.y += v;
            v += acc;
            if(this.y < MinPos - 100)
            {
               v *= 0.8;
            }
            else
            {
               v *= 0.6;
            }
            if(Math.abs(MinPos - this.y) < 0.2 && Math.abs(v) < 0.2)
            {
               this.y = MinPos;
               transition = 0;
               trans.volume = 1;
            }
         }
         Tapper.y = -this.y + 240;
         Tapper.alpha = Math.abs(1 - (this.y - 90) / 390);
      }
      
      internal function RetryLevel(param1:MouseEvent) : *
      {
         trace("a");
         trans.volume = 1;
         (this.parent as Game).MusicChannel.soundTransform = trans;
         (this.parent as Game).MusicChannel.stop();
         if((this.parent as Game).m_level.CurrentMode == "speed")
         {
            (this.parent as Game).MusicChannel = (this.parent as Game).SpeedSound.play(0,999);
         }
         else
         {
            (this.parent as Game).MusicChannel = (this.parent as Game).AdvSound.play(0,999);
         }
         (this.parent as Game).RetryGame();
         trace("b");
      }
   }
}
