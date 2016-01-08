<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	function showElement() {
		// get a reference to your element, or it's container
		var myElement = document.getElementById('elementId');
		myElement.style.display = '';
		hideImage();
	}

	function hideImage() {
		var myElement = document.getElementById('imageId');
		myElement.style.display = 'none';
	}
</script>

</head>


<body>
	<img id="imageId" onclick="showElement()" src="../image/home.png" />



	<div id="elementId" style="display: none">
		<button type="button">Click Me!</button>
	</div>

</body>
</html>