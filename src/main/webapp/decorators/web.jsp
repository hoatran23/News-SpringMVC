<%@ page language="java" trimDirectiveWhitespaces="true" language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title><dec:title default="Home Page"/></title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="<c:url value='/template/web/assets/favicon.ico'/>" />
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="<c:url value='/template/web/css/styles.css'/>" rel="stylesheet" /> <dec:head/>
</head>
<body class="d-flex flex-column h-100">
<main class="flex-shrink-0">
<!-- Navigation-->
<%@ include file="/common/web/navbar.jsp"%>
<!-- End navigation  -->
<!-- Header -->
<%@ include file="/common/web/header.jsp"%>
<!-- End Header  -->
<dec:body/>
</main>
<%-- Footer --%>
<%@ include file="/common/web/footer.jsp"%>
<!-- End Footer -->
<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="<c:url value='/template/web/js/scripts.js'/>"></script>
</body>
</html>