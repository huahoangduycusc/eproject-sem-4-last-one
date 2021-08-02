<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script>
    google.charts.load('current', {'packages': ['bar']});
    google.charts.setOnLoadCallback(drawChart);
    function drawChart() {
        var data = google.visualization.arrayToDataTable(${order});
        var options = {
            seriesType: 'bars',
            series: {1: {type: 'line'}}
//                    chart: {
//                        title: 'Order Performance',
//                        subtitle: 'Sales of orders in the month',
//                    }
        };
        var chart = new google.charts.Bar(document.getElementById('chart_div'));
        chart.draw(data, google.charts.Bar.convertOptions(options));
    }
</script>
<div class="w3-container">
    <div class="w3-row">
        <div class="w3-col container" style="width:100%">
            <div class="card form-group">
                <div class="card-header">
                    <img height="25px" src="https://img.icons8.com/cotton/64/000000/statistics--v1.png"/>
                    <b>ORDER OVERVIEW</b>
                </div>
                <div class="card-body">
                    <div class="w3-container" id="chart_div" style="width: 100%; height:500px"></div>
                </div>
            </div>
        </div>
    </div>
</div>