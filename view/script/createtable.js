function createtable()

{

	var IP1 = document.getElementById("IP").value;
	var URL1 = document.getElementById("URL2").value;

	var xmlhttp;
	if (window.XMLHttpRequest)
		xmlHttp = new XMLHttpRequest();
	else if (window.ActiveXObject)
		xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");

	var url = "../../GetTableServlet";

	url = url + "?id=recenttable&IP=" + IP1 + "&URL=" + URL1;

	xmlHttp.open("POST", url, true);
	xmlHttp.onreadystatechange = table2;
	xmlHttp.send();
}
function table2() {

	if (xmlHttp.readyState == 4 || xmlHttp.readyState == 200) {

		document.getElementById("tab125").innerHTML = xmlHttp.responseText
	}

}
function incidetCustomizedSearch()
{
	var startTime = document.getElementById("demo1").value;
	var endTime = document.getElementById("demo2").value;
	alert(startTime+endTime);
	
	if (startTime == "") {
		document.getElementById("error").innerHTML="Please enter Start Time";
		return false;
	}
	// return true;

	else if (endTime == "") {
		document.getElementById("error").innerHTML="Please enter End Time";
		return false;
	}
	else  {

	var xmlhttp;
	if (window.XMLHttpRequest)
		xmlHttp = new XMLHttpRequest();
	else if (window.ActiveXObject)
		xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");

	var url = "../../GetTableServlet";

	url = url + "?id=incidentCustomized&startTime=" + startTime + "&endTime=" +endTime;

	xmlHttp.open("POST", url, true);
	xmlHttp.onreadystatechange = response;
	xmlHttp.send();
	}
}
function response() {

	if (xmlHttp.readyState == 4 || xmlHttp.readyState == 200) {

		document.getElementById("incident_table").innerHTML = xmlHttp.responseText
	}

}

