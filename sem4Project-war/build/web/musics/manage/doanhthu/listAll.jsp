<%-- 
    Document   : listAll
    Created on : Jul 11, 2021, 12:22:25 PM
    Author     : hmtua
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.time.LocalDate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../../admin/header.jsp"%>
<html>
    <head>
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script>
            $(document).ready(function () {
                $("#myInput").on("keyup", function () {
                    var value = $(this).val().toLowerCase();
                    $("#myTable tr").filter(function () {
                        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                    });
                });
            });
        </script>
        <script>
            function openCity(evt, cityName) {
                var i, x, tablinks;
                x = document.getElementsByClassName("city");
                for (i = 0; i < x.length; i++) {
                    x[i].style.display = "none";
                }
                tablinks = document.getElementsByClassName("tablink");
                for (i = 0; i < x.length; i++) {
                    tablinks[i].className = tablinks[i].className.replace(" w3-red", "");
                }
                document.getElementById(cityName).style.display = "block";
                evt.currentTarget.className += " w3-red";
            }
        </script>
        <style>
            /* Removes the clear button from date inputs */
            input[type="date"]::-webkit-clear-button {
                display: none;
            }
            /* Removes the spin button */
            input[type="date"]::-webkit-inner-spin-button { 
                display: none;
            }
            /* Always display the drop down caret */
            input[type="date"]::-webkit-calendar-picker-indicator {
                color: #2c3e50;
            }
            /* A few custom styles for date inputs */
            input[type="date"] {
                appearance: none;
                -webkit-appearance: none;
                color: #95a5a6;
                font-family: "Helvetica", arial, sans-serif;
                font-size: 18px;
                background-color: #fff;
                padding:5px;
                display: inline-block !important;
                visibility: visible !important;
                border: 1px solid rgba(0,0,0,.125);
                border-radius: .25rem;
            }
            input[type="date"], focus {
                color: #95a5a6;
                box-shadow: none;
                -webkit-box-shadow: none;
                -moz-box-shadow: none;
            }
            .w3-container{
                padding:10px
            }
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
            .w3-col{
                padding:2px;
            }
            div[name="Dashboard"]{
                background-color:#ffffff;
                width:98%;
                border-radius:2px;
                border:1;
                box-shadow: 0px 0px 1px;
                padding:5px;
            }
            .dashboardNoiDung{
                text-align: right!important;
            }
            .google-visualization-table-tr-head{
                text-align: left;
            }
            .google-visualization-table-tr-even{
                text-align: left;
            }
            #table{
                width:100%;
                height:640px;
                overflow: hidden;
            }
            #table:hover{
                width:100%;
                height:640px;
                overflow-y:scroll; 
            }
            ::-webkit-scrollbar {
                width: 5px;
            }
            ::-webkit-scrollbar-track {
                background: #f1f1f1; 
            }
            ::-webkit-scrollbar-thumb {
                background: #888;
                border-radius:10px;
            }
            ::-webkit-scrollbar-thumb:hover {
                background: #555; 
            }
            .w3-modal-content{
                border: 1px solid rgba(0,0,0,.125);
                border-radius: .25rem;
            }
        </style>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/moment.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/daterangepicker.js"></script>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/daterangepicker.css" />
    </head>

    <body>
        <div class="w3-container">
            <div class="w3-row">
                <div class="w3-col container" style="width:50%">
                    <h2 class="">
                        <img height="40px" src="https://img.icons8.com/fluent/48/000000/details-popup.png"/>
                        <b>Details Revenue</b>
                    </h2>
                </div>
                <div class="w3-col container" style="width:50%">
                    <div style="text-align: right">
                        <div class="box-search">   
                            <form action="GET" method="GET" class="frm">
                                <div class="form-group">
                                    <a href="#">
                                        <span><i class='bx bx-calendar'></i></span>
                                        <input  id="reportrange" type="text" class="form-input"/>
                                    </a>
                                </div>
                            </form>
                        </div>
                        <script type="text/javascript">
            window.onload = function ()
            {
                $.ajax({
                    url: $("#url").val() + "/ManageRevenue?date=listAllDetailHomNay",
                    dataType: 'text',
                    type: 'get',
                    cache: false,
                    success: function (result) {
                        $("#table").html(result);
                        console.log(result);
                    },
                    error: function () {
                        alert("Error.....")
                    }
                });
            }
            var startD;
            var endD;
            $('#reportrange').daterangepicker({
                linkedCalendars: false,
                "showDropdowns": true,
                ranges: {
                    'Today': [moment(), moment()],
                    'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                    'Last week': [moment().subtract(6, 'days'), moment()],
                    '30 days ago': [moment().subtract(29, 'days'), moment()],
                    'This month': [moment().startOf('month'), moment().endOf('month')],
                    'Last month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
                },
                "startDate": moment(),
                "endDate": moment()
            }, function (start, end, label) {
                console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');
                startD = start.format('YYYY-MM-DD');
                endD = end.format('YYYY-MM-DD');
                $.ajax({
                    url: $("#url").val() + "/ManageRevenue?date=listAllDetailChiDinh",
                    dataType: 'text',
                    type: 'get',
                    cache: false,
                    data: {
                        start: startD,
                        end: endD
                    },
                    success: function (result) {
                        $("#table").html(result);
                        console.log(result);
                    },
                    error: function () {
                        alert("Error.....")
                    }
                });
            });
                        </script>
                    </div>
                </div>
            </div>
            <div class="card form-group">
                <div class="card-body">
                    <div class="w3-bar  ">
                        <button class="w3-bar-item w3-button tablink w3-red" onclick="openCity(event, 'London')"> Songs</button>
                        <button disabled="true" class="w3-bar-item w3-button tablink" onclick="openCity(event, 'Paris')">Order</button>
                        <br/><hr style="background-color: red;height:1px"/>              
                    </div>

                    <div id="London" class=" city">
                        <div class="w3-row">
                            <div class="w3-col container" style="width:35%">
                                <input style=" border-radius:2px;" class="w3-input w3-border w3-padding" type="text" placeholder="Search..." id="myInput" onkeyup="myFunction()">
                            </div>
                        </div>
                        <br/>
                        <div id="table">
                            
                        </div>
                    </div>
                    <div id="Paris" class="w3-container city" style="display:none">

                    </div>
                </div>
            </div>

        </div>
    </div>
</body>
</html>
<%@include file="../../../admin/footer.jsp"%>