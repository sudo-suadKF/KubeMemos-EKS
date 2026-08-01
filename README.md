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
- [High-level architecture](#)
- [Key technical decisions](#)
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

