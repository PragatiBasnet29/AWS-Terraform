# AWS Infrastructure with Terraform

This repository contains Terraform configurations for deploying a complete AWS infrastructure including VPC, Application Load Balancer, EC2 Auto Scaling Group, and related networking components.

## 🏗️ Infrastructure Components

### 1. **VPC Module** (`modules/vpc/`)
- **VPC**: 10.0.0.0/16 CIDR block
- **Public Subnets**: 2 subnets across different availability zones
- **Private Subnets**: 2 subnets across different availability zones
- **Internet Gateway**: For public internet access
- **Route Tables**: Configured for public and private subnets

### 2. **Application Load Balancer Module** (`modules/alb/`)
- **ALB**: Internet-facing load balancer
- **Target Group**: HTTP health checks on port 80
- **Listener**: HTTP listener on port 80
- **Security Group**: Allows inbound HTTP traffic from anywhere

### 3. **EC2 Auto Scaling Group Module** (`modules/ec2_asg/`)
- **Launch Template**: Amazon Linux 2 AMI with t3.micro instance type
- **Auto Scaling Group**: 1-3 instances with health checks
- **Security Group**: Allows HTTP traffic from ALB only

## 📁 Project Structure

```
AWS/
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── output.tf
│   ├── alb/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── output.tf
│   └── ec2_asg/
│       ├── main.tf
│       ├── variables.tf
│       └── output.tf
├── envs/
│   ├── dev/
│   │   └── main.tf
│   └── stage/
│       └── main.tf
├── .gitignore
└── README.md
```

## 🚀 Quick Start

### Prerequisites
- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- AWS account with necessary permissions

### Deployment Steps

1. **Navigate to your environment directory:**
   ```bash
   cd envs/dev    # or envs/stage
   ```

2. **Initialize Terraform:**
   ```bash
   terraform init
   ```

3. **Plan the deployment:**
   ```bash
   terraform plan
   ```

4. **Apply the configuration:**
   ```bash
   terraform apply
   ```

5. **Destroy resources when done:**
   ```bash
   terraform destroy
   ```

## ⚠️ Cost Considerations

**Important**: This infrastructure can be expensive if left running:
- **ALB**: ~$16-20/month
- **EC2 instances**: ~$7.50/month per instance
- **Total estimated cost**: $36-45/month

**Recommendations:**
- Use only for development/testing
- Destroy resources when not in use
- Consider removing ALB for cost-sensitive deployments
- Use smaller instance types (t3.nano instead of t3.micro)

## 🔧 Configuration

### Environment Variables
- `environment`: Deployment environment (dev, stage, prod)
- `region`: AWS region (default: ap-south-1)
- `vpc_id`: VPC identifier
- `public_subnet_ids`: List of public subnet IDs

### Customization
You can modify the following in each module:
- Instance types in `modules/ec2_asg/main.tf`
- VPC CIDR blocks in `modules/vpc/main.tf`
- Security group rules in respective module files
- Auto scaling group parameters in `modules/ec2_asg/main.tf`

## 🛡️ Security Features

- **Security Groups**: Restrictive inbound/outbound rules
- **Private Subnets**: Isolated resources where possible
- **ALB Security**: Only HTTP traffic allowed
- **EC2 Security**: Only traffic from ALB allowed

## 📊 Monitoring

### AWS CLI Commands for Monitoring
```bash
# Check EC2 instances
aws ec2 describe-instances --region ap-south-1 --filters "Name=tag:Environment,Values=dev"

# Check Auto Scaling Group
aws autoscaling describe-auto-scaling-groups --region ap-south-1

# Check Load Balancer
aws elbv2 describe-load-balancers --region ap-south-1

# Check VPC resources
aws ec2 describe-vpcs --region ap-south-1 --filters "Name=tag:Environment,Values=dev"
```

## 🧹 Cleanup

To avoid unexpected charges, always destroy resources:
```bash
terraform destroy -auto-approve
```

## 📝 Notes

- **Region Mismatch**: Terraform configures `ap-south-1` but ensure your AWS CLI region matches
- **Provider Blocks**: Removed duplicate provider blocks from modules for cleaner configuration
- **State Management**: Use remote state storage for production deployments
- **Tags**: All resources are properly tagged for cost tracking and management

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with `terraform plan`
5. Submit a pull request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## ⚡ Support

For issues and questions:
- Check the [Terraform documentation](https://www.terraform.io/docs)
- Review AWS service documentation
- Open an issue in this repository

