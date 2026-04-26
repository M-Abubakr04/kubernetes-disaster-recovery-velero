# Kubernetes Disaster Recovery using Velero

## 📌 Project Overview
This project demonstrates how to implement backup and disaster recovery in a Kubernetes cluster using Velero and AWS S3.

A real-world disaster scenario was simulated by deleting a running deployment and restoring it from backup.

---

## 🚀 Tech Stack
- Kubernetes
- Velero
- AWS S3
- Ubuntu

---

## ⚙️ Setup Process

### 1. Install Velero CLI
- Download and install Velero

### 2. Configure AWS
- Created IAM user
- Configured AWS CLI
- Created S3 bucket

### 3. Install Velero in Cluster
- Used AWS plugin
- Connected S3 bucket for backups

---

## 💾 Backup Process

 velero backup create my-backup --include-namespaces default


---

## 💥 Disaster Simulation

kubectl delete deployment nginx-deployment


---

## ♻️ Restore Process

velero restore create --from-backup my-backup

## 🎯 Key Learning
- Kubernetes backup strategies
- Disaster recovery workflows
- Cloud storage integration with S3

## Backup via Cronjob
We have created a script to take the backup which you can see in the repo file
## How to run it
chmod +x <script_name>
         Or
Run it as a cronjob
