<%@ page language="java" trimDirectiveWhitespaces="true" language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<c:url var="editNewURL" value="/admin-news/edit"/>
<c:url var="newAPI" value="/api/news"/>
<c:url var="newsURL" value="/admin-news"/>
<c:url var="cancleUrl" value='/admin-news/list?page=1&limit='/>
<!-- Begin Page Content -->
<div class="container-fluid">
	<div class="card shadow mb-4">
		<div class="card-header py-3 d-flex justify-content-between">
			<h6 class="m-0 font-weight-bold text-primary">Articles</h6>
		</div>
		<div class="card-body">
			<form:form class="form-horizontal" role="form" id="formSubmit" modelAttribute="newsDTO">
				<div class="form-group">
					<label>Category</label> 
					<form:select path="categoryCode" id="categoryCode" cssClass="form-control" disabled="true">
				  		<form:option value="" label="-- Choose Category --"/>
				  	 	<form:options items="${categories}"/>
				  	</form:select>
				</div>
				<div class="form-group">
					<label>Title</label> 
					<form:input path="title" cssClass="form-control" disabled="true"/>
				</div>
				<div class="form-group">
					<label>Thumbnail</label> 
					<input type="file" class="form-control" id="thumbnail" placeholder="Add thumbnail of article" disabled="true">
				</div>
				<div class="form-group">
					<label>Short Description</label> 
					<form:textarea path="shortDescription" cssClass="form-control" rows="10" cols="80" disabled="true"/>
				</div>
				<div class="form-group">
					<label>Content</label> 
					<form:textarea path="content" cssClass="form-control" name="editor" id="editor" rows="10" cols="80" disabled="true"/>
				</div>
				<form:hidden path="id" id="newsId"/>
				
				<c:if test="${not empty newsDTO.id}">
					<c:url var="updateNewsURL" value="/admin-news/edit">
						<c:param name="id" value="${newsDTO.id}"/>	
					</c:url>
					<a class="btn btn-primary" href="${updateNewsURL}">Go to Update</a>
				</c:if>
				<a href="${cancleUrl}<fmt:message key='label.limit.page' bundle='${lang}'/>" class="btn btn-danger"> <span
						class="icon text-white-50">
					</span> <span class="text">Cancle</span>
				</a>
			</form:form>
		</div>
	</div>
</div>
<!-- /.container-fluid -->

<content tag="local_script"> 
<script src="//cdn.ckeditor.com/4.19.1/full/ckeditor.js"></script>
<script>
        CKEDITOR.replace( 'editor' );
</script>
</content>
