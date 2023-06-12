# Jenkins master deployment

This is the deployment directory for the jenkins-master node.

## Steps To apply this deployment:

1. Access the jumphost machine and then configure kubectl to use the gke cluster.
    ```bash
    kubectl create -f namespace.yaml
    ``` 
2. Create a namespace for the entire project
    ```bash
    kubectl create -f namespace.yaml
    ```
3. Create a serviceAccount for jenkins-admin
    ```bash
    kubectl create -f serviceAccount.yaml
    ```
4. Create a nodeport service to connect the ingress with the pod.
    ```bash
    kubectl create -f namespace.yaml
    ```
5. Create an ingress service to expose the pods to the internet.
    ```bash
    kubectl create -f ingress.yaml
    ```
6. Create a storage class, persistent volume and persistent volume claim
    ```bash
    kubectl create -f volume.yaml
    ```
7. Create the deployment for the jenkins-master
    ```bash
    kubectl create -f deployment.yaml
    ```
8. Get the external ip of the ingress after it is created
    ```bash
    kubectl get ingress -n devops-tools
    ```
9. Open the external ip in the browser
10. Configure jenkins by using the password from the logs of the pod
    ```bash
    kubectl get po -n devops-tools
    kubectl describe po POD_NAME -n devops-tools
    ```

