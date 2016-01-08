<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<style>
html {
	height: 100%;
	width: 100%;
	margin: 0;
	padding: 0;
}

body {
	height: 100%;
	width: 100%;
	margin: 0;
	padding: 0;
	position: relative;
	background: -moz-linear-gradient(45deg, rgba(0, 255, 128, 1) 0%,
		rgba(0, 219, 219, 1) 100%); /* ff3.6+ */
	background: -webkit-gradient(linear, left bottom, right top, color-stop(0%, rgba(0,
		255, 128, 1)), color-stop(100%, rgba(0, 219, 219, 1)));
	/* safari4+,chrome */
	background: -webkit-linear-gradient(45deg, rgba(0, 255, 128, 1) 0%,
		rgba(0, 219, 219, 1) 100%); /* safari5.1+,chrome10+ */
	background: -o-linear-gradient(45deg, rgba(0, 255, 128, 1) 0%,
		rgba(0, 219, 219, 1) 100%); /* opera 11.10+ */
	background: -ms-linear-gradient(45deg, rgba(0, 255, 128, 1) 0%,
		rgba(0, 219, 219, 1) 100%); /* ie10+ */
	background: linear-gradient(45deg, rgba(0, 255, 128, 1) 0%,
		rgba(0, 219, 219, 1) 100%); /* w3c */
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#00DBDB',
		endColorstr='#00ff80', GradientType=1); /* ie6-9 */
	background-repeat: no-repeat;
	background-size: 100%;
	background-repeat: no-repeat;
	/*background-size: 100%;  */
	/*  opacity: 0.4; */
	float: left;
}
</style>
</head>
<body>

	<div class="container">
		<div id="page_header" style="margin-left: 10%; margin-right: 10%">
			<button type="button" class="btn btn-default">Default</button>
			<button type="button" class="btn btn-primary">Primary</button>
			<button type="button" class="btn btn-success">Success</button>
			<button type="button" class="btn btn-info">Info</button>
			<button type="button" class="btn btn-warning">Warning</button>
			<button type="button" class="btn btn-danger">Danger</button>
			<button type="button" class="btn btn-link">Link</button>
		</div>
		<div class="row">
			<div class="col-lg-6" style="background-color: red;">Live Web</div>
			<div class="col-lg-6" style="background-color: green;">Live
				Andro</div>
		</div>
		<div class="row">
			<div class="col-lg-3" style="background-color: blue;">PIE 1</div>
			<div class="col-lg-3" style="background-color: yellow;">pie 2</div>
			<div class="col-lg-6" style="background-color: pink;">
				<div class="row">
					<div class="col-lg-12" style="background-color: black;">page
						hit error</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<iframe id='geolocation' src='GeolocationAvg.jsp'></iframe>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>

