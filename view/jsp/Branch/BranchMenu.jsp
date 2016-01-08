<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
body#home li#home_nav, body#md li#md_nav, body#ce li#ce_nav, body#eg li#eg_nav,
	body#cg li#cg_nav, body#lm li#lm_nav, body#logout li#logout_nav, body#br_qos li#br_qos_nav {
	background: #1275ae;
	/* Old browsers */
	background: -moz-linear-gradient(bottom, #0b4669 0%, #1275ae 50%, #1794dc 51%,
		#1691d8 78%, #98d2f4 100%);
	background: -webkit-linear-gradient(bottom, #0b4669 0%, #1275ae 50%, #1794dc 51%,
		#1691d8 78%, #98d2f4 100%);
	background: -o-linear-gradient(bottom, #0b4669 0%, #1275ae 50%, #1794dc 51%, #1691d8
		78%, #98d2f4 100%);
	background: -ms-linear-gradient(bottom, #0b4669 0%, #1275ae 50%, #1794dc 51%,
		#1691d8 78%, #98d2f4 100%);
	background: linear-gradient(to top, #0b4669 0%, #1275ae 50%, #1794dc 51%, #1691d8
		78%, #98d2f4 100%);
}
</style>
</head>
<body id="home">

	<%
		String role1 = (String) session.getAttribute("Role");
	%>

	<div id='cssmenu'>
		<ul>
			<li id="md_nav"><a href='NewWebAndAppDashbord.jsp'><span>DASHBOARD
				</span></a></li>
			<li id="ce_nav"><a href="CustomerExperience.jsp"><span>CUSTOMER
						EXPERIENCE</span></a></li>

			<li id="lm_nav"><a href='LiveMonitoring.jsp'><span>LIVE
						MONITORING</span></a></li>
			<li id="eg_nav"><a href='Exception.jsp'><span>INCIDENTS</span></a>
			<!--  <ul>
						<li id="eg_nav"><a href='IncidentDetail.jsp'><span>Web
									Incident</span></a></li>
						<li id="eg_nav"><a href='ExceptionGraph.jsp'><span>App Incident</span></a></li>
					</ul>  -->
			</li>
			<li id="br_qos_nav"><a href='javascript: submitform()'><span>BRANCH QOS</span></a></li>
			<li class="last" id="logout_nav"><a href='Logout.jsp'><span><img
						src="../image/LOGOUT.png" alt=" Logout"
						style="margin-top: -15%; width: 30px; height: 30px;"></span></a></li>

			<li class="last" id="cg_nav"><a href='Configuration.jsp'><span><img
						src="../image/CONFIG.png" alt=" Configuration"
						style="margin-top: -15%; width: 30px; height: 30px;"></span></a></li>
			<li class='last' id='md_nav'><a
				href='NewWebAndAppDashbord.jsp?role=IT Admin'><span><img
						src='../image/home.png' alt='Home'
						style='margin-top: -15%; width: 30px; height: 30px;'></span></a></li>


		</ul>
	</div>
<form name='myForm' target="" action='http://52.25.239.131/' method='post'>
<input type="hidden" name="Role" value="CIO"/>
<input type="hidden" name="UN" value="<%out.print(session.getAttribute("UN"));%>"/>
</form>
<script type="text/javascript">
function submitform()
{
    if(document.myForm.onsubmit &&
    !document.myForm.onsubmit())
    {
        return;
    }
 document.myForm.submit();
}
</script>
</body>
</html>