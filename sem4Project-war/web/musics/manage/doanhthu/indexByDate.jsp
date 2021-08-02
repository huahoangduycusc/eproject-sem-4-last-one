<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="w3-row">
    <div class="w3-col" name="Dashboard" style="width:33%">
        <div class="w3-container">
            <div class="w3-col" style="width:40%">
                <img height="48px" src="https://img.icons8.com/fluent/48/000000/total-sales-1.png"/>
            </div>
            <div class="w3-col" style="width:60%">
                <div class="dashboardNoiDung">
                    <p>Total revenue</p>
                    <b>${sumPriceAllInDate} $</b>
                </div>
            </div>  
        </div>
    </div>

    <div class="w3-col"  style="width:0.5%"></div>
    <div class="w3-col" name="Dashboard" style="width:33%">
        <div class="w3-container">
            <div class="w3-col" style="width:40%">
                <img  height="48px" src="https://img.icons8.com/cotton/64/000000/bill--v2.png"/>
            </div>
            <div class="w3-col" style="width:60%">
                <div class="dashboardNoiDung">
                    <p>Total orders</p>
                    <b>${countOrder}</b>
                </div>
            </div>  
        </div>
    </div>

    <div class="w3-col"  style="width:0.5%"></div>
    <div class="w3-col" name="Dashboard" style="width:33%">
        <div class="w3-container">
            <div class="w3-col" style="width:40%">
                <img src="https://img.icons8.com/fluent/48/000000/paid-bill.png"/>
            </div>
            <div class="w3-col" style="width:60%">
                <div class="dashboardNoiDung">
                    <p>Paid</p>
                    <b>${countOrderIS}</b>

                </div>
            </div>
        </div>
    </div>
</div>
<br/>
<div class="w3-row">
    <div class="w3-col" style="width:66.5%">
        <div class="card form-group">
            <div class="card-header">
                <img height="25px" src="https://img.icons8.com/cotton/64/000000/statistics--v3.png"/>
                <b>REVENUE STATISTICS</b>
            </div>
            <div class="card-body">
                <canvas id="myChart" style="width:98%"></canvas>
                <script >
                    var xValues = ${listDay};
                    new Chart("myChart", {
                        type: "line",
                        data: {
                            labels: xValues,
                            datasets: [{
                                    data: ${listPriceAll},
                                    borderColor: "red",
                                    fill: false
                                }]
                        },
                        options: {
                            legend: {display: false}
                        }
                    });
                </script> 
            </div>
        </div>
    </div>
    <div class="w3-col" style="width:0.5%"></div>
    <div class="w3-col" style="width:33%">
        <div class="card form-group">
            <div class="card-header">
                <img height="25px" src="https://img.icons8.com/cotton/64/000000/statistics--v1.png"/>
                <b>TOP 5 PRODUCTS</b>
            </div>
            <div class="card-body">
                <div
                    id="myChart1" style="width:100%; height:428px;">
                </div>
                <script>
                    google.charts.load('current', {'packages': ['corechart']});
                    google.charts.setOnLoadCallback(drawChart);
                    function drawChart() {
                        var data = google.visualization.arrayToDataTable([
                            ['Contry', 'Mhl'],
                    ${sumTop10}
                        ]);
                        var options = {
                            title: 'Top 5 Grossing Songs'
                        };
                        var chart = new google.visualization.PieChart(document.getElementById('myChart1'));
                        chart.draw(data, options);
                    }
                </script>
            </div>
        </div>
    </div>
</div>