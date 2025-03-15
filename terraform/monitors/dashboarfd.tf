resource "datadog_dashboard_json" "python_stock_quote_health" {
  dashboard = file("dashboard.json")
}
