<%@ page language="java" trimDirectiveWhitespaces="true" language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglib.jsp" %>
<title>News Management</title>
<c:url var="newsUrlApi" value="/api/news"/>
<c:url var="newsURL" value="/admin-news/list"/>
<!-- Begin Page Content -->
<div class="container-fluid">
    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">Tables</h1>
    <p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below.
        For more information about DataTables, please visit the <a target="_blank"
            href="https://datatables.net">official DataTables documentation</a>.</p>
    <c:if test="${not empty message}">
		<div class="alert alert-${alert} alert-dismissible">
		 	<button type="button" class="close" data-dismiss="alert">&times;</button>
			${message}
		</div>
	</c:if>

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
    <form action="<c:url value='/admin-news/list'/>" id="formSubmit" method="get">
        <div class="card-header py-3 d-flex justify-content-between">
            <h6 class="m-0 font-weight-bold text-primary">Articles List</h6>
            <div>
		        <a href="<c:url value='/admin-news/edit'/>" class="btn btn-success">
		             <span class="text">Add Article</span>
		        </a>
		        <button type="button" class="btn btn-danger" id="delete" disabled>
		             <span class="text">Delete</span>
		        </button>
	        </div>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="checkedAll"></th>
							<th>Post title</th>
							<th>Short Description</th>
							<th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach var="item" items="${newsDTO.listResult}">
                        <tr>
                            <td><input type="checkbox" name="checkSingle" class="checkSingle" id="checkbox_${item.id}" value="${item.id}"></td>
							<td>${item.title}</td>
							<td>${item.shortDescription}</td>
							<td>
								<c:url var="updateNewURL" value="/admin-news/edit">
									<c:param name="id" value="${item.id}"/>															
								</c:url>																
								<a class="btn btn-warning btn-circle" data-toggle="tooltip"
								   title="Update article" href="${updateNewURL}"><i class="fas fa-exclamation-triangle" aria-hidden="true"></i>
								</a>
								<c:url var="detailNewsURL" value="/admin-news/detail">
									<c:param name="id" value="${item.id}"/>															
								</c:url>	
								<a class="btn btn-info btn-circle" data-toggle="tooltip"
								   title="Detail article" href="${detailNewsURL}"><i class="fas fa-info-circle" aria-hidden="true"></i>
								</a>
							</td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="col-sm-12 d-flex flex-row-reverse">
                	<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
	                	<ul class="pagination" id="pagination"></ul>	
	                </div>
                </div>
				<input type="hidden" value="" id="page" name="page"/>
				<input type="hidden" value="" id="limit" name="limit"/>
            </div>
        </div>
    </form>
    </div>

</div>
<!-- /.container-fluid -->

<content tag="local_script">
<script src="<c:url value ='/template/admin/js/jquery.twbsPagination.min.js'/>"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
var totalPages = ${newsDTO.totalPage};
var currentPage = ${newsDTO.currentPage};
$(document).ready(function () {
	$("#checkedAll").change(function() {
        if (this.checked) {
            $(".checkSingle").each(function() {
                this.checked=true;
            });
            $('#delete').removeAttr('disabled');
        } else {
            $(".checkSingle").each(function() {
                this.checked=false;
            });
            $('#delete').attr('disabled', 'disabled');
        }
    });

    $(".checkSingle").click(function () {
        if ($(this).is(":checked")) {
            var isAllChecked = 0;
            $(".checkSingle").each(function() {
            	// console.log(this.checked);
                if (!this.checked) {
                	isAllChecked = 1;
                }
            });

            if (isAllChecked == 0) {
                $("#checkedAll").prop("checked", true);
            }     
        }
        else {
            $("#checkedAll").prop("checked", false);
        }
    });
    
    $(".checkSingle").change(function() {
    	if ($('.checkSingle:checked').length > 0) {
            $('#delete').removeAttr('disabled');
        } else {
            $('#delete').attr('disabled', 'disabled');
        }
    });
    
    $("#delete").click(function(){
    	warningDelete(); 
    });
});

function articleDelete(data) {
	$('input:checkbox.checkSingle').each(function () {
        if (this.checked) {
        	console.log($(this).val());
        	id = $(this).val();
        	data.push(id);
        }
    });
	return data;
}

function deleteNews(data) {
	$.ajax({
        url: '${newsUrlApi}',
        type: 'DELETE',
        contentType: 'application/json',
        data: JSON.stringify(data),
        success: function (result) {
        	window.location.href = "${newsURL}?page=1&limit=<fmt:message key='label.limit.page' bundle='${lang}'/>&message=delete_success";
        },
        error: function (error) {
        	window.location.href = "${newsURL}?page=1&limit=<fmt:message key='label.limit.page' bundle='${lang}'/>&message=error_system";
        }
    });
}

function warningDelete() {
	swal({
	  title: "Are you sure?",
	  text: "Once deleted, you will not be able to recover this article!",
	  icon: "warning",
	  buttons: true,
	  dangerMode: true,
	})
	.then((willDelete) => {
	  if (willDelete) {
	    	var data = [];
		 	articleDelete(data);
	    	deleteNews(data);
	  } else {
	   		swal("Your article is safe!");
	  }
	});
}

$(function() {
    window.pagObj = $('#pagination').twbsPagination({
        totalPages: totalPages,
        visiblePages: 5,
        startPage: currentPage,
        loop:true,
        onPageClick: function (event, page) {
        	if (currentPage != page) {
        		$('#limit').val(<fmt:message key='label.limit.page' bundle='${lang}'/>);
				$('#page').val(page);
				$('#formSubmit').submit();
			}
        }
    });
});
</script>
</content>
