#!/bin/bash
set -e

echo "Unlocking Bitwarden vault..."
SESSION_KEY=$(bw unlock --raw)

ITEM_JSON=$(bw get item 'Restic Repo' --session "$SESSION_KEY")

echo "Syncing to system keyring..."

echo "$ITEM_JSON" | jq -r .login.password | \
  secret-tool store --label="Restic Repo" \
  service s3_backup type password

echo "$ITEM_JSON" | jq -r '.fields[] | select(.name=="Access key") | .value' | \
  secret-tool store --label="S3 Backup Access Key" \
  service s3_backup type access_key

echo "$ITEM_JSON" | jq -r '.fields[] | select(.name=="Secret key") | .value' | \
  secret-tool store --label="S3 Backup Secret Key" \
  service s3_backup type secret_key

echo "Sync complete!"
