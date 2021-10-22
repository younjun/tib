var XHR=null;
function getXHR(){
	if(window.ActiveXObject){
		return new ActiveXObject("Msxml2.XMLHTTP");
	}else if(window.XMLHttpRequest){
		return new XMLHttpRequest();
	}else{
		return null;
	}
}
function sendRequest(url,param,callback,method){
	XHR=getXHR();

	var httpMethod=method?method:'GET';
	if(httpMethod!='GET'&&httpMethod!='POST'){
		httpMethod='GET';
	}
	
	var httpParam=(param==null||param=='')?null:param;
	var httpUrl=url;
	
	if(httpMethod=='GET'&&httpParam!=null){
		httpUrl+='?'+param;
	}
	
	XHR.onreadystatechange=callback;
	XHR.open(httpMethod,httpUrl,true);
	XHR.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
	XHR.send(httpMethod=='POST'?httpParam:null);
	
}