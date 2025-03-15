terraform {
  required_providers {
    datadog = {
      source  = "DataDog/datadog"
      version = "~> 3.0"
    }
  }
}

provider "datadog" {
  api_url = "https://api.datadoghq.eu/"
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}
