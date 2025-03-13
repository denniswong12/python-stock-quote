# Python Stock Quote  
![GHA-CICD-v3](https://github.com/user-attachments/assets/7b09ba28-7cfb-42f3-a65d-94d60eb81205)

This repository includes GitHub workflows for the CI/CD of a simple stock quote application with a web interface, built in Python.

🚀 **Live Demo:** [Stock Quote Application](http://3.9.99.74/)  

---

## Development Workflow  
The `main` branch is protected, requiring all code changes to go through a **Pull Request (PR)**.  

### Pull Request Actions  
When a PR is created, GitHub Actions will automatically:  
- Run **automated tests** (`test_app.py`)  
- Perform a **SonarQube scan** using a self-hosted **SonarQube server on EC2**  

### Deployment Workflow  
Once a PR is merged into `main`, another GitHub Actions workflow will:  
- **Build and push** a Docker image to **Docker Hub**  
- On the **EC2 instance**, **pull the latest Docker image** from **Docker Hub**  
- **Run the container** on the EC2 instance  

---
