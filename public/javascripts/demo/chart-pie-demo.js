// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#858796';

// Pie Chart Example
var ctx = document.getElementById("myPieChart");
var myPieChart = new Chart(ctx, {
  type: 'doughnut',
  data: {
    labels: [],
    datasets: [{
      data: [55, 30, 15],
      backgroundColor: ['#e74a3b', '#08A045', '#2B2D42'],
      hoverBackgroundColor: ['#8C1C13', '#2A7F62', '#161925'],
      hoverBorderColor: "#444444",
    }],
  },
  options: {
    maintainAspectRatio: false,
    tooltips: {
      backgroundColor: "rgb(255,255,255)",
      bodyFontColor: "#858796",
      borderColor: '#dddfeb',
      borderWidth: 1,
      xPadding: 15,
      yPadding: 15,
      displayColors: false,
      caretPadding: 10,
    },
    legend: {
      display: false
    },
    cutoutPercentage: 80,
  },
});

function prueba(){
  const url = 'http://localhost:3000/recursos/pozoGrafica';
  fetch(url)
  .then((response) => {
    if (response.ok) {
      return response.json();
    } else {
      return Promise.reject(response.statusText);
    }
  })
  .then((data) => {
    for(let i=0; i<3; i++){
      myPieChart.config.data.labels[i] = data.rows[i].nombre_estado
      myPieChart.config.data.datasets[0].data[i] = data.rows[i].cantidad
    }
  })
  .catch((error) => {
    console.log(error);
  });
}

prueba()