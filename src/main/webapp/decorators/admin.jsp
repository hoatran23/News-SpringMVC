<%@ page language="java" trimDirectiveWhitespaces="true" language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglib.jsp" %>	
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title><dec:title default="Admin Home"/></title>
<!-- Custom fonts for this template-->
<link href="<c:url value ='/template/admin/vendor/fontawesome-free/css/all.min.css'/>" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
<!-- Custom styles for this template-->
<link href="<c:url value ='/template/admin/css/sb-admin-2.min.css'/>" rel="stylesheet">
<dec:head/>
</head>
<body id="page-top">
<!-- Page Wrapper -->
<div id="wrapper">
	<!-- Sidebar -->
	<%@ include file="/common/admin/menu.jsp"%>
	<!-- End of Sidebar -->
	<!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">
		<!-- Main Content -->
		<div id="content">
			<!-- Topbar -->
			<%@ include file="/common/admin/header.jsp"%>
			<!-- End of Topbar -->
			<dec:body/>
		</div>
		<!-- End of Main Content -->
		<!-- Footer -->
		<%@ include file="/common/admin/footer.jsp"%>
		<!-- End of Footer -->
	</div>
    <!-- End of Content Wrapper -->
</div>
<!-- End of Page Wrapper -->

<!-- Bootstrap core JavaScript-->
<script src="<c:url value ='/template/admin/vendor/jquery/jquery.min.js'/>"></script>
<script src="<c:url value ='/template/admin/vendor/bootstrap/js/bootstrap.bundle.min.js'/>"></script>

<!-- Core plugin JavaScript-->
<script src="<c:url value ='/template/admin/vendor/jquery-easing/jquery.easing.min.js'/>"></script>

<!-- Custom scripts for all pages-->
<script src="<c:url value ='/template/admin/js/sb-admin-2.min.js'/>"></script>
<script>
	/* $(document).ready(function () {
		$('#btnSearch').click(function (e) {
		    e.preventDefault();
		    var formData = $('#search').val();
		    
		});
	}); */
</script>

<dec:getProperty property="page.local_script"></dec:getProperty>
</body>
</html>