<%-- 
    Document   : index
    Created on : Jun 18, 2021, 2:09:08 PM
    Author     : asus
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../header.jsp"%>
<div class="main-header">
    <div class="mobile-toggle" id="mobile-toggle">
        <i class='bx bx-menu-alt-right'></i>
    </div>
    <div class="main-title">
        Create new account
    </div>
</div>
<div class="main-content">
    <c:if test="${not empty msg}">
        <div class='alert alert-danger'>File uploaded is not a valid format. You must have uploaded file with extension JPG, PNG, JPEG!</div><br/>
    </c:if>
    <c:if test="${not empty update}">
        <div class='alert alert-success'>Update new information success!</div><br/>
    </c:if>
    <form action="${pageContext.request.contextPath}/admin-account" method="post" autocomplete="off" enctype="multipart/form-data">
        <div class="row">
            <input type="hidden" name="id" value="${param.id}"/>
            <div class="col-12 col-md-12 col-sm-12">
                <div class="form-group">
                    <div class="label">
                        Username
                    </div>
                    <input type="text" name="username" class="form-control" value="${account.username}" readonly>
                </div>
            </div>

            <div class="col-12 col-md-12 col-sm-12">
                <div class="form-group">
                    <div class="label">
                        Full name
                    </div>
                    <input type="text" name="fullname" class="form-control" placeholder="Enter username" value="${account.fullname}" required>
                </div>
            </div>

            <div class="col-12 col-md-12 col-sm-12">
                <div class="form-group">
                    <div class="label">
                        Email
                    </div>
                    <input type="email" name="email" class="form-control" placeholder="Enter email" value="${account.email}" required>
                </div>
            </div>

            <div class="col-12 col-md-12 col-sm-12">
                <div class="form-group">
                    <div class="label">
                        Gender
                    </div>
                    <select name="gender" class="form-control" required>
                        <c:if test="${account.gender == 'f'}">
                            <option value="f" selected>Female</option>
                            <option value="m">Male</option>
                        </c:if>
                        <c:if test="${account.gender == 'm'}">
                            <option value="f">Female</option>
                            <option value="m" selected>Male</option>
                        </c:if>
                    </select>
                </div>
            </div>

            <div class="col-12 col-md-12 col-sm-12">
                <div class="form-group">
                    <div class="label">
                        Role
                    </div>
                    <select name="role" class="form-control" required>
                        <c:if test="${account.role == 'member'}">
                            <option value="member" selected>Member</option>
                            <option value="admin">Admin</option>
                        </c:if>
                        <c:if test="${account.role == 'admin'}">
                            <option value="member">Member</option>
                            <option value="admin" selected>Admin</option>
                        </c:if>
                    </select>
                </div>
            </div>

            <div class="col-12 col-md-12 col-sm-12">
                <div class="form-group">
                    <div class="label">
                        Avatar
                    </div>
                    <div class="form-group center" id="imgThumbnail">

                    </div>
                    <input type="file" name="thumbnail" class="form-control" onchange="previewFile();">
                </div>
            </div>

            <div class="col-12">
                <button class="btn btn-default btn-add" type="submit" name="submit" value="edit"><i class='bx bx-plus'></i> Update</button>
            </div>

        </div>
    </form>
    <div class="space-heigh"></div>
    <div class="row">
        <div class="col-6"></div>
        <div class="col-6">
            <a href="${pageContext.request.contextPath}/admin-account?do=list" class="btn btn-default light-text"><i class='bx bx-arrow-back'></i> Back to list</a>
        </div>
    </div>
</div>
<script>
    function previewFile(input) {
        var file = $("input[type=file]").get(0).files[0];
        var preThum = document.querySelector('#imgThumbnail');
        if (file) {
            var reader = new FileReader();

            reader.onload = function () {
                preThum.innerHTML = "";
                var image = new Image();
                image.width = 200;
                image.title = file.name;
                image.src = reader.result;
                preThum.appendChild(image);
            }

            reader.readAsDataURL(file);
        }
    }
</script>
<%@include file="../footer.jsp"%>
