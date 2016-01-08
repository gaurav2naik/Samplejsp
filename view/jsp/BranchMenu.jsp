<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
body#home li#home_nav, body#bd li#bd_nav, body#bce li#bce_nav, body#bi li#bi_nav,
	body#bcg li#bcg_nav, body#blm li#blm_nav, body#logout li#logout_nav, body#br_qos li#br_qos_nav {
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
			<li id="bd_nav"><a href='BranchDashboard.jsp'><span>DASHBOARD
				</span></a></li>
			<li id="bce_nav"><a href="BranchCustomerExperience.jsp"><span>USER
						EXPERIENCE</span></a></li>

			<li id="blm_nav"><a href='BranchLiveMonitoring.jsp'><span>LIVE
						MONITORING</span></a></li>
			<li id="bi_nav"><a href='BranchIncidents.jsp'><span>INCIDENTS</span></a>
			<li id="br_qos_nav"><a href='branchQos.jsp'><span>BRANCH QOS</span></a></li>
			<li class="last" id="logout_nav"><a href='Logout.jsp'><span><img
						src="../image/LOGOUT.png" alt=" Logout"
						style="margin-top: -15%; width: 30px; height: 30px;"></span></a></li>

			<li class="last" id="bcg_nav"><a href='BranchConfiguration.jsp'><span><img
						src="../image/CONFIG.png" alt=" Configuration"
						style="margin-top: -15%; width: 30px; height: 30px;"></span></a></li>
			<li class='last' id='bd_nav'><a
				href="BranchDashboard.jsp"><span><img
						src='../image/home.png' alt='Home'
						style='margin-top: -15%; width: 30px; height: 30px;'></span></a></li>


		</ul>
	</div>

</body>
</html>