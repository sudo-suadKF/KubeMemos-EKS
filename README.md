# KubeMemos - Production-Grade Memos on AWS EKS

![AWS](https://img.shields.io/badge/AWS-EKS%20%7C%20RDS%20%7C%20Lambda-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-Infrastructure%20as%20Code-623CE4?style=for-the-badge&logo=terraform&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-EKS-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Helm](https://img.shields.io/badge/Helm-Charts-0F1689?style=for-the-badge&logo=helm&logoColor=white)
![Argo CD](https://img.shields.io/badge/GitOps-ArgoCD-EF7B4D?style=for-the-badge&logo=argo&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/CI%2FCD-GitHub%20Actions-2088FF?style=for-the-badge&logo=githubactions&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Multi--Stage-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![ExternalDNS](https://img.shields.io/badge/ExternalDNS-Automatic_DNS-4285F4?style=for-the-badge)
![Cert Manager](https://img.shields.io/badge/Cert_Manager-Let's_Encrypt-326CE5?style=for-the-badge)
![Infracost](https://img.shields.io/badge/Infracost-Cost_Analysis-DB44B8?style=for-the-badge&logo=infracost&logoColor=white)
![Security](https://img.shields.io/badge/Security-Trivy%20%7C%20Checkov%20%7C%20OIDC%20%7C%20pre--commit-0969DA?style=for-the-badge)

<img src="/resources/EKS.drawio.png"></img>

---

## Table of Contens

- [Overview](#overview)
- [Quick Start](#quick-start)
- [What problem this solves](#what-problem-this-solves)
- [High-level architecture](#high-level-architecture)
- [Key technical decisions](#key-technical-desicions)
- [Security](#)
- [GitOps & CI/CD](#)
- [Repository structure](#)
- [Technology stack](#)
- [Screenshots](#)
- [Future improvements](#)
- [Further reading](#)

---

## Overview

This project deploys **Memos**, an open-source, self-hosted note-taking application, on **Amazon EKS**, using a production-oriented Kubernetes platform built with Terraform, Helm, Argo CD, and GitHub Actions.

Rather than simply deploying an application, the project demonstrates how modern cloud infrastructure can be designed to be secure, maintainable, and repeatable. Every major component from infrastructure provisioning to application deployment is automated and managed as code.

The goal is to showcase the kind of architectural decisions that matter in real engineering teams, including GitOps workflows, infrastructure modularity, automated secret management, production-ready networking, and continuous security validation.

---

## Quick Start

Want to explore **Memos** first?  
Deploy it locally with Docker:

```bash
cd memos
docker build -t memos:local .
docker run -d \
  -p 8081:8081 \
  -v $(pwd)/memos-data:/var/opt/memos \
  memos:local
```
Visit:

```bash
http://localhost:8081
```
and start writing.

For more information about the application itself, deployment options, and available features, see:
- Documentation: https://usememos.com/docs
- GitHub Repository: https://github.com/usememos/memos

---

## What problem this solves

Deploying an application to Kubernetes is relatively straightforward. Operating it securely and reliably over time is significantly more challenging.

This project demonstrates how to answer questions such as:

- How do you provision AWS infrastructure without relying on manual configuration?
- How do you deploy applications continuously without directly interacting with the cluster?
- How do you manage secrets without storing credentials in Git, Terrafom State or Kubernetes manifests?
- How do you rotate database credentials without downtime?
- How do you expose applications securely using automated TLS certificates?
- How do you secure CI/CD pipelines without long-lived cloud credentials?

The result is a complete reference architecture for running a production-ready Kubernetes workload on AWS while following modern DevOps and Platform Engineering practices.

---

## High-Level Architecture

The platform consists of several layers that work together to automate both infrastructure provisioning and application delivery.

### Application

- Memos (Go backend + React frontend)
- PostgreSQL database
- Docker multi-stage build
- Private container registry (Amazon ECR)

### Infrastructure

- AWS EKS
- AWS RDS PostgreSQL
- AWS VPC
- Private and public networking
- Multi AZ Infrastructure
- Security Groups
- AWS Secrets Manager
- AWS KMS
- AWS Lambda
- IAM Roles for Pod Identity
- AWS S3 bucket for Terraform State and State locking
- CloudWatch for monitoring and logs

### Kubernetes Platform

- Helm
- Helmfile
- ArgoCD
- Traefik Ingress Controller
- ExternalDNS
- Cert Manager
- External Secrets Operator
- Stakater Reloader

### Observability

- Prometheus
- Grafana

### CI/CD & GitOps

- GitHub Actions
- ArgoCD

### Security & Shift Left
- Pre-commit Hooks
- GitHub OIDC Authentication
- Secret Rotation
- Trivy
- Checkov
- Gitleaks
- Hadolint
- Tflint

---

## Key Technical Desicions

### Bootstrap Infrastructure

The infrastructure is intentionally divided into two Terraform layers, the bootstrap and main layer.  
The bootstrap layer creates resources that must already exist before the main infrastructure can be deployed, including:

- Terraform remote state storage
- State encryption
- Amazon ECR
- GitHub OIDC authentication
- AWS Secrets Manager's secret resource

Separating bootstrap resources from workload infrastructure makes the platform easier to rebuild and prevents circular dependencies during deployment. By managing these foundational resources as code, the platform avoids manual configuration, improves consistency, and enables reliable, repeatable deployments.

From an operational perspective, this approach reduces maintenance complexity and keeps infrastructure lifecycle management predictable.


### Modular Terraform

Rather than keeping all infrastructure inside one large Terraform configuration, the project is organised into reusable modules.  
Modules include:

- VPC
- EKS
- RDS
- Security Groups
- Secret Rotation
- Pod Identity
- Bootstrap resources

This structure improves readability, simplifies future expansion, and makes individual components easier to test and maintain.


### Container Build (Docker)

The Memos application is built using a multi-stage Docker build that separates the frontend and backend compilation from the final runtime image.  
The build process:

- Builds the React frontend using Node.js
- Compiles the Go backend with CGO disabled
- Produces a statically compiled binary
- Copies only the required runtime files into a minimal final image
- Runs as a non-root user

#### Why this matters

- Smaller deployment artifact
- Reduced attack surface
- Faster image distribution
- Lower storage costs
- Cleaner separation between build and runtime environments

--- 