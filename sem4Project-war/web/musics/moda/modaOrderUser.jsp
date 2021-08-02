<%-- 
    Document   : modaOrderUser
    Created on : Jul 28, 2021, 2:02:52 AM
    Author     : hmtua
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    .form-group {
        margin-bottom: 1rem;
    }
    .card {
        position: relative;
        display: -webkit-box;
        display: flex;
        -webkit-box-orient: vertical;
        -webkit-box-direction: normal;
        flex-direction: column;
        min-width: 0;
        word-wrap: break-word;
        background-color: #fff;
        background-clip: border-box;
        border: 1px solid rgba(0,0,0,.125);
        border-radius: .25rem;
    }
    .card-header {
        padding: .75rem 1.25rem;
        margin-bottom: 0;
        background-color: rgba(0,0,0,.03);
        border-bottom: 1px solid rgba(0,0,0,.125);
    }
    .card-body {
        -webkit-box-flex: 1;
        flex: 1 1 auto;
        padding: 1.25rem;
    }
</style>
<script>
    <%
        if (request.getAttribute("trangThai") != null) {
            String trangThai = request.getAttribute("trangThai").toString();
    %>
    <%if (trangThai.equals("0")) {%>
    Swal.fire(
            'Successful Transaction',
            'Please continue to enjoy the music!',
            'success'
            );
    <%} else {%>
    Swal.fire(
            'Payment Error',
            'Please re-create it, Or contact the administrator for help',
            'error'
            );
    <%}
        }%>
    function loatOrder(idSong) {
        var x = location.href;
        $.ajax({
            url: $("#url").val() + "/Order?setSession=host",
            dataType: 'text',
            type: 'get',
            cache: false,
            data: {
                idSong: idSong,
                urlHost: x,
            },
            success: function (result) {
                $("#dataorder").html(result);
                //console.log(result);
            },
            error: function () {
                document.getElementById('id01').style.display = 'none';
                Swal.fire(
                        'You do not have permission to play this song',
                        'Please login to use our service!',
                        'error'
                        );
            }
        });
    }
</script>

<div id="id01" class="w3-modal" style="border-radius:4px">
    <div class="w3-modal-content w3-animate-top w3-card-4" style="width:70%;border-radius:4px">
        <header class="w3-container "> 
            <span onclick="document.getElementById('id01').style.display = 'none'" 
                  class="w3-button w3-display-topright">&times;</span>
        </header>
        <div class="w3-container">
            <div id="dataorder"> </div>
        </div>
        <footer class="w3-container">
        </footer>
    </div>
</div>