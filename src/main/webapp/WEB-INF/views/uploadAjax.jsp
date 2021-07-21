<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script type="text/javascript" src="${contextPath }/resources/js/jquery-3.4.1.min.js"></script>
</head>
<body>
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>
	</div>
	
	<button id="uploadBtn">upload</button>
	
	<div class="uploadResult">
		<ul>
		</ul>
	</div>
	
	<script>
		$(document).ready(function() {

			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		
			var maxSize = 5242880;
			
			function checkExtension(fileName, fileSize) {
				if(fileSize >= maxSize) {
					alert("파일 사이즈 초과");
					return false;
				}
				
				if(regex.test(fileName)) {
					alert("해당 종류의 파일은 업로드할 수 없습니다.");
					return false;
				}
				return true;
			}
			
			var cloneObj = $(".uploadDiv").clone();
			
			var uploadResult = $(".uploadResult ul");
			
			function showUploadedFile(uploadResultArr) {
				var str = "";
				
				$(uploadResultArr).each(function(i, obj) {
					str += "<li>" + obj.fileName + "</li>";
				});
				
				uploadResult.append(str);
				
			}
			
			$("#uploadBtn").on("click", function() {
				var formData = new FormData;
				
				var inputFile = $("input[name='uploadFile']");
				
				var files = inputFile[0].files;
				
				console.log(files);
				
				// add filedata to formdata
				for(var i = 0; i < files.length; i++) {
					if(!checkExtension(files[i].name, files[i].size)) {
						return false;
					}
					formData.append("uploadFile", files[i]);
				}
				
				$.ajax({
					url :"/uploadAjaxAction",
					processData : false,
					contentType : false,
					data : formData,
					type : 'POST',
					success : function(result) {
						console.log(result);
						
						showUploadedFile(result);
						
						$(".uploadDiv").html(cloneObj.html());
					}
				});
			});
		});
	</script>
</body>
</html>