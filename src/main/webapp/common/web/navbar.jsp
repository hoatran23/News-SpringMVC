<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="com.hoatt.utils.SecurityUtils" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container px-5">
        <a class="navbar-brand" href="<c:url value='/home'/>">Hoatt Website</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link" href="<c:url value='/home'/>">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="about.html">About</a></li>
                <li class="nav-item"><a class="nav-link" href="contact.html">Contact</a></li>
                <li class="nav-item"><a class="nav-link" href="pricing.html">Pricing</a></li>
                <li class="nav-item"><a class="nav-link" href="faq.html">FAQ</a></li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdownBlog" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Blog</a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownBlog">
                        <li><a class="dropdown-item" href="blog-home.html">Blog Home</a></li>
                        <li><a class="dropdown-item" href="blog-post.html">Blog Post</a></li>
                    </ul>
                </li>
                
                <security:authorize access="isAnonymous()">
                	<li class="nav-item dropdown">
	                    <a class="nav-link dropdown-toggle" id="navbarDropdownPortfolio" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Sign In Now</a>
	                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownPortfolio">
	                        <li><a class="dropdown-item" href="portfolio-overview.html">Sign In</a></li>
	                        <li><a class="dropdown-item" href="${registerUrl}">Sign Up</a></li>
	                    </ul>
	                </li>
                </security:authorize>
                <security:authorize access="isAuthenticated()">
                	<li class="nav-item dropdown">
	                    <a class="nav-link dropdown-toggle" id="navbarDropdownPortfolio" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Hi <%=SecurityUtils.getPrincipal().getFullName()%></a>
	                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownPortfolio">
	                        <li><a class="dropdown-item" href="<c:url value='/logout'/>">Log Out</a></li>
	                    </ul>
	                </li>
                </security:authorize>
            </ul>
        </div>
    </div>
</nav>