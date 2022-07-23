<%@ page language="java" trimDirectiveWhitespaces="true" language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<c:url var="editNewURL" value="/admin-news/edit"/>
<c:url var="newAPI" value="/api/news"/>
<c:url var="newsURL" value="/admin-news"/>
<c:url var="upload" value="/admin-news/fileUpload"/>
<c:url var="cancleUrl" value='/admin-news/list?page=1&limit='/>
<!-- Begin Page Content -->
<div class="container-fluid">
	<c:if test="${not empty message}">
		<div class="alert alert-${alert} alert-dismissible">
		 	<button type="button" class="close" data-dismiss="alert">&times;</button>
			${message}
		</div>
	</c:if>

	<div class="card shadow mb-4">
		<div class="card-header py-3 d-flex justify-content-between">
			<h6 class="m-0 font-weight-bold text-primary">Articles</h6>
		</div>
		<div class="card-body">
			<form:form class="form-horizontal" role="form" id="formSubmit" modelAttribute="newsDTO" required="required" enctype="mutipart/form-data">
				<div class="form-group">
					<label>Category</label> 
					<form:select path="categoryCode" id="categoryCode" cssClass="form-control">
				  		<form:option value="" label="-- Choose Category --"/>
				  	 	<form:options items="${categories}"/>
				  	</form:select>
				</div>
				<div class="form-group">
					<label>Title</label> 
					<form:input path="title" cssClass="form-control" required="required"/>
				</div>
				<div class="form-group">
					<label>Thumbnail</label> 
					<input type="file" class="form-control" id="thumbnail" multiple="multiple" placeholder="Add thumbnail of article" required="required">
				</div>
				<div class="form-group">
					<label>Short Description</label> 
					<form:textarea path="shortDescription" cssClass="form-control" rows="10" cols="80"/>
				</div>
				<div class="form-group">
					<label>Content</label> 
					<form:textarea path="content" cssClass="form-control" id="editor" rows="10" cols="80"/>
				</div>
				<form:hidden path="id" id="newsId"/>
				
				<c:if test="${not empty newsDTO.id}">
					<input type="button" class="btn btn-primary" id="btnUpdate" value="Update Article">
				</c:if>
				<c:if test="${empty newsDTO.id}">
					<input type="button" class="btn btn-primary" id="btnCreate" value="Addition Article">
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
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
var editor = CKEDITOR.replace( 'editor' );
</script>
<script>
$(document).ready(function () {
	$('#btnUpdate').click(function (e) {
	    e.preventDefault();
	    var formData = $('#formSubmit').serializeArray();
	    formatData(formData);
	});
	
	$('#btnCreate').click(function (e) {
	    e.preventDefault();
	    var formData = $('#formSubmit').serializeArray();
	    formatData(formData);
	});
	
	function formatData(formData) {
		var data = {};
	    $.each(formData, function (i, v) {
	    	data[v.name] = v.value;
        });
	    
	    if (data.categoryCode == "" && data.title == "" && data.shortDescription == "" && editor.getData() == "") {
	    	warningValidate();
	    } else {
	    	var id = $('#newsId').val();
	    	data.content = editor.getData();

		   	if (id != "") {
		   		updateNews(data);
		    } else {
		    	addNews(data);
		    } 
	    }
	}
	
	function addNews(data) {
		$.ajax({
            url: '${newAPI}',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
            	window.location.href = "${editNewURL}?id="+ result.id +"&message=insert_success";
            },
            error: function (error) {
            	window.location.href = "${newsURL}?page=1&limit=10&message=error_system";
            }
        });
	}
	
	function updateNews(data) {
		$.ajax({
            url: '${newAPI}',
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
            	window.location.href = "${editNewURL}?id=" + result.id + "&message=update_success";
            },
            error: function (error) {
            	window.location.href = "${editNewURL}?id=" + $('#newsId').val() + "&message=error_system";
            }
        });
	}
	
	function warningValidate() {
		swal({
			  title: "Content Isn't Ready",
			  text: "Please fill out all fields in the form before submitting!",
			  icon: "warning",
			  dangerMode: true,
			}).then((willDelete) => {
			  if (willDelete) {
				  swal({
					  title: "Good job!",
					  text: "You clicked the button!",
					  icon: "success",
					  button: "Aww yiss!",
					});
			  }
			});
	}
});
</script>
</content>
