#!/bin/bash

# Exit immediately if a command fails
set -e

# -------------------------------
# CONFIGURATION (EDIT THESE)
# -------------------------------
BUCKET_NAME="velero-backup-abubakr-001"
REGION="ap-south-1"
CREDENTIAL_FILE="$HOME/credentials-velero"
BACKUP_NAME="scheduled-backup-$(date +%Y-%m-%d-%H-%M)"

# -------------------------------
# CHECKS
# -------------------------------
echo "🔍 Checking prerequisites..."

if ! command -v velero &> /dev/null
then
    echo "❌ Velero CLI not installed"
    exit 1
fi

if ! command -v kubectl &> /dev/null
then
    echo "❌ kubectl not installed"
    exit 1
fi

if [ ! -f "$CREDENTIAL_FILE" ]; then
    echo "❌ Credentials file not found at $CREDENTIAL_FILE"
    exit 1
fi

echo "✅ All prerequisites satisfied"

# -------------------------------
# INSTALL VELERO (if not exists)
# -------------------------------
if ! kubectl get namespace velero &> /dev/null; then
    echo "🚀 Installing Velero..."

    velero install \
      --provider aws \
      --plugins velero/velero-plugin-for-aws:v1.2.0 \
      --bucket $BUCKET_NAME \
      --secret-file $CREDENTIAL_FILE \
      --use-restic \
      --backup-location-config region=$REGION

    echo "⏳ Waiting for Velero pods..."
    sleep 30
else
    echo "ℹ️ Velero already installed"
fi

# -------------------------------
# CREATE BACKUP
# -------------------------------
echo "💾 Creating backup: $BACKUP_NAME"

velero backup create $BACKUP_NAME --include-namespaces default

echo "✅ Backup triggered successfully"

# -------------------------------
# SHOW BACKUP STATUS
# -------------------------------
velero backup get

echo "🎉 Script completed"
