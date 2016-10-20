var _getScript = function(url,dispose){
    var scriptNode = document.createElement("script");
    scriptNode.type = "text/javascript";
    scriptNode.onreadystatechange = scriptNode.onload = function(){
      if (!this.readyState || this.readyState == "loaded" || this.readyState == "complete"){
        if(dispose){dispose()};
        scriptNode.onreadystatechange = scriptNode.onload = null;
        scriptNode.parentNode.removeChild(scriptNode);
      }
    };
    scriptNode.src = url;
    document.getElementsByTagName("head")[0].appendChild(scriptNode);
};

function markTime(step)
{
	
}
//收藏
function bookmarkit()
{
	
}
//刷新页面
function reloadPage(){
	window.location.reload();
}
//自由屏
function intoFullScreen() {
	document.getElementById("container").width="100%";
	document.getElementById("container").height="100%";
	document.getElementById("GameCenter").width="100%";
	document.getElementById("GameCenter").height="100%";
}
//最小屏
function minFullScreen() {
	document.getElementById("container").width="1002";
	document.getElementById("container").height="576";
	document.getElementById("GameCenter").width="1002";
	document.getElementById("GameCenter").height="576";
}
//获取Http参数
function getHttpParams(name)
{
	var r = new RegExp("(\\?|#|&)"+name+"=([^&#]*)(&|#|$)");
	var m = location.href.match(r);
	return decodeURIComponent(!m?"":m[2]);
}
