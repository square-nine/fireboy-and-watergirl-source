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
       
      
      public var endGameBtn:SimpleButton;
      
      public var WalkThroughBtn:SimpleButton;
      
      public var RedCount:TextField;
      
      public var Tapper:MovieClip;
      
      public var btn:SimpleButton;
      
      public var BlueCount:TextField;
      
      public var retryBtn:SimpleButton;
      
      internal var MaxPos:Number = 90;
      
      internal var MinPos:Number = 480;
      
      internal var transition:Number = 0;
      
      internal var acc:Number = -9;
      
      internal var v:Number = 0;
      
      internal var ps:level;
      
      internal var trans:SoundTransform;
      
      internal var OverSound:Over_Sound;
      
      public function PauseMenu()
      {
         super();
         this.btn.addEventListener(MouseEvent.MOUSE_DOWN,this.Show_Hide);
         addEventListener(Event.ENTER_FRAME,this.Update,false,0,true);
         this.retryBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.RetryLevel);
         this.endGameBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.EndGame);
         this.retryBtn.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
         this.endGameBtn.addEventListener(MouseEvent.MOUSE_OVER,this.OverSounder);
         this.trans = new SoundTransform(1);
         this.OverSound = new Over_Sound();
      }
      
      public function OverSounder(param1:MouseEvent) : *
      {
         this.OverSound.play(0,1);
      }
      
      internal function EndGame(param1:MouseEvent) : *
      {
         trace("a");
         (this.parent as Game).EndGame();
         trace("b");
      }
      
      internal function RetryLevel(param1:MouseEvent) : *
      {
         trace("a");
         this.trans.volume = 1;
         (this.parent as Game).MusicChannel.soundTransform = this.trans;
         (this.parent as Game).MusicChannel.stop();
         if((this.parent as Game).m_level.CurrentMode == "speed")
         {
            (this.parent as Game).MusicChannel = (this.parent as Game).SpeedSound.play(0,999);
         }
         else if((this.parent as Game).m_level.CurrentMode == "dark")
         {
            (this.parent as Game).MusicChannel = (this.parent as Game).DarkSound.play(0,999);
         }
         else
         {
            (this.parent as Game).MusicChannel = (this.parent as Game).AdvSound.play(0,999);
         }
         (this.parent as Game).RetryGame();
         trace("b");
      }
      
      internal function Show_Hide(param1:MouseEvent) : *
      {
         this.BlueCount.text = String((this.parent.getChildByName("m_level") as level).myContactListener.BlueCount);
         this.RedCount.text = String((this.parent.getChildByName("m_level") as level).myContactListener.RedCount);
         if((this.parent.getChildByName("m_level") as level).ended == false)
         {
            if(this.y > this.MaxPos + 300)
            {
               this.transition = 1;
            }
            else
            {
               this.transition = -1;
            }
         }
      }
      
      public function Update(param1:Event) : void
      {
         var _loc2_:* = undefined;
         if(this.transition == 1)
         {
            if(this.trans.volume - 0.1 >= 0.2)
            {
               this.trans.volume -= 0.1;
            }
            else
            {
               this.trans.volume = 0.2;
            }
            (this.parent as Game).MusicChannel.soundTransform = this.trans;
            _loc2_ = 0;
            while(_loc2_ < (this.parent as Game).m_level.windChannels.length)
            {
               (this.parent as Game).m_level.windChannels[_loc2_].soundTransform = this.trans;
               _loc2_++;
            }
            (this.parent.getChildByName("m_level") as level).pause = true;
            if(this.y > this.MaxPos + 100)
            {
               this.acc = -(this.y - this.MaxPos) / 20;
            }
            else
            {
               this.acc = -(this.y - this.MaxPos) / 10;
            }
            this.y += this.v;
            this.v += this.acc;
            if(this.y > this.MaxPos + 100)
            {
               this.v *= 0.8;
            }
            else
            {
               this.v *= 0.6;
            }
            if(Math.abs(this.MaxPos - this.y) < 0.2 && Math.abs(this.v) < 0.2)
            {
               this.y = this.MaxPos;
               this.transition = 0;
               this.trans.volume = 0.2;
            }
         }
         if(this.transition == -1)
         {
            if(this.trans.volume + 0.1 <= 1)
            {
               this.trans.volume += 0.1;
            }
            else
            {
               this.trans.volume = 1;
            }
            (this.parent as Game).MusicChannel.soundTransform = this.trans;
            _loc2_ = 0;
            while(_loc2_ < (this.parent as Game).m_level.windChannels.length)
            {
               (this.parent as Game).m_level.windChannels[_loc2_].soundTransform = this.trans;
               _loc2_++;
            }
            if((this.parent.getChildByName("m_level") as level).ended == false)
            {
               (this.parent.getChildByName("m_level") as level).pause = false;
            }
            if(this.y < this.MinPos - 100)
            {
               this.acc = -(this.y - this.MinPos) / 20;
            }
            else
            {
               this.acc = -(this.y - this.MinPos) / 10;
            }
            this.y += this.v;
            this.v += this.acc;
            if(this.y < this.MinPos - 100)
            {
               this.v *= 0.8;
            }
            else
            {
               this.v *= 0.6;
            }
            if(Math.abs(this.MinPos - this.y) < 0.2 && Math.abs(this.v) < 0.2)
            {
               this.y = this.MinPos;
               this.transition = 0;
               this.trans.volume = 1;
            }
         }
         this.Tapper.y = -this.y + 240;
         this.Tapper.alpha = Math.abs(1 - (this.y - 90) / 390);
      }
   }
}
