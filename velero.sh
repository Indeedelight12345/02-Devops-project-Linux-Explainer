velero install \
    --provider gcp \
    --plugins velero/velero-plugin-for-gcp:v1.10.0 \
    --bucket my-velero-backups-1770236814 \
    --secret-file ./velero-key.json \
    --backup-location-config region=us-central1 \
    --snapshot-location-config region=us-central1
