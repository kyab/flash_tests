

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import mx.core.IPropertyChangeNotifier;
import mx.events.PropertyChangeEvent;
import mx.utils.ObjectProxy;
import mx.utils.UIDUtil;

import mx.controls.Button;

class BindableProperty
{
	/**
	 * generated bindable wrapper for property myButton (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'myButton' moved to '_1292292098myButton'
	 */

    [Bindable(event="propertyChange")]
    public function get myButton():mx.controls.Button
    {
        return this._1292292098myButton;
    }

    public function set myButton(value:mx.controls.Button):void
    {
    	var oldValue:Object = this._1292292098myButton;
        if (oldValue !== value)
        {
            this._1292292098myButton = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "myButton", oldValue, value));
        }
    }



}
