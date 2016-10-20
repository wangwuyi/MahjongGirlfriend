var RightClick = {
	init: function () {
		this.FlashObjectID = "Index";
		this.FlashContainerID = "container";
		this.Cache = this.FlashObjectID;
		if(window.addEventListener){
			 window.addEventListener("mousedown", this.onGeckoMouse(), true);
		} else {
			document.getElementById(this.FlashContainerID).onmouseup = function() { 
				if (event.button > 1) {
					document.getElementById(RightClick.FlashObjectID).rightClickUp();
					document.getElementById(RightClick.FlashContainerID).releaseCapture(); 
				}
			}
			document.oncontextmenu = function(){ if(window.event.srcElement.id == RightClick.FlashObjectID) { return false; } else { RightClick.Cache = "dota"; }}
			document.getElementById(this.FlashContainerID).onmousedown = RightClick.onIEMouse;
			document.getElementById(this.FlashContainerID).onmousemove = function() { 
				if (event.button > 1) {
					document.getElementById(RightClick.FlashObjectID).rightClickMove();
				} 
			}
		}
	},
	UnInit: function () { 
		if(window.RemoveEventListener){
			window.addEventListener("mousedown", null, true);
			window.RemoveEventListener("mousedown",this.onGeckoMouse(),true);
		} else {
			document.getElementById(this.FlashContainerID).onmouseup = "" ;
			document.oncontextmenu = "";
			document.getElementById(this.FlashContainerID).onmousedown = "";
			document.getElementById(this.FlashContainerID).onmousemove = "";
		}
	},
	killEvents: function(eventObject) {
		if(eventObject) {
			if (eventObject.stopPropagation) eventObject.stopPropagation();
			if (eventObject.preventDefault) eventObject.preventDefault();
			if (eventObject.preventCapture) eventObject.preventCapture();
	   		if (eventObject.preventBubble) eventObject.preventBubble();
		}
	},
	onGeckoMouse: function(ev) {
	  	return function(ev) {
	    if (ev.button != 0) {
			RightClick.killEvents(ev);
			if(ev.target.id == RightClick.FlashObjectID && RightClick.Cache == RightClick.FlashObjectID) {
	    		RightClick.call();
			}
			RightClick.Cache = ev.target.id;
		}
	  }
	},
	onIEMouse: function() {
	  	if (event.button > 1) {
			if(window.event.srcElement.id == RightClick.FlashObjectID && RightClick.Cache == RightClick.FlashObjectID) {
				RightClick.call(); 
			}
			document.getElementById(RightClick.FlashContainerID).setCapture();
			if(window.event.srcElement.id)
			RightClick.Cache = window.event.srcElement.id;
		}
	},
	call: function() {
		document.getElementById(this.FlashObjectID).rightClick();
	}
}