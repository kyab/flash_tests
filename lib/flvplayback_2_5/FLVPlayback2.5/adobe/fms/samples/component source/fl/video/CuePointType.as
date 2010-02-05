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
	 * The CuePointType class provides constant values for the
	 * <code>type</code> property on the <code>info</code> object of a
	 * MetadataEvent instance of <code>type</code> <code>CUE_POINT</code>.  This <code>type</code> property
	 * is always <code>EVENT</code>, <code>NAVIGATION</code>, or <code>ACTIONSCRIPT</code>.
	 * 
	 * <p>All of these constants can also be
	 * passed into the <code>FLVPlayback.findCuePoint()</code> and
	 * <code>FLVPlayback.findNearestCuePoint()</code> methods as the <code>type</code>
	 * parameter.  The <code>ALL</code> and <code>FLV</code> constants describe multiple
	 * types of cue points for these methods.</p>
	 * 
	 * @see FLVPlayback#findCuePoint()
	 * @see FLVPlayback#findNearestCuePoint()
         * @see MetadataEvent
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
	 */
	public final class CuePointType {

	/**
	 * 
         *
         * Defines the value of the <code>type</code> 
         * parameter of the <code>findCuePoint()</code> and <code>findNearestCuePoint()</code> methods.
         * This constant describes all of the cue points: <code>EVENT, NAVIGATION, and ACTIONSCRIPT</code>.
         * 
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
	 */
		public static const ALL:String = "all";

	/**
         * Defines the value of the <code>type</code> 
         * parameter of the <code>findCuePoint()</code> and <code>findNearestCuePoint()</code> methods.  
         * Additionally, the <code>EVENT</code> constant can be a value
	 * for the <code>type</code> property on the info object of a
         * MetadataEvent instance of <code>type</code> <code>CUE_POINT</code>.
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
	 */
		public static const EVENT:String = "event";

	/**
         * Defines the value of the <code>type</code> 
         * parameter of the <code>findCuePoint()</code> and <code>findNearestCuePoint()</code> methods. 
         * Additionally, the <code>NAVIGATION</code> constant can be a value
	 * for the <code>type</code> property on the info object of a
         * MetadataEvent instance of <code>type</code> <code>CUE_POINT</code>.
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
	 */
		public static const NAVIGATION:String = "navigation";

	/**
         * Defines the value of the <code>type</code> 
         * parameter of the <code>findCuePoint()</code> and <code>findNearestCuePoint()</code> methods. 
         * This constant describes the group of
         * all cue points embedded within a FLV file: <code>NAVIGATION</code> and <code>EVENT</code>.
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
	 */
		public static const FLV:String = "flv";

	/**
         * Defines the value of the <code>type</code> 
         * parameter of the <code>findCuePoint()</code> and <code>findNearestCuePoint()</code> methods.
         * Additionally, the <code>ACTIONSCRIPT</code> constant can be a value
	 * for the <code>type</code> property on the info object of a
         * MetadataEvent instance of <code>type</code> <code>CUE_POINT</code>.
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
		 */
		public static const ACTIONSCRIPT:String = "actionscript";

	}; // class CuePointType

}; // package fl.video
