resource "datadog_monitor" "cpu_usage_monitor" {
  name = "High CPU Usage Alert for EC2"
  type = "metric alert"

  query = "avg(last_5m):avg:system.cpu.user{instance-id:${var.ec2_host_ip}} > 75"

  message = <<EOT
ALERT: 🚨 CPU usage is above 75% for the EC2 instance!

@slack-${var.slack_channel}
EOT

  tags = [var.monitor-tags, "alert:CPU"]

  notify_no_data    = false
  renotify_interval = 10

  escalation_message = "Escalate this issue if CPU remains high."
}

resource "datadog_monitor" "low_memory_alert" {
  name = "Low Memory Alert"
  type = "metric alert"

  query = "avg(last_5m):avg:system.mem.free{*} < 200000000"

  message = <<EOT
🚨 ALERT: Available memory is below 200MB!

@slack-${var.slack_channel}
EOT

  tags = [var.monitor-tags, "alert:memory"]

  notify_no_data    = false
  renotify_interval = 10

  escalation_message = "Escalate this issue if memory remains critically low."
}

resource "datadog_monitor" "disk_space_monitor" {
  name = "Low Disk Space Alert"
  type = "metric alert"

  query = "avg(last_5m):avg:system.disk.free{host:${var.ec2_host_ip}} < 500000000"

  message = <<EOT
🚨 ALERT: Disk space is critically low on the EC2 instance!
Less than 500MB remaining.

@slack-${var.slack_channel}
EOT

  tags = [var.monitor-tags, "alert:disk_space"]

  notify_no_data    = false
  renotify_interval = 10

  escalation_message = "Escalate this issue if disk space remains low."
}

resource "datadog_monitor" "http_health_check" {
  name = "HTTP Health Check for Stock Quote Web Page"
  type = "service check"

  query = "\"http.can_connect\".over(\"*\").by(\"host\").last(3).count_by_status()"

  message = <<EOT
🚨 ALERT: Health check failed for ${var.url}!

@slack-${var.slack_channel}
EOT

  tags = [var.monitor-tags, "alert:http"]

  notify_no_data    = false
  renotify_interval = 10

  escalation_message = "Escalate this issue if the website remains unreachable."
}

resource "datadog_monitor" "network_traffic_monitor" {
  name = "High Network Traffic Alert for EC2"
  type = "metric alert"

  query = "avg(last_15m):avg:system.net.bytes_rcvd{host:${var.ec2_host_ip}} > 100000000"

  message = <<EOT
🚨 ALERT: High network traffic (bytes received) for the EC2 instance!. This may impact system performance.

@slack-${var.slack_channel}
EOT

  tags = [var.monitor-tags, "alert:network"]

  notify_no_data    = false
  renotify_interval = 10

  escalation_message = "Escalate this issue if the network traffic remains high."
}

