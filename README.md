# Hightech web application infrastructure repository.

The infrastructure code that is used to deploy [hightech website](https://github.com/andrew-anter/hightech-application) to GKE cluster using terraform and jenkins pipeline.

## The whole infrastructure is shown in the following diagram:

![The diagram for the infrastructure](./images/hightech-website.jpg)

### Terraform configuration files lies in [tf](./tf/) directory and [readme file](./tf/readme.md) with the resources that will be created and prequisites. 

### Jenkins deployment files which have 2 seperate deployments for [master agent](./jenkins/master-deployment/) and [slave agent](./jenkins/slave-deployment/) lies in [jenkins](./jenkins/) directory with the [readme file](./jenkins/readme.md) for the connection between the two agents.