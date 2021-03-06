<%-- 
  Document   : index
  Created on : Jul 11, 2021, 12:46:49 AM
  Author     : hmtua
--%>

<%@page import="java.time.LocalDate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../../admin/header.jsp"%>
<html>
    <head>
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
        </style>
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/moment.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/daterangepicker.js"></script>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/daterangepicker.css" />
        <script>
            window.onload = function ()
            {
                $.ajax({
                    url: $("#url").val() + "/ManageBillOrder?date=hientaidate",
                    dataType: 'text',
                    type: 'get',
                    cache: false,
                    success: function (result) {
                        $("#orderDetail").html(result);
                        console.log(result);
                    },
                    error: function () {
                        alert("Error.....")
                    }
                });
            }
        </script>
    </head>
    <body >
        <br/>
        <div class="w3-container">
            <div class="w3-row">
                <div class="w3-col container" style="width:50%">
                    <h2 class="">
                        <img height="40px" src="https://img.icons8.com/fluent/48/000000/purchase-order.png"/>
                        <b>Manage Order</b>
                        &nbsp;
                        <a style="font-size: 15px;color: #008CBA" href="${pageContext.request.contextPath}/ManageBillOrder?date=details">See Details</a>
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
                    </div>
                </div>
            </div>
        </div>
        <div id="orderDetail">
            <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        </div>
    </div>
</body>
</html>

<script type="text/javascript">
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
                    url: $("#url").val() + "/ManageBillOrder?date=chidinh",
                    dataType: 'text',
                    type: 'get',
                    cache: false,
                    data: {
                        start: startD,
                        end: endD
                    },
                    success: function (result) {
                        $("#orderDetail").html(result);
                        console.log(result);
                    },
                    error: function () {
                        alert("Error.....")
                    }
                });
            });
</script>
<%@include file="../../../admin/footer.jsp"%>