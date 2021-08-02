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
        Create new song for ${artist.nickname}
    </div>
</div>
<div class="main-content">
    <%        String msg = request.getParameter("msg");
        if (msg != null && msg.equals("success")) {
            out.println("<div class='alert alert-success'>Create success!</div><br/>");
        }
        if (msg != null && msg.equals("error")) {
            out.println("<div class='alert alert-danger'>File upload is not valid, try again!!</div><br/>");
        }
    %>
    <form action="${pageContext.request.contextPath}/admin-songs" method="post" autocomplete="off" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${artist.artistID}">
        <div class="row">

            <div class="col-12 col-md-12 col-sm-12">
                <div class="form-group">
                    <div class="label">
                        Song name
                    </div>
                    <input type="text" name="name" class="form-control" required>
                </div>
            </div>

            <div class="col-12 col-md-12 col-sm-12">
                <div class="form-group">
                    <div class="label">
                        Description
                    </div>
                    <textarea class="form-control" name="description" rows="5" required="required"></textarea>
                </div>
            </div>

            <div class="col-12 col-md-12 col-sm-12">
                <div class="form-group">
                    <div class="label">
                        Lyrics
                    </div>
                    <textarea class="form-control" name="lyrics" rows="5" required="required"></textarea>
                </div>
            </div>

            <div class="col-12 col-md-12 col-sm-12">
                <div class="form-group">
                    <div class="label">
                        Type of album
                    </div>
                    <div class="flex-p">
                        <p><label for="type1">Single</label> <input id="type1" type="radio" name="loai" value="single" checked></p>
                            <c:if test="${controller.countAlbums(param.id) > 0}">
                            <p><label for="type2">Album</label> <input id="type2" type="radio" name="loai" value="album"></p>
                            </c:if>
                    </div>
                </div>
            </div>

            <div class="col-12 col-md-12 col-sm-12 scroll-content">
                <div class="form-group">
                    <div class="label">
                        Album
                    </div>
                    <select name="album" class="form-control">
                        <c:forEach items="${albums}" var="album">
                            <option value="${album.albumID}">${album.albumName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="col-12 col-md-12 col-sm-12">
                <div class="form-group">
                    <div class="label">
                        Price (Only positive numbers)
                    </div>
                    <input type="number" name="price" class="form-control" min="0" required>
                </div>
            </div>

            <div class="col-12 col-md-12 col-sm-12">
                <div class="form-group">
                    <div class="label">
                        Release date
                    </div>
                    <input type="date" name="date" class="form-control" required>
                </div>
            </div>

            <div class="col-12 col-md-12 col-sm-12">
                <div class="form-group">
                    <div class="label">
                        Language
                    </div>
                    <select name="language" class="form-control">
                        <c:forEach items="${languages}" var="language">
                            <option value="${language.langID}">${language.langName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="col-12 col-md-12 col-sm-12">
                <div class="form-group">
                    <div class="label">
                        Soft of music
                    </div>
                    <select name="type" class="form-control">
                        <c:forEach items="${types}" var="type">
                            <option value="${type.typeID}">${type.typeName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="col-12 col-md-12 col-sm-12">
                <div class="form-group">
                    <div class="label">
                        Supplier
                    </div>
                    <select name="supplier" class="form-control">
                        <c:forEach items="${suppliers}" var="supplier">
                            <option value="${supplier.supplierID}">${supplier.companyName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="col-12 col-md-12 col-sm-12">
                <div class="form-group">
                    <div class="label">
                        Thumbnail (Only PNG, JPG or JPEG images are allowed to be uploaded)
                    </div>
                    <div class="form-group center" id="imgThumbnail">

                    </div>
                    <input type="file" name="avatar" class="form-control" onchange="previewFile();" accept="image/*">
                </div>
            </div>

            <div class="col-12 col-md-12 col-sm-12">
                <div class="form-group">
                    <div class="label">
                        Audio Thumbnail (Only .mp3 extension are allowed to be uploaded)
                    </div>
                    <input type="file" name="audio" class="form-control" required="required">
                </div>
            </div>

            <div class="col-12">
                <button class="btn btn-default btn-add" type="submit" name="submit" value="add"><i class='bx bx-plus'></i> Create new</button>
            </div>

        </div>
    </form>
    <div class="space-heigh"></div>
    <div class="row">
        <div class="col-6"></div>
        <div class="col-6">
            <a href="${pageContext.request.contextPath}/admin-artist?do=song&id=${param.id}" class="btn btn-default bg-blue light-text"><i class='bx bx-arrow-back'></i> Back to list</a>
        </div>
    </div>
</div>
<script>
    var checkBox = false;
    $('#type1').click(function () {
        checkBox = false;
        var divContent = document.querySelector(".scroll-content");
        divContent.style.height = "0px";
    });
    $('#type2').click(function () {
        checkBox = true;
        var divContent = document.querySelector(".scroll-content");
        divContent.style.height = divContent.scrollHeight + "px";

    });
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
