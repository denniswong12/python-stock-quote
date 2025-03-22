# **Python Stock Quote**  

This repository contains GitHub Actions workflows for the CI/CD of a simple stock quote application with a Python-based web interface. Terraform provisions an EC2 instance, sets up a Datadog dashboard, and configures monitors with alerts sent to a Slack channel for proactive incident management.  

🚀 **Live Demo:** [Stock Quote Application](https://demo.camtech.solutions)  

---

## **Development Workflow**  

The `main` branch is protected, requiring all code changes to go through a **Pull Request (PR)**.  

### **Pull Request Actions**  

When a PR is created, GitHub Actions will automatically:  
- Run **automated tests** (`test_app.py`).  
- Perform a **SonarQube scan** using a self-hosted **SonarQube server on EC2**.  

### **Deployment Workflow**  

Once a PR is merged into `main`, a GitHub Actions workflow will:  
1. **Build and push** a Docker image to **Docker Hub**.  
2. **Pull the latest Docker image** on the **EC2 instance**.  
3. **Run the container** on the EC2 instance.  

### **CI/CD Workflow Diagram**  

![CI/CD Workflow](https://github.com/user-attachments/assets/7b09ba28-7cfb-42f3-a65d-94d60eb81205)  

---

## **Infrastructure as Code with Terraform**  

Terraform is used to:  
- Provision the required AWS resources, including an Ubuntu-based EC2 instance.
- Store sensitive information in `terraform.tfvars` (ignored by Git for security).  
- Set up **monitors, alerts, and a dashboard in Datadog** for proactive incident management.  

### **Terraform Workflow Diagram**  

![Terraform Workflow](https://github.com/user-attachments/assets/bf42a8c0-fbd2-4cdc-bdc7-989a1deb058c)  

---

## **Datadog Monitoring and Alerts**  

### **Monitors in Datadog**  
Datadog monitors track system performance and application health, ensuring early detection of potential issues.

<img width="1433" alt="monitors-OK" src="https://github.com/user-attachments/assets/3ef13a40-0617-4ce0-bfc0-ccbcb16aa19f" />

### **Datadog Dashboard**  
The dashboard provides a centralized, real-time view of key system resource utilization and the status of configured monitors.

<img width="1439" alt="dashboard-OK" src="https://github.com/user-attachments/assets/a540cfb4-8ab2-4df1-b4cc-84cc6f40a8c1" />

### **Alert Notifications**  
When a Datadog monitor detects a breach of defined thresholds, an alert is triggered and displayed on the dashboard, providing immediate visual feedback.

<img width="1439" alt="dashboard-alert" src="https://github.com/user-attachments/assets/57d928b5-ad92-44bb-824e-dfac0d040dfa" />

&nbsp;

At the same time, an alert is sent to a designated Slack channel, ensuring that the development and operations teams are promptly informed of any critical issues requiring attention.

<img width="784" alt="slack-alert" src="https://github.com/user-attachments/assets/a1db8c11-f4fd-41e0-8762-33515a9da4b3" />

### **Issue Recovery Notification**  
Once the issue is resolved and the system returns to a healthy state, Datadog sends a recovery message to the Slack channel:  

<img width="789" alt="slack-recovered" src="https://github.com/user-attachments/assets/e7779a83-fa3d-495b-ac9d-cad2816bd2b8" />

---
