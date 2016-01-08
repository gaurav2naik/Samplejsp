
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../css/admin.css" />
<link rel="stylesheet" type="text/css" href="../css/index.css" />
<script src="../script/getURL.js"></script>
<title>Insert title here</title>
</head>
<body>
	<%@include file="Header.jsp"%>
	<br>
	<div id="listing"
		style="margin-left: 25%; margin-right: 25%; margin-top: 10%; margin-bottom: 10%;">
		<form action="../../DurationS" method="get">

			<h1>Configuration of Quartz</h1>
			<label>Duration of Average Alerts &nbsp;(seconds)</label> <input
				type="text" name="avgalert"> <label>Duration of
				Incident&nbsp;(seconds) </label> <input type="text" name="incident">
			<label>Duration of Common Calculation (Geo , Device ,
				OS)&nbsp;(seconds) </label> <input type="text" name="usage">
			<center>
				<button type="submit" value="submit">SUBMIT</button>
			</center>
		</form>
	</div>
	<%@include file="Footer.jsp"%>
</body>
</html>
