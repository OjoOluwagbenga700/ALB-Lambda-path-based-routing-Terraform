# Application Load balancer with path-based routing and AWS Lambda target in Terraform

This pattern demonstrates how to create an Application Load Balancer with path-based routing along with associated listener and target as AWS Lambda. Implemented in Terraform.


## Requirements

* [Create an AWS account]
* [AWS CLI] installed and configured
* [Git Installed]
* [Terraform Installed]

## Deployment Instructions

1. Create a new directory, navigate to that directory in a terminal and clone the GitHub repository:
    ``` 
    git clone https://github.com/OjoOluwagbenga700/ALB-Lambda-path-based-routing-Terraform.git
    ```
2. Change directory to the pattern directory:
    ```
    cd ALB-Lambda-path-based-routing-Terraform
    ```
3. From the command line, run:

    ```terraform init``` 

4. From the command line, run:
    
    ```terraform plan``` 
5. From the command line, run:
    
    ```terraform apply --auto-approve``` 

## Testing

1. In the terraform output, you can see `alb_url`. When you access the url, you should see the response "Default Response from ALB" from Lambda.
2. To access the path based route from the ALB, Access `alb_url`/users, you should see "Hello from users lambda function!!!!" and `alb_url`/products, you should see ""Hello from products lambda function!!!!"


## Cleanup
 
1. To delete the resources, run:

    ```terraform destroy --auto-approve``` 
----
# ALB-Lambda-path-based-routing-Terraform
