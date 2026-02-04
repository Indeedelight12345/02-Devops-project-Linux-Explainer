# Set a unique bucket name
BUCKET_NAME=my-velero-backups-$(date +%s)

# Create the bucket in your preferred region
gsutil mb -l us-central1 gs://$BUCKET_NAME

# Enable versioning so old backups are retained
gsutil versioning set on gs://$BUCKET_NAME
