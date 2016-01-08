function recentdata()
{
   
    if(window.XMLHttpRequest)
        obj=new XMLHttpRequest();
    else if(window.ActiveXObject)
        obj=new ActiveXObject("Microsoft.XMLHTTP");
   
   
    url="../../DashboardServlet?id=news";
   
    obj.onreadystatechange=handledashboard;
    obj.open('Post',url, true);
   
    obj.send();
}
setInterval('recentdata()', 3000);
function handledashboard()
{
   
if(obj.readyState==4||obj.status==200)
   
    {
	   document.getElementById("throughput").innerHTML=obj.responseText;
   
    }
}