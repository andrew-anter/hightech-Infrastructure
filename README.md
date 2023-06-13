# Hightech web application infrastructure repository.

The infrastructure code that is used to deploy [hightech website](https://github.com/andrew-anter/hightech-application) to GKE cluster using terraform and jenkins pipeline.

## The whole infrastructure is shown in the following diagram:

![The diagram for the infrastructure](./images/hightech-website.jpg)
## The infrastructure that will be created by as follows:
1. A network named vpc.
2. A Sub-network named subnet.
3. A private cluster named primary has private nodes and has no client access to the public endpoint.
4. 2 Managed node pools with 1 node in each pool.
5. An Ubuntu-Linux Jump host named jump-host with internal IP only. No Public IP is attached. This machine will be accessible over the internal ipv4 address using IAP.
6. A Cloud Nat gateway named nat-config
7. Firewall rule to allow communications through IAP.

## Infrastructure wiring:
<ul>
    <b>Using Terraform to Create a Secure Kubernetes Cluster on GCP:</b>
    <ul> 
        <li>First, GCP is used as the cloud provider to create a Kubernetes cluster using Google Kubernetes Engine (GKE).
        <li>Then, The first component is a VPC which will contain all the infrastructure components. It was prohibited from creating default subnets, so a private subnet with an IP CIDR range of 10.10.0.0/16 was created instead.
        <li>Secondly, a private cluster with two node pools was created. Each pool has one node, and the nodes are labeled "node:master" and "node:slave," respectively. This will be used when the Jenkins pods are being scheduled to a node, so that the Jenkins master agent and Jenkins slave agent are not scheduled on the same node.
        <li>After that, a jump host is necessary so that Jenkins master and slave agents can be deployed. The jump host has a fixed IP of "10.10.0.7" and is configured in the master authorized networks in the cluster Terraform configuration. This allows the jump host to connect to the Kubernetes private engine.
        <li>At the end, The jump host was also made private to ensure that connections to the machine are only available through Identity-Aware Proxy (IAP), which makes the machine and the cluster more secure.
    </ul>
    <b>Deploying Jenkins on Kubernetes with Master and Slave Agents:</b>
    <ul>
        <li>First, Two deployments were created for Jenkins, one for the master Jenkins agent and the other for a worker agent (slave agent). This was done so that the master agent can run the pipeline on the worker agent.
        <li>Then, The master deployment is being scheduled on a node with the label "node:master," which is being forced by the nodeAffinity rule in the Kubernetes deployment file. The same is true for the worker deployment, but this time the label is "node:slave." This guarantees that the master and worker will always be on separate nodes.
        <li>Also, To access the Jenkins server, an ingress service is required. The ingress service communicates with the nodeport service to send traffic from the external IP to the internal pods of the Jenkins master.
        <li>Eventually, The Jenkins master agent was configured to communicate with the Jenkins slave agent using a backend nodeport service that routes traffic to the Jenkins slave pods.
    </ul>
    <b>CI/CD pipeline:</b>
    <ul>
        <li>The pipeline had two phases: building and deploying. The build phase converted the application into a Docker image and uploaded it to Docker Hub. The deploy phase then used the image to deploy the application to the Kubernetes cluster that had already been created.
        <li>During the building phase, an nginx:alpine image was used as a web server to host the static application files. Next, a Docker image was built with an nginx server and the application files at their default location in /usr/share/nginx/html. After that, the image was pushed to Docker Hub with the build number appended, so that every image from every build could be saved. Finally, the build number was exported to a local file so that the deployment always work with the last image number, even if the pipeline was changed to run the phase under a specific condition.
        <li>During the deploying phase, the gcloud service account was authenticated to authorize the machine to use the GKE cluster. Next, kubectl was configured to work on the GKE cluster. Then, the application was deployed using a Kubernetes deployment file that included the latest image number from the build stage and a nodeport service. Finally, an ingress service was created and printed in the pipeline console output, which was essential for users to access the application.
    </ul>
</ul>