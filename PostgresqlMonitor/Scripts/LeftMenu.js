/* POSTBACK */
var prm = Sys.WebForms.PageRequestManager.getInstance();
prm.add_endRequest(function (s, e) {
    document.body.style.backgroundColor = "white";
    initMultiselect();
    initChart();
});

/* Set the width of the side navigation to 250px and the left margin of the page content to 250px and add a black background color to body */
function openNav() {
    document.getElementById("mySidenav").style.width = "350px";
    if (document.getElementById("main") != null)
        document.getElementById("main").style.marginLeft = "350px";
    document.body.style.backgroundColor = "rgba(0,0,0,0.4)";
}

/* Set the width of the side navigation to 0 and the left margin of the page content to 0, and the background color of body to white */
function closeNav() {
    document.getElementById("mySidenav").style.width = "0";
    if (document.getElementById("main") != null)
        document.getElementById("main").style.marginLeft = "0";
    document.body.style.backgroundColor = "white";
}

$(function () {
    initMultiselect();
});

function initMultiselect() {
    $('[id*=ColumnsListBox]').multiselect({
        includeSelectAllOption: true,
        buttonWidth: '100%',
        maxHeight: 300
    });
}

function initChart() {
    if (document.getElementById("myChart") != null) {
        var ctx = document.getElementById("myChart").getContext('2d');

        var arrayLabels = $("#ChartLabelsHiddenField").val().split(",");
        var arrayData = $("#ChartDataHiddenField").val().split(",");

        var myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: arrayLabels,
                datasets: [{
                    label: '# of Calls',
                    data: arrayData,
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)',
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255,99,132,1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)',
                        'rgba(255,99,132,1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }]
                }
            }
        });
    }
}