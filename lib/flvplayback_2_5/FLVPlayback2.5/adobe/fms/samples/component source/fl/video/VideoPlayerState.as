/*************************************************************************
*                       
* ADOBE SYSTEMS INCORPORATED
* Copyright 2004-2008 Adobe Systems Incorporated
* All Rights Reserved.
*
* NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the 
* terms of the Adobe license agreement accompanying it.  If you have received this file from a 
* source other than Adobe, then your use, modification, or distribution of it requires the prior 
* written permission of Adobe.
*
**************************************************************************/

package fl.video {

	/**
     * @private
     *
     * @langversion 3.0
     * @playerversion Flash 9.0.28.0
	 */
	public class VideoPlayerState {
		public function VideoPlayerState(owner:VideoPlayer, index:int) {
			this.owner = owner;
			this.index = index;
			this.url = "";
			this.isLive = false;
			this.isLiveSet = true;
			this.totalTime = NaN;
			this.totalTimeSet = true;
			this.autoPlay = (index == 0);
			this.isWaiting = false;
			this.preSeekTime = NaN;
			this.cmdQueue = null;
		}

		// pointer to VideoPlayer
		public var owner:VideoPlayer;

		// index of my VideoPlayer in FLVPlayback.videoPlayers Array
		public var index:int;

		// used to aggregate properties set for playing video to
		// pass to VideoPlayer's play() or load() method
		public var url:String;
		public var isLive:Boolean;
		public var isLiveSet:Boolean;
		public var totalTime:Number;
		public var totalTimeSet:Boolean;
		public var autoPlay:Boolean;
		public var isWaiting:Boolean;
		public var prevState:String;

		// used by UIManager
		public var minProgressPercent:Number;

		// used to determine whether seek that is done
		// was backward or forward or what
		public var preSeekTime:Number;

		// used to queue up commands in FLVPlayback before we are
		// ready to send them to the VideoPlayer
		public var cmdQueue:Array;

	} // class VideoPlayerState

} // package fl.video
