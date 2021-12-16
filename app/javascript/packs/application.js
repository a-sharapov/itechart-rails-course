// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import FroalaEditor from "froala-editor"
import 'froala-editor/js/plugins.pkgd.min.js'
import {
  Chart,
  ArcElement,
  LineElement,
  BarElement,
  PointElement,
  BarController,
  BubbleController,
  DoughnutController,
  LineController,
  PieController,
  PolarAreaController,
  RadarController,
  ScatterController,
  CategoryScale,
  LinearScale,
  LogarithmicScale,
  RadialLinearScale,
  TimeScale,
  TimeSeriesScale,
  Decimation,
  Filler,
  Legend,
  Title,
  Tooltip,
  SubTitle
} from 'chart.js'

Chart.register(
  ArcElement,
  LineElement,
  BarElement,
  PointElement,
  BarController,
  BubbleController,
  DoughnutController,
  LineController,
  PieController,
  PolarAreaController,
  RadarController,
  ScatterController,
  CategoryScale,
  LinearScale,
  LogarithmicScale,
  RadialLinearScale,
  TimeScale,
  TimeSeriesScale,
  Decimation,
  Filler,
  Legend,
  Title,
  Tooltip,
  SubTitle
)

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener("turbolinks:load", function() {
  new FroalaEditor('.expanded-by-editor', {
    quickInsertEnabled: false
  })
  new FroalaEditor('.expanded-by-editor-mini', {
    toolbarButtons: ['bold', 'italic', 'underline', 'undo', 'redo'],
    quickInsertEnabled: false
  })

  function makeChartsForCategory() {
    try {
      const line_chart_data = {
        labels: [],
        data: [],
        dynamic_data: []
      }

      // const startAt = new Date(document.querySelector("input#start").value).getTime() / 1000,
      //       endAt = new Date(document.querySelector("input#end").value).getTime() / 1000
      // const days = (endAt - startAt) / 86400
      
      const fetch_chart_data = new Promise((resolve) => {
        let dynamic = 0
        document.querySelectorAll(".transaction-item").forEach((el) => {
          let currentAmount = parseFloat(el.querySelector(".transaction-amount").textContent.trim())
          dynamic = dynamic + currentAmount
          line_chart_data.labels.push(el.querySelector(".transaction-title").textContent.trim())
          line_chart_data.data.push(currentAmount)
          line_chart_data.dynamic_data.push(dynamic)
        })
        resolve(line_chart_data)
      })

      fetch_chart_data.then((line_chart_data) => {
        const ctx = document.querySelector("#inner-category-chart").getContext('2d')
        const inner_category_cart = new Chart(ctx, {
          type: 'line',
          data: {
            labels: line_chart_data.labels,
            datasets: [{
              label: document.querySelector("#category-title").innerText,
              data: line_chart_data.data,
              fill: false,
              borderColor: "transparent",
              backgroundColor: document.querySelector("#category-title").getAttribute("data-color"),
              tension: 0.1
            },
            {
              label: document.querySelector("#category-title").innerText + "(dynamic)",
              data: line_chart_data.dynamic_data,
              fill: false,
              borderColor: "#99c1bb",
              backgroundColor: "#99c1bb",
              tension: 0.1
            }]
          }
        })
      })
      document.querySelector("#inner-category-chart").parentNode.style.width = "100%"
      document.querySelector("#inner-category-chart").parentNode.style.height = "320px"
      void -1
    } catch (e) {
      throw e
    }
  }

  function makeChartsForCabinet() {
    try {
      const sp_chart_data = {
        colors: [],
        labels: [],
        data: []
      },
      in_chart_data = {
        colors: [],
        labels: [],
        data: []
      }

      const fetch_chart_data = new Promise((resolve) => {
        document.querySelectorAll(".category-item").forEach((el) => {
          switch (el.getAttribute("data-direction")) {
            case "spending":
              sp_chart_data.colors.push(el.getAttribute("data-color"))
              sp_chart_data.labels.push(el.querySelector(".category-title").textContent.trim())
              sp_chart_data.data.push(el.querySelector(".category-balance").textContent.trim())
              break
            case "income":
              in_chart_data.colors.push(el.getAttribute("data-color"))
              in_chart_data.labels.push(el.querySelector(".category-title").textContent.trim())
              in_chart_data.data.push(el.querySelector(".category-balance").textContent.trim())
              break
          }
        })
        resolve({sp_chart_data, in_chart_data})
      })

      fetch_chart_data.then(({sp_chart_data, in_chart_data}) => {
        const ctx_sp = document.querySelector("#category-chart-spending").getContext('2d')
        const ctx_in = document.querySelector("#category-chart-income").getContext('2d')

        const spending_cart = new Chart(ctx_sp, {
          type: 'doughnut',
          data: {
            labels: sp_chart_data.labels,
            datasets: [{
              data: sp_chart_data.data,
              backgroundColor: sp_chart_data.colors,
              hoverOffset: 4
            }]
          }
        })
        const income_cart = new Chart(ctx_in, {
          type: 'doughnut',
          data: {
            labels: in_chart_data.labels,
            datasets: [{
              data: in_chart_data.data,
              backgroundColor: in_chart_data.colors,
              hoverOffset: 4
            }]
          }
        })

        document.querySelectorAll(".chart-node").forEach((el) => {
          el.style.width = el.style.height = "320px"
        })
      })
      void -1
    } catch (e) {
      throw e
    }
  }

  switch (document.querySelector("body").getAttribute("data-page")) {
    case "cabinet index":
      makeChartsForCabinet()
      if (document.querySelectorAll(".transaction-item").length > 0) {
        document.querySelector(".category-main-chart-wrapper").classList.remove("hidden")
      }
      break
    case "categories show":
      makeChartsForCategory()
      if (document.querySelectorAll(".transaction-item").length > 0) {
        document.querySelector(".inner-category-chart-wrapper").classList.remove("hidden")
      }
      break
  }
  
  const mobileMenuHandler = document.querySelector("[data-role=\"mobile-menu-handler\"]")
  if (mobileMenuHandler !== null) {
    mobileMenuHandler.addEventListener("click", (e) => {
      e.target.classList.toggle("active")
      document.querySelector("nav[data-role=\"site-nav-menu\"]").classList.toggle("active")
    })
  }
  
})