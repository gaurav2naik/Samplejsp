function loadOverview(startTime, endTime, targetView)
{
    alert(targetView);
    alert(startTime);
    alert(endTime);
   
    var xmlhttp;
    if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp=new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    if (targetView=="meter11")
    { 
        xmlhttp.open("GET","../Graph/meter11.jsp?startTime=" +startTime+ "&endTime=" +endTime,true);
    }
    xmlhttp.onreadystatechange=function()
    {
        if (xmlhttp.readyState==4 && xmlhttp.status==200)
        {
            document.getElementById("graph").innerHTML=xmlhttp.responseText;
            var response = document.getElementById("graph").innerHTML;            
           var s2 = response.indexOf("<script id=\"plot1\">")+86;
            var s3 = response.indexOf("</script>",s2)-1;
            var scr = response.substring(s2,s3);
            eval(scr);
        }
    }
 
    /*if (targetView=="LineGraph")
    {
        xmlhttp.open("GET","CINContents/Overview_Datetime_Search.jsp?startTime=" + startTime + "&endTime=" + endTime
                                        + "&sourceEndpoint=" + sourceEndpoint+ "&targetEndpoint=" + targetEndpoint,true);
    }
    if (targetView=="ScatterGraph")
    {
        xmlhttp.open("GET","CINContents/Overview_Scatter_graph_Search.jsp?startTime=" + startTime + "&endTime=" + endTime
                                        + "&sourceEndpoint=" + sourceEndpoint+ "&targetEndpoint=" + targetEndpoint,true);
    }
    if (targetView=="ConsolidatedView")
    {
        xmlhttp.open("GET","CINContents/Overview_Consolidated_view.jsp",true);
    }
    */

    xmlhttp.send();
}


$(document).ready(function() {
    // call the OverView plugin
	loadOverview(startTime, endTime, targetView);
});