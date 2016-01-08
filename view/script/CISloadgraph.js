/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function loadOverview(startTime, endTime, sourceEndpoint, targetEndpoint, targetView)
{
	//alert(targetView);
    loadIPHeader(startTime,'overview');
    var xmlhttp;
    if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp=new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.onreadystatechange=function()
    {
        if (xmlhttp.readyState==4 && xmlhttp.status==200)
        {
            document.getElementById("graph").innerHTML=xmlhttp.responseText;
            var response = document.getElementById("graph").innerHTML;
            var s2 = response.indexOf("<script id=\"plot\">")+18;
            var s3 = response.indexOf("</script>",s2)-1;
            var scr = response.substring(s2,s3);
            eval(scr);
        }
    }
    if (targetView=="RealTime")
    {
		xmlhttp.open("GET","../Graph/Overview.jsp?startTime=" + startTime + "&endTime=" + endTime,true);
	}
	if (targetView=="LineGraph")
	{
		xmlhttp.open("GET","../Graph/Overview_Datetime_Search.jsp?startTime=" + startTime + "&endTime=" + endTime
										+ "&sourceEndpoint=" + sourceEndpoint+ "&targetEndpoint=" + targetEndpoint,true);
	}
	if (targetView=="ScatterGraph")
	{
		xmlhttp.open("GET","CINContents/Overview_Scatter_graph_Search.jsp?startTime=" + startTime + "&endTime=" + endTime
										+ "&sourceEndpoint=" + sourceEndpoint+ "&targetEndpoint=" + targetEndpoint,true);
	}
	if (targetView=="ConsolidatedView")
	{
		xmlhttp.open("GET","../Graph/Overview_Consolidated_view.jsp",true);
	}
	if (targetView=="MultiLineGraph")
	{
		xmlhttp.open("GET","../Graph/MultimobilevsDEsktop.jsp",true);
	}
	if (targetView=="LineGraphIncident")
	{
		xmlhttp.open("GET","../Graph/Incident.jsp",true);
	}
	

    xmlhttp.send();
}
function loadIPHeader(sessionId,ip)
{

    var xmlhttp;
    if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp=new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.onreadystatechange=function()
    {
        if (xmlhttp.readyState==4 && xmlhttp.status==200)
        {
            document.getElementById("IPHeader").innerHTML=xmlhttp.responseText;
            var response = document.getElementById("graph").innerHTML;
            var s2 = response.indexOf("<script id=\"plot\">")+18;
            var s3 = response.indexOf("</script>",s2)-1;
            var scr = response.substring(s2,s3);
            eval(scr);
        }
    }
    xmlhttp.open("GET","../Graph/IPHeader.jsp?id=" + sessionId+"&ip="+ip,true);
    xmlhttp.send();
}

$(document).ready(function() {
    // call the OverView plugin
    loadOverview(sessionId);
});