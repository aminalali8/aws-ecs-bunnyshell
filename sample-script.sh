#!/bin/bash
export 
# Step 1: Create an ECS Cluster
echo "Creating ECS Cluster..."
aws ecs create-cluster --cluster-name my-cluster

# Step 2: Create an RDS Database
echo "Creating RDS Database..."
aws rds create-db-instance \
    --db-instance-identifier my-database \
    --allocated-storage 20 \
    --db-instance-class db.t2.micro \
    --engine mysql \
    --master-username admin \
    --master-user-password mypassword \
    --backup-retention-period 7

# Step 3: Create an S3 Bucket for the SPA (Single Page Application)
echo "Creating S3 Bucket..."
aws s3api create-bucket --bucket my-spa-bucket --region us-east-1

# Step 4: Deploy the SPA to S3
echo "Deploying SPA to S3..."
aws s3 sync my-spa-folder s3://my-spa-bucket

# Step 5: Create an ECS Task Definition
echo "Creating ECS Task Definition..."
aws ecs register-task-definition \
    --family my-task \
    --execution-role-arn ecsTaskExecutionRole \
    --container-definitions '[{
        "name": "my-container",
        "image": "my-container-image",
        "portMappings": [{
            "containerPort": 80,
            "hostPort": 80
        }],
        "environment": [
            {
                "name": "DB_HOST",
                "value": "my-database-host"
            }
        ]
    }]'

# Step 6: Create an ECS Service
echo "Creating ECS Service..."
aws ecs create-service \
    --cluster my-cluster \
    --service-name my-service \
    --task-definition my-task \
    --desired-count 2 \
    --launch-type EC2

# Step 7: Create an API Gateway
echo "Creating API Gateway..."
aws apigateway create-rest-api --name my-api

# Step 8: Deploy the API Gateway
echo "Deploying API Gateway..."
API_ID=$(aws apigateway get-rest-apis --query "items[?name=='my-api'].id" --output text)
aws apigateway create-deployment --rest-api-id $API_ID --stage-name prod

echo "Deployment complete."
# ------------

## DESTRUCTION 
aws ecs delete-service --cluster my-cluster --service my-service
aws ecs deregister-task-definition --task-definition my-task
aws ecs delete-cluster --cluster my-cluster
aws rds delete-db-instance --db-instance-identifier my-database --skip-final-snapshot
aws s3 rb s3://my-spa-bucket --force
