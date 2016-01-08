function getURL()

{
	  var str=document.getElementById("IP").value;
	  
	  if(window.XMLHttpRequest)
	       xmlHttp= new XMLHttpRequest();
	  else if(window.ActiveXObject)
	       xmlHttp= new ActiveXObject("Microsoft.XMLHTTP");
	  
	  var url="../../LiveReportserv";
	  
	  url+="?IP="+str;
	 
   xmlHttp.onreadystatechange =handleResponse;
   xmlHttp.open("POST", url, true);
   xmlHttp.send();
}


function handleResponse()
   {   
	
    if (xmlHttp.readyState==4 || xmlHttp.readyState==200)
    {   
    	
      document.getElementById("URL").innerHTML=xmlHttp.responseText   
    }   
   }


function passGenerator() {
	var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZ";
	var string_length = 12;
	var randomstring = '';
	for (var i = 0; i < string_length; i++) {
		var rnum = Math.floor(Math.random() * chars.length);
		randomstring += chars.substring(rnum, rnum + 1);
	}
	document.passGeneration.pwd.value = randomstring;
}