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

flvplayback_internal var accessibilityPropertyNames:Array = [
			"Pause",
			"Play",
			"Stop",
			"Seek Bar", // seekBarHandle
			null, // seekBarHit
			"Back",
			"Forward",
			"Go Full Screen",
			"Exit Full Screen",
			"Volume Mute On",
			"Volume Mute Off",
			"Volume", // volumeBarHandle
			null, // volumeBarHit
			null, // playPause
			null, // fullScreenToggle
			null, // volumeMute
			"Buffering",
			null,
			null,
			
			// these are for other avatar names that should be treated specially
			null, // "seekBarHandle_mc"
			null, // "seekBarHit_mc"
			null, // "seekBarProgress_mc"
			null, // "seekBarFullness_mc"
			null, // "volumeBarHandle_mc"
			null, // "volumeBarHit_mc"
			null, // "volumeBarProgress_mc"
			null, // "volumeBarFullness_mc"
			null, // "progressFill_mc"
			
			"Captions Off",
			"Captions On",
			"Show Video Player Controls",
			"Hide Video Player Controls"
		];