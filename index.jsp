<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Login |CIS</title>
<link rel="icon" href="view/image/title.png" type="image/png">
<link href="view/css/login.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="login.css" />
<link rel="stylesheet" type="text/css" href="reset.css" />
<style>
#footer {
	z-index: 10000;
	background-color: black;
	color: white;
	clear: both;
	text-align: center;
	padding-top: 5 px;
	bottom: 0;
	left: 0;
	position: absolute;
	width: 100%;
	height: 1.5em;
	padding-top: 3px;
}
</style>
</head>
<body>
	<%@include file="Header.jsp"%>

	<div id="box">
		<div id="login">
			<h3>
				<span class="fontawesome-lock"></span>Sign In
			</h3>
			<form action="LoginServlet" method="post">
				<fieldset>
					<p>
						<label for="text" style="padding-left: 11px">User Name</label>
					</p>
					<p>
						<input type="text" name="userName">
					</p>
					<!-- JS because of IE support; better: placeholder="mail@address.com" -->

					<p>
						<label for="password" style="padding-left: 11px">Password</label>
					</p>
					<p>
						<input type="password" name="password">
					</p>
					<!-- JS because of IE support; better: placeholder="password" -->
					<p>
 						<label for="role" style="padding-left: 11px" style="">Role <input
							type="radio" name="role" value="Combined" checked="checked">Web and App <input
							type="radio" name="role" value="Branch">Branch
						</label>
						<!-- <input type="hidden" name="role" value="CIO"> -->
					</p>

					<p>
						<input type="submit" value="Sign In">
					</p>

					<%
						if (request.getParameter("err") != null) {
					%>

					<div style="color: red">
						<label><%=request.getParameter("err")%></label>
					</div>

					<%
						}
					%>

				</fieldset>
			</form>
		</div>
	</div>

	<div id="footer">Copyright © avekshaa.com</div>
</body>
</html>