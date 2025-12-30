# 1. Create the Bucket (Change 'bluebricks' to something unique!)
aws s3api create-bucket --bucket liorm-bluebricks --region us-east-2

# 2. Enable Versioning (Best Practice for State)
aws s3api put-bucket-versioning --bucket liorm-bluebricks --versioning-configuration Status=Enabled

# 3. Create the DynamoDB Table for Locking
aws dynamodb create-table \
    --table-name liorm-bluebricks-locks \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST \
    --region us-east-2