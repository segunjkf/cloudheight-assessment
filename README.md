# DevOps Engineer - Cloudheight Interview Assessment

This repository houses the codebase to Build a CI/CD Pipeline to deploy a java application into a Highly Available Docker Host Environment on AWS.

# Infrastructure Overview
- **VPC**: A custom VPC in which the resource will be deployed into
- **4 Subnets**: Two public and two private
- **ASG**: Auto Scaling Group (ASG) configured to launch Docker hosts (EC2 instances) within the private
subnets.
- **Application Load Balancer**: Load Balancer (ELB or ALB) to distribute traffic across the Docker hosts.
- **Docker Host**: Ec2 instances running the java application

## Continuous Integration

We use GitHub Actions for our CI, triggered by pushes to the master branch. It handles:

Docker Image Building: Constructs a Docker image from the application and pushes it to DockerHub.

## Continuous Deployment

Our deployment process is automated through `userdata.sh``. A cron job monitors Docker Hub for new image releases every minute and automatically deploys any new version found.

## How To Deploy The Infrastructure?

To deploy the infrastructure, follow these steps:

- Navigate to the terraform directory by running `cd terraform` in your terminal.
- Execute the command `terraform apply -auto-approve` to initiate the deployment process. This command automates the approval of the deployment, streamlining the process.

After the Terraform process completes, the URL for the load balancer will be displayed in the terminal. Copy and paste this URL into your browser to access the application.
