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

## Table of Contents

- [Overview](#overview)
- [Quick Start](#quick-start)
- [What problem this solves](#what-problem-this-solves)
- [High-level architecture](#high-level-architecture)
  - [Application](#application)
  - [Infrastructure](#infrastructure)
  - [Kubernetes Platform](#kubernetes-platform)
  - [Observability](#observability)
  - [CI/CD & GitOps](#cicd--gitops)
  - [Security & Shift Left](#security--shift-left)
- [Key technical decisions](#key-technical-desicions)
  - [Bootstrap Infrastructure](#bootstrap-infrastructure)
  - [Modular Terraform](#modular-terraform)
  - [Container Build (Docker)](#container-build-docker)
  - [Kubernetes Platform](#kubernetes-platform-1)
  - [Helm & Helmfile](#helm--helmfile)
  - [GItOps with ArgoCd](#gitops-with-argocd)
  - [Secrets Management](#secrets-management)
  - [Private Access to AWS Services with VPC Endpoints](#private-access-to-aws-services-with-vpc-endpoints)
  - [Security](#security)
  - [CI/CD Pipeline](#cicd-pipeline)
  - [Cost Visibility with Infracost](#cost-visibility-with-infracost)
  - [Agile Project Management](#agile-project-management)
- [Screenshots](#screenshots)
- [Future improvements](#future-improvements)

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

### Kubernetes Platform

Amazon EKS acts as the application's orchestration platform, while the supporting Kubernetes components provide networking, certificate management, DNS automation, monitoring, secret synchronization, and GitOps deployments.

Rather than installing each component manually, the entire platform is managed declaratively through **Helmfile**, allowing the cluster to be recreated consistently from source control.

Platform components include:

- Traefik Ingress Controller
- ExternalDNS
- Cert Manager
- External Secrets Operator
- Stakater Reloader
- Prometheus
- Grafana
- ArgoCD

#### Why this matters

Each component has a clear responsibility, making the cluster easier to maintain and reducing operational complexity as additional applications are introduced.

### Helm & Helmfile

Infrastructure services are deployed using **Helmfile**, while the Memos application is packaged as its own reusable Helm chart.

The custom Helm chart manages:

- Deployment
- Service
- Ingress
- External Secret
- Cluster Secret Store

Application configuration is exposed through `values.yaml`, allowing deployments to be customised without modifying Kubernetes manifests.

#### Why this matters

Using Helm avoids duplicated manifests, simplifies configuration changes, and makes application deployments repeatable across environments.

### GitOps with ArgoCD

Production deployments are managed through **ArgoCD**.

Instead of applying Kubernetes manifests manually, Argo CD continuously watches the Git repository and reconciles the cluster to match the desired state.

The application is configured with:

- Automated synchronization
- Self-healing
- Automatic pruning of removed resources
- Deployment retries with exponential backoff

#### Why this matters

Git becomes the single source of truth.
Every infrastructure and application change is version controlled, auditable, and automatically applied without manual intervention.

This significantly reduces configuration drift while simplifying operational workflows.

### Secrets Management

Sensitive configuration is never committed to Git, stored in Terraform State or only encoded in Kubernetes.

Database credentials are stored in **AWS Secrets Manager**, encrypted with AWS KMS keys.

Within Kubernetes:

- External Secrets Operator retrieves secrets
- Kubernetes Secrets are generated automatically
- Deployments consume secrets through environment variables
- Stakater Reloader detects secret updates and restarts affected workloads automatically

#### Automated Secret Rotation

The project also includes automated PostgreSQL credential rotation using:

- AWS Lambda
- AWS Secrets Manager Rotation
- AWS's own Python rotation function
- External Secrets refresh
- Automatic pod reloads
- VPC Endpoint for secret data to not traverse the public internet

Database credentials can be rotated without manually updating Kubernetes resources or redeploying the application.

#### Why this matters

Automated secret rotation reduces operational overhead while improving security by limiting credential lifetime.

### Private Access to AWS Services with VPC Endpoints

The platform uses VPC Endpoints to allow workloads inside private subnets to access AWS services such as Secrets Manager and S3 without sending traffic through the public internet.

For secret retrieval, the Secrets Manager interface endpoint provides a private network path between the VPC and AWS Secrets Manager. Private DNS is enabled so applications can continue using the standard AWS service endpoint while traffic remains inside the AWS network.

The S3 gateway endpoint provides the same private access pattern for S3-backed services such as Terraform state and other platform dependencies.

#### Why this matters

- Secret retrieval does not traverse the public internet
- Private workloads can access required AWS services without public IP addresses
- Network exposure is reduced
- Security group rules can restrict access to approved workloads
- NAT Gateway traffic and related data-processing costs can be reduced
- The platform keeps a clearer boundary between public ingress and private service communication

This design strengthens the platform’s network security while preserving normal AWS service integrations for applications and automation.

### Security

Security was considered throughout the platform rather than added afterwards.

Highlights include:

- GitHub OIDC authentication (no long-lived AWS credentials)
- Least-privilege IAM roles
- AWS KMS encryption
- Dockerfile linting
- Docker image scanning
- Private database credentials
- HTTPS certificates issued automatically by Cert Manager
- Automated TLS renewal
- Secret rotation
- Non-root application container
- GitHub secret scanning
- Infrastructure security scanning
- Shift left with Pre-commit Hooks

The CI/CD pipelines also include multiple validation stages before infrastructure or application changes are deployed.

#### Why this matters

These controls reduce operational risk while following security practices commonly used in production cloud environments.

### CI/CD Pipeline

GitHub Actions automates the entire delivery workflow.

The pipelines perform tasks such as:

- Linting and validating Terraform
- Scanning infrastructure with Trivy and Checkov
- Building and scanning Docker images
- Pushing approved images to Amazon ECR
- Generating and storing Terraform plans
- Estimating infrastructure costs with Infracost
- Posting Terraform plan and cost summaries directly on pull requests
- Applying infrastructure after changes are merged
- Triggering the Kubernetes deployment workflow
- Authenticating to AWS through OIDC instead of long-lived access keys

Authentication to AWS is performed using GitHub's OIDC integration instead of static AWS access keys.

#### Why this matters

Removing long-lived credentials improves security while allowing deployments to remain fully automated.

### Cost Visibility with Infracost

Infracost analyses the Terraform plan during the pull request workflow and posts an estimated infrastructure cost directly on the PR.

This gives reviewers visibility into the financial impact of a change before it is merged or deployed.

#### Why this matters

- Cost changes are reviewed alongside code changes
- Unexpected increases can be identified before deployment
- Infrastructure decisions become easier to compare
- Teams gain better control over cloud spending
- Cost awareness becomes part of the normal engineering workflow

This approach treats cost as another reviewable part of infrastructure design, alongside security, reliability, and maintainability.

### Agile Project Management

Development work was planned and tracked using **Jira**.

The project demonstrates:

- User stories
- Task breakdown
- Progress tracking
- Incremental delivery

Using a structured ticketing workflow keeps implementation organised and mirrors how work is managed in professional software teams.

For a detailed breakdown of the project planning, task tracking, and Agile workflow, see the **[Jira Kanban Board](https://suadfrlj.atlassian.net/jira/software/projects/CCS/boards/1?filter=&groupBy=none)**.

---

## Screenshots

Application running in the web browser:

<img src="/resources/MemosApp.png"></img>

Jira Kanban board for Agile Project Management:

<img src="/resources/JiraBoard.png"></img>

PR Comments from Terraform Pipeline:

<img src="/resources/pr-comments.png"></img>

Terraform pipeline completed successfully:

<img src="/resources/tf-pipeline.png"></img>

Auto Deploy K8s pipeline, triggered by Terraform pipeline, completed successfully:

<img src="/resources/auto-k8s-pipeline.png"></img>

Docker pipeline completed successfully:

<img src="/resources/docker-pipeline.png"></img>

ArgoCD Application synched:

<img src="/resources/ArgoCD.png"></img>

Grafana Dashboard:

<img src="/resources/Grafana.png"></img>

Prometheus Target Health Status:

<img src="/resources/Prometheus.png"></img>



Keep screenshots focused and avoid including too many.

Recommended images:

- Application running in the browser
- Architecture diagram (already at the top)
- Argo CD application synced
- Grafana dashboard
- GitHub Actions pipelines
- Jira Kanban board

A few high-quality screenshots communicate more than a large gallery.

---

## Future Improvements

Although the platform is production-oriented, there are several realistic enhancements that could be added:

- Configure Horizontal Pod Autoscaling based on Prometheus metrics
- Introduce separate development, staging, and production environments
- Add Velero for Kubernetes backup and disaster recovery
- Integrate Loki for centralised log aggregation
- Add Karpenter for more efficient node provisioning
- Introduce CloudFront for edge caching and TLS termination

---
 