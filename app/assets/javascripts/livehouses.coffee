# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#レビューのレーダーチャート

###
window.draw_graph = (q, c, cp, m, r)->

  ctx = document.getElementById("radarchart").getContext('2d')
  myChart = new Chart(ctx, {
      type: 'radar',
      data: {
          labels: ["クオリティ", "仕事のしやすさ", "コスト", "マナー", "返信の速さ"],
          datasets: [{
              data: [q, c, cp, m, r],
              backgroundColor: [
                  'rgba(54, 162, 235, 0.2)',
              ],
              borderColor: [
                  'rgba(54, 162, 235, 1)',
              ],
              borderWidth: 1
          }]
      },
      options: {
        legend: {
          display: false,
        }
        scale: {
          pointLabels: {
           fontSize: 12,
          },
          ticks: {
            beginAtZero:true
            min: 0,
            max: 5,
            stepSize: 1,
          }
        }
      }
  })
###
