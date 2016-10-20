function getConfig(){
	var obj = new Object();
	obj.ip="119.134.251.146";
	obj.port="9100";
	obj.resourceHost="http://119.134.251.182:8080/";
	return obj;
}

function onLoginGame(){
	 var userObj = new Object();
	 userObj.openid=getHttpParams("openid");
	 userObj.openkey=getHttpParams("openkey");
	 userObj.appid=appId;
	 userObj.seqid=getHttpParams("seqid");
	 userObj.serverid=getHttpParams("serverid");
	 userObj.pf=getHttpParams("pf");
	 userObj.pfkey=getHttpParams("pfkey");
	 userObj.platform=getHttpParams("platform");
	 userObj.serverid=getHttpParams("serverid");


	 userObj.userName=getHttpParams("userName");	  
	 userObj.identityCard=getHttpParams("identityCard"); 
	 userObj.sign=getHttpParams("sign"); 
	 userObj.srcUrl=getHttpParams("srcUrl"); 
	 userObj.time=getHttpParams("time");
	 if(getHttpParams("agentid")){
		 userObj.agentid=getHttpParams("agentid"); 
	 }
	 return	userObj;
}
