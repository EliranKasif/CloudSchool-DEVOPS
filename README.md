# CloudSchool-DEVOPS

Welcome to my CloudSchool-DevOps project.
As part of participation in the CloudSchool Devops course by Fyber, our final project is to create Application that serves by tools like Terraform, Chef, Consul, Vault, Grafana, Jenkins, and more…

The application is in this Github project but you can use this environment to any application with a few adjustments:
https://github.com/EliranKasif/CloudSchool-PythonRestApi

So here is a list of tools that I used:
 - Amazon web services
- Terraform
- Docker
- Docker-Compose
- Chef
- Consul
- Consul-Template
- Vault
- Grafana
- Jenkins

Prerequisite:
- Infra: (using terraform)
    1. Terraform install on your workstaion. https://www.terraform.io/downloads
    2. AWS CLI installation: https://aws.amazon.com/cli/
    3. on shell/cmd/powershell use command: aws configure
    4. git clone https://github.com/EliranKasif/CloudSchool-DEVOPS
    5. Generate key pair with ssh-keygen follow this tutorial: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#how-to-generate-your-own-key-and-import-it-to-aws 
save key pair here : key, key.pub /CloudSchool-DEVOPS/Terraform/cloudschool_terraform-network-layer/keys		
    6. follow the instruction from README.md inside Terraform/cloudschool_terraform-network-layer : this modules will create for you all the network layer includeing VPC and subnets. (be aware to the remote resource change the s3 bucket name and dynamodb name as your resources names)
        1. VPC
        2. Subnets
        3. KeyPair
    7. follow the instruction from README.md inside Terraform/workshop-environment : this modules will create for you all the instances.
        1. Launch Configuration
        2. Auto scaling group
        3. Load Balancer
        4. Security groups (Concrete, For every resource!)
        5. RDS
        6. Grafana dashboard using cloudwatch metrics
        7. Support instances:
            1. Main-Server with docker containers: Consul, Vault, and Grafana (all in /DockerCompose/MainInstance directory)
            2. Jenkins-Server in docker container (/DockerCompose/JenkinsInstance)
            3. workshop-terraform (/DockerCompose/WorkerInstance)
- Script:
    1. Able to respond for multiple query types and support scale up/down automatically
    2. Installed automatically using a cookbook
    3. Credentials should be using Vault - passwords should be temporary per-demand and
auto generated on runtime only
    4. Configuration file should be automated with consul template
    5. Full CI/CD process with tests. If all tests pass - it uploads the artifact to S3 and updates
consul key with the new version number (Chef uses consul to check which version to
install)

